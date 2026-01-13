import pyodbc

def obtener_conexion():
    return pyodbc.connect(
        "DRIVER={SQL Server};"
        "SERVER=DESKTOP-JDTRNFK\SQLEXPRESS;"
        "DATABASE=AsignacionCuposULEAM;"
        "Trusted_Connection=yes;"
    )
