from abc import ABC, abstractmethod
from typing import List, Dict
from datetime import datetime

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
