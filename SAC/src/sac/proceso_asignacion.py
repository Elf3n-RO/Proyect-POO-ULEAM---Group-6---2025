from datetime import datetime
from typing import List
from interfaz import IReportable
from carrera import Carrera
from modelos import Postulante

class ProcesoAsignacion(IReportable):
    def __init__(self, desempate_strategy, senescyt):
        self.carreras: List[Carrera] = []
        self.postulantes: List[Postulante] = []
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy
        self._senescyt = senescyt

    def ejecutarAsignacion(self) -> str:
        self.procesarAsignacionPorSegmento()
        self.gestionarReasignacion()
        self.resolverEmpate()
        self.redistribuirCupos()
        return "Asignación ejecutada (Art. 51)."

    def procesarAsignacionPorSegmento(self) -> str:
        orden_segmentos = [
            'PoliticaCuotas', 'Vulnerabilidad', 'MeritoAcademico',
            'OtrosReconocimientos', 'BachilleresPueblos',
            'BachilleresGeneral', 'PoblacionGeneral'
        ]

        for carrera in self.carreras:
            carrera.segmentarCupos()
            for seg_tipo in orden_segmentos:
                postulantes_seg = [p for p in self.postulantes if seg_tipo in p.segmentos]
                postulantes_seg.sort(key=lambda p: p.calcularPuntaje(), reverse=True)

                for postulante in postulantes_seg:
                    if carrera.verificarDisponibilidad(seg_tipo):
                        carrera.asignarCupo(postulante)
        return "Asignación por segmento procesada."

    def gestionarReasignacion(self) -> str:
        for postulante in self.postulantes:
            if not any(ac.aceptado for ac in postulante.asignaciones):
                if not postulante.has_titulo_superior:
                    postulante.segmentos.append('PoblacionGeneral')
        return "Reasignaciones gestionadas."

    def resolverEmpate(self) -> str:
        empatados = [p for p in self.postulantes if len(p.segmentos) > 1][:2]
        if len(empatados) > 1:
            ganador = self._desempate_strategy.resolve(empatados)
            return f"Empate resuelto: {ganador.nombres} {ganador.apellidos}"
        return "Sin empates."

    def redistribuirCupos(self) -> str:
        return "Cupos redistribuidos a población general."

    def generarReportes(self) -> str:
        return "Reportes de asignación generados."

    def generarReporteConsolidado(self) -> str:
        aceptados = sum(1 for p in self.postulantes for ac in p.asignaciones if ac.aceptado)
        return f"Consolidado: {aceptados} cupos aceptados."
