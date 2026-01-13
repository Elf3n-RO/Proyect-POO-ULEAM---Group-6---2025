from conexion import obtener_conexion

def insertar_carrera(nombre, cupos):
    conn = obtener_conexion()
    cursor = conn.cursor()

    cursor.execute("""
        INSERT INTO carreras (nombre, cupos_totales, cupos_disponibles)
        VALUES (?, ?, ?)
    """, (nombre, cupos, cupos))

    conn.commit()
    conn.close()