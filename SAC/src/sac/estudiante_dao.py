from conexion import obtener_conexion

def insertar_estudiante(cedula, nombres, puntaje):
    conn = obtener_conexion()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO postulantes (cedula, nombres, puntaje)
        VALUES (?, ?, ?)
    """, (cedula, nombres, puntaje))

    conn.commit()
    conn.close()


def obtener_estudiantes_por_puntaje():
    conn = obtener_conexion()
    cursor = conn.cursor()

    cursor.execute("""
        SELECT id_postulante, puntaje
        FROM postulantes
        ORDER BY puntaje DESC
    """)

    datos = cursor.fetchall()
    conn.close()
    return datos