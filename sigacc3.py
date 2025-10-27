from abc import ABC, abstractmethod
from datetime import datetime
from typing import List, Dict

# Interfaces (ABC)
class IReportable(ABC):
    @abstractmethod
    def generarReportes(self) -> str:
        pass

class ICupoManager(ABC):
    @abstractmethod
    def segmentarCupos(self) -> None:
        pass

    @abstractmethod
    def verificarDisponibilidad(self, segmento: str) -> bool:
        pass

    @abstractmethod
    def asignarCupo(self, postulante) -> bool:
        pass

    @abstractmethod
    def liberarCupo(self) -> None:
        pass

class IValidable(ABC):
    @abstractmethod
    def validarRequisitos(self) -> bool:
        pass

class IDesempateStrategy(ABC):
    @abstractmethod
    def resolve(self, postulantes: List['Postulante']) -> 'Postulante':
        pass

# Estrategia concreta (Art. 54)
class VulnerabilidadFechaDesempate(IDesempateStrategy):
    def resolve(self, postulantes: List['Postulante']) -> 'Postulante':
        return sorted(postulantes, key=lambda p: (p.vulnerabilidad, p.fecha_inscripcion))[0]

# Clase Senescyt (implementa IReportable, simula web services)
class Senescyt(IReportable):
    def __init__(self):
        self.ies: List['IES'] = []

    def supervisarCumplimiento(self) -> str:
        return "Supervisión realizada."

    def auditarProcesos(self) -> str:
        return "Auditoría completada."

    def generarReportes(self) -> str:
        return "Reportes nacionales generados."

    def consultarPAA_OA(self, codigo_ies: int, identificacion: str) -> Dict:
        # Simulación del servicio web consultarPAA_OA
        return {
            "periodo": "PRIMER PERIODO 2025",
            "identificacion": identificacion,
            "nombres": "EJEMPLO NOMBRES",
            "apellidos": "EJEMPLO APELLIDOS",
            "condicion_socioeconomica": "SI",
            "discapacidad": "NO",
            "pueblos_nacionalidades": "NO",
            "merito_academico": "SI",
            "bachiller_periodo_academico": "SI",
            "poblacion_general": "NO",
            "mensajeRespuesta": "Consulta exitosa"
        }

    def consultarRegistroNacional(self, codigo_ies: int, identificacion: str) -> Dict:
        # Simulación del servicio web consultarRegistroNacional
        return {
            "tipoDocumento": "CÉDULA",
            "identificacion": identificacion,
            "nombres": "EJEMPLO NOMBRES",
            "apellidos": "EJEMPLO APELLIDOS",
            "nacionalidad": "ECUATORIANA",
            "fechaNacimiento": "01/01/2000",
            "autoidentificacion": "Mestiza/o",
            "mensajeRespuesta": "Consulta exitosa"
        }

# Clase IES (implementa IReportable)
class IES(IReportable):
    def __init__(self, nombre: str, codigo: str):
        self.nombre = nombre
        self.codigo = codigo
        self.porcentajes_segmentos: Dict[str, float] = {}

    def configurarPorcentajes(self, segmento: str, porcentaje: float):
        self.porcentajes_segmentos[segmento] = porcentaje

    def generarReportes(self) -> str:
        return f"Reportes para IES {self.nombre}."

