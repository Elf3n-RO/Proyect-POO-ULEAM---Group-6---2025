from flask import Flask, flash, render_template, request, session, redirect, url_for
from datetime import datetime
import pyodbc
import pandas as pd
from io import BytesIO
from flask import send_file, render_template_string
import pdfkit

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
        "SERVER=localhost\SQLEXPRESS;"
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
    # Recogemos los datos del formulario
    email_ingresado = request.form.get('correo')
    # Usamos el mismo campo de 'contrasena' para la clave del admin 
    # o para la identificación del postulante
    password_o_id = request.form.get('contrasena') 

    conn = get_db_connection()
    cursor = conn.cursor()
    
    # 1. INTENTAR LOGIN COMO ADMINISTRADOR
    cursor.execute("SELECT * FROM administradores WHERE correo = ? AND contrasena = ?", 
                   (email_ingresado, password_o_id))
    admin = cursor.fetchone()

    if admin:
        session['user_type'] = 'admin'
        session['correo'] = admin[1] # Suponiendo que el correo es la col 1
        conn.close()
        return redirect(url_for('admin_panel'))

    # 2. SI NO ES ADMIN, INTENTAR COMO POSTULANTE
    cursor.execute("SELECT * FROM postulantes WHERE correo = ? AND identificacion = ?", 
                   (email_ingresado, password_o_id))
    postulante = cursor.fetchone()
    conn.close()

    if postulante:
        session['user_type'] = 'postulante'
        session['user_id'] = postulante[2] # Su identificación
        session['user_name'] = f"{postulante[3]} {postulante[4]}" # Nombres y Apellidos
        print("DEBUG LOGIN - Cédula guardada:", session['user_id'])
        print("DEBUG LOGIN - Nombre guardado:", session['user_name'])
        # IMPORTANTE: Usa redirect para el perfil, no render_template directamente
        return redirect(url_for('perfil_postulante'))
    
    # 3. SI NINGUNO COINCIDE
    flash("Credenciales incorrectas. Verifique su correo, contraseña o cédula.", "error")
    return redirect(url_for('index'))

@app.route('/mi-perfil')
def perfil_postulante():
    if session.get('user_type') != 'postulante' or 'user_id' not in session:
        session.clear()           # ← Limpia sesión inconsistente
        return redirect(url_for('index'))
    return render_template('postulante.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/admin-panel')
def admin_panel():
    if session.get('user_type') != 'admin' or 'correo' not in session:
        session.clear()
        return redirect(url_for('index'))
    # ... resto del código

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
    cursor.execute("""
        SELECT p.*, af.codigo_carrera 
        FROM postulantes p
        LEFT JOIN asignaciones_finales af ON p.identificacion = af.identificacion_postulante
    """)
    postulantes = cursor.fetchall()

    cursor.execute("SELECT id_proceso, fecha_ejecucion, cupos_asignados, usuario_responsable FROM historial_procesos ORDER BY fecha_ejecucion DESC")
    historial = cursor.fetchall()

    conn.close()
    return render_template('admin.html', 
                           admin_logeado=True, 
                           carreras=carreras_objetos, 
                           postulantes=postulantes,
                           historial=historial)

# --- RUTAS DE GESTIÓN (CONFIGURACIÓN) ---

@app.route('/config-page')
def config_page():
    if not session.get('correo'): return redirect(url_for('index'))
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT codigo, nombre, cupos_totales FROM carreras")
    carreras = cursor.fetchall()
    conn.close()
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT criterio_primario, criterio_secundario FROM configuracion_sistema WHERE id = 1")
    row = cursor.fetchone()
    conn.close()

    estrategia_actual = row[0] if row else 'puntaje'

    return render_template('configuracion.html', carreras=carreras, estrategia=estrategia_actual)

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

@app.route('/set-desempate', methods=['POST'])
def guardar_configuracion():
    seleccion = request.form.get('prioridad_desempate') 
    
    # Mapeo de valores según lo que el usuario eligió
    if seleccion == "merito":
        primario, secundario = 'puntaje', 'vulnerabilidad'
        session['estrategia_id'] = 'merito' # Guardamos en sesión para ejecutar-asignacion
    else:
        primario, secundario = 'vulnerabilidad', 'fecha_inscripcion'
        session['estrategia_id'] = 'vuln'

    conn = get_db_connection()
    cursor = conn.cursor()
    # Actualizamos la base de datos
    cursor.execute("""
        UPDATE configuracion_sistema 
        SET criterio_primario = ?, criterio_secundario = ? 
        WHERE id = 1
    """, (primario, secundario))
    conn.commit()
    conn.close()

    flash("¡Configuración guardada! El próximo proceso usará este criterio.")
    return redirect(url_for('config_page'))


