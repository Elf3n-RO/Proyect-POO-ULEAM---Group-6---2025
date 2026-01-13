from flask import Flask, render_template, request, session, redirect, url_for
from datetime import datetime

# Importación de tu lógica
from modelos import Postulante
from carrera import Carrera
from proceso_asignacion import ProcesoAsignacion
from desempate import VulnerabilidadFechaDesempate
from senescyt import Senescyt

app = Flask(__name__)
app.secret_key = "a3f9c8d7e2b14f6a9d3c0b5f8a7e9d2c"

# Datos globales iniciales
carreras_admin = [
    Carrera("TI-001", "Ingeniería TI", 100),
    Carrera("MED-002", "Medicina", 50)
]

# Lista global de postulantes para simular una base de datos
# Lista global de postulantes (simulación)
postulantes_db = [
    Postulante("CEDULA", "1312345678", "JUAN", "PEREZ", 950.0, datetime.now()),
    Postulante("CEDULA", "1309876543", "MARIA", "LOOR", 880.5, datetime.now())
]

# --- RUTAS DE NAVEGACIÓN GENERAL ---

@app.route('/')
def index():
    return render_template('admin.html', admin_logeado=False)

@app.route('/login', methods=['POST'])
def login():
    correo = request.form.get('correo')
    contrasena = request.form.get('contrasena')

    session['correo'] = correo
    session['contrasena'] = contrasena

    if correo == "admin@uleam.edu.ec" and contrasena == "12345":
        for c in carreras_admin:
            c.segmentarCupos()
        return render_template('admin.html', admin_logeado=True, carreras=carreras_admin)
    elif correo == "postulante@uleam.edu.ec" and contrasena == "78910":
        return render_template('postulante.html')
    return "Error de acceso."

# --- RUTAS DE ADMINISTRACIÓN Y ASIGNACIÓN ---

@app.route('/ejecutar-asignacion', methods=['POST'])
def ejecutar_asignacion():
    estrategia = VulnerabilidadFechaDesempate()
    entidad_control = Senescyt()
    proceso = ProcesoAsignacion(estrategia, entidad_control)
    
    proceso.carreras = carreras_admin
    res_asignacion = proceso.ejecutarAsignacion() 
    res_reporte = proceso.generarReportes()
    res_auditoria = entidad_control.auditarProcesos()

    mensaje_final = f"{res_asignacion} | {res_reporte} | {res_auditoria}"
    return render_template('admin.html', admin_logeado=True, carreras=carreras_admin, mensaje=mensaje_final)

@app.route('/report-page')
def report_page():
    return render_template('reportes.html')

@app.route('/config-page')
def config_page():
    return render_template('configuracion.html', carreras=carreras_admin)

# --- RUTAS DE GESTIÓN DE CARRERAS (CRUD) ---

@app.route('/update-cupos', methods=['POST'])
def update_cupos():
    """Ruta única para actualizar cupos desde el panel de gestión."""
    codigo = request.form.get('codigo')
    # Se unificó para recibir 'n_cupos' como define tu configuracion.html
    n_cupos_raw = request.form.get('n_cupos')
    
    if codigo and n_cupos_raw:
        n_cupos = int(n_cupos_raw)
        for c in carreras_admin:
            if c.codigo == codigo:
                c.cuposTotales = n_cupos
                c.cuposDisponibles = n_cupos
                c.segmentarCupos()
                break
    return redirect(url_for('config_page'))

@app.route('/add-carrera', methods=['POST'])
def add_carrera():
    """Añade una nueva carrera a la lista global."""
    codigo = request.form.get('codigo')
    nombre = request.form.get('nombre')
    cupos = int(request.form.get('cupos'))
    
    nueva_carrera = Carrera(codigo, nombre, cupos)
    nueva_carrera.segmentarCupos()
    carreras_admin.append(nueva_carrera)
    return redirect(url_for('config_page'))

@app.route('/delete-carrera/<codigo>')
def delete_carrera(codigo):
    """Elimina una carrera de la lista global por su código."""
    global carreras_admin
    carreras_admin = [c for c in carreras_admin if c.codigo != codigo]
    return redirect(url_for('config_page'))

# --- RUTAS DE CONFIGURACIÓN ADICIONAL ---

@app.route('/set-desempate', methods=['POST'])
def set_desempate():
    estrategia_id = request.form.get('estrategia')
    # Espacio para implementar lógica de cambio de estrategia en ProcesoAsignacion
    return redirect(url_for('config_page'))

@app.route('/search-estudiante', methods=['POST'])
def search_estudiante():
    cedula = request.form.get('cedula')
    # Buscamos por el atributo identificacion de tu clase
    estudiante = next((p for p in postulantes_db if p.identificacion == cedula), None)
    
    if estudiante:
        return render_template('configuracion.html', 
                               carreras=carreras_admin, 
                               estudiante=estudiante)
    
    return render_template('configuracion.html', 
                           carreras=carreras_admin, 
                           mensaje_estudiante="Estudiante no encontrado.")

@app.route('/update-estudiante', methods=['POST'])
def update_estudiante():
    id_org = request.form.get('id_original')
    nuevo_nom = request.form.get('nombres')
    nuevo_ape = request.form.get('apellidos')
    nuevo_pun = float(request.form.get('puntaje'))
    
    for p in postulantes_db:
        if p.identificacion == id_org:
            p.nombres = nuevo_nom.upper()
            p.apellidos = nuevo_ape.upper()
            p.puntaje = nuevo_pun
            break
            
    return redirect(url_for('config_page'))

@app.route('/admin-panel')
def admin_panel():
    # Verificamos si los datos de sesión existen (opcional pero recomendado)
    if session.get('correo') == "admin@uleam.edu.ec":
        return render_template('admin.html', admin_logeado=True, carreras=carreras_admin)
    return redirect(url_for('index'))

# --- ACCIONES DEL POSTULANTE ---

@app.route('/ver-estado', methods=['POST'])
def ver_estado():
    correo = session.get('correo')
    contrasena = session.get('contrasena')
    if correo == "postulante@uleam.edu.ec" and contrasena == "78910":
        return render_template('estado.html', estado_postulacion="Postulación en proceso.")
    return "Error de acceso."

if __name__ == '__main__':
    app.run(debug=True)