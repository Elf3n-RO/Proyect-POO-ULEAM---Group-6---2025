from typing import List
from abc import ABC, abstractmethod
from .modelos import Postulante

class Segmento(ABC):
    def __init__(self, tipo: str, codigo: int, porcentaje_min: float, porcentaje_max: float):
        self.tipo = tipo
        self.codigo = codigo
        self.porcentaje_min = porcentaje_min
        self.porcentaje_max = porcentaje_max
        self.porcentaje = (porcentaje_min + porcentaje_max) / 2
        self.postulantes: List[Postulante] = []

    @abstractmethod
    def ordenarPorMerito(self) -> List[Postulante]:
        pass

    def calcularCupos(self, total_cupos: int) -> int:
        return int(total_cupos * self.porcentaje)

    def validarRequisitos(self) -> bool:
        return all(p.validarRequisitos() for p in self.postulantes)

class PoliticaCuotas(Segmento):
    def __init__(self):
        super().__init__('PoliticaCuotas', 1, 0.05, 0.10)

    def ordenarPorMerito(self) -> List[Postulante]:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class Vulnerabilidad(Segmento):
    def __init__(self):
        super().__init__('Vulnerabilidad', 2, 0.10, 0.20)

    def ordenarPorMerito(self) -> List[Postulante]:
        return sorted(self.postulantes, key=lambda p: (p.calcularPuntaje(), p.vulnerabilidad), reverse=True)

class MeritoAcademico(Segmento):
    def __init__(self):
        super().__init__('MeritoAcademico', 3, 0.20, 0.20)

    def ordenarPorMerito(self) -> List[Postulante]:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class PoblacionGeneral(Segmento):
    def __init__(self):
        super().__init__('PoblacionGeneral', 7, 0.20, 0.20)

    def ordenarPorMerito(self) -> List[Postulante]:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)
