from abc import ABC, abstractmethod

class EstrategiaDesempate(ABC):
    @abstractmethod
    def comparar(self, p1, p2):
        pass

class VulnerabilidadFechaDesempate(EstrategiaDesempate):
    def comparar(self, p1, p2):
        # 1. Prioridad por Vulnerabilidad (Mayor es mejor)
        if p1.vulnerabilidad != p2.vulnerabilidad:
            return p1.vulnerabilidad > p2.vulnerabilidad
        # 2. Empate: Por fecha de inscripción (Primero es mejor)
        return p1.fecha_inscripcion < p2.fecha_inscripcion

class MeritoAcademicoDesempate(EstrategiaDesempate):
    def comparar(self, p1, p2):
        # 1. Prioridad por Mérito Académico ("SI" va antes que "NO")
        if p1.merito_academico != p2.merito_academico:
            return p1.merito_academico == "SI"
        # 2. Empate: Por Índice de Vulnerabilidad
        if p1.vulnerabilidad != p2.vulnerabilidad:
            return p1.vulnerabilidad > p2.vulnerabilidad
        # 3. Empate total: Fecha de inscripción
        return p1.fecha_inscripcion < p2.fecha_inscripcion