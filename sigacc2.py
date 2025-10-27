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
        return "Reportes generados."

    def consultarPAA_OA(self, codigo_ies: int, identificacion: str) -> Dict:
        return {
            "periodo": "PRIMER PERIODO 2025",
            "identificacion": identificacion,
            "nombres": "Ejemplo Nombres",
            "apellidos": "Ejemplo Apellidos",
            "cupo_aceptado_historico_pc": "NO",
            "vulnerabilidad_socioeconomica": "NO",
            "merito_academico": "NO",
            "poblacion_general": "SI"
        }

    def consultarRegistroNacional(self, codigo_ies: int, identificacion: str) -> Dict:
        return {
            "tipoDocumento": "CÉDULA",
            "identificacion": identificacion,
            "nombres": "Ejemplo Nombres",
            "apellidos": "Ejemplo Apellidos",
            "nacionalidad": "ECUATORIANA"
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

# Clase ProcesoAsignacion (implementa IReportable, DI)
class ProcesoAsignacion(IReportable):
    def __init__(self, desempate_strategy: IDesempateStrategy):
        self.carreras: List['Carrera'] = []
        self.postulantes: List['Postulante'] = []
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy

    def ejecutarAsignacion(self) -> str:
        self.procesarAsignacionPorSegmento()
        self.gestionarReasignacion()
        self.resolverEmpate()
        self.redistribuirCupos()
        return "Asignación ejecutada."

    def procesarAsignacionPorSegmento(self) -> str:
        orden_segmentos = ['PoliticaCuotas', 'Vulnerabilidad', 'MeritoAcademico', 'OtrosReconocimientos', 'BachilleresPueblos', 'BachilleresGeneral', 'PoblacionGeneral']
        for carrera in self.carreras:
            carrera.segmentarCupos()
            for seg_tipo in orden_segmentos:
                postulantes_seg = sorted([p for p in self.postulantes if seg_tipo in p.segmentos], key=lambda p: p.calcularPuntaje(), reverse=True)
                for postulante in postulantes_seg:
                    if carrera.verificarDisponibilidad(seg_tipo):
                        carrera.asignarCupo(postulante)
        return "Asignación por segmento procesada."

    def gestionarReasignacion(self) -> str:
        for postulante in self.postulantes:
            if not any(ac.aceptado for ac in postulante.asignaciones) and not postulante.has_titulo_superior:
                postulante.segmentos.append('PoblacionGeneral')
        return "Reasignaciones gestionadas."

    def resolverEmpate(self) -> str:
        empatados = self.postulantes[:2]  # Simulado
        if len(empatados) > 1:
            ganador = self._desempate_strategy.resolve(empatados)
            return f"Empate resuelto: {ganador.nombres}"
        return "Sin empates."

    def redistribuirCupos(self) -> str:
        return "Cupos redistribuidos (Art. 55)."

    def generarReportes(self) -> str:
        return "Reportes generados."

    def generarReporteConsolidado(self) -> str:
        aceptados = sum(1 for p in self.postulantes for ac in p.asignaciones if ac.aceptado)
        return f"Consolidado: {aceptados} cupos aceptados."

# Clase Postulante (implementa IValidable)
class Postulante(IValidable):
    def __init__(self, tipo_documento: str, identificacion: str, nombres: str, apellidos: str, puntaje: float, vulnerabilidad: float, fecha_inscripcion: datetime, has_titulo_superior: bool = False, discapacidad: str = "NO", ruralidad: str = "NO", pueblos_nacionalidades: str = "NO", condicion_socioeconomica: str = "NO", merito_academico: str = "NO", bachiller_pueblos_nacionalidad: str = "NO", bachiller_periodo_academico: str = "NO"):
        self.tipo_documento = tipo_documento
        self.identificacion = identificacion
        self.nombres = nombres
        self.apellidos = apellidos
        self.puntaje = puntaje
        self.vulnerabilidad = vulnerabilidad
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior
        self.discapacidad = discapacidad
        self.ruralidad = ruralidad
        self.pueblos_nacionalidades = pueblos_nacionalidades
        self.condicion_socioeconomica = condicion_socioeconomica
        self.merito_academico = merito_academico
        self.bachiller_pueblos_nacionalidad = bachiller_pueblos_nacionalidad
        self.bachiller_periodo_academico = bachiller_periodo_academico
        self.segmentos: List[str] = ['PoblacionGeneral'] if has_titulo_superior else []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []
        self.determinarSegmentos()

    def calcularPuntaje(self) -> float:
        return self.puntaje

    def determinarSegmentos(self) -> None:
        if self.condicion_socioeconomica == "SI":
            self.segmentos.append("Vulnerabilidad")
        if self.merito_academico == "SI":
            self.segmentos.append("MeritoAcademico")

    def validarRequisitos(self) -> bool:
        return True

# Clase PreferenciaCarrera
class PreferenciaCarrera:
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera', prioridad: int):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad

# Clase abstracta Segmento (corregido MRO)
class Segmento(IValidable, ABC):
    def __init__(self, tipo: str, codigo: int, porcentaje_min: float, porcentaje_max: float):
        self.tipo = tipo
        self.codigo = codigo
        self.porcentaje = (porcentaje_min + porcentaje_max) / 2
        self.postulantes: List['Postulante'] = []

    @abstractmethod
    def ordenarPorMerito(self) -> List['Postulante']:
        pass

    def calcularCupos(self, total_cupos: int) -> int:
        return int(total_cupos * self.porcentaje)

    def validarRequisitos(self) -> bool:
        return True

# Subclases
class PoliticaCuotas(Segmento):
    def __init__(self):
        super().__init__('PoliticaCuotas', 1, 0.05, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class Vulnerabilidad(Segmento):
    def __init__(self):
        super().__init__('Vulnerabilidad', 2, 0.10, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: (p.calcularPuntaje(), p.vulnerabilidad), reverse=True)

class MeritoAcademico(Segmento):
    def __init__(self):
        super().__init__('MeritoAcademico', 3, 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class OtrosReconocimientos(Segmento):
    def __init__(self):
        super().__init__('OtrosReconocimientos', 4, 0.0, 0.02)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class BachilleresPueblos(Segmento):
    def __init__(self):
        super().__init__('BachilleresPueblos', 5, 0.0, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class BachilleresGeneral(Segmento):
    def __init__(self):
        super().__init__('BachilleresGeneral', 6, 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class PoblacionGeneral(Segmento):
    def __init__(self):
        super().__init__('PoblacionGeneral', 7, 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

# Clase Carrera (implementa ICupoManager)
class Carrera(ICupoManager):
    def __init__(self, codigo: str, nombre: str, cuposTotales: int):
        self.codigo = codigo
        self.nombre = nombre
        self.cuposTotales = cuposTotales
        self.cuposDisponibles = cuposTotales
        self.cuposPorSegmento: Dict[str, int] = {}

    def segmentarCupos(self) -> None:
        segmentos = ['PoliticaCuotas', 'Vulnerabilidad', 'MeritoAcademico', 'OtrosReconocimientos', 'BachilleresPueblos', 'BachilleresGeneral', 'PoblacionGeneral']
        for seg in segmentos:
            self.cuposPorSegmento[seg] = int(self.cuposTotales * 0.143)

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.cuposPorSegmento.get(segmento, 0) > 0

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        segmento = postulante.segmentos[0] if postulante.segmentos else 'PoblacionGeneral'
        if self.verificarDisponibilidad(segmento):
            self.cuposPorSegmento[segmento] -= 1
            self.cuposDisponibles -= 1
            asignacion = AsignacionCupo(postulante, self)
            postulante.asignaciones.append(asignacion)
            return True
        return False

    def liberarCupo(self) -> None:
        self.cuposDisponibles += 1

# Clase AsignacionCupo (implementa ICupoManager)
class AsignacionCupo(ICupoManager):
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera'):
        self.postulante = postulante
        self.carrera = carrera
        self.fechaAsignacion = datetime.now()
        self.aceptado = False

    def segmentarCupos(self) -> None:
        pass

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.carrera.verificarDisponibilidad(segmento)

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        self.aceptado = True
        return True

    def liberarCupo(self) -> None:
        self.aceptado = False
        self.carrera.liberarCupo()

    def registrarAceptacionCupo(self) -> str:
        if not self.aceptado:
            self.aceptado = True
            return "Aceptado."
        return "Ya aceptado."

# Ejemplo de uso
if __name__ == "__main__":
    desempate = VulnerabilidadFechaDesempate()
    proceso = ProcesoAsignacion(desempate)
    carrera = Carrera("GEN01", "Carrera General", 100)
    proceso.carreras.append(carrera)

    postulante = Postulante("CÉDULA", "1234567890", "Aspirante", "Ejemplo", 850.0, 0.5, datetime.now(), False, "NO", "SI", "NO")
    postulante.segmentos.append("MeritoAcademico")
    proceso.postulantes.append(postulante)

    pref = PreferenciaCarrera(postulante, carrera, 1)
    postulante.preferenciaCarrera.append(pref)

    print(proceso.ejecutarAsignacion())
    if postulante.asignaciones:
        print(postulante.asignaciones[0].registrarAceptacionCupo())
    print(proceso.generarReporteConsolidado())