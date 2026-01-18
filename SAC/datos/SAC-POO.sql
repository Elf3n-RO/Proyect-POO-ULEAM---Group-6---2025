USE [master]
GO
/****** Object:  Database [AsignacionCuposULEAM]    Script Date: 18/1/2026 0:05:46 ******/
CREATE DATABASE [AsignacionCuposULEAM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AsignacionCuposULEAM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\AsignacionCuposULEAM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AsignacionCuposULEAM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\AsignacionCuposULEAM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [AsignacionCuposULEAM] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AsignacionCuposULEAM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ARITHABORT OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET  MULTI_USER 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AsignacionCuposULEAM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AsignacionCuposULEAM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [AsignacionCuposULEAM] SET QUERY_STORE = ON
GO
ALTER DATABASE [AsignacionCuposULEAM] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [AsignacionCuposULEAM]
GO
/****** Object:  Table [dbo].[administradores]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[administradores](
	[id_admin] [int] IDENTITY(1,1) NOT NULL,
	[cedula] [varchar](10) NOT NULL,
	[correo] [varchar](50) NOT NULL,
	[contrasena] [varchar](255) NOT NULL,
	[fecha_creacion] [datetime] NULL,
	[activo] [char](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[asignaciones]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asignaciones](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_postulante] [int] NULL,
	[id_carrera] [int] NULL,
	[fecha_asignacion] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[asignaciones_finales]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[asignaciones_finales](
	[id_asignacion] [int] IDENTITY(1,1) NOT NULL,
	[id_proceso] [int] NULL,
	[identificacion_postulante] [varchar](10) NOT NULL,
	[codigo_carrera] [varchar](20) NULL,
	[fecha_ejecucion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_asignacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[carreras]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[carreras](
	[id_carrera] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](10) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[cupos_totales] [int] NOT NULL,
	[cupos_disponibles] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_carrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[configuracion_sistema]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[configuracion_sistema](
	[id] [int] NOT NULL,
	[criterio_primario] [varchar](50) NOT NULL,
	[criterio_secundario] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[historial_procesos]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[historial_procesos](
	[id_proceso] [int] IDENTITY(1,1) NOT NULL,
	[fecha_ejecucion] [datetime] NULL,
	[cupos_asignados] [int] NULL,
	[usuario_responsable] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_proceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[postulantes]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[postulantes](
	[id_postulante] [int] IDENTITY(1,1) NOT NULL,
	[tipo_documento] [varchar](20) NOT NULL,
	[identificacion] [varchar](10) NOT NULL,
	[nombres] [varchar](100) NOT NULL,
	[apellidos] [varchar](100) NOT NULL,
	[puntaje] [decimal](5, 2) NOT NULL,
	[fecha_inscripcion] [datetime] NOT NULL,
	[has_titulo_superior] [char](2) NOT NULL,
	[condicion_socioeconomica] [char](2) NULL,
	[discapacidad] [char](2) NULL,
	[pueblos_nacionalidades] [char](2) NULL,
	[merito_academico] [char](2) NULL,
	[ruralidad] [char](2) NULL,
	[territorialidad] [char](2) NULL,
	[vulnerabilidad] [decimal](5, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_postulante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[preferencias_carrera]    Script Date: 18/1/2026 0:05:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[preferencias_carrera](
	[id_preferencia] [int] IDENTITY(1,1) NOT NULL,
	[id_postulante] [int] NOT NULL,
	[id_carrera] [int] NOT NULL,
	[prioridad] [int] NOT NULL,
	[estado_asignacion] [varchar](20) NULL,
	[fecha_procesamiento] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_preferencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[administradores] ON 
GO
INSERT [dbo].[administradores] ([id_admin], [cedula], [correo], [contrasena], [fecha_creacion], [activo]) VALUES (1, N'1351914146', N'a1351914146@admin.edu.ec', N'Admin#2026', CAST(N'2026-01-12T22:50:33.290' AS DateTime), N'SI')
GO
SET IDENTITY_INSERT [dbo].[administradores] OFF
GO
SET IDENTITY_INSERT [dbo].[asignaciones_finales] ON 
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (1, 1, N'0910000001', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (2, 1, N'0910000002', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (3, 1, N'0910000003', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (4, 1, N'0910000004', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (5, 1, N'0910000005', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (6, 1, N'0910000006', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (7, 1, N'0910000007', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (8, 1, N'0910000008', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (9, 1, N'0910000009', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (10, 1, N'0910000010', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (11, 1, N'0910000011', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (12, 1, N'0910000012', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (13, NULL, N'0910000001', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (14, NULL, N'0910000002', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (15, NULL, N'0910000003', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (16, NULL, N'0910000004', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (17, NULL, N'0910000005', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (18, NULL, N'0910000006', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (19, NULL, N'0910000007', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (20, NULL, N'0910000008', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (21, NULL, N'0910000009', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (22, NULL, N'0910000010', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (23, NULL, N'0910000011', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (24, NULL, N'0910000012', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (25, 2, N'0910000001', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (26, 2, N'0910000002', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (27, 2, N'0910000003', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (28, 2, N'0910000004', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (29, 2, N'0910000005', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (30, 2, N'0910000006', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (31, 2, N'0910000007', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (32, 2, N'0910000008', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (33, 2, N'0910000009', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (34, 2, N'0910000010', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (35, 2, N'0910000011', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (36, 2, N'0910000012', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (37, NULL, N'0910000001', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (38, NULL, N'0910000002', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (39, NULL, N'0910000003', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (40, NULL, N'0910000004', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (41, NULL, N'0910000005', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (42, NULL, N'0910000006', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (43, NULL, N'0910000007', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (44, NULL, N'0910000008', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (45, NULL, N'0910000009', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (46, NULL, N'0910000010', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (47, NULL, N'0910000011', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (48, NULL, N'0910000012', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (49, 3, N'0910000001', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (50, 3, N'0910000002', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (51, 3, N'0910000003', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (52, 3, N'0910000004', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (53, 3, N'0910000005', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (54, 3, N'0910000006', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (55, 3, N'0910000007', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (56, 3, N'0910000008', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (57, 3, N'0910000009', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (58, 3, N'0910000010', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (59, 3, N'0910000011', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (60, 3, N'0910000012', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (61, NULL, N'0910000001', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (62, NULL, N'0910000002', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (63, NULL, N'0910000003', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (64, NULL, N'0910000004', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (65, NULL, N'0910000005', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (66, NULL, N'0910000006', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (67, NULL, N'0910000007', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (68, NULL, N'0910000008', N'EF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (69, NULL, N'0910000009', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (70, NULL, N'0910000010', N'ENF-004', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (71, NULL, N'0910000011', N'MED-003', NULL)
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (72, NULL, N'0910000012', N'EF-004', NULL)
GO
SET IDENTITY_INSERT [dbo].[asignaciones_finales] OFF
GO
SET IDENTITY_INSERT [dbo].[carreras] ON 
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (1, N'MED-001', N'Medicina', 40, 40)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (2, N'ENF-002', N'Enfermería', 30, 30)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (3, N'DER-003', N'Derecho', 50, 50)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (4, N'ING-004', N'Ingeniería en Tecnologías de la Información', 45, 45)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (5, N'ADM-005', N'Administración de Empresas', 60, 60)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (6, N'ARQ-006', N'Arquitectura', 25, 25)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (7, N'PSI-007', N'Psicología', 35, 35)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (8, N'COM-008', N'Comunicación', 30, 30)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (9, N'AGR-009', N'Ingeniería Agropecuaria', 40, 40)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (10, N'EDU-010', N'Educación Inicial', 35, 35)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (11, N'HOT-011', N'Hospitalidad y Hotelería', 40, 40)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (12, N'BIO-012', N'Biología Marina', 20, 20)
GO
SET IDENTITY_INSERT [dbo].[carreras] OFF
GO
INSERT [dbo].[configuracion_sistema] ([id], [criterio_primario], [criterio_secundario]) VALUES (1, N'puntaje', N'vulnerabilidad')
GO
SET IDENTITY_INSERT [dbo].[historial_procesos] ON 
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (1, CAST(N'2026-01-17T12:25:23.260' AS DateTime), 12, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (2, CAST(N'2026-01-17T12:28:23.513' AS DateTime), 12, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (3, CAST(N'2026-01-17T12:29:27.293' AS DateTime), 12, N'Administrador Principal')
GO
SET IDENTITY_INSERT [dbo].[historial_procesos] OFF
GO
SET IDENTITY_INSERT [dbo].[postulantes] ON 
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (1, N'CEDULA', N'0910000001', N'Juan Carlos', N'Mendoza Lopez', CAST(920.00 AS Decimal(5, 2)), CAST(N'2025-01-02T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.80 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (2, N'CEDULA', N'0910000002', N'Maria Fernanda', N'Gomez Perez', CAST(890.00 AS Decimal(5, 2)), CAST(N'2025-01-03T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'SI', N'NO', CAST(0.75 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (3, N'CEDULA', N'0910000003', N'Luis Alberto', N'Ramirez Torres', CAST(860.00 AS Decimal(5, 2)), CAST(N'2025-01-04T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.65 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (4, N'CEDULA', N'0910000004', N'Ana Lucia', N'Vera Castillo', CAST(840.00 AS Decimal(5, 2)), CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.70 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (5, N'CEDULA', N'0910000005', N'Pedro Javier', N'Cedeño Morales', CAST(820.00 AS Decimal(5, 2)), CAST(N'2025-01-06T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.60 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (6, N'CEDULA', N'0910000006', N'Daniel Andres', N'Paz Bravo', CAST(805.00 AS Decimal(5, 2)), CAST(N'2025-01-07T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.55 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (7, N'CEDULA', N'0910000007', N'Carla Estefania', N'Macias Solorzano', CAST(780.00 AS Decimal(5, 2)), CAST(N'2025-01-08T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', N'SI', CAST(0.78 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (8, N'CEDULA', N'0910000008', N'Jose Miguel', N'Ortega Ruiz', CAST(760.00 AS Decimal(5, 2)), CAST(N'2025-01-09T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.50 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (9, N'CEDULA', N'0910000009', N'Paola Andrea', N'Loor Zambrano', CAST(740.00 AS Decimal(5, 2)), CAST(N'2025-01-10T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.68 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (10, N'CEDULA', N'0910000010', N'Bryan Steven', N'Catagua Cedeño', CAST(720.00 AS Decimal(5, 2)), CAST(N'2025-01-11T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.45 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (11, N'CEDULA', N'0910000011', N'Sofia Elena', N'Reyes Delgado', CAST(700.00 AS Decimal(5, 2)), CAST(N'2025-01-12T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.82 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (12, N'CEDULA', N'0910000012', N'Kevin Alexander', N'Ponce Mero', CAST(680.00 AS Decimal(5, 2)), CAST(N'2025-01-13T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.40 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (13, N'CEDULA', N'0910000013', N'Valeria Isabel', N'Alvarez Rivas', CAST(660.00 AS Decimal(5, 2)), CAST(N'2025-01-14T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'SI', N'NO', CAST(0.77 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (14, N'CEDULA', N'0910000014', N'Jorge Luis', N'Santana Palma', CAST(640.00 AS Decimal(5, 2)), CAST(N'2025-01-15T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.38 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (15, N'CEDULA', N'0910000015', N'Andrea Carolina', N'Peña Velez', CAST(620.00 AS Decimal(5, 2)), CAST(N'2025-01-16T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.62 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (16, N'CEDULA', N'0910000016', N'Carlos Eduardo', N'Mora Lino', CAST(600.00 AS Decimal(5, 2)), CAST(N'2025-01-17T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.35 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (17, N'CEDULA', N'0910000017', N'Natalia Beatriz', N'Quiroz Mendez', CAST(580.00 AS Decimal(5, 2)), CAST(N'2025-01-18T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.80 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (18, N'CEDULA', N'0910000018', N'Diego Sebastian', N'Figueroa Cruz', CAST(560.00 AS Decimal(5, 2)), CAST(N'2025-01-19T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.30 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (19, N'CEDULA', N'0910000019', N'Melissa Paola', N'Chavez Paredes', CAST(540.00 AS Decimal(5, 2)), CAST(N'2025-01-20T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'SI', N'NO', CAST(0.74 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (20, N'CEDULA', N'0910000020', N'Andres Felipe', N'Espinoza Roldan', CAST(520.00 AS Decimal(5, 2)), CAST(N'2025-01-21T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.28 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (21, N'CEDULA', N'0910000021', N'Camila Alejandra', N'Suarez Molina', CAST(500.00 AS Decimal(5, 2)), CAST(N'2025-01-22T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.66 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (22, N'CEDULA', N'0910000022', N'Fernando Isaac', N'Vargas Ortiz', CAST(480.00 AS Decimal(5, 2)), CAST(N'2025-01-23T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.25 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (23, N'CEDULA', N'0910000023', N'Rocio Daniela', N'Guerrero Pino', CAST(460.00 AS Decimal(5, 2)), CAST(N'2025-01-24T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.85 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (24, N'CEDULA', N'0910000024', N'Cristian Mateo', N'Cano Aguilar', CAST(440.00 AS Decimal(5, 2)), CAST(N'2025-01-25T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.22 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (25, N'CEDULA', N'0910000025', N'Paula Cristina', N'Villacres Rosero', CAST(420.00 AS Decimal(5, 2)), CAST(N'2025-01-26T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'SI', N'NO', CAST(0.71 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (26, N'CEDULA', N'0910000026', N'Oscar David', N'Morales Vega', CAST(400.00 AS Decimal(5, 2)), CAST(N'2025-01-27T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.20 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (27, N'CEDULA', N'0910000027', N'Gabriela Fernanda', N'Benitez Luna', CAST(380.00 AS Decimal(5, 2)), CAST(N'2025-01-28T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.64 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (28, N'CEDULA', N'0910000028', N'Jonathan Xavier', N'Paredes Leon', CAST(350.00 AS Decimal(5, 2)), CAST(N'2025-01-29T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.18 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (29, N'CEDULA', N'0910000029', N'Alejandra Sofia', N'Montes Soto', CAST(320.00 AS Decimal(5, 2)), CAST(N'2025-01-30T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.88 AS Decimal(5, 2)))
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad]) VALUES (30, N'CEDULA', N'0910000030', N'MARCO ANTONIO', N'LINARES CAGUA', CAST(700.00 AS Decimal(5, 2)), CAST(N'2025-01-31T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.15 AS Decimal(5, 2)))
GO
SET IDENTITY_INSERT [dbo].[postulantes] OFF
GO
SET IDENTITY_INSERT [dbo].[preferencias_carrera] ON 
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (1, 1, 1, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (2, 1, 4, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (3, 2, 2, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (4, 2, 1, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (5, 3, 3, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (6, 3, 5, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (7, 4, 1, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (8, 4, 7, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (9, 5, 4, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (10, 5, 6, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (11, 6, 10, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (12, 6, 8, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (13, 7, 1, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (14, 8, 3, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (15, 8, 4, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (16, 9, 2, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (17, 9, 12, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (18, 10, 4, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (19, 11, 1, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (20, 11, 2, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (21, 11, 7, 3, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (22, 12, 9, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (23, 12, 11, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (24, 13, 12, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (25, 14, 3, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (26, 15, 7, 1, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (27, 15, 10, 2, N'PENDIENTE', CAST(N'2026-01-17T15:19:40.597' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[preferencias_carrera] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__administ__2A586E0B92757E23]    Script Date: 18/1/2026 0:05:47 ******/
ALTER TABLE [dbo].[administradores] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__administ__415B7BE513E3A384]    Script Date: 18/1/2026 0:05:47 ******/
ALTER TABLE [dbo].[administradores] ADD UNIQUE NONCLUSTERED 
(
	[cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Asignaciones_Proceso]    Script Date: 18/1/2026 0:05:47 ******/
CREATE NONCLUSTERED INDEX [IX_Asignaciones_Proceso] ON [dbo].[asignaciones_finales]
(
	[id_proceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__carreras__40F9A20666E0D77A]    Script Date: 18/1/2026 0:05:47 ******/
ALTER TABLE [dbo].[carreras] ADD UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Carrera_Codigo]    Script Date: 18/1/2026 0:05:47 ******/
ALTER TABLE [dbo].[carreras] ADD  CONSTRAINT [UQ_Carrera_Codigo] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__postulan__C196DEC73E168B8A]    Script Date: 18/1/2026 0:05:47 ******/
ALTER TABLE [dbo].[postulantes] ADD UNIQUE NONCLUSTERED 
(
	[identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Postulante_Identificacion]    Script Date: 18/1/2026 0:05:47 ******/
ALTER TABLE [dbo].[postulantes] ADD  CONSTRAINT [UQ_Postulante_Identificacion] UNIQUE NONCLUSTERED 
(
	[identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Postulantes_Puntaje]    Script Date: 18/1/2026 0:05:47 ******/
CREATE NONCLUSTERED INDEX [IX_Postulantes_Puntaje] ON [dbo].[postulantes]
(
	[puntaje] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[administradores] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[administradores] ADD  DEFAULT ('SI') FOR [activo]
GO
ALTER TABLE [dbo].[configuracion_sistema] ADD  DEFAULT ((1)) FOR [id]
GO
ALTER TABLE [dbo].[historial_procesos] ADD  DEFAULT (getdate()) FOR [fecha_ejecucion]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ('NO') FOR [condicion_socioeconomica]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ('NO') FOR [discapacidad]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ('NO') FOR [pueblos_nacionalidades]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ('NO') FOR [merito_academico]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ('NO') FOR [ruralidad]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ('NO') FOR [territorialidad]
GO
ALTER TABLE [dbo].[postulantes] ADD  DEFAULT ((0)) FOR [vulnerabilidad]
GO
ALTER TABLE [dbo].[preferencias_carrera] ADD  DEFAULT ('PENDIENTE') FOR [estado_asignacion]
GO
ALTER TABLE [dbo].[asignaciones]  WITH CHECK ADD FOREIGN KEY([id_carrera])
REFERENCES [dbo].[carreras] ([id_carrera])
GO
ALTER TABLE [dbo].[asignaciones]  WITH CHECK ADD FOREIGN KEY([id_postulante])
REFERENCES [dbo].[postulantes] ([id_postulante])
GO
ALTER TABLE [dbo].[asignaciones_finales]  WITH CHECK ADD FOREIGN KEY([id_proceso])
REFERENCES [dbo].[historial_procesos] ([id_proceso])
GO
ALTER TABLE [dbo].[asignaciones_finales]  WITH CHECK ADD  CONSTRAINT [FK_Asignaciones_Historial] FOREIGN KEY([id_proceso])
REFERENCES [dbo].[historial_procesos] ([id_proceso])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[asignaciones_finales] CHECK CONSTRAINT [FK_Asignaciones_Historial]
GO
ALTER TABLE [dbo].[asignaciones_finales]  WITH CHECK ADD  CONSTRAINT [FK_Asignaciones_Postulante] FOREIGN KEY([identificacion_postulante])
REFERENCES [dbo].[postulantes] ([identificacion])
GO
ALTER TABLE [dbo].[asignaciones_finales] CHECK CONSTRAINT [FK_Asignaciones_Postulante]
GO
ALTER TABLE [dbo].[preferencias_carrera]  WITH CHECK ADD FOREIGN KEY([id_carrera])
REFERENCES [dbo].[carreras] ([id_carrera])
GO
ALTER TABLE [dbo].[preferencias_carrera]  WITH CHECK ADD FOREIGN KEY([id_postulante])
REFERENCES [dbo].[postulantes] ([id_postulante])
GO
USE [master]
GO
ALTER DATABASE [AsignacionCuposULEAM] SET  READ_WRITE 
GO
