import pyodbc

def obtener_conexion():
    return pyodbc.connect(
        "DRIVER={SQL Server};"
        "SERVER=DESKTOP-3MAKMH3\SQLEXPRESS;"
        "DATABASE=AsignacionCuposULEAM;"
        "Trusted_Connection=yes;"
    )
