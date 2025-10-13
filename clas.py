#Carranza Derlis
#Kuznetsov Oleg
class Estudiante:
    #atributo de clases
    rol ='estudiante'
    #el metodo __int__ es llamadao al crear el objeto
    def __init__(self, id, apellido,nombre,puntaje):
        print (f"creando {Estudiante.rol},{id}, {apellido}, {nombre},{puntaje}")

        #atributo de instancia
        self.id= id
        self.apellido= apellido
        self.__nombre= nombre    
        self.puntaje=puntaje
    @property
    def nombre(self):
        return (self.__nombre)
  
    @nombre.setter
    def nombre(self,nombre):
        self.__nombre = "pepe."

    def inscribir(self, carrera):
        print(f"El estudiante se a inscrito a la {carrera}")
    def ver_materia(self, materia):
        print(f"El estudiante esta viendo materia {materia}")  
    def leer(self, libro):
        print(f"El estudiante tiene disponible {libro}")

mi_estudiante1= Estudiante("1315783959","carranza acosta","derlis dario","840")
print (type(mi_estudiante1))
print(mi_estudiante1.rol)
    
mi_estudiante2= Estudiante("13157383959","zambrano zambrano","damian carlos","970")
print (type(mi_estudiante2))
print(mi_estudiante2.rol) 
 
mi_estudiante2.rol="profesional"
Estudiante.rol="expulsado"
print(mi_estudiante1.rol)
print(mi_estudiante2.rol) 

class Cupo:
    #atributo de clases
    rol = "cupo"
    #el metodo __int__ es llamadao al crear el objeto
    def __init__(self, id_cupo, carrera,estado):
        print (f"creando cupo {id_cupo}, {carrera}, {estado}")
        
        #atributo de instancia 
        self.id_cupo= id_cupo
        self.carrera= carrera
        self.estado= estado   

    def entrega(self, nombre):
        print(f"El cupa a asignado a la persona {nombre}")
    def cupo_materia(self, cupo_materia):
        print(f"Cantidad de disponibles cupos de cada materia {cupo_materia}")  
    def antidad_cupo(self, cantidad_total_cupo):
        print(f"En la Universidad hay dispoble solo {cantidad_total_cupo}")

mi_cupo = Cupo("234","Ing.Software","aceptado") 
print(type(mi_cupo)) 


class Universidad:
    #atributo de clases
    rol ="universidad"
    #el metodo __int__ es llamadao al crear el objeto
    def __init__(self, id_universidad, nombre,oferta_carrera):
        print (f"creando cupo {id_universidad}, {nombre}, {oferta_carrera}")

        #atributo de instancia
        self.id_universidad= id_universidad
        self.nombre= nombre
        self.oferta_carrera= oferta_carrera  

    def carreras_dis(self, carrera_disponible):
        print(f"Carrerar dispobiles en la Universidad {carrera_disponible}")
    def cantidad_estudiantes(self, estudiantes):
        print(f"Cantidad de estudiantes {estudiantes}")  
    def ciudad(self):
        print(f"Manta")

mi_universidad=Universidad("12","Uleam","2025-2")
print(type(mi_universidad))    


class Carrera:
    #atributo de clases
    rol ="carrera"
    #el metodo __int__ es llamadao al crear el objeto
    def __init__(self, id_carrera, nombre_carrera,universidad):
        print (f"creando estudiante {id_carrera}, {nombre_carrera}, {universidad}")

        #atributo de instancia
        self.id_carrera= id_carrera
        self.nombre_carrera= nombre_carrera
        self.universidad= universidad

    def carreras_dis(self, carrera_disponible):
        print(f"Carrerar dispobiles en la Universidad {carrera_disponible}")
    def cantidad_estudiantes(self, estudiantes):
        print(f"Cantidad de estudiantes {estudiantes}")  
    def ciudad(self):
        print(f"Manta")

mi_carrera= Carrera("7","software", "Uleam")
print(type(mi_carrera))


class Sede:
    #atributo de clases
    rol="sede"
    #el metodo __int__ es llamadao al crear el objeto
    def __init__(self,id_sede,ubicacion,capacidad_max  ):
        print (f"Creando sede {id_sede},{ubicacion},{capacidad_max}")

        #atributo de instancia
        self._id_sede= id_sede
        self._ubicacion=ubicacion
        self._capacidad_max= capacidad_max
    
    def disponibilidad_sede(self):
        print(f"Disponible")
    def organizacion(self, equipo):
        print(f"Tiene {equipo} de trabajo")  
    def dia_trabajo(self, dias_laborales):
        print(f"Los dias son {dias_laborales}")

mi_sede= Sede("5","Moscow", "7963")
print(type(mi_sede))
        
