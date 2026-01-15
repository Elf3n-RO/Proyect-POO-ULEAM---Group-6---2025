from datetime import datetime
from interfaz import IReportable
from conexion import obtener_conexion


class ProcesoAsignacion(IReportable):

    def __init__(self, desempate_strategy, senescyt):
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy
        self._senescyt = senescyt

    def ejecutarAsignacion(self) -> str:
        self.procesarAsignacionPorSegmento()
        return "Asignación ejecutada (Art. 51)."

    def procesarAsignacionPorSegmento(self) -> str:
        conn = obtener_conexion()
        cursor = conn.cursor()

        # 🔹 Estudiantes ordenados por puntaje y prioridad
        cursor.execute("""
            SELECT  
                e.id_postulante,
                c.id_carrera
            FROM postulantes e
            LEFT JOIN asignaciones a ON e.id_postulante = a.id_postulante
            JOIN carreras c ON e.id_carrera = c.id_carrera
            WHERE a.id_postulante IS NULL
                AND c.cupos_disponibles > 0
            ORDER BY  
                e.puntaje DESC,
                e.prioridad ASC;
        """)

        registros = cursor.fetchall()

        for id_postulante, id_carrera in registros:

            # 🔹 Verificar cupos actualizados
            cursor.execute("""
                SELECT cupos_disponibles
                FROM carreras
                WHERE id_carrera = ?
            """, (id_carrera,))

            resultado = cursor.fetchone()

            if not resultado:
                continue

            cupos = resultado[0]

            if cupos > 0:
                # 🔹 Registrar asignación
                cursor.execute("""
                    INSERT INTO asignaciones (
                        id_postulante,
                        id_carrera,
                        fecha_asignacion,
                        aceptado
                    )
                    VALUES (?, ?, GETDATE(), 1)
                """, (id_postulante, id_carrera))

                # 🔹 Actualizar cupos
                cursor.execute("""
                    UPDATE carreras
                    SET cupos_disponibles = cupos_disponibles - 1
                    WHERE id_carrera = ?
                """, (id_carrera,))

        conn.commit()
        conn.close()
        return "Asignación por segmento procesada."

    def generarReportes(self) -> str:
        return "Reportes de asignación generados."

    def generarReporteConsolidado(self) -> str:
        conn = obtener_conexion()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT COUNT(*) 
            FROM asignaciones
            WHERE aceptado = 1
        """)

        total = cursor.fetchone()[0]
        conn.close()

        return f"Consolidado: {total} cupos aceptados."