# Clase ProcesoAsignacion (implementa IReportable, Inyección de Dependencias)
class ProcesoAsignacion(IReportable):
    def __init__(self, desempate_strategy: IDesempateStrategy, senescyt: Senescyt):
        self.carreras: List['Carrera'] = []
        self.postulantes: List['Postulante'] = []
        self.fechaEjecucion = datetime.now()
        self._desempate_strategy = desempate_strategy  # DI
        self._senescyt = senescyt  # DI para servicios web

    def ejecutarAsignacion(self) -> str:
        self.procesarAsignacionPorSegmento()
        self.gestionarReasignacion()
        self.resolverEmpate()
        self.redistribuirCupos()
        return "Asignación ejecutada (Art. 51)."

    def procesarAsignacionPorSegmento(self) -> str:
        # Orden de segmentos según Art. 52
        orden_segmentos = [
            'PoliticaCuotas', 'Vulnerabilidad', 'MeritoAcademico', 
            'OtrosReconocimientos', 'BachilleresPueblos', 
            'BachilleresGeneral', 'PoblacionGeneral'
        ]
        
        for carrera in self.carreras:
            carrera.segmentarCupos()
            for seg_tipo in orden_segmentos:
                postulantes_seg = [p for p in self.postulantes if seg_tipo in p.segmentos]
                postulantes_seg.sort(key=lambda p: p.calcularPuntaje(), reverse=True)
                
                for postulante in postulantes_seg:
                    if carrera.verificarDisponibilidad(seg_tipo):
                        carrera.asignarCupo(postulante)
        return "Asignación por segmento procesada."

    def gestionarReasignacion(self) -> str:
        # Reasignación según Art. 52
        for postulante in self.postulantes:
            if not any(ac.aceptado for ac in postulante.asignaciones):
                if not postulante.has_titulo_superior:
                    postulante.segmentos.append('PoblacionGeneral')
        return "Reasignaciones gestionadas."

    def resolverEmpate(self) -> str:
        # Desempate usando estrategia inyectada (Art. 54)
        empatados = [p for p in self.postulantes if len(p.segmentos) > 1][:2]  # Simulado
        if len(empatados) > 1:
            ganador = self._desempate_strategy.resolve(empatados)
            return f"Empate resuelto: {ganador.nombres} {ganador.apellidos}"
        return "Sin empates."

    def redistribuirCupos(self) -> str:
        # Redistribución de cupos no usados (Art. 55)
        return "Cupos redistribuidos a población general."

    def generarReportes(self) -> str:
        return "Reportes de asignación generados."

    def generarReporteConsolidado(self) -> str:
        aceptados = sum(1 for p in self.postulantes for ac in p.asignaciones if ac.aceptado)
        return f"Consolidado: {aceptados} cupos aceptados."

# Clase Postulante (implementa IValidable)
class Postulante(IValidable):
    def __init__(self, tipo_documento: str, identificacion: str, nombres: str, apellidos: str, puntaje: float, fecha_inscripcion: datetime, has_titulo_superior: bool = False):
        self.tipo_documento = tipo_documento
        self.identificacion = identificacion
        self.nombres = nombres.upper()  # Mayúsculas según diccionario
        self.apellidos = apellidos.upper()
        self.puntaje = puntaje
        self.fecha_inscripcion = fecha_inscripcion
        self.has_titulo_superior = has_titulo_superior
        
        # Campos de PAA/OA del diccionario (simulados)
        self.condicion_socioeconomica = "NO"
        self.discapacidad = "NO"
        self.pueblos_nacionalidades = "NO"
        self.merito_academico = "NO"
        self.bachiller_periodo_academico = "NO"
        self.bachiller_pueblos_nacionalidad = "NO"
        self.ruralidad = "NO"
        self.territorialidad = "NO"
        self.vulnerabilidad = 0.0  # Para desempate
        
        self.segmentos: List[str] = ['PoblacionGeneral'] if has_titulo_superior else []
        self.preferenciaCarrera: List['PreferenciaCarrera'] = []
        self.asignaciones: List['AsignacionCupo'] = []
        
        self.determinarSegmentos()

    def calcularPuntaje(self) -> float:
        return self.puntaje

    def determinarSegmentos(self) -> None:
        # Lógica basada en diccionario PAA/OA (Art. 52)
        if self.condicion_socioeconomica == "SI":
            self.segmentos.insert(0, "Vulnerabilidad")
        if self.merito_academico == "SI":
            self.segmentos.insert(0, "MeritoAcademico")
        if self.bachiller_periodo_academico == "SI":
            self.segmentos.insert(0, "BachilleresGeneral")
        if self.pueblos_nacionalidades == "SI":
            self.segmentos.insert(0, "BachilleresPueblos")

    def validarRequisitos(self) -> bool:
        # Validación simple basada en normativa
        return len(self.identificacion) == 10 and self.puntaje >= 0

