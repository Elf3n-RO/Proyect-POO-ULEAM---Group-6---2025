from abc import ABC, abstractmethod
from datetime import datetime
from typing import List, Dict

# Interfaces (ABC)
class IReportable(ABC):
    @abstractmethod
    def generarReportes(self) -> str:
        pass

class ICupoManager(ABC):
    @abstractmethod
    def segmentarCupos(self) -> None:
        pass

    @abstractmethod
    def verificarDisponibilidad(self, segmento: str) -> bool:
        pass

    @abstractmethod
    def asignarCupo(self, postulante) -> bool:
        pass

    @abstractmethod
    def liberarCupo(self) -> None:
        pass

class IValidable(ABC):
    @abstractmethod
    def validarRequisitos(self) -> bool:
        pass

class IDesempateStrategy(ABC):
    @abstractmethod
    def resolve(self, postulantes: List['Postulante']) -> 'Postulante':
        pass

# Estrategia concreta (Art. 54)
class VulnerabilidadFechaDesempate(IDesempateStrategy):
    def resolve(self, postulantes: List['Postulante']) -> 'Postulante':
        return sorted(postulantes, key=lambda p: (p.vulnerabilidad, p.fecha_inscripcion))[0]

# Clase Senescyt (implementa IReportable, simula web services)
class Senescyt(IReportable):
    def __init__(self):
        self.ies: List['IES'] = []

    def supervisarCumplimiento(self) -> str:
        return "Supervisión realizada."

    def auditarProcesos(self) -> str:
        return "Auditoría completada."

    def generarReportes(self) -> str:
        return "Reportes nacionales generados."

    def consultarPAA_OA(self, codigo_ies: int, identificacion: str) -> Dict:
        # Simulación del servicio web consultarPAA_OA
        return {
            "periodo": "PRIMER PERIODO 2025",
            "identificacion": identificacion,
            "nombres": "EJEMPLO NOMBRES",
            "apellidos": "EJEMPLO APELLIDOS",
            "condicion_socioeconomica": "SI",
            "discapacidad": "NO",
            "pueblos_nacionalidades": "NO",
            "merito_academico": "SI",
            "bachiller_periodo_academico": "SI",
            "poblacion_general": "NO",
            "mensajeRespuesta": "Consulta exitosa"
        }

    def consultarRegistroNacional(self, codigo_ies: int, identificacion: str) -> Dict:
        # Simulación del servicio web consultarRegistroNacional
        return {
            "tipoDocumento": "CÉDULA",
            "identificacion": identificacion,
            "nombres": "EJEMPLO NOMBRES",
            "apellidos": "EJEMPLO APELLIDOS",
            "nacionalidad": "ECUATORIANA",
            "fechaNacimiento": "01/01/2000",
            "autoidentificacion": "Mestiza/o",
            "mensajeRespuesta": "Consulta exitosa"
        }

# Clase IES (implementa IReportable)
class IES(IReportable):
    def __init__(self, nombre: str, codigo: str):
        self.nombre = nombre
        self.codigo = codigo
        self.porcentajes_segmentos: Dict[str, float] = {}

    def configurarPorcentajes(self, segmento: str, porcentaje: float):
        self.porcentajes_segmentos[segmento] = porcentaje

    def generarReportes(self) -> str:
        return f"Reportes para IES {self.nombre}."

