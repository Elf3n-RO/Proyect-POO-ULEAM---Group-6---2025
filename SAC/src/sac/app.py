from flask import Flask, render_template, request
from datetime import datetime

# Importación de tu lógica (Asegúrate de haber quitado los '.' en los archivos originales)
from modelos import Postulante
from carrera import Carrera
from proceso_asignacion import ProcesoAsignacion
from desempate import VulnerabilidadFechaDesempate
from senescyt import Senescyt

app = Flask(__name__)

# Datos globales para el ejemplo
carreras_admin = [
    Carrera("TI-001", "Ingeniería TI", 100),
    Carrera("MED-002", "Medicina", 50)
]

@app.route('/')
def index():
    return render_template('admin.html', admin_logeado=False)

@app.route('/login', methods=['POST'])
def login():
    correo = request.form.get('correo')
    contrasena = request.form.get('contrasena')

    if correo == "admin@uleam.edu.ec" and contrasena == "12345":
        # ACCIÓN 1: Segmentar cupos automáticamente al entrar (Lógica de carrera.py)
        for c in carreras_admin:
            c.segmentarCupos() 
        return render_template('admin.html', admin_logeado=True, carreras=carreras_admin)
    elif correo == "postulante@uleam.edu.ec" and contrasena =="78910":
        return render_template('postulante.html')
    return "Error de acceso."

@app.route('/ejecutar-asignacion', methods=['POST'])
def ejecutar_asignacion():
    # Instanciamos tus clases de lógica
    estrategia = VulnerabilidadFechaDesempate()
    entidad_control = Senescyt()
    proceso = ProcesoAsignacion(estrategia, entidad_control)
    
    proceso.carreras = carreras_admin
    # (Aquí normalmente cargarías los postulantes de una base de datos)
    
    # ACCIÓN 2: Ejecutar el motor principal (Lógica de proceso_asignacion.py)
    res_asignacion = proceso.ejecutarAsignacion() 
    
    # ACCIÓN 3: Generar reportes finales (Lógica de senescyt.py / proceso)
    res_reporte = proceso.generarReportes()
    res_auditoria = entidad_control.auditarProcesos()

    mensaje_final = f"{res_asignacion} | {res_reporte} | {res_auditoria}"
    
    return render_template('index.html', 
                           admin_logeado=True, 
                           carreras=carreras_admin, 
                           mensaje=mensaje_final)

@app.route('/report-page')
def report_page():
    # Esta ruta nos lleva a la interfaz de descarga
    return render_template('reportes.html')

@app.route('/config-page')
def config_page():
    # Pasamos las carreras para poder editarlas
    return render_template('configuracion.html', carreras=carreras_admin)

@app.route('/actualizar-cupos', methods=['POST'])
def actualizar_cupos():
    codigo = request.form.get('codigo')
    nuevo_cupo = int(request.form.get('cupos'))
    # Buscamos la carrera y actualizamos
    for c in carreras_admin:
        if c.codigo == codigo:
            c.cuposTotales = nuevo_cupo
            c.cuposDisponibles = nuevo_cupo
            c.segmentarCupos() # Recalculamos segmentos (15%, 20%, etc.)
    return redirect(url_for('config_page'))

if __name__ == '__main__':
    app.run(debug=True)