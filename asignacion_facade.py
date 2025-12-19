# Sistema (Estructural)

from datetime import datetime
from sigacc3 import ProcesoAsignacion
from carrera import CarreraBuilder
from sigacc3 import Postulante
from sigacc3 import VulnerabilidadFechaDesempate

class AsignacionFacade:
    def __init__(self):
        self.carreras = []
        self.postulantes = []
        self.estrategia_desempate = VulnerabilidadFechaDesempate()  # por defecto, se puede cambiar

