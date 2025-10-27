import abc

class ClaseAbstracta(metaclass=abc.ABCMeta):
    @abc.abstractmethod
    def metodo_abstracto(self):
        pass

class ClaseConcreta(ClaseAbstracta):
    def metodo_abstracto(self):
        return "Implementación concreta del método abstracto"
    