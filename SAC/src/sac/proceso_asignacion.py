from datetime import datetime
from interfaz import IReportable

class ProcesoAsignacion(IReportable):
    def __init__(self, desempate_strategy, senescyt):
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy
        self._senescyt = senescyt
        self.postulantes = []  # Se llena desde app.py
        self.carreras = []    # Se llena desde app.py

    def ejecutarAsignacion(self) -> str:
        if not self.postulantes:
            return "Error: No hay postulantes cargados."

        # 1. Ordenar postulantes por puntaje (y desempate según estrategia)
        # Usamos una función que aplica tu estrategia de desempate
        from functools import cmp_to_key
        
        def comparar_postulantes(p1, p2):
            if p1.puntaje != p2.puntaje:
                return 1 if p1.puntaje < p2.puntaje else -1
            # Si hay empate en puntaje, usar la estrategia (Vulnerabilidad o Mérito)
            return -1 if self._desempate_strategy.comparar(p1, p2) else 1

        self.postulantes.sort(key=cmp_to_key(comparar_postulantes))

        contador_asignados = 0

        # 2. Asignación lógica
        for postulante in self.postulantes:
            # Revisar las preferencias del postulante por orden de prioridad
            # Ordenamos sus preferencias internamente por el atributo prioridad
            postulante.preferenciaCarrera.sort(key=lambda x: x.prioridad)
            
            for preferencia in postulante.preferenciaCarrera:
                carrera = preferencia.carrera
                
                # Intentar asignar cupo usando el método de la clase Carrera
                # Este método ya resta de cuposDisponibles y cuposPorSegmento
                if carrera.asignarCupo(postulante):
                    from modelos import AsignacionCupo
                    nueva_asignacion = AsignacionCupo(postulante, carrera)
                    postulante.asignaciones.append(nueva_asignacion)
                    contador_asignados += 1
                    break # Cupo asignado, pasar al siguiente estudiante

        return f"Proceso completado. Se asignaron {contador_asignados} cupos con éxito."

    def generarReportes(self): return "Reporte generado"
    def generarReporteConsolidado(self): return "Consolidado generado"