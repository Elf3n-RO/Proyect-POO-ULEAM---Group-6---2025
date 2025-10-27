import abc

# Base abstract class para polimorfismo (interface)
class Entidad(abc.ABC):
    rol = 'entidad'

    @abc.abstractmethod
    def describir(self):
        """Método abstracto para describir la entidad, permitiendo polimorfismo."""
        pass

# Clase base para entidades educativas con métodos comunes (herencia)
class EntidadEducativa(Entidad):
    def __init__(self, id_entidad, nombre):
        self.id_entidad = id_entidad
        self.nombre = nombre

    def carreras_dis(self, carrera_disponible):
        print(f"Carreras disponibles en {self.nombre}: {carrera_disponible}")

    def cantidad_estudiantes(self, estudiantes):
        print(f"Cantidad de estudiantes en {self.nombre}: {estudiantes}")

    def ciudad(self):
        print("Manta")

# Carranza Derlis
# Kuznetsov Oleg
class Estudiante(Entidad):
    # Atributo de clase
    rol = 'estudiante'

    # El método __init__ es llamado al crear el objeto
    def __init__(self, id, apellido, nombre, puntaje):
        print(f"creando {Estudiante.rol}, {id}, {apellido}, {nombre}, {puntaje}")

        # Atributos de instancia
        self.id = id
        self.apellido = apellido
        self.__nombre = nombre
        self.puntaje = puntaje

    @property
    def nombre(self):
        return self.__nombre

    @nombre.setter
    def nombre(self, nombre):
        self.__nombre = nombre  # Corregido para asignar el valor correcto

    def inscribir(self, carrera):
        print(f"El estudiante se ha inscrito a la {carrera}")

    def ver_materia(self, materia):
        print(f"El estudiante está viendo materia {materia}")

    def leer(self, libro):
        print(f"El estudiante tiene disponible {libro}")

    # Implementación del método abstracto para polimorfismo
    def describir(self):
        print(f"Estudiante ID: {self.id}, Apellido: {self.apellido}, Nombre: {self.nombre}, Puntaje: {self.puntaje}")

class Cupo(Entidad):
    # Atributo de clase
    rol = 'cupo'

    # El método __init__ es llamado al crear el objeto
    def __init__(self, id_cupo, carrera, estado):
        print(f"creando cupo {id_cupo}, {carrera}, {estado}")

        # Atributos de instancia
        self.id_cupo = id_cupo
        self.carrera = carrera
        self.estado = estado

    def entrega(self, nombre):
        print(f"El cupo ha sido asignado a la persona {nombre}")

    def cupo_materia(self, cupo_materia):
        print(f"Cantidad de cupos disponibles de cada materia: {cupo_materia}")

    def cantidad_cupo(self, cantidad_total_cupo):
        print(f"En la Universidad hay disponible solo {cantidad_total_cupo}")

    # Implementación del método abstracto para polimorfismo
    def describir(self):
        print(f"Cupo ID: {self.id_cupo}, Carrera: {self.carrera}, Estado: {self.estado}")

# Universidad hereda de EntidadEducativa (herencia con métodos comunes)
class Universidad(EntidadEducativa):
    # Atributo de clase
    rol = 'universidad'

    # El método __init__ es llamado al crear el objeto
    def __init__(self, id_universidad, nombre, oferta_carrera):
        super().__init__(id_universidad, nombre)
        print(f"creando {Universidad.rol} {id_universidad}, {nombre}, {oferta_carrera}")

        # Atributo de instancia adicional
        self.oferta_carrera = oferta_carrera

    # Sobrescritura para polimorfismo
    def describir(self):
        print(f"Universidad ID: {self.id_entidad}, Nombre: {self.nombre}, Oferta Carrera: {self.oferta_carrera}")

# Carrera hereda de EntidadEducativa (herencia con métodos comunes, polimorfismo posible)
class Carrera(EntidadEducativa):
    # Atributo de clase
    rol = 'carrera'

    # El método __init__ es llamado al crear el objeto
    def __init__(self, id_carrera, nombre_carrera, universidad):
        super().__init__(id_carrera, nombre_carrera)
        print(f"creando {Carrera.rol} {id_carrera}, {nombre_carrera}, {universidad}")

        # Atributo de instancia adicional
        self.universidad = universidad

    # Sobrescritura para polimorfismo
    def describir(self):
        print(f"Carrera ID: {self.id_entidad}, Nombre: {self.nombre}, Universidad: {self.universidad}")

# Sede hereda de EntidadEducativa (herencia, asumiendo similitudes en gestión educativa)
class Sede(EntidadEducativa):
    # Atributo de clase
    rol = 'sede'

    # El método __init__ es llamado al crear el objeto
    def __init__(self, id_sede, nombre, ubicacion, capacidad_max):
        super().__init__(id_sede, nombre)
        print(f"Creando {Sede.rol} {id_sede}, {ubicacion}, {capacidad_max}")

        # Atributos de instancia adicionales
        self.ubicacion = ubicacion
        self.capacidad_max = capacidad_max

    def disponibilidad_sede(self):
        print("Disponible")

    def organizacion(self, equipo):
        print(f"Tiene {equipo} de trabajo")

    def dia_trabajo(self, dias_laborales):
        print(f"Los días son {dias_laborales}")

    # Sobrescritura para polimorfismo
    def describir(self):
        print(f"Sede ID: {self.id_entidad}, Nombre: {self.nombre}, Ubicación: {self.ubicacion}, Capacidad Máx: {self.capacidad_max}")

# Ejemplos de creación (mantenidos del código original)
mi_estudiante1 = Estudiante("1315783959", "carranza acosta", "derlis dario", "840")
print(type(mi_estudiante1))
print(mi_estudiante1.rol)

mi_estudiante2 = Estudiante("13157383959", "zambrano zambrano", "damian carlos", "970")
print(type(mi_estudiante2))
print(mi_estudiante2.rol)

mi_estudiante2.rol = "profesional"
Estudiante.rol = "expulsado"
print(mi_estudiante1.rol)
print(mi_estudiante2.rol)

mi_cupo = Cupo("234", "Ing.Software", "aceptado")
print(type(mi_cupo))

mi_universidad = Universidad("12", "Uleam", "2025-2")
print(type(mi_universidad))

mi_carrera = Carrera("7", "software", "Uleam")
print(type(mi_carrera))

mi_sede = Sede("5", "Moscow Sede", "Moscow", "7963")
print(type(mi_sede))

# Demostración de polimorfismo: lista de entidades y llamada al método describir
entidades = [mi_estudiante1, mi_estudiante2, mi_cupo, mi_universidad, mi_carrera, mi_sede]
for entidad in entidades:
    entidad.describir()