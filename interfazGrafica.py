import customtkinter as ctk
from datetime import datetime
from sigacc3 import (
    Postulante, Carrera, ProcesoAsignacion,
    VulnerabilidadFechaDesempate, Senescyt
)

class App(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("Sistema de Asignación de Cupos")
        self.geometry("700x450")
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")

        # Crear carrera con la firma correcta (codigo, nombre, cuposTotales)
        self.carrera = Carrera("GEN01", "Ingeniería en Software", 2)

        # Crear estrategia y servicio requeridos por ProcesoAsignacion
        desempate = VulnerabilidadFechaDesempate()
        senescyt = Senescyt()
        self.proceso = ProcesoAsignacion(desempate, senescyt)

        # Postulantes: usar la firma de SAC2.Postulante
        self.postulantes = [
            Postulante("CÉDULA", "0000000001", "Derlis", "Carranza", 850.0, datetime.now()),
            Postulante("CÉDULA", "0000000002", "Steven", "Catagua", 820.0, datetime.now()),
            Postulante("CÉDULA", "0000000003", "Jofre", "Cedeño", 900.0, datetime.now()),
        ]

        # Ajustar segmentos de ejemplo (simula lo que antes se pasaba)
        # Por ejemplo: marcar el primero como vulnerabilidad y el segundo como mérito
        self.postulantes[0].condicion_socioeconomica = "SI"
        self.postulantes[0].determinarSegmentos()
        self.postulantes[1].merito_academico = "SI"
        self.postulantes[1].determinarSegmentos()
        # el tercero queda en PoblacionGeneral por defecto

        # Registrar carrera y postulantes en el proceso
        self.proceso.carreras.append(self.carrera)
        self.proceso.postulantes.extend(self.postulantes)

        self.lbl_titulo = ctk.CTkLabel(self, text="Asignación de Cupos - SENESCYT", font=("Arial", 20, "bold"))
        self.lbl_titulo.pack(pady=15)

        self.tabla = ctk.CTkTextbox(self, width=600, height=200, font=("Consolas", 13))
        self.tabla.pack(pady=10)
        self.mostrar_postulantes()

        self.btn_asignar = ctk.CTkButton(self, text="Ejecutar Asignación", command=self.asignar)
        self.btn_asignar.pack(pady=10)

        self.lbl_resultado = ctk.CTkLabel(self, text="", font=("Arial", 14))
        self.lbl_resultado.pack(pady=10)

    def mostrar_postulantes(self):
        self.tabla.delete("1.0", ctk.END)
        self.tabla.insert("end", f"{'Nombre':<15}{'Apellido':<15}{'Puntaje':<10}{'Segmento':<20}{'Asignado':<10}\n")
        self.tabla.insert("end", "-"*75 + "\n")
        for p in self.postulantes:
            asignado = "✅" if any(ac.aceptado for ac in p.asignaciones) or bool(p.asignaciones) else "❌"
            segmento = p.segmentos[0] if p.segmentos else "N/A"
            self.tabla.insert("end", f"{p.nombres:<15}{p.apellidos:<15}{p.puntaje:<10}{segmento:<20}{asignado:<10}\n")
        

    def asignar(self):
        resultado = self.proceso.ejecutarAsignacion()
        self.mostrar_postulantes()
        self.lbl_resultado.configure(text=resultado)

if __name__ == "__main__":
    app = App()
    app.mainloop()