# Clase ProcesoAsignacion (implementa IReportable, Inyección de Dependencias)
class ProcesoAsignacion(IReportable):
    def __init__(self, desempate_strategy: IDesempateStrategy, senescyt: Senescyt):
        self.carreras: List['Carrera'] = []
        self.postulantes: List['Postulante'] = []
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy  # DI
        self._senescyt = senescyt  # DI para servicios web

    def ejecutarAsignacion(self) -> str:
        self.procesarAsignacionPorSegmento()
        self.gestionarReasignacion()
        self.resolverEmpate()
        self.redistribuirCupos()
        return "Asignación ejecutada (Art. 51)."

    def procesarAsignacionPorSegmento(self) -> str:
        # Orden de segmentos según Art. 52
        orden_segmentos = [
            'PoliticaCuotas', 'Vulnerabilidad', 'MeritoAcademico', 
            'OtrosReconocimientos', 'BachilleresPueblos', 
            'BachilleresGeneral', 'PoblacionGeneral'
        ]
        
        for carrera in self.carreras:
            carrera.segmentarCupos()
            for seg_tipo in orden_segmentos:
                postulantes_seg = [p for p in self.postulantes if seg_tipo in p.segmentos]
                postulantes_seg.sort(key=lambda p: p.calcularPuntaje(), reverse=True)
                
                for postulante in postulantes_seg:
                    if carrera.verificarDisponibilidad(seg_tipo):
                        carrera.asignarCupo(postulante)
        return "Asignación por segmento procesada."

    def gestionarReasignacion(self) -> str:
        # Reasignación según Art. 52
        for postulante in self.postulantes:
            if not any(ac.aceptado for ac in postulante.asignaciones):
                if not postulante.has_titulo_superior:
                    postulante.segmentos.append('PoblacionGeneral')
        return "Reasignaciones gestionadas."

    def resolverEmpate(self) -> str:
        # Desempate usando estrategia inyectada (Art. 54)
        empatados = [p for p in self.postulantes if len(p.segmentos) > 1][:2]  # Simulado
        if len(empatados) > 1:
            ganador = self._desempate_strategy.resolve(empatados)
            return f"Empate resuelto: {ganador.nombres} {ganador.apellidos}"
        return "Sin empates."

    def redistribuirCupos(self) -> str:
        # Redistribución de cupos no usados (Art. 55)
        return "Cupos redistribuidos a población general."

    def generarReportes(self) -> str:
        return "Reportes de asignación generados."

    def generarReporteConsolidado(self) -> str:
        aceptados = sum(1 for p in self.postulantes for ac in p.asignaciones if ac.aceptado)
        return f"Consolidado: {aceptados} cupos aceptados."

# Clase Postulante (implementa IValidable)
class Postulante(IValidable):
    def __init__(self, tipo_documento: str, identificacion: str, nombres: str, apellidos: str, puntaje: float, fecha_inscripcion: datetime, has_titulo_superior: bool = False):
        self.tipo_documento = tipo_documento
        self.identificacion = identificacion
        self.nombres = nombres.upper()  # Mayúsculas según diccionario
        self.apellidos = apellidos.upper()
        self.puntaje = puntaje
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior
        
        # Campos de PAA/OA del diccionario (simulados)
        self.condicion_socioeconomica = "NO"
        self.discapacidad = "NO"
        self.pueblos_nacionalidades = "NO"
        self.merito_academico = "NO"
        self.bachiller_periodo_academico = "NO"
        self.bachiller_pueblos_nacionalidad = "NO"
        self.ruralidad = "NO"
        self.territorialidad = "NO"
        self.vulnerabilidad = 0.0  # Para desempate
        
        self.segmentos: List[str] = ['PoblacionGeneral'] if has_titulo_superior else []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []
        
        self.determinarSegmentos()

    def calcularPuntaje(self) -> float:
        return self.puntaje

    def determinarSegmentos(self) -> None:
        # Lógica basada en diccionario PAA/OA (Art. 52)
        if self.condicion_socioeconomica == "SI":
            self.segmentos.insert(0, "Vulnerabilidad")
        if self.merito_academico == "SI":
            self.segmentos.insert(0, "MeritoAcademico")
        if self.bachiller_periodo_academico == "SI":
            self.segmentos.insert(0, "BachilleresGeneral")
        if self.pueblos_nacionalidades == "SI":
            self.segmentos.insert(0, "BachilleresPueblos")

    def validarRequisitos(self) -> bool:
        # Validación simple basada en normativa
        return len(self.identificacion) == 10 and self.puntaje >= 0

# Clase PreferenciaCarrera (campos del diccionario inscripción)
class PreferenciaCarrera:
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera', prioridad: int, nombre_carrera: str, ofa_id: int, cus_id: int):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad  # 1, 2, 3 según diccionario
        self.nombre_carrera = nombre_carrera.upper()
        self.ofa_id = ofa_id
        self.cus_id = cus_id
