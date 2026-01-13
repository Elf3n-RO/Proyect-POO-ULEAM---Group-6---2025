from abc import ABC, abstractmethod
from datetime import datetime
from typing import List, Dict

# ================= INTERFACES =================

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


# ================= ESTRATEGIAS =================

class VulnerabilidadFechaDesempate(IDesempateStrategy):
    def resolve(self, postulantes: List['Postulante']) -> 'Postulante':
        return sorted(
            postulantes,
            key=lambda p: (p.vulnerabilidad, p.fecha_inscripcion)
        )[0]


# ================= SERVICIO EXTERNO =================

class Senescyt(IReportable):
    def generarReportes(self) -> str:
        return "Reportes nacionales generados."


# ================= PROCESO PRINCIPAL =================

class ProcesoAsignacion(IReportable):
    def __init__(self, desempate_strategy: IDesempateStrategy, senescyt: Senescyt):
        self.carreras: List['Carrera'] = []
        self.postulantes: List['Postulante'] = []
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy
        self._senescyt = senescyt

    def ejecutarAsignacion(self) -> str:
        self.procesarAsignacionPorSegmento()
        self.gestionarReasignacion()
        self.resolverEmpate()
        self.redistribuirCupos()
        return "Asignación ejecutada correctamente."

    def procesarAsignacionPorSegmento(self) -> None:
        orden_segmentos = [
            'PoliticaCuotas', 'Vulnerabilidad',
            'MeritoAcademico', 'PoblacionGeneral'
        ]

        for carrera in self.carreras:
            carrera.segmentarCupos()
            for segmento in orden_segmentos:
                postulantes_filtrados = [
                    p for p in self.postulantes if segmento in p.segmentos
                ]
                postulantes_filtrados.sort(
                    key=lambda p: p.calcularPuntaje(),
                    reverse=True
                )

                for postulante in postulantes_filtrados:
                    if carrera.verificarDisponibilidad(segmento):
                        carrera.asignarCupo(postulante)

    def gestionarReasignacion(self) -> None:
        for postulante in self.postulantes:
            if not postulante.asignaciones and not postulante.has_titulo_superior:
                postulante.segmentos.append('PoblacionGeneral')

    def resolverEmpate(self) -> None:
        empatados = [p for p in self.postulantes if len(p.segmentos) > 1]
        if len(empatados) > 1:
            self._desempate_strategy.resolve(empatados)

    def redistribuirCupos(self) -> None:
        pass

    def generarReportes(self) -> str:
        return "Reporte generado."

    def generarReporteConsolidado(self) -> str:
        aceptados = sum(
            1 for p in self.postulantes for a in p.asignaciones if a.aceptado
        )
        return f"Total de cupos aceptados: {aceptados}"


# ================= ENTIDADES =================

class Postulante(IValidable):
    def __init__(
        self,
        tipo_documento: str,
        identificacion: str,
        nombres: str,
        apellidos: str,
        puntaje: float,
        fecha_inscripcion: datetime,
        has_titulo_superior: bool = False
    ):
        self.tipo_documento = tipo_documento
        self.identificacion = identificacion
        self.nombres = nombres.upper()
        self.apellidos = apellidos.upper()
        self.puntaje = puntaje
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior

        self.segmentos: List[str] = []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []

        self.vulnerabilidad = 0.0

    def calcularPuntaje(self) -> float:
        return self.puntaje

    def validarRequisitos(self) -> bool:
        return len(self.identificacion) == 10 and self.puntaje >= 0


class PreferenciaCarrera:
    def __init__(self, postulante, carrera, prioridad):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad


class Carrera(ICupoManager):
    def __init__(self, codigo: str, nombre: str, cuposTotales: int):
        self.codigo = codigo
        self.nombre = nombre.upper()
        self.cuposTotales = cuposTotales
        self.cuposDisponibles = cuposTotales
        self.cuposPorSegmento: Dict[str, int] = {}

    def segmentarCupos(self) -> None:
        self.cuposPorSegmento = {
            'PoliticaCuotas': int(self.cuposTotales * 0.07),
            'Vulnerabilidad': int(self.cuposTotales * 0.15),
            'MeritoAcademico': int(self.cuposTotales * 0.20),
            'PoblacionGeneral': self.cuposTotales
        }

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.cuposPorSegmento.get(segmento, 0) > 0

    def asignarCupo(self, postulante: Postulante) -> bool:
        segmento = postulante.segmentos[0] if postulante.segmentos else 'PoblacionGeneral'
        if self.verificarDisponibilidad(segmento):
            self.cuposPorSegmento[segmento] -= 1
            self.cuposDisponibles -= 1
            postulante.asignaciones.append(AsignacionCupo(postulante, self))
            return True
        return False

    def liberarCupo(self) -> None:
        self.cuposDisponibles += 1


class AsignacionCupo(ICupoManager):
    def __init__(self, postulante: Postulante, carrera: Carrera):
        self.postulante = postulante
        self.carrera = carrera
        self.fechaAsignacion = datetime.now()
        self.aceptado = False

    def segmentarCupos(self) -> None:
        pass

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.carrera.verificarDisponibilidad(segmento)

    def asignarCupo(self, postulante: Postulante) -> bool:
        if self.postulante == postulante:
            self.aceptado = True
            return True
        return False

    def liberarCupo(self) -> None:
        self.aceptado = False
        self.carrera.liberarCupo()