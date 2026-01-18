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
        # Si no se han calculado segmentos, forzamos el cálculo
        if not self.cuposPorSegmento:
            self.segmentarCupos()
            
        segmento = postulante.segmentos[0] if postulante.segmentos else 'PoblacionGeneral'
        
        # Lógica simplificada: si hay cupos generales, asignar
        if self.cuposDisponibles > 0:
            if segmento in self.cuposPorSegmento and self.cuposPorSegmento[segmento] > 0:
                self.cuposPorSegmento[segmento] -= 1
            
            self.cuposDisponibles -= 1
            # Importación local para evitar error circular
            from modelos import AsignacionCupo
            asignacion = AsignacionCupo(postulante, self)
            postulante.asignaciones.append(asignacion)
            return True
        return False

    def liberarCupo(self) -> None:
        self.cuposDisponibles += 1
