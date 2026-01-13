# Sistema (Estructural)

from datetime import datetime
from sigacc3 import ProcesoAsignacion
from carrera2 import CarreraBuilder
from sigacc3 import Postulante
from sigacc3 import VulnerabilidadFechaDesempate

class AsignacionFacade:
    def __init__(self):
        self.carreras = []
        self.postulantes = []
        self.estrategia_desempate = VulnerabilidadFechaDesempate()  # por defecto, se puede cambiar

    def agregar_carrera(self, codigo: str, nombre: str, cupos: int):
        carrera = CarreraBuilder().con_codigo(codigo).con_nombre(nombre).con_cupos(cupos).build()
        self.carreras.append(carrera)

    def agregar_postulante(self, tipo_doc: str, id: str, nombres: str, apellidos: str, puntaje: float, fecha_insc: datetime, titulo_superior: bool = False):
        post = Postulante(tipo_doc, id, nombres, apellidos, puntaje, fecha_insc, titulo_superior)
        self.postulantes.append(post)

    def ejecutar_asignacion_completa(self) -> str:
        proceso = ProcesoAsignacion(self.estrategia_desempate, None)  # senescyt en caso de necesitarlo
        proceso.carreras = self.carreras
        proceso.postulantes = self.postulantes

        return proceso.ejecutarAsignacion() + " " + proceso.generarReporteConsolidado()
