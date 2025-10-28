from datetime import datetime
from typing import List
from .interfaz import IValidable
from .carrera import Carrera

class Postulante(IValidable):
    def __init__(self, tipo_documento: str, identificacion: str, nombres: str, apellidos: str, puntaje: float, fecha_inscripcion: datetime, has_titulo_superior: bool = False):
        self.tipo_documento = tipo_documento
        self.identificacion = identificacion
        self.nombres = nombres.upper()
        self.apellidos = apellidos.upper()
        self.puntaje = puntaje
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior

        self.condicion_socioeconomica = "NO"
        self.discapacidad = "NO"
        self.pueblos_nacionalidades = "NO"
        self.merito_academico = "NO"
        self.bachiller_periodo_academico = "NO"
        self.bachiller_pueblos_nacionalidad = "NO"
        self.ruralidad = "NO"
        self.territorialidad = "NO"
        self.vulnerabilidad = 0.0

        self.segmentos: List[str] = ['PoblacionGeneral'] if has_titulo_superior else []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []

        self.determinarSegmentos()

    def calcularPuntaje(self) -> float:
        return self.puntaje

    def determinarSegmentos(self) -> None:
        if self.condicion_socioeconomica == "SI":
            self.segmentos.insert(0, "Vulnerabilidad")
        if self.merito_academico == "SI":
            self.segmentos.insert(0, "MeritoAcademico")
        if self.bachiller_periodo_academico == "SI":
            self.segmentos.insert(0, "BachilleresGeneral")
        if self.pueblos_nacionalidades == "SI":
            self.segmentos.insert(0, "BachilleresPueblos")

    def validarRequisitos(self) -> bool:
        return len(self.identificacion) == 10 and self.puntaje >= 0

class PreferenciaCarrera:
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera', prioridad: int, nombre_carrera: str, ofa_id: int, cus_id: int):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad
        self.nombre_carrera = nombre_carrera.upper()
        self.ofa_id = ofa_id
        self.cus_id = cus_id

class AsignacionCupo:
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera'):
        self.postulante = postulante
        self.carrera = carrera
        self.fechaAsignacion = datetime.now()
        self.aceptado = False

    def registrarAceptacionCupo(self) -> str:
        if not self.aceptado:
            self.aceptado = True
            return f"Cupo aceptado para {self.postulante.nombres} {self.postulante.apellidos}"


        return "Ya aceptado."