# Clase PreferenciaCarrera (campos del diccionario inscripción)
class PreferenciaCarrera:
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera', prioridad: int, nombre_carrera: str, ofa_id: int, cus_id: int):
        self.postulante = postulante
        self.carrera = carrera
        self.prioridad = prioridad  # 1, 2, 3 según diccionario
        self.nombre_carrera = nombre_carrera.upper()
        self.ofa_id = ofa_id
        self.cus_id = cus_id

# Clase abstracta Segmento (ABC, IMPLEMENTA IValidable)
class Segmento(ABC):
    def __init__(self, tipo: str, codigo: int, porcentaje_min: float, porcentaje_max: float):
        self.tipo = tipo
        self.codigo = codigo  # Código del diccionario
        self.porcentaje_min = porcentaje_min
        self.porcentaje_max = porcentaje_max
        self.porcentaje = (porcentaje_min + porcentaje_max) / 2
        self.postulantes: List['Postulante'] = []

    @abstractmethod
    def ordenarPorMerito(self) -> List['Postulante']:
        pass

    def calcularCupos(self, total_cupos: int) -> int:
        return int(total_cupos * self.porcentaje)

    def validarRequisitos(self) -> bool:  # Implementa IValidable
        return all(p.validarRequisitos() for p in self.postulantes)