# --- PROCESO DE ASIGNACIÓN ---

@app.route('/ejecutar-asignacion', methods=['POST'])
def ejecutar_asignacion():
    # 1. Obtener la estrategia de la sesión
    est_id = session.get('estrategia_id', 'vuln')
    from desempate import VulnerabilidadFechaDesempate, MeritoAcademicoDesempate
    estrategia = MeritoAcademicoDesempate() if est_id == 'merito' else VulnerabilidadFechaDesempate()
    
    proceso = ProcesoAsignacion(estrategia, Senescyt())
    conn = get_db_connection()
    cursor = conn.cursor()

    # 2. Cargar Carreras
    cursor.execute("SELECT id_carrera, codigo, nombre, cupos_totales FROM carreras")
    carreras_dict = {r.id_carrera: Carrera(r.codigo, r.nombre, r.cupos_totales) for r in cursor.fetchall()}
    proceso.carreras = list(carreras_dict.values())

    # 3. Cargar Postulantes CON sus Preferencias (JOIN)
    cursor.execute("""
        SELECT p.*, pref.id_carrera, pref.prioridad 
        FROM postulantes p
        INNER JOIN preferencias_carrera pref ON p.id_postulante = pref.id_postulante
        ORDER BY p.id_postulante, pref.prioridad
    """)
    
    postulantes_map = {}
    for r in cursor.fetchall():
        if r.identificacion not in postulantes_map:
            p = Postulante(r.tipo_documento, r.identificacion, r.nombres, r.apellidos, 
                           float(r.puntaje), r.fecha_inscripcion)
            p.vulnerabilidad = float(r.vulnerabilidad)
            p.merito_academico = r.merito_academico
            postulantes_map[r.identificacion] = p
        
        # Vincular preferencia al objeto
        obj_p = postulantes_map[r.identificacion]
        obj_c = carreras_dict.get(r.id_carrera)
        if obj_c:
            from modelos import PreferenciaCarrera
            pref = PreferenciaCarrera(obj_p, obj_c, r.prioridad, obj_c.nombre, r.id_carrera, 0)
            obj_p.preferenciaCarrera.append(pref)

    proceso.postulantes = list(postulantes_map.values())

    # 4. Ejecutar y GUARDAR CAMBIOS
    res_asignacion = proceso.ejecutarAsignacion() 

    conn = get_db_connection()
    cursor = conn.cursor()
    # Contar cuántos asignados hubo realmente
    total_asignados = sum(1 for p in proceso.postulantes if p.asignaciones)
     
    # 1. Crear el registro en el historial
    usuario = session.get('admin_nombre', 'Administrador Principal')
    cursor.execute("""
        INSERT INTO historial_procesos (cupos_asignados, usuario_responsable)
        OUTPUT INSERTED.id_proceso
        VALUES (?, ?)
    """, (total_asignados, usuario))
    id_proceso = cursor.fetchone()[0]
    
    # 2. Guardar el detalle vinculando al ID del proceso
    for p in proceso.postulantes:
        if p.asignaciones:
            carrera_cod = p.asignaciones[0].carrera.codigo
            cursor.execute("""
                INSERT INTO asignaciones_finales (id_proceso, identificacion_postulante, codigo_carrera, fecha_ejecucion)
                VALUES (?, ?, ?, GETDATE())
            """, (id_proceso, p.identificacion, carrera_cod))

    for c in proceso.carreras:
        cursor.execute("UPDATE carreras SET cupos_disponibles = ? WHERE codigo = ?", 
                       (c.cuposDisponibles, c.codigo))
    
    conn.commit() # Esto hace que los cambios sean reales en SQL
    conn.close()

    return redirect(url_for('admin_panel', mensaje=res_asignacion))

