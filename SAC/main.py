# Archivo de entrada para ejecutar una simulación rápida
from src.sac.senescyt import Senescyt
from src.sac.modelos import Postulante
from src.sac.proceso_asignacion import ProcesoAsignacion
from src.sac.desempate import VulnerabilidadFechaDesempate
from src.sac.carrera import Carrera
from src.sac.modelos import PreferenciaCarrera
from src.sac.cuotas import Vulnerabilidad, MeritoAcademico

from datetime import datetime

def run_demo():
    desempate_strategy = VulnerabilidadFechaDesempate()
    senescyt = Senescyt()
    proceso = ProcesoAsignacion(desempate_strategy, senescyt)

    carrera = Carrera('GEN01', 'Ingeniería de Software', 10)
    proceso.carreras.append(carrera)

    p1 = Postulante('CÉDULA', '1712345678', 'Derlis Dario', 'Carranza Acosta', 850.0, datetime.now())
    p1.condicion_socioeconomica = 'SI'
    p1.determinarSegmentos()

