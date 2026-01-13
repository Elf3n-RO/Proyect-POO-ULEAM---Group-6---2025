from typing import Dict
from interfaz import ICupoManager

class Carrera(ICupoManager):
    def __init__(self, codigo: str, nombre: str, cuposTotales: int):
        self.codigo = codigo
        self.nombre = nombre.upper()
        self.cuposTotales = cuposTotales
        self.cuposDisponibles = cuposTotales
        self.cuposPorSegmento: Dict[str, int] = {}

    def segmentarCupos(self) -> None:
        segmentos = {
            'PoliticaCuotas': 0.07,
            'Vulnerabilidad': 0.15,
            'MeritoAcademico': 0.20,
            'PoblacionGeneral': 0.58
        }
        for seg, porc in segmentos.items():
            self.cuposPorSegmento[seg] = int(self.cuposTotales * porc)

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.cuposPorSegmento.get(segmento, 0) > 0

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        segmento = postulante.segmentos[0] if postulante.segmentos else 'PoblacionGeneral'
        if self.verificarDisponibilidad(segmento):
            self.cuposPorSegmento[segmento] -= 1
            self.cuposDisponibles -= 1
            from .modelos import AsignacionCupo
            asignacion = AsignacionCupo(postulante, self)
            postulante.asignaciones.append(asignacion)
            return True
        return False

    def liberarCupo(self) -> None:
        self.cuposDisponibles += 1
