-- CREACION DE BASE DE DATOS

CREATE DATABASE AsignacionCuposULEAM;
GO
USE AsignacionCuposULEAM;
GO

-- TABLA: POSTULANTES
CREATE TABLE postulantes (
    id_postulante INT IDENTITY PRIMARY KEY,
    tipo_documento VARCHAR(20) NOT NULL,
    identificacion VARCHAR(10) NOT NULL UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    puntaje DECIMAL(5,2) NOT NULL,
    fecha_inscripcion DATETIME NOT NULL,
    has_titulo_superior CHAR(2) NOT NULL,

    condicion_socioeconomica CHAR(2) DEFAULT 'NO',
    discapacidad CHAR(2) DEFAULT 'NO',
    pueblos_nacionalidades CHAR(2) DEFAULT 'NO',
    merito_academico CHAR(2) DEFAULT 'NO',
    ruralidad CHAR(2) DEFAULT 'NO',
    territorialidad CHAR(2) DEFAULT 'NO',
    vulnerabilidad DECIMAL(5,2) DEFAULT 0
);


-- TABLA: CARRERAS
CREATE TABLE carreras (
    id_carrera INT IDENTITY PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    cupos_totales INT NOT NULL,
    cupos_disponibles INT NOT NULL
);


-- TABLA: PREFERENCIAS DE CARRERA
CREATE TABLE preferencias_carrera (
    id_preferencia INT IDENTITY PRIMARY KEY,
    id_postulante INT NOT NULL,
    id_carrera INT NOT NULL,
    prioridad INT NOT NULL,
    estado_asignacion VARCHAR(20) DEFAULT 'PENDIENTE',
    fecha_procesamiento DATETIME NULL,

    FOREIGN KEY (id_postulante) REFERENCES postulantes(id_postulante),
    FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);


-- TABLA: ADMINISTRADORES

CREATE TABLE administradores (
    id_admin INT IDENTITY PRIMARY KEY,
    cedula VARCHAR(10) UNIQUE NOT NULL,
    correo VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    activo CHAR(2) DEFAULT 'SI'
);

SET DATEFORMAT ymd;

