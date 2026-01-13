# Builder (Creacional)

from typing import Dict
from SAC.src.sac.interfaz import ICupoManager
from sigacc3 import AsignacionCupo, Postulante

#producto
class Carrera(ICupoManager):
    def __init__(
        self,
        codigo: str,
        nombre: str,
        cupos_totales: int,
        cupos_por_segmento: Dict[str, int]
    ):
        self.codigo = codigo
        self.nombre = nombre.upper()
        self.cuposTotales = cupos_totales
        self.cuposDisponibles = cupos_totales
        self.cuposPorSegmento = cupos_por_segmento

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.cuposPorSegmento.get(segmento, 0) > 0

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        segmento = (
            postulante.segmentos[0]
            if postulante.segmentos
            else 'PoblacionGeneral'
        )

        if self.verificarDisponibilidad(segmento):
            self.cuposPorSegmento[segmento] -= 1
            self.cuposDisponibles -= 1

            asignacion = AsignacionCupo(postulante, self)
            postulante.asignaciones.append(asignacion)
            return True

        return False

    def liberarCupo(self, segmento: str) -> None:
        self.cuposPorSegmento[segmento] += 1
        self.cuposDisponibles += 1

#builder
class CarreraBuilder:
    def __init__(self):
        self.reset()

    def reset(self):
        self._codigo = None
        self._nombre = None
        self._cupos_totales = None
        self._segmentos_porcentajes = {
            'PoliticaCuotas': 0.07,
            'Vulnerabilidad': 0.15,
            'MeritoAcademico': 0.20,
            'PoblacionGeneral': 0.58
        }

    def con_codigo(self, codigo: str):
        self._codigo = codigo
        return self

    def con_nombre(self, nombre: str):
        self._nombre = nombre
        return self

    def con_cupos_totales(self, cupos: int):
        if cupos <= 0:
            raise ValueError("Los cupos deben ser mayores a cero")
        self._cupos_totales = cupos
        return self

    def con_porcentajes(self, porcentajes: Dict[str, float]):
        if abs(sum(porcentajes.values()) - 1.0) > 0.01:
            raise ValueError("Los porcentajes deben sumar 1.0")
        self._segmentos_porcentajes = porcentajes
        return self

    def _calcular_cupos_por_segmento(self) -> Dict[str, int]:
        cupos = {
            seg: int(self._cupos_totales * porc)
            for seg, porc in self._segmentos_porcentajes.items()
        }

        # Ajuste por redondeo
        diferencia = self._cupos_totales - sum(cupos.values())
        cupos['PoblacionGeneral'] += diferencia

        return cupos

    def build(self) -> Carrera:
        if not all([self._codigo, self._nombre, self._cupos_totales]):
            raise ValueError("Faltan parámetros obligatorios para construir Carrera")

        cupos_por_segmento = self._calcular_cupos_por_segmento()

        carrera = Carrera(
            codigo=self._codigo,
            nombre=self._nombre,
            cupos_totales=self._cupos_totales,
            cupos_por_segmento=cupos_por_segmento
        )

        self.reset()
        return carrera