# Builder (Creacional)

from typing import Dict
from interfazGrafica import ICupoManager
from sigacc3 import AsignacionCupo, Postulante

class Carrera(ICupoManager):
    def __init__(self, codigo: str, nombre: str, cuposTotales: int, cuposPorSegmento: Dict[str, int]):
        self.codigo = codigo
        self.nombre = nombre.upper()
        self.cuposTotales = cuposTotales
        self.cuposDisponibles = cuposTotales
        self.cuposPorSegmento = cuposPorSegmento

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


class CarreraBuilder:
    def __init__(self):
        self.codigo = None
        self.nombre = None
        self.cuposTotales = None
        self.segmentos_porcentajes = {
            'PoliticaCuotas': 0.07,
            'Vulnerabilidad': 0.15,
            'MeritoAcademico': 0.20,
            'PoblacionGeneral': 0.58
        }

    def con_codigo(self, codigo: str):
        self.codigo = codigo
        return self

    def con_nombre(self, nombre: str):
        self.nombre = nombre
        return self

    def con_cupos(self, cupos: int):
        self.cuposTotales = cupos
        return self

    def con_porcentajes_personalizados(self, porcentajes: Dict[str, float]):
        self.segmentos_porcentajes = porcentajes
        return self

    def build(self) -> Carrera:
        if not all([self.codigo, self.nombre, self.cuposTotales]):
            raise ValueError("Faltan parámetros obligatorios")
        cupos_seg = {seg: int(self.cuposTotales * porc) for seg, porc in self.segmentos_porcentajes.items()}
        return Carrera(self.codigo, self.nombre, self.cuposTotales, cupos_seg)