-- INSERCION DE POSTULANTES (30 REGISTROS)
INSERT INTO postulantes (
    tipo_documento, identificacion, nombres, apellidos,
    puntaje, fecha_inscripcion, has_titulo_superior,
    condicion_socioeconomica, discapacidad,
    pueblos_nacionalidades, merito_academico,
    ruralidad, territorialidad, vulnerabilidad
)
VALUES
('CEDULA','0910000001','Juan Carlos','Mendoza Lopez',920,'2025-01-02','NO','SI','NO','NO','SI','NO','NO',0.80),
('CEDULA','0910000002','Maria Fernanda','Gomez Perez',890,'2025-01-03','NO','NO','NO','SI','SI','SI','NO',0.75),
('CEDULA','0910000003','Luis Alberto','Ramirez Torres',860,'2025-01-04','NO','SI','NO','NO','NO','NO','SI',0.65),
('CEDULA','0910000004','Ana Lucia','Vera Castillo',840,'2025-01-05','NO','NO','SI','NO','SI','NO','NO',0.70),
('CEDULA','0910000005','Pedro Javier','Cedeño Morales',820,'2025-01-06','NO','SI','NO','NO','NO','SI','NO',0.60),
('CEDULA','0910000006','Daniel Andres','Paz Bravo',805,'2025-01-07','NO','NO','NO','NO','SI','NO','NO',0.55),
('CEDULA','0910000007','Carla Estefania','Macias Solorzano',780,'2025-01-08','NO','SI','NO','SI','NO','NO','SI',0.78),
('CEDULA','0910000008','Jose Miguel','Ortega Ruiz',760,'2025-01-09','NO','NO','NO','NO','SI','NO','NO',0.50),
('CEDULA','0910000009','Paola Andrea','Loor Zambrano',740,'2025-01-10','NO','SI','NO','NO','NO','SI','NO',0.68),
('CEDULA','0910000010','Bryan Steven','Catagua Cedeño',720,'2025-01-11','NO','NO','NO','NO','SI','NO','NO',0.45),
('CEDULA','0910000011','Sofia Elena','Reyes Delgado',700,'2025-01-12','NO','SI','SI','NO','NO','NO','SI',0.82),
('CEDULA','0910000012','Kevin Alexander','Ponce Mero',680,'2025-01-13','NO','NO','NO','NO','SI','NO','NO',0.40),
('CEDULA','0910000013','Valeria Isabel','Alvarez Rivas',660,'2025-01-14','NO','SI','NO','SI','NO','SI','NO',0.77),
('CEDULA','0910000014','Jorge Luis','Santana Palma',640,'2025-01-15','NO','NO','NO','NO','SI','NO','NO',0.38),
('CEDULA','0910000015','Andrea Carolina','Peña Velez',620,'2025-01-16','NO','SI','NO','NO','NO','SI','NO',0.62),
('CEDULA','0910000016','Carlos Eduardo','Mora Lino',600,'2025-01-17','NO','NO','NO','NO','SI','NO','NO',0.35),
('CEDULA','0910000017','Natalia Beatriz','Quiroz Mendez',580,'2025-01-18','NO','SI','SI','NO','NO','NO','SI',0.80),
('CEDULA','0910000018','Diego Sebastian','Figueroa Cruz',560,'2025-01-19','NO','NO','NO','NO','SI','NO','NO',0.30),
('CEDULA','0910000019','Melissa Paola','Chavez Paredes',540,'2025-01-20','NO','SI','NO','SI','NO','SI','NO',0.74),
('CEDULA','0910000020','Andres Felipe','Espinoza Roldan',520,'2025-01-21','NO','NO','NO','NO','SI','NO','NO',0.28),
('CEDULA','0910000021','Camila Alejandra','Suarez Molina',500,'2025-01-22','NO','SI','NO','NO','NO','SI','NO',0.66),
('CEDULA','0910000022','Fernando Isaac','Vargas Ortiz',480,'2025-01-23','NO','NO','NO','NO','SI','NO','NO',0.25),
('CEDULA','0910000023','Rocio Daniela','Guerrero Pino',460,'2025-01-24','NO','SI','SI','NO','NO','NO','SI',0.85),
('CEDULA','0910000024','Cristian Mateo','Cano Aguilar',440,'2025-01-25','NO','NO','NO','NO','SI','NO','NO',0.22),
('CEDULA','0910000025','Paula Cristina','Villacres Rosero',420,'2025-01-26','NO','SI','NO','SI','NO','SI','NO',0.71),
('CEDULA','0910000026','Oscar David','Morales Vega',400,'2025-01-27','NO','NO','NO','NO','SI','NO','NO',0.20),
('CEDULA','0910000027','Gabriela Fernanda','Benitez Luna',380,'2025-01-28','NO','SI','NO','NO','NO','SI','NO',0.64),
('CEDULA','0910000028','Jonathan Xavier','Paredes Leon',350,'2025-01-29','NO','NO','NO','NO','SI','NO','NO',0.18),
('CEDULA','0910000029','Alejandra Sofia','Montes Soto',320,'2025-01-30','NO','SI','SI','NO','NO','NO','SI',0.88),
('CEDULA','0910000030','Marco Antonio','Linares Cagua',300,'2025-01-31','NO','NO','NO','NO','SI','NO','NO',0.15);


-- INSERCION DE CARRERAS
INSERT INTO carreras (codigo, nombre, cupos_totales, cupos_disponibles)
VALUES
('TI-001','Ingenieria en Tecnologias de la Informacion',50,50),
('SW-002','Ingenieria de Software',40,40),
('MED-003','Medicina',30,30),
('ENF-004','Enfermeria',35,35),
('ADM-005','Administraciin de Empresas',45,45);


-- INSERCION DE PREFERENCIAS DE CARRERA

INSERT INTO preferencias_carrera (id_postulante, id_carrera, prioridad)
VALUES
(1,1,1),(1,2,2),
(2,3,1),(2,2,2),
(3,1,1),(3,5,2),
(4,3,1),
(5,4,1),
(6,1,1),
(7,2,1),
(8,5,1),
(9,4,1),
(10,1,1),
(11,3,1),
(12,5,1);


-- INSERCION DE ADMINISTRADOR
INSERT INTO administradores (cedula, correo, contrasena)
VALUES
('1351914146','a1351914146@admin.edu.ec','Admin#2026');


-- CONSULTAS DE VERIFICACION

SELECT * FROM postulantes;
SELECT * FROM carreras;
SELECT * FROM preferencias_carrera;
SELECT * FROM administradores;