# Subclases con herencia y polimorfismo
class PoliticaCuotas(Segmento):
    def __init__(self):
        super().__init__('PoliticaCuotas', 1, 0.05, 0.10)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class Vulnerabilidad(Segmento):
    def __init__(self):
        super().__init__('Vulnerabilidad', 2, 0.10, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        # Prioriza puntaje y vulnerabilidad
        return sorted(self.postulantes, key=lambda p: (p.calcularPuntaje(), p.vulnerabilidad), reverse=True)

class MeritoAcademico(Segmento):
    def __init__(self):
        super().__init__('MeritoAcademico', 3, 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

class PoblacionGeneral(Segmento):
    def __init__(self):
        super().__init__('PoblacionGeneral', 7, 0.20, 0.20)

    def ordenarPorMerito(self) -> List['Postulante']:
        return sorted(self.postulantes, key=lambda p: p.calcularPuntaje(), reverse=True)

# Clase Carrera (implementa ICupoManager)
class Carrera(ICupoManager):
    def __init__(self, codigo: str, nombre: str, cuposTotales: int):
        self.codigo = codigo
        self.nombre = nombre.upper()
        self.cuposTotales = cuposTotales
        self.cuposDisponibles = cuposTotales
        self.cuposPorSegmento: Dict[str, int] = {}

    def segmentarCupos(self) -> None:
        # Segmentación según Art. 52-53
        segmentos = {
            'PoliticaCuotas': 0.07,  # 5-10%
            'Vulnerabilidad': 0.15,   # 10-20%
            'MeritoAcademico': 0.20,  # 20%
            'PoblacionGeneral': 0.58  # Resto
        }
        for seg, porc in segmentos.items():
            self.cuposPorSegmento[seg] = int(self.cuposTotales * porc)

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.cuposPorSegmento.get(segmento, 0) > 0

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        segmento = postulante.segmentos[0] if postulante.segmentos else 'PoblacionGeneral'
        if self.verificarDisponibilidad(segmento):
            self.cuposPorSegmento[segmento] -= 1
            self.cuposDisponibles -= 1
            asignacion = AsignacionCupo(postulante, self)
            postulante.asignaciones.append(asignacion)
            return True
        return False

    def liberarCupo(self) -> None:
        self.cuposDisponibles += 1

# Clase AsignacionCupo (implementa ICupoManager)
class AsignacionCupo(ICupoManager):
    def __init__(self, postulante: 'Postulante', carrera: 'Carrera'):
        self.postulante = postulante
        self.carrera = carrera
        self.fechaAsignacion = datetime.now()
        self.aceptado = False

    def segmentarCupos(self) -> None:
        pass

    def verificarDisponibilidad(self, segmento: str) -> bool:
        return self.carrera.verificarDisponibilidad(segmento)

    def asignarCupo(self, postulante: 'Postulante') -> bool:
        if self.postulante == postulante:
            self.aceptado = True
            return True
        return False

    def liberarCupo(self) -> None:
        self.aceptado = False
        self.carrera.liberarCupo()

    def registrarAceptacionCupo(self) -> str:
        if not self.aceptado:
            self.aceptado = True
            return f"Cupo aceptado para {self.postulante.nombres} {self.postulante.apellidos}"
        return "Ya aceptado."

# DEMOSTRACIÓN DE CONCEPTOS OOP
if __name__ == "__main__":
    # Inyección de Dependencias
    desempate_strategy = VulnerabilidadFechaDesempate()
    senescyt = Senescyt()
    
    # Crear proceso con DI
    proceso = ProcesoAsignacion(desempate_strategy, senescyt)
    
    # Crear carrera
    carrera = Carrera("GEN01", "INGENIERIA DE SOFTWARE", 100)
    proceso.carreras.append(carrera)
    
    # Crear postulantes con diferentes segmentos
    postulante1 = Postulante("CÉDULA", "1234567890", "DERLIS DARIO", "CARRANZA ACOSTA", 850.0, datetime.now())
    postulante1.condicion_socioeconomica = "SI"  # Para segmento Vulnerabilidad
    postulante1.determinarSegmentos()
    
    postulante2 = Postulante("CÉDULA", "0987654321", "STEVEN SNEYDER", "CATAGUA CEDEÑO", 820.0, datetime.now())
    postulante2.merito_academico = "SI"  # Para segmento Mérito Académico
    postulante2.determinarSegmentos()
    
    proceso.postulantes.extend([postulante1, postulante2])
    
    # Crear preferencias (diccionario inscripción)
    pref1 = PreferenciaCarrera(postulante1, carrera, 1, "INGENIERIA DE SOFTWARE", 12345, 67890)
    pref2 = PreferenciaCarrera(postulante2, carrera, 1, "INGENIERIA DE SOFTWARE", 12345, 67890)
    postulante1.preferenciaCarrera.append(pref1)
    postulante2.preferenciaCarrera.append(pref2)
    
    # POLIMORFISMO CON CLASES ABSTRACTAS
    segmento_vuln = Vulnerabilidad()
    segmento_merito = MeritoAcademico()
    segmento_vuln.postulantes.append(postulante1)
    segmento_merito.postulantes.append(postulante2)
    
    print("=== POLIMORFISMO CON CLASES ABSTRACTAS ===")
    print("Orden Vulnerabilidad:", [p.nombres for p in segmento_vuln.ordenarPorMerito()])
    print("Orden Mérito:", [p.nombres for p in segmento_merito.ordenarPorMerito()])
    
    # EJECUTAR PROCESO
    print("\n=== PROCESO DE ASIGNACIÓN ===")
    print(proceso.ejecutarAsignacion())
    print(proceso.resolverEmpate())
    
    # Verificar asignaciones
    for postulante in proceso.postulantes:
        if postulante.asignaciones:
            print(postulante.asignaciones[0].registrarAceptacionCupo())
    
    print(proceso.generarReporteConsolidado())
    
    # Simular consulta web service
    print("\n=== CONSULTA SERVICIO WEB ===")
    paa_data = senescyt.consultarPAA_OA(58, "1234567890")
    print(f"Condición socioeconómica: {paa_data['condicion_socioeconomica']}")