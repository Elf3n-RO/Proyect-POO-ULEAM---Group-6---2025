import customtkinter as ctk
from datetime import datetime
from tkinter import messagebox
import sys
from sigacc3 import (
    Postulante, Carrera, ProcesoAsignacion, PreferenciaCarrera,
    VulnerabilidadFechaDesempate, Senescyt
)

#Sistema de Asignacion de Cupos
class App(ctk.CTk):
    
    def __init__(self):
        super().__init__()
        
        #Configuracion de la ventana
        self.title("Sistema de Asignación de Cupos - SENESCYT")
        self.geometry("1000x700")
        self.minsize(900, 600)
        
        #Tema
        ctk.set_appearance_mode("dark")
        ctk.set_default_color_theme("blue")
        
        #Inicializa componentes del sistema, crea interfaz y datos iniciales
        self._inicializar_sistema()
        self._crear_interfaz()
        self.actualizar_tabla()
        self.actualizar_estadisticas()
    
    #Inicializa carreras, postulantes y proceso de asignacion
    def _inicializar_sistema(self):
        try:
            #Estrategia y servicio con Inyección de Dependencias
            desempate = VulnerabilidadFechaDesempate()
            senescyt = Senescyt()
            self.proceso = ProcesoAsignacion(desempate, senescyt)
            
            #Controla si ya esta ejecutado la asignacion
            self.asignacion_ejecutada = False
            
            #Crear 3 carreras
            self.carreras = [
                Carrera("GEN01", "Ingeniería en Software", 5),
                Carrera("GEN02", "Medicina", 3),
                Carrera("GEN03", "Derecho", 4)
            ]
            
            #Postulantes
            self.postulantes = [
                Postulante("CÉDULA", "0000000001", "Derlis", "Carranza", 950.0, 
                          datetime(2025, 1, 15, 10, 30), False),
                Postulante("CÉDULA", "0000000002", "Steven", "Catagua", 920.0, 
                          datetime(2025, 1, 15, 11, 0), False),
                Postulante("CÉDULA", "0000000003", "Jofre", "Cedeño", 900.0, 
                          datetime(2025, 1, 16, 9, 0), False),
                Postulante("CÉDULA", "0000000004", "Oleg", "Kuznetsov", 880.0, 
                          datetime(2025, 1, 16, 14, 30), False),
                Postulante("CÉDULA", "0000000005", "Vladimir", "Putin", 870.0, 
                          datetime(2025, 1, 17, 8, 15), False),
                Postulante("CÉDULA", "0000000006", "Donald", "Trump", 860.0, 
                          datetime(2025, 1, 17, 10, 0), True)
            ]
            
            #Segmentos de los postulantes
            self._configurar_segmentos()
            
            #Preferencias de carreras
            self._crear_preferencias()
            
            # Registrar en el proceso
            self.proceso.carreras.extend(self.carreras)
            self.proceso.postulantes.extend(self.postulantes)

        #Si falla de repente    
        except Exception as e:
            messagebox.showerror("Error de Iniciar", 
                               f"Error al inicializar el sistema:\n{str(e)}")
            sys.exit(1)
    
    #Configura los segmentos de cada postulante segun criterios"""
    def _configurar_segmentos(self):
        #Postulante 1: Vulnerabilidad
        self.postulantes[0].condicion_socioeconomica = "SI"
        self.postulantes[0].vulnerabilidad = 0.8
        
        #Postulante 2: Merito Academico
        self.postulantes[1].merito_academico = "SI"
        self.postulantes[1].vulnerabilidad = 0.3
        
        #Postulante 3: Bachiller General
        self.postulantes[2].bachiller_periodo_academico = "SI"
        
        #Postulante 4: Pueblos y Nacionalidades
        self.postulantes[3].pueblos_nacionalidades = "SI"
        self.postulantes[3].bachiller_pueblos_nacionalidad = "SI"
        
        #Postulante 5: Poblacion General
        self.postulantes[4].vulnerabilidad = 0.1
        
        #Postulante 6: Con titulo superior (Poblacion General)
        self.postulantes[5].has_titulo_superior = True
        
        #Determinar segmentos para todos
        for p in self.postulantes:
            p.determinarSegmentos()
    
    #Preferencias de carrera para cada postulante
    def _crear_preferencias(self):
        # Cada postulante tiene preferencias para las carreras
        for i, postulante in enumerate(self.postulantes):
            for prioridad, carrera in enumerate(self.carreras[:2], start=1):
                pref = PreferenciaCarrera(
                postulante, carrera, prioridad, carrera.nombre, 10000 + i, 20000 + i)
                postulante.preferenciaCarrera.append(pref)
    
    #Crea TODOS los elementos de la interfaz grafica
    def _crear_interfaz(self):
        # Frame principal con padding
        main_frame = ctk.CTkFrame(self, fg_color="transparent")
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)
        
        #Titulo
        self._crear_titulo(main_frame)
        
        #Panel de informacion
        self._crear_panel_info(main_frame)
        
        #Tabla de postulantes
        self._crear_tabla(main_frame)
        
        #Panel de controles
        self._crear_controles(main_frame)
        
        #Panel de resultados
        self._crear_panel_resultados(main_frame)
    
    #Crea Titulo
    def _crear_titulo(self, parent):
        titulo_frame = ctk.CTkFrame(parent)
        titulo_frame.pack(fill="x", pady=(0, 15))
        
        lbl_titulo = ctk.CTkLabel(
            titulo_frame,
            text="Sistema de Asignacion de Cupos",
            font=("Arial", 24, "bold")
        )
        lbl_titulo.pack(pady=10)
        
        lbl_subtitulo = ctk.CTkLabel(
            titulo_frame,
            text="SENESCYT - Secretaría de Educación Superior",
            font=("Arial", 12),
            text_color="gray"
        )
        lbl_subtitulo.pack()
    
    #Crea panel de informacion
    def _crear_panel_info(self, parent):
        info_frame = ctk.CTkFrame(parent)
        info_frame.pack(fill="x", pady=(0, 10))
        
        # Grid de 4 columnas
        info_frame.grid_columnconfigure((0, 1, 2, 3), weight=1)
        
        # Estadisticas
        self.lbl_total_postulantes = self._crear_stat_tarjeta(
            info_frame, "Total Postulantes", "0", 0
        )
        self.lbl_total_cupos = self._crear_stat_tarjeta(
            info_frame, "Total Cupos", "0", 1
        )
        self.lbl_cupos_asignados = self._crear_stat_tarjeta(
            info_frame, "Cupos Asignados", "0", 2
        )
        self.lbl_cupos_disponibles = self._crear_stat_tarjeta(
            info_frame, "Cupos Disponibles", "0", 3
        )
    
    #Crea una tarjeta de estadistica
    def _crear_stat_tarjeta(self, parent, titulo, valor, columna):
        card = ctk.CTkFrame(parent)
        card.grid(row=0, column=columna, padx=5, pady=5, sticky="ew")
        
        lbl_titulo = ctk.CTkLabel(
            card, text=titulo, font=("Arial", 11), text_color="gray"
        )
        lbl_titulo.pack(pady=(8, 2))
        
        lbl_valor = ctk.CTkLabel(card, text=valor, font=("Arial", 20, "bold"))
        lbl_valor.pack(pady=(2, 8))
        return lbl_valor
    
    #Crea tabla de postulantes
    def _crear_tabla(self, parent):
        tabla_frame = ctk.CTkFrame(parent)
        tabla_frame.pack(fill="both", expand=True, pady=(0, 10))
        
        #Titulo de la tabla con los postulantes
        lbl_tabla = ctk.CTkLabel(
            tabla_frame,
            text="Lista de Postulantes",
            font=("Arial", 14, "bold")
        )
        lbl_tabla.pack(pady=10)
        
        # Tabla con scroll
        self.tabla = ctk.CTkTextbox(
            tabla_frame,
            font=("Consolas", 11),
            wrap="none"
        )
        self.tabla.pack(fill="both", expand=True, padx=10, pady=(0, 10))
    
    #Crea panel de controles
    def _crear_controles(self, parent):
        controles_frame = ctk.CTkFrame(parent)
        controles_frame.pack(fill="x", pady=(0, 10))
        
        btn_frame = ctk.CTkFrame(controles_frame, fg_color="transparent")
        btn_frame.pack(pady=10)
        
        #Boton 1
        self.btn_asignar = ctk.CTkButton(
            btn_frame,
            text="▶️ Ejecutar Asignación",
            command=self.ejecutar_asignacion,
            font=("Arial", 13, "bold"),
            height=40,
            width=200)
        self.btn_asignar.pack(side="left", padx=5)
        
        #Boton 2
        self.btn_limpiar = ctk.CTkButton(
            btn_frame,
            text="🔄 Reiniciar Sistema",
            command=self.reiniciar_sistema,
            font=("Arial", 13),
            height=40,
            width=180,
            fg_color="gray40",
            hover_color="gray30")
        self.btn_limpiar.pack(side="left", padx=5)
        
        #Boton 3
        self.btn_reportes = ctk.CTkButton(
            btn_frame,
            text="📊 Ver Reportes",
            command=self.mostrar_reportes,
            font=("Arial", 13),
            height=40,
            width=180,
            fg_color="green",
            hover_color="darkgreen")
        self.btn_reportes.pack(side="left", padx=5)
    
    #Crea panel de resultados
    def _crear_panel_resultados(self, parent):
        resultado_frame = ctk.CTkFrame(parent)
        resultado_frame.pack(fill="x")
        
        self.lbl_resultado = ctk.CTkLabel(
            resultado_frame,
            text="",
            font=("Arial", 12),
            wraplength=900)
        self.lbl_resultado.pack(pady=10)
    
    #Actualiza la tabla con los postulantes"""
    def actualizar_tabla(self):
        self.tabla.configure(state="normal")
        self.tabla.delete("1.0", "end")
        
        #Cabeza
        header = (
            f"{'Cédula':<13} {'Nombre':<18} {'Apellido':<18} "
            f"{'Puntaje':<8} {'Segmento':<22} {'Estado':<10}\n"
        )
        self.tabla.insert("end", header)
        self.tabla.insert("end", "=" * 110 + "\n")
        
        #Datos
        for p in self.postulantes:
            asignado = "✅ Asignado" if any(
                ac.aceptado for ac in p.asignaciones
            ) else "⏳ Pendiente"
            
            segmento = p.segmentos[0] if p.segmentos else "Sin Segmento"
            
            # Formatear nombre y apellido
            nombre = p.nombres[:17] if len(p.nombres) > 17 else p.nombres
            apellido = p.apellidos[:17] if len(p.apellidos) > 17 else p.apellidos
            
            fila = (
                f"{p.identificacion:<13} {nombre:<18} {apellido:<18} "
                f"{p.puntaje:<8.1f} {segmento:<22} {asignado:<10}\n")
            self.tabla.insert("end", fila)
        
        self.tabla.configure(state="disabled")

    #Actualiza las estadisticas del panel de información
    def actualizar_estadisticas(self):
        total_postulantes = len(self.postulantes)
        total_cupos = sum(c.cuposTotales for c in self.carreras)
        
        #Cuenta a postulantes com asignacion aceptada
        postulantes_asignados = set()
        for p in self.postulantes:
            if any(ac.aceptado for ac in p.asignaciones):
                postulantes_asignados.add(p.identificacion)
        
        cupos_asignados = len(postulantes_asignados)
        cupos_disponibles = total_cupos - cupos_asignados
        
        self.lbl_total_postulantes.configure(text=str(total_postulantes))
        self.lbl_total_cupos.configure(text=str(total_cupos))
        self.lbl_cupos_asignados.configure(text=str(cupos_asignados))
        self.lbl_cupos_disponibles.configure(text=str(cupos_disponibles))
    
    #Realiza la asignacion de cupos
    def ejecutar_asignacion(self):
        try:
            #Permiso para ejecutar otra vez la asignacion
            if self.asignacion_ejecutada:
                respuesta = messagebox.askyesno(
                    "Pregunta",
                    "La asignación ya fue ejecutada.\n"
                    "Ejecutarla otra vez? Esto reiniciara el sistema.")
                return
            
            self.btn_asignar.configure(state="disabled", text="⏳ Procesando...")
            self.update()
            
            #Limpiar asignaciones anteriores, antes de ejecutar
            for postulante in self.postulantes:
                postulante.asignaciones.clear()
            
            #Restaura cupos de carreras
            for carrera in self.carreras:
                carrera.cuposDisponibles = carrera.cuposTotales
                carrera.cuposPorSegmento.clear()
            
            #Ejecuta proceso
            resultado = self.proceso.ejecutarAsignacion()
            
            #Acepta las asignaciones realizadas
            for postulante in self.postulantes:
                if postulante.asignaciones:
                    for asignacion in postulante.asignaciones:
                        asignacion.registrarAceptacionCupo()
            
            #Marcar como ejecutada
            self.asignacion_ejecutada = True
            
            #Actualiza las interfaz
            self.actualizar_tabla()
            self.actualizar_estadisticas()
            
            #Resultado de postulante si esta asignado o no
            mensaje = f"✅ {resultado}\n\n"
            mensaje += self._generar_resumen()
            
            self.lbl_resultado.configure(
                text=mensaje,
                text_color="lightgreen")
            
            messagebox.showinfo("Exito", "Asignacion completada")
            
        #Caso de algun error
        except Exception as e:
            messagebox.showerror(
                "Error",
                f"Error durante la asignacion:\n{str(e)}")
            self.lbl_resultado.configure(
                text=f"❌ Error: {str(e)}",
                text_color="red")
        
        finally:
            self.btn_asignar.configure(
                state="normal",
                text="▶️ Ejecutar Asignacion")

    #Genera un resumen del proceso de asignacion
    def _generar_resumen(self):
        
        #Cuenta postulantes asignados
        postulantes_asignados_set = set()
        for p in self.postulantes:
            if any(ac.aceptado for ac in p.asignaciones):
                postulantes_asignados_set.add(p.identificacion)
        
        asignados = [p for p in self.postulantes if p.identificacion in postulantes_asignados_set]
        
        resumen = f"Resumen: {len(asignados)} postulantes asignados\n"
        
        # Desglose por segmento
        segmentos_count = {}
        for p in asignados:
            seg = p.segmentos[0] if p.segmentos else "Sin Segmento"
            segmentos_count[seg] = segmentos_count.get(seg, 0) + 1
        
        if segmentos_count:
            resumen += "Distribucion por segmento:\n"
            for seg, count in segmentos_count.items():
                resumen += f"  • {seg}: {count}\n"
        return resumen
    
    #Reinicia el sistema a su estado inicial (boton central)
    def reiniciar_sistema(self, mostrar_mensaje=True):
        if mostrar_mensaje:
            respuesta = messagebox.askyesno(
                "Pregunta",
                "Reiniciar el sistema?\n"
                "Se perderán todas las asignaciones actuales.")
            if not respuesta:
                return
        
        #Limpia todas asignaciones
        for p in self.postulantes:
            p.asignaciones.clear()
        
        #Regresa cupos
        for c in self.carreras:
            c.cuposDisponibles = c.cuposTotales
            c.cuposPorSegmento.clear()
        
        #Resetear flag de asignaciones y Actualiza interfaz
        self.asignacion_ejecutada = False
        self.actualizar_tabla()
        self.actualizar_estadisticas()
        self.lbl_resultado.configure(text="Sistema reiniciado")
        
        if mostrar_mensaje:
            messagebox.showinfo("Exito", "Sistema reiniciado")
    
    #Ventana con reporte detallado
    def mostrar_reportes(self):
        ventana_reportes = ctk.CTkToplevel(self)
        ventana_reportes.title("Reportes del Sistema")
        ventana_reportes.geometry("700x500")
        
        #Titulo
        lbl_titulo = ctk.CTkLabel(
            ventana_reportes,
            text="Reportes Consolidados",
            font=("Arial", 18, "bold"))
        lbl_titulo.pack(pady=15)
        
        #Area de texto para reportes
        txt_reportes = ctk.CTkTextbox(
            ventana_reportes,
            font=("Consolas", 11))
        txt_reportes.pack(fill="both", expand=True, padx=20, pady=(0, 20))
        
        # Generar contenido del reporte
        reporte = self._generar_reporte_completo()
        txt_reportes.insert("1.0", reporte)
        txt_reportes.configure(state="disabled")
        
        # Botón cerrar
        btn_cerrar = ctk.CTkButton(
            ventana_reportes,
            text="Cerrar",
            command=ventana_reportes.destroy
        )
        btn_cerrar.pack(pady=(0, 15))

    #Genera reporte completo del sistema
    def _generar_reporte_completo(self):
        reporte = "=" * 70 + "\n"
        reporte += "RePoRtE cOnSoLiDaDo DeL sIsTeMa De AsIgNaCiOn\n"
        reporte += f"Fecha: {datetime.now().strftime('%d/%m/%Y %H:%M:%S')}\n"
        reporte += "=" * 70 + "\n\n"
        
        #Reporte de carreras
        reporte += "1. CARRERAS DISPONIBLES\n"
        reporte += "-" * 70 + "\n"
        for c in self.carreras:
            reporte += f"Codigo: {c.codigo} | {c.nombre}\n"
            reporte += f"   Cupos Totales: {c.cuposTotales}\n"
            reporte += f"   Cupos Disponibles: {c.cuposDisponibles}\n"
            if c.cuposPorSegmento:
                reporte += "   Distribución por segmento:\n"
                for seg, cupos in c.cuposPorSegmento.items():
                    reporte += f"      • {seg}: {cupos}\n"
            reporte += "\n"
        
        #Cuenta postulantes asignados
        postulantes_asignados_set = set()
        for p in self.postulantes:
            if any(ac.aceptado for ac in p.asignaciones):
                postulantes_asignados_set.add(p.identificacion)
        
        #Reporte de postulantes asignados
        reporte += "\n2. POSTULANTES ASIGNADOS\n"
        reporte += "-" * 70 + "\n"
        asignados = [p for p in self.postulantes if p.identificacion in postulantes_asignados_set]
        
        if asignados:
            for p in asignados:
                reporte += f"{p.nombres} {p.apellidos} (CI: {p.identificacion})\n"
                reporte += f"   Puntaje: {p.puntaje}\n"
                reporte += f"   Segmento: {p.segmentos[0] if p.segmentos else 'N/A'}\n"
                for ac in p.asignaciones:
                    if ac.aceptado:
                        reporte += f"   Carrera: {ac.carrera.nombre}\n"
                        break 
                reporte += "\n"
        else:
            reporte += "No hay postulantes asignados aún.\n\n"
        
        #Reporte de postulantes NO asignados
        reporte += "\n3. POSTULANTES NO ASIGNADOS\n"
        reporte += "-" * 70 + "\n"
        no_asignados = [
            p for p in self.postulantes 
            if p.identificacion not in postulantes_asignados_set]
        
        if no_asignados:
            for p in no_asignados:
                reporte += f"{p.nombres} {p.apellidos} - Puntaje: {p.puntaje}\n"
        else:
            reporte += "Todos los postulantes han sido asignados.\n"
        
        reporte += "\n" + "=" * 70 + "\n"
        reporte += f"CONSOLIDADO: {len(asignados)} cupos aceptados de {sum(c.cuposTotales for c in self.carreras)} disponibles\n"
        reporte += "=" * 70 + "\n"
        return reporte


#PARA EJECUTAR LA APLIACION
if __name__ == "__main__":
    try:
        app = App()
        app.mainloop()
    except Exception as e:
        print(f"Error: {str(e)}")
        messagebox.showerror("Error!!!", f"No se puede iniciar la aplicacion:\n{str(e)}")
        sys.exit(1)