@app.route('/historial/<int:id_proceso>')
def detalle_historial(id_proceso):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Traer datos del proceso y lista de alumnos asignados
    cursor.execute("""
        SELECT 
            p.identificacion, 
            p.nombres, 
            p.apellidos, 
            c.nombre AS carrera 
        FROM asignaciones_finales af
        JOIN postulantes p ON af.identificacion_postulante = p.identificacion
        JOIN carreras c ON af.codigo_carrera = c.codigo
        WHERE af.id_proceso = ?
    """, (id_proceso,))
    estudiantes = cursor.fetchall()
    
    return render_template('detalle_historial.html', estudiantes=estudiantes, id_p=id_proceso)

@app.route('/report-page', methods=['GET', 'POST'])
def report_page():
    if not session.get('correo'):
        return redirect(url_for('index'))
    
    conn = get_db_connection()
    cursor = conn.cursor()
    # Traemos las ejecuciones para que el usuario pueda elegir una
    cursor.execute("SELECT id_proceso, fecha_ejecucion, cupos_asignados FROM historial_procesos ORDER BY fecha_ejecucion DESC")
    historial = cursor.fetchall()
    conn.close()
    
    return render_template('reportes.html', historial=historial)

@app.route('/report', methods=['POST'])
def descargar_reporte_consolidado():
    formato = request.form.get('formato')
    id_proceso = request.form.get('id_proceso')
    conn = get_db_connection()
    
    try:
        # 1. DEFINIR QUERIES BASADAS EN LA SELECCIÓN
        if id_proceso != 'todos':
            # Filtro por ID específico
            query_historial = f"""
                SELECT id_proceso AS [ID Proceso], 
                       fecha_ejecucion AS [Fecha Ejecución], 
                       cupos_asignados AS [Cupos Asignados], 
                       usuario_responsable AS [Responsable]
                FROM historial_procesos 
                WHERE id_proceso = {id_proceso}
            """
            query_detalle = f"""
                SELECT af.id_proceso AS [ID Proceso], 
                       p.identificacion AS [Cédula], 
                       p.nombres AS [Nombres], 
                       p.apellidos AS [Apellidos], 
                       c.nombre AS [Carrera Asignada]
                FROM asignaciones_finales af
                JOIN postulantes p ON af.identificacion_postulante = p.identificacion
                JOIN carreras c ON af.codigo_carrera = c.codigo
                WHERE af.id_proceso = {id_proceso}
            """
            nombre_archivo_base = f"Reporte_Ejecucion_{id_proceso}"
        else:
            # Reporte General (Todos)
            query_historial = """
                SELECT id_proceso AS [ID Proceso], 
                       fecha_ejecucion AS [Fecha Ejecución], 
                       cupos_asignados AS [Cupos Asignados], 
                       usuario_responsable AS [Responsable]
                FROM historial_procesos 
                ORDER BY fecha_ejecucion DESC
            """
            query_detalle = """
                SELECT af.id_proceso AS [ID Proceso], 
                       p.identificacion AS [Cédula], 
                       p.nombres AS [Nombres], 
                       p.apellidos AS [Apellidos], 
                       c.nombre AS [Carrera Asignada]
                FROM asignaciones_finales af
                JOIN postulantes p ON af.identificacion_postulante = p.identificacion
                JOIN carreras c ON af.codigo_carrera = c.codigo
            """
            nombre_archivo_base = "Reporte_General_SAC"

        # 2. EJECUTAR CONSULTAS
        df_historial = pd.read_sql(query_historial, conn)
        df_detalle = pd.read_sql(query_detalle, conn)

        # Formatear la fecha para que no salga con ###### en Excel
        if not df_historial.empty:
            df_historial['Fecha Ejecución'] = pd.to_datetime(df_historial['Fecha Ejecución']).dt.strftime('%d/%m/%Y %H:%M')

    finally:
        # CERRAMOS LA CONEXIÓN UNA SOLA VEZ AQUÍ
        conn.close()

    # --- GENERACIÓN DE EXCEL ---
    if formato == 'excel':
        output = BytesIO()
        with pd.ExcelWriter(output, engine='openpyxl') as writer:
            df_historial.to_excel(writer, index=False, sheet_name='Historial_General')
            df_detalle.to_excel(writer, index=False, sheet_name='Estudiantes_Asignados')
            
            # AUTO-AJUSTAR COLUMNAS
            for sheet in writer.sheets:
                for col in writer.sheets[sheet].columns:
                    max_length = 0
                    column = col[0].column_letter
                    for cell in col:
                        try:
                            if len(str(cell.value)) > max_length:
                                max_length = len(str(cell.value))
                        except: pass
                    writer.sheets[sheet].column_dimensions[column].width = max_length + 2
        
        output.seek(0)
        return send_file(output, download_name=f"{nombre_archivo_base}.xlsx", as_attachment=True)

    # --- GENERACIÓN DE PDF ---
    elif formato == 'pdf':
        path_wkhtmltopdf = r'C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe'
        config = pdfkit.configuration(wkhtmltopdf=path_wkhtmltopdf)
        
        html_template = f"""
        <html>
        <head>
            <meta charset="UTF-8">
            <style>
                body {{ font-family: Arial, sans-serif; color: #333; padding: 20px; }}
                h1 {{ text-align: center; color: #1a1a2e; border-bottom: 2px solid #ffc107; padding-bottom: 10px; }}
                h2 {{ background-color: #f4f4f4; padding: 10px; border-left: 5px solid #ffc107; margin-top: 30px; }}
                table {{ width: 100%; border-collapse: collapse; margin-bottom: 20px; }}
                th, td {{ border: 1px solid #ddd; padding: 8px; text-align: left; font-size: 11px; }}
                th {{ background-color: #2c3e50; color: white; }}
                .footer {{ text-align: center; font-size: 10px; color: #777; margin-top: 50px; }}
            </style>
        </head>
        <body>
            <h1>REPORTE OFICIAL DE ASIGNACIÓN (SAC)</h1>
            <p><strong>Tipo de Reporte:</strong> {'Individual' if id_proceso != 'todos' else 'Consolidado General'}</p>
            <p><strong>Fecha de Emisión:</strong> {datetime.now().strftime('%d/%m/%Y %H:%M')}</p>
            
            <h2>1. Resumen de Ejecución</h2>
            {df_historial.to_html(index=False, classes='table')}
            
            <div style="page-break-before: always;"></div>
            
            <h2>2. Listado de Estudiantes Asignados</h2>
            {df_detalle.to_html(index=False, classes='table')}
            
            <div class="footer">Sistema de Asignación de Cupos - ULEAM 2025</div>
        </body>
        </html>
        """
        pdf = pdfkit.from_string(html_template, False, configuration=config)
        output = BytesIO(pdf)
        return send_file(output, 
                         download_name=f"{nombre_archivo_base}.pdf", 
                         as_attachment=True)

    return redirect(url_for('admin_panel'))


