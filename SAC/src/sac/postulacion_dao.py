from conexion import obtener_conexion

def insertar_postulacion(id_estudiante, id_carrera, prioridad):
    conn = obtener_conexion()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO postulaciones (id_estudiante, id_carrera, prioridad)
        VALUES (?, ?, ?)
    """)

    conn.commit()
    conn.close()