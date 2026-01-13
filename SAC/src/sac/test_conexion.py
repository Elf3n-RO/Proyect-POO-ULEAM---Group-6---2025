from conexion import obtener_conexion

try:
    conn = obtener_conexion()
    print("✅ Conexión exitosa a SQL Server")
    conn.close()
except Exception as e:
    print("❌ Error de conexión:", e)