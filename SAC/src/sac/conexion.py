import pyodbc

def obtener_conexion():
    return pyodbc.connect(
        "DRIVER={SQL Server};"
        "SERVER=DESKTOP-8LBD4SQ\SQLEXPRESS;"
        "DATABASE=AsignacionCuposULEAM;"
        "Trusted_Connection=yes;"
    )
