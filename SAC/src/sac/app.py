from flask import Flask, render_template, request, session, redirect, url_for
from datetime import datetime
import pyodbc

# Importación de tu lógica original
from modelos import Postulante, PreferenciaCarrera, AsignacionCupo
from carrera import Carrera
from proceso_asignacion import ProcesoAsignacion
from desempate import VulnerabilidadFechaDesempate
from senescyt import Senescyt

app = Flask(__name__)
app.secret_key = "a3f9c8d7e2b14f6a9d3c0b5f8a7e9d2c"

# --- CONFIGURACIÓN DE CONEXIÓN SQL SERVER ---
def get_db_connection():
    # Ajusta 'SERVER' al nombre de tu PC o 'localhost'
    conn_str = (
        "DRIVER={SQL Server};"
        "SERVER=DESKTOP-JDTRNFK\SQLEXPRESS;"
        "DATABASE=AsignacionCuposULEAM;"
        "Trusted_Connection=yes;"
    )
    return pyodbc.connect(conn_str)

# --- RUTAS DE NAVEGACIÓN Y LOGIN ---

@app.route('/')
def index():
    return render_template('admin.html', admin_logeado=False)

@app.route('/login', methods=['POST'])
def login():
    correo = request.form.get('correo')
    contrasena = request.form.get('contrasena')

    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Validamos contra tu tabla 'administradores'
    cursor.execute("SELECT * FROM administradores WHERE correo = ? AND contrasena = ?", (correo, contrasena))
    admin = cursor.fetchone()
    conn.close()

    if admin:
        session['correo'] = correo
        session['admin_id'] = admin.id_admin
        return redirect(url_for('admin_panel'))
    
    # Lógica para postulante (puedes adaptarla a SQL también)
    if correo == "postulante@uleam.edu.ec" and contrasena == "78910":
        session['correo'] = correo
        return render_template('postulante.html')
        
    return "Error de acceso: Credenciales incorrectas."

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/admin-panel')
def admin_panel():
    if not session.get('correo'):
        return redirect(url_for('index'))

    conn = get_db_connection()
    cursor = conn.cursor()

    # 1. Obtener Carreras (Ofertas Académicas)
    cursor.execute("SELECT codigo, nombre, cupos_totales, cupos_disponibles FROM carreras")
    carreras_rows = cursor.fetchall()
    
    # Convertimos a objetos de tu clase Carrera para que funcione .segmentarCupos() y .cuposPorSegmento
    carreras_objetos = []
    for row in carreras_rows:
        c = Carrera(row.codigo, row.nombre, row.cupos_totales)
        c.cuposDisponibles = row.cupos_disponibles
        c.segmentarCupos() # Calcula los 15% y 20%
        carreras_objetos.append(c)

    # 2. Obtener Postulantes
    cursor.execute("SELECT identificacion, nombres, apellidos, puntaje, fecha_inscripcion, vulnerabilidad FROM postulantes")
    postulantes = cursor.fetchall()

    conn.close()
    return render_template('admin.html', 
                           admin_logeado=True, 
                           carreras=carreras_objetos, 
                           postulantes=postulantes)

# --- RUTAS DE GESTIÓN (CONFIGURACIÓN) ---
@app.route('/report-page', methods=['POST'])
def generar_reporte():
    if not session.get("correo"): return redirect(url_for("index"))
    return render_template("reportes.html",)

@app.route('/config-page')
def config_page():
    if not session.get('correo'): return redirect(url_for('index'))
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT codigo, nombre, cupos_totales FROM carreras")
    carreras = cursor.fetchall()
    conn.close()
    
    return render_template('configuracion.html', carreras=carreras)

@app.route('/add-carrera', methods=['POST'])
def add_carrera():
    codigo = request.form.get('codigo')
    nombre = request.form.get('nombre')
    cupos = int(request.form.get('cupos'))
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO carreras (codigo, nombre, cupos_totales, cupos_disponibles) VALUES (?, ?, ?, ?)",
                   (codigo, nombre, cupos, cupos))
    conn.commit()
    conn.close()
    return redirect(url_for('config_page'))

@app.route('/delete-carrera/<codigo>')
def delete_carrera(codigo):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM carreras WHERE codigo = ?", (codigo,))
    conn.commit()
    conn.close()
    return redirect(url_for('config_page'))

@app.route('/update-cupos', methods=['POST'])
def update_cupos():
    codigo = request.form.get('codigo')
    n_cupos = int(request.form.get('n_cupos'))
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("UPDATE carreras SET cupos_totales = ?, cupos_disponibles = ? WHERE codigo = ?", 
                   (n_cupos, n_cupos, codigo))
    conn.commit()
    conn.close()
    return redirect(url_for('config_page'))

# --- PROCESO DE ASIGNACIÓN ---

@app.route('/ejecutar-asignacion', methods=['POST'])
def ejecutar_asignacion():
    # 1. Configurar Estrategia de Desempate
    est_id = session.get('estrategia_id', 'vuln')
    estrategia = MeritoAcademicoDesempate() if est_id == 'merito' else VulnerabilidadFechaDesempate()
    
    proceso = ProcesoAsignacion(estrategia, Senescyt())
    
    conn = get_db_connection()
    cursor = conn.cursor()

    # 2. Cargar Carreras (Objetos)
    cursor.execute("SELECT id_carrera, codigo, nombre, cupos_totales FROM carreras")
    carreras_dict = {}
    for r in cursor.fetchall():
        obj_c = Carrera(r.codigo, r.nombre, r.cupos_totales)
        obj_c.id_sql = r.id_carrera
        carreras_dict[r.id_carrera] = obj_c
    
    proceso.carreras = list(carreras_dict.values())

    # 3. Cargar Postulantes y sus Preferencias (Relación SQL)
    cursor.execute("""
        SELECT p.*, pref.id_preferencia, pref.id_carrera, pref.prioridad 
        FROM postulantes p
        LEFT JOIN preferencias_carrera pref ON p.id_postulante = pref.id_postulante
    """)
    
    postulantes_map = {}
    for r in cursor.fetchall():
        if r.identificacion not in postulantes_map:
            p = Postulante(r.tipo_documento, r.identificacion, r.nombres, r.apellidos, 
                           float(r.puntaje), r.fecha_inscripcion)
            # Mapeo de campos de desempate
            p.vulnerabilidad = float(r.vulnerabilidad)
            p.merito_academico = r.merito_academico
            postulantes_map[r.identificacion] = p
        
        # Crear objeto de Preferencia
        obj_p = postulantes_map[r.identificacion]
        obj_c = carreras_dict.get(r.id_carrera)
        if obj_c:
            pref = PreferenciaCarrera(obj_p, obj_c, r.prioridad, obj_c.nombre, r.id_carrera, r.id_preferencia)
            obj_p.preferenciaCarrera.append(pref)

    proceso.postulantes = list(postulantes_map.values())

    # 4. Ejecución del Motor de Asignación
    msg = proceso.ejecutarAsignacion()

    # 5. Persistencia: Actualizar cupos en SQL
    for c in proceso.carreras:
        cursor.execute("UPDATE carreras SET cupos_disponibles = ? WHERE codigo = ?", 
                       (c.cuposDisponibles, c.codigo))
    
    conn.commit()
    conn.close()

    return redirect(url_for('admin_panel', mensaje=msg))


if __name__ == '__main__':
    app.run(debug=True)