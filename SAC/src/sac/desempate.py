from typing import List
from interfaz import IDesempateStrategy
from modelos import Postulante

class VulnerabilidadFechaDesempate(IDesempateStrategy):
    def resolve(self, postulantes: List[Postulante]) -> Postulante:
        # Ordena por vulnerabilidad (mayor) y luego por fecha de inscripción (más antigua primero)
        return sorted(postulantes, key=lambda p: (-p.vulnerabilidad, p.fecha_inscripcion))[0]
