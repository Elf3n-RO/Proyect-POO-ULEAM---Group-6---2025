from datetime import datetime
from typing import List

class Postulante:
    def __init__(self, tipo_documento, identificacion, nombres, apellidos, puntaje, fecha_inscripcion, has_titulo_superior=False):
        self.tipo_documento = tipo_documento
        self.identificacion = identificacion
        self.nombres = nombres.upper()
        self.apellidos = apellidos.upper()
        self.puntaje = puntaje
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior

        # Campos de desempate (se llenan desde SQL Server)
        self.condicion_socioeconomica = "NO"
        self.discapacidad = "NO"
        self.pueblos_nacionalidades = "NO"
        self.merito_academico = "NO"
        self.ruralidad = "NO"
        self.territorialidad = "NO"
        self.vulnerabilidad = 0.0

        # Relaciones
        self.segmentos: List[str] = []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []

    def calcularPuntaje(self) -> float:
        return self.puntaje

class PreferenciaCarrera:
    def __init__(self, postulante, carrera, prioridad, nombre_carrera, ofa_id, cus_id):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad
        self.nombre_carrera = nombre_carrera.upper()
        self.ofa_id = ofa_id
        self.cus_id = cus_id

class AsignacionCupo:
    def __init__(self, postulante, carrera):
        self.postulante = postulante
        self.carrera = carrera
        self.fechaAsignacion = datetime.now()
        self.aceptado = True  # Al asignarse por el Art. 51, se marca como pre-aceptado