@app.route('/soporte')
def soporte_tecnico():
    return render_template('soporte.html')

@app.route('/manual-admin')
def manual_admin():
    return render_template('manual_admin.html')

@app.route('/ayuda')
def ayuda():
    # Fuerza limpieza de cualquier sesión inconsistente o vieja
    if 'user_type' in session:
        if session.get('user_type') == 'postulante' and 'user_id' not in session:
            session.clear()
        elif session.get('user_type') == 'admin' and 'correo' not in session:
            session.clear()
        # Opcional: limpiar SIEMPRE al entrar a páginas públicas
        # session.clear()   ← descomenta solo para probar

    return render_template('ayuda.html')

@app.route('/ver-estado', methods=['GET', 'POST'])
def ver_estado():
  
    user_id = session['user_id']
    conn = get_db_connection()
    cursor = conn.cursor()

    # Usamos JOIN para asegurar que traemos el nombre del alumno y su carrera si existe
    query = """
        SELECT 
            p.nombres, 
            p.apellidos, 
            c.nombre AS carrera_nombre,
            af.codigo_carrera
        FROM postulantes p
        LEFT JOIN asignaciones_finales af ON p.identificacion = af.identificacion_postulante
        LEFT JOIN carreras c ON af.codigo_carrera = c.codigo
        WHERE p.identificacion = ?
    """
    cursor.execute(query, (user_id,))
    row = cursor.fetchone()
    conn.close()

    if row:
        # El HTML espera 'nombre_estudiante', 'carrera' y 'codigo'
        asignacion_data = {
            'nombre_estudiante': f"{row[0]} {row[1]}",
            'carrera': row[2],  # Esto será None si no tiene cupo
            'codigo': row[3]
        }
        return render_template('estado.html', asignacion=asignacion_data)
    else:
        return f"DEBUG: No se encontró NINGUNA fila para cédula = '{user_id}'"
    
    return render_template('estado.html', asignacion=None)

if __name__ == '__main__':
    app.run(debug=True)