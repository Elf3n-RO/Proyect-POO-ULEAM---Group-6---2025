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

# Estrategia concreta (polimorfismo, Art. 54)
class VulnerabilidadFechaDesempate(IDesempateStrategy):
    def resolve(self, postulantes: List['Postulante']) -> 'Postulante':
        return sorted(postulantes, key=lambda p: (p.vulnerabilidad, p.fecha_inscripcion))[0]

# Clase Senescyt (implementa IReportable)
class Senescyt(IReportable):
    def __init__(self):
        self.ies: List['IES'] = []

    def supervisarCumplimiento(self) -> str:
        return "Supervisión realizada."

    def auditarProcesos(self) -> str:
        return "Auditoría completada."

    def generarReportes(self) -> str:
        return "Reportes nacionales generados."

# Clase IES (implementa IReportable)
class IES(IReportable):
    def __init__(self, nombre: str, codigo: str):
        self.nombre = nombre
        self.codigo = codigo
        self.porcentajes_segmentos: Dict[str, float] = {}  # Configurables (Art. 52)

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
            return f"Empate resuelto: {ganador.nombre}"
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
    def __init__(self, cedula: str, nombre: str, puntaje: float, vulnerabilidad: float, fecha_inscripcion: datetime, has_titulo_superior: bool = False):
        self.cedula = cedula
        self.nombre = nombre
        self.puntaje = puntaje
        self.vulnerabilidad = vulnerabilidad
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior
        self.segmentos: List[str] = ['PoblacionGeneral'] if has_titulo_superior else []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []

    def calcularPuntaje(self) -> float:
        return self.puntaje

    def determinarSegmentos(self) -> None:
        pass  # Lógica para agregar segmentos basada en criterios

    def validarRequisitos(self) -> bool:
        return True  # Simple

# Clase PreferenciaCarrera
class PreferenciaCarrera:
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera', prioridad: int):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad

# Clase abstracta Segmento (ABC, herencia/polimorfismo)
class Segmento(ABC, IValidable):
    def __init__(self, tipo: str, porcentaje_min: float, porcentaje_max: float):
        self.tipo = tipo
        self.porcentaje = (porcentaje_min + porcentaje_max) / 2  # Promedio simple
        self.criterios: List[str] = []
        self.postulantes: List['Postulante'] = []

    @abstractmethod
    def ordenarPorMerito(self) -> List['Postulante']:
        pass

    def calcularCupos(self, total_cupos: int) -> int:
        return int(total_cupos * self.porcentaje)

    def validarRequisitos(self) -> bool:
        return True

# Subclases (herencia, polimorfismo diferente)
class PoliticaCuotas(Segmento):
    def __init__(self):
        super().__init__('PoliticaCuotas', 0.05, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class Vulnerabilidad(Segmento):
    def __init__(self):
        super().__init__('Vulnerabilidad', 0.10, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: (p.calcularPuntaje(), p.vulnerabilidad), reverse=True)

class MeritoAcademico(Segmento):
    def __init__(self):
        super().__init__('MeritoAcademico', 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class OtrosReconocimientos(Segmento):
    def __init__(self):
        super().__init__('OtrosReconocimientos', 0.0, 0.02)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class BachilleresPueblos(Segmento):
    def __init__(self):
        super().__init__('BachilleresPueblos', 0.0, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class BachilleresGeneral(Segmento):
    def __init__(self):
        super().__init__('BachilleresGeneral', 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class PoblacionGeneral(Segmento):
    def __init__(self):
        super().__init__('PoblacionGeneral', 0.20, 0.20)

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
            self.cuposPorSegmento[seg] = int(self.cuposTotales * 0.143)  # Aprox igual

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.cuposPorSegmento.get(segmento, 0) > 0

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        segmento = postulante.segmentos[0]
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
            return "Aceptado (Art. 56)."
        return "Ya aceptado."

# Ejemplo simple
if __name__ == "__main__":
    desempate = VulnerabilidadFechaDesempate()
    proceso = ProcesoAsignacion(desempate)
    carrera = Carrera("GEN01", "Carrera General", 100)
    proceso.carreras.append(carrera)

    postulante = Postulante("1234567890", "Aspirante", 850.0, 0.5, datetime.now(), False)
    postulante.segmentos.append("MeritoAcademico")
    proceso.postulantes.append(postulante)

    pref = PreferenciaCarrera(postulante, carrera, 1)
    postulante.preferenciaCarrera.append(pref)

    print(proceso.ejecutarAsignacion())
    if postulante.asignaciones:
        print(postulante.asignaciones[0].registrarAceptacionCupo())
    print(proceso.generarReporteConsolidado())