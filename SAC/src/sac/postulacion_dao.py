from conexion import obtener_conexion

def insertar_postulacion(id_postulante, id_carrera, prioridad):
    conn = obtener_conexion()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO postulantes (id_postulante, id_carrera, prioridad)
        VALUES (?, ?, ?)
    """)

    conn.commit()
    conn.close()