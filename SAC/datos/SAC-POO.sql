USE [master]
GO
/****** Object:  Database [AsignacionCuposULEAM]    Script Date: 19/1/2026 0:01:40 ******/
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
/****** Object:  Table [dbo].[administradores]    Script Date: 19/1/2026 0:01:41 ******/
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
/****** Object:  Table [dbo].[asignaciones]    Script Date: 19/1/2026 0:01:41 ******/
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
/****** Object:  Table [dbo].[asignaciones_finales]    Script Date: 19/1/2026 0:01:41 ******/
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
/****** Object:  Table [dbo].[carreras]    Script Date: 19/1/2026 0:01:41 ******/
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
/****** Object:  Table [dbo].[configuracion_sistema]    Script Date: 19/1/2026 0:01:41 ******/
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
/****** Object:  Table [dbo].[historial_procesos]    Script Date: 19/1/2026 0:01:41 ******/
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
/****** Object:  Table [dbo].[postulantes]    Script Date: 19/1/2026 0:01:41 ******/
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
	[correo] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_postulante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[preferencias_carrera]    Script Date: 19/1/2026 0:01:41 ******/
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
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (1, 7, N'0910000001', N'BIO-012', CAST(N'2026-01-18T23:15:11.573' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (2, 7, N'0910000002', N'ENF-002', CAST(N'2026-01-18T23:15:11.577' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (3, 7, N'0910000003', N'MED-001', CAST(N'2026-01-18T23:15:11.577' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (4, 7, N'0910000004', N'DER-003', CAST(N'2026-01-18T23:15:11.580' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (5, 7, N'0910000005', N'ING-004', CAST(N'2026-01-18T23:15:11.580' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (6, 7, N'0910000006', N'BIO-012', CAST(N'2026-01-18T23:15:11.580' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (7, 7, N'0910000007', N'ADM-005', CAST(N'2026-01-18T23:15:11.580' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (8, 7, N'0910000008', N'AGR-009', CAST(N'2026-01-18T23:15:11.583' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (9, 7, N'0910000009', N'BIO-012', CAST(N'2026-01-18T23:15:11.583' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (10, 7, N'0910000010', N'ARQ-006', CAST(N'2026-01-18T23:15:11.583' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (11, 7, N'0910000011', N'PSI-007', CAST(N'2026-01-18T23:15:11.583' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (12, 7, N'0910000030', N'ADM-005', CAST(N'2026-01-18T23:15:11.587' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (13, 7, N'0910000031', N'ARQ-006', CAST(N'2026-01-18T23:15:11.587' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (14, 7, N'0910000101', N'BIO-012', CAST(N'2026-01-18T23:15:11.587' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (15, 7, N'0910000012', N'COM-008', CAST(N'2026-01-18T23:15:11.587' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (16, 8, N'0910000032', N'PSI-007', CAST(N'2026-01-18T23:15:29.430' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (17, 8, N'0910000102', N'ENF-002', CAST(N'2026-01-18T23:15:29.433' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (18, 8, N'0910000103', N'MED-001', CAST(N'2026-01-18T23:15:29.433' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (19, 8, N'0910000033', N'COM-008', CAST(N'2026-01-18T23:15:29.433' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (20, 8, N'0910000104', N'DER-003', CAST(N'2026-01-18T23:15:29.437' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (21, 8, N'0910000105', N'ING-004', CAST(N'2026-01-18T23:15:29.437' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (22, 8, N'0910000013', N'AGR-009', CAST(N'2026-01-18T23:15:29.437' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (23, 8, N'0910000034', N'AGR-009', CAST(N'2026-01-18T23:15:29.437' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (24, 8, N'0910000106', N'BIO-012', CAST(N'2026-01-18T23:15:29.440' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (25, 8, N'0910000107', N'ADM-005', CAST(N'2026-01-18T23:15:29.440' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (26, 8, N'0910000035', N'EDU-010', CAST(N'2026-01-18T23:15:29.440' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (27, 8, N'0910000108', N'AGR-009', CAST(N'2026-01-18T23:15:29.443' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (28, 8, N'0910000109', N'BIO-012', CAST(N'2026-01-18T23:15:29.447' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (29, 8, N'0910000014', N'EDU-010', CAST(N'2026-01-18T23:15:29.447' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (30, 8, N'0910000036', N'HOT-011', CAST(N'2026-01-18T23:15:29.447' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (31, 9, N'0910000110', N'ARQ-006', CAST(N'2026-01-18T23:17:09.463' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (32, 9, N'0910000111', N'PSI-007', CAST(N'2026-01-18T23:17:09.467' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (33, 9, N'0910000037', N'BIO-012', CAST(N'2026-01-18T23:17:09.470' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (34, 9, N'0910000112', N'COM-008', CAST(N'2026-01-18T23:17:09.470' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (35, 9, N'0910000113', N'AGR-009', CAST(N'2026-01-18T23:17:09.470' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (36, 9, N'0910000015', N'BIO-012', CAST(N'2026-01-18T23:17:09.473' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (37, 9, N'0910000038', N'HOT-011', CAST(N'2026-01-18T23:17:09.473' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (38, 9, N'0910000114', N'EDU-010', CAST(N'2026-01-18T23:17:09.477' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (39, 9, N'0910000115', N'BIO-012', CAST(N'2026-01-18T23:17:09.477' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (40, 9, N'0910000039', N'EDU-010', CAST(N'2026-01-18T23:17:09.480' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (41, 9, N'0910000116', N'HOT-011', CAST(N'2026-01-18T23:17:09.480' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (42, 9, N'0910000117', N'EDU-010', CAST(N'2026-01-18T23:17:09.483' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (43, 9, N'0910000016', N'HOT-011', CAST(N'2026-01-18T23:17:09.483' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (44, 9, N'0910000040', N'AGR-009', CAST(N'2026-01-18T23:17:09.487' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (45, 9, N'0910000118', N'AGR-009', CAST(N'2026-01-18T23:17:09.487' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (46, 10, N'0910000099', N'ENF-002', CAST(N'2026-01-18T23:21:07.973' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (47, 10, N'0910000137', N'BIO-012', CAST(N'2026-01-18T23:21:07.980' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (48, 10, N'0910000135', N'EDU-010', CAST(N'2026-01-18T23:21:07.980' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (49, 10, N'0910000089', N'EDU-010', CAST(N'2026-01-18T23:21:07.983' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (50, 10, N'0910000079', N'ING-004', CAST(N'2026-01-18T23:21:07.983' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (51, 10, N'0910000129', N'ING-004', CAST(N'2026-01-18T23:21:07.983' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (52, 10, N'0910000086', N'HOT-011', CAST(N'2026-01-18T23:21:07.987' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (53, 10, N'0910000096', N'DER-003', CAST(N'2026-01-18T23:21:07.987' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (54, 10, N'0910000119', N'COM-008', CAST(N'2026-01-18T23:21:07.987' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (55, 10, N'0910000140', N'MED-001', CAST(N'2026-01-18T23:21:07.990' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (56, 10, N'0910000029', N'ING-004', CAST(N'2026-01-18T23:21:07.990' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (57, 10, N'0910000069', N'COM-008', CAST(N'2026-01-18T23:21:07.990' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (58, 10, N'0910000126', N'MED-001', CAST(N'2026-01-18T23:21:07.990' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (59, 10, N'0910000076', N'MED-001', CAST(N'2026-01-18T23:21:07.993' AS DateTime))
GO
INSERT [dbo].[asignaciones_finales] ([id_asignacion], [id_proceso], [identificacion_postulante], [codigo_carrera], [fecha_ejecucion]) VALUES (60, 10, N'0910000092', N'PSI-007', CAST(N'2026-01-18T23:21:07.993' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[asignaciones_finales] OFF
GO
SET IDENTITY_INSERT [dbo].[carreras] ON 
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (1, N'MED-001', N'Medicina', 40, 35)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (2, N'ENF-002', N'Enfermería', 30, 27)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (3, N'DER-003', N'Derecho', 50, 47)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (4, N'ING-004', N'Ingeniería en Tecnologías de la Información', 45, 40)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (5, N'ADM-005', N'Administración de Empresas', 60, 57)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (6, N'ARQ-006', N'Arquitectura', 25, 22)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (7, N'PSI-007', N'Psicología', 35, 31)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (8, N'COM-008', N'Comunicación', 40, 35)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (9, N'AGR-009', N'Ingeniería Agropecuaria', 40, 32)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (10, N'EDU-010', N'Educación Inicial', 35, 28)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (11, N'HOT-011', N'Hospitalidad y Hotelería', 40, 35)
GO
INSERT [dbo].[carreras] ([id_carrera], [codigo], [nombre], [cupos_totales], [cupos_disponibles]) VALUES (12, N'BIO-012', N'Biología Marina', 20, 10)
GO
SET IDENTITY_INSERT [dbo].[carreras] OFF
GO
INSERT [dbo].[configuracion_sistema] ([id], [criterio_primario], [criterio_secundario]) VALUES (1, N'vulnerabilidad', N'fecha_inscripcion')
GO
SET IDENTITY_INSERT [dbo].[historial_procesos] ON 
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (1, CAST(N'2026-01-17T12:25:23.260' AS DateTime), 12, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (2, CAST(N'2026-01-17T12:28:23.513' AS DateTime), 12, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (3, CAST(N'2026-01-17T12:29:27.293' AS DateTime), 12, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (4, CAST(N'2026-01-18T00:06:47.493' AS DateTime), 15, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (5, CAST(N'2026-01-18T20:36:31.730' AS DateTime), 15, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (6, CAST(N'2026-01-18T20:43:35.143' AS DateTime), 15, N'Administrador Principal')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (7, CAST(N'2026-01-18T23:15:11.567' AS DateTime), 15, N'1351914146')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (8, CAST(N'2026-01-18T23:15:29.430' AS DateTime), 15, N'1351914146')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (9, CAST(N'2026-01-18T23:17:09.453' AS DateTime), 15, N'1351914146')
GO
INSERT [dbo].[historial_procesos] ([id_proceso], [fecha_ejecucion], [cupos_asignados], [usuario_responsable]) VALUES (10, CAST(N'2026-01-18T23:21:07.967' AS DateTime), 15, N'1351914146')
GO
SET IDENTITY_INSERT [dbo].[historial_procesos] OFF
GO
SET IDENTITY_INSERT [dbo].[postulantes] ON 
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (1, N'CEDULA', N'0910000001', N'Juan Carlos', N'Mendoza Lopez', CAST(920.00 AS Decimal(5, 2)), CAST(N'2025-01-02T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.80 AS Decimal(5, 2)), N'0910000001@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (2, N'CEDULA', N'0910000002', N'Maria Fernanda', N'Gomez Perez', CAST(890.00 AS Decimal(5, 2)), CAST(N'2025-01-03T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'SI', N'NO', CAST(0.75 AS Decimal(5, 2)), N'0910000002@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (3, N'CEDULA', N'0910000003', N'Luis Alberto', N'Ramirez Torres', CAST(860.00 AS Decimal(5, 2)), CAST(N'2025-01-04T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.65 AS Decimal(5, 2)), N'0910000003@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (4, N'CEDULA', N'0910000004', N'Ana Lucia', N'Vera Castillo', CAST(840.00 AS Decimal(5, 2)), CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.70 AS Decimal(5, 2)), N'0910000004@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (5, N'CEDULA', N'0910000005', N'Pedro Javier', N'Cedeño Morales', CAST(820.00 AS Decimal(5, 2)), CAST(N'2025-01-06T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.60 AS Decimal(5, 2)), N'0910000005@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (6, N'CEDULA', N'0910000006', N'Daniel Andres', N'Paz Bravo', CAST(805.00 AS Decimal(5, 2)), CAST(N'2025-01-07T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.55 AS Decimal(5, 2)), N'0910000006@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (7, N'CEDULA', N'0910000007', N'Carla Estefania', N'Macias Solorzano', CAST(780.00 AS Decimal(5, 2)), CAST(N'2025-01-08T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', N'SI', CAST(0.78 AS Decimal(5, 2)), N'0910000007@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (8, N'CEDULA', N'0910000008', N'Jose Miguel', N'Ortega Ruiz', CAST(760.00 AS Decimal(5, 2)), CAST(N'2025-01-09T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.50 AS Decimal(5, 2)), N'0910000008@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (9, N'CEDULA', N'0910000009', N'Paola Andrea', N'Loor Zambrano', CAST(740.00 AS Decimal(5, 2)), CAST(N'2025-01-10T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.68 AS Decimal(5, 2)), N'0910000009@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (10, N'CEDULA', N'0910000010', N'Bryan Steven', N'Catagua Cedeño', CAST(720.00 AS Decimal(5, 2)), CAST(N'2025-01-11T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.45 AS Decimal(5, 2)), N'0910000010@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (11, N'CEDULA', N'0910000011', N'Sofia Elena', N'Reyes Delgado', CAST(700.00 AS Decimal(5, 2)), CAST(N'2025-01-12T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.82 AS Decimal(5, 2)), N'0910000011@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (12, N'CEDULA', N'0910000012', N'Kevin Alexander', N'Ponce Mero', CAST(680.00 AS Decimal(5, 2)), CAST(N'2025-01-13T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.40 AS Decimal(5, 2)), N'0910000012@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (13, N'CEDULA', N'0910000013', N'Valeria Isabel', N'Alvarez Rivas', CAST(660.00 AS Decimal(5, 2)), CAST(N'2025-01-14T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'SI', N'NO', CAST(0.77 AS Decimal(5, 2)), N'0910000013@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (14, N'CEDULA', N'0910000014', N'Jorge Luis', N'Santana Palma', CAST(640.00 AS Decimal(5, 2)), CAST(N'2025-01-15T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.38 AS Decimal(5, 2)), N'0910000014@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (15, N'CEDULA', N'0910000015', N'Andrea Carolina', N'Peña Velez', CAST(620.00 AS Decimal(5, 2)), CAST(N'2025-01-16T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.62 AS Decimal(5, 2)), N'0910000015@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (16, N'CEDULA', N'0910000016', N'Carlos Eduardo', N'Mora Lino', CAST(600.00 AS Decimal(5, 2)), CAST(N'2025-01-17T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.35 AS Decimal(5, 2)), N'0910000016@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (17, N'CEDULA', N'0910000017', N'Natalia Beatriz', N'Quiroz Mendez', CAST(580.00 AS Decimal(5, 2)), CAST(N'2025-01-18T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.80 AS Decimal(5, 2)), N'0910000017@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (18, N'CEDULA', N'0910000018', N'Diego Sebastian', N'Figueroa Cruz', CAST(560.00 AS Decimal(5, 2)), CAST(N'2025-01-19T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.30 AS Decimal(5, 2)), N'0910000018@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (19, N'CEDULA', N'0910000019', N'Melissa Paola', N'Chavez Paredes', CAST(540.00 AS Decimal(5, 2)), CAST(N'2025-01-20T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'SI', N'NO', CAST(0.74 AS Decimal(5, 2)), N'0910000019@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (20, N'CEDULA', N'0910000020', N'Andres Felipe', N'Espinoza Roldan', CAST(520.00 AS Decimal(5, 2)), CAST(N'2025-01-21T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.28 AS Decimal(5, 2)), N'0910000020@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (21, N'CEDULA', N'0910000021', N'Camila Alejandra', N'Suarez Molina', CAST(500.00 AS Decimal(5, 2)), CAST(N'2025-01-22T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.66 AS Decimal(5, 2)), N'0910000021@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (22, N'CEDULA', N'0910000022', N'Fernando Isaac', N'Vargas Ortiz', CAST(480.00 AS Decimal(5, 2)), CAST(N'2025-01-23T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.25 AS Decimal(5, 2)), N'0910000022@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (23, N'CEDULA', N'0910000023', N'Rocio Daniela', N'Guerrero Pino', CAST(460.00 AS Decimal(5, 2)), CAST(N'2025-01-24T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.85 AS Decimal(5, 2)), N'0910000023@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (24, N'CEDULA', N'0910000024', N'Cristian Mateo', N'Cano Aguilar', CAST(440.00 AS Decimal(5, 2)), CAST(N'2025-01-25T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.22 AS Decimal(5, 2)), N'0910000024@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (25, N'CEDULA', N'0910000025', N'Paula Cristina', N'Villacres Rosero', CAST(420.00 AS Decimal(5, 2)), CAST(N'2025-01-26T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'SI', N'NO', N'SI', N'NO', CAST(0.71 AS Decimal(5, 2)), N'0910000025@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (26, N'CEDULA', N'0910000026', N'Oscar David', N'Morales Vega', CAST(400.00 AS Decimal(5, 2)), CAST(N'2025-01-27T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.20 AS Decimal(5, 2)), N'0910000026@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (27, N'CEDULA', N'0910000027', N'Gabriela Fernanda', N'Benitez Luna', CAST(380.00 AS Decimal(5, 2)), CAST(N'2025-01-28T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.64 AS Decimal(5, 2)), N'0910000027@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (28, N'CEDULA', N'0910000028', N'Jonathan Xavier', N'Paredes Leon', CAST(350.00 AS Decimal(5, 2)), CAST(N'2025-01-29T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.18 AS Decimal(5, 2)), N'0910000028@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (29, N'CEDULA', N'0910000029', N'Alejandra Sofia', N'Montes Soto', CAST(320.00 AS Decimal(5, 2)), CAST(N'2025-01-30T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.88 AS Decimal(5, 2)), N'0910000029@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (30, N'CEDULA', N'0910000030', N'MARCO ANTONIO', N'LINARES CAGUA', CAST(700.00 AS Decimal(5, 2)), CAST(N'2025-01-31T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.15 AS Decimal(5, 2)), N'0910000030@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (31, N'CEDULA', N'0910000031', N'Luis Fernando', N'Zamora Pico', CAST(690.00 AS Decimal(5, 2)), CAST(N'2025-02-01T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.63 AS Decimal(5, 2)), N'0910000031@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (32, N'CEDULA', N'0910000032', N'Diana Carolina', N'Mero Andrade', CAST(680.00 AS Decimal(5, 2)), CAST(N'2025-02-02T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.58 AS Decimal(5, 2)), N'0910000032@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (33, N'CEDULA', N'0910000033', N'Miguel Angel', N'Cruz Delgado', CAST(670.00 AS Decimal(5, 2)), CAST(N'2025-02-03T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.72 AS Decimal(5, 2)), N'0910000033@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (34, N'CEDULA', N'0910000034', N'Paola Fernanda', N'Ponce Vera', CAST(660.00 AS Decimal(5, 2)), CAST(N'2025-02-04T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.76 AS Decimal(5, 2)), N'0910000034@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (35, N'CEDULA', N'0910000035', N'Jonathan Ivan', N'Lopez Mejia', CAST(650.00 AS Decimal(5, 2)), CAST(N'2025-02-05T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.61 AS Decimal(5, 2)), N'0910000035@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (36, N'CEDULA', N'0910000036', N'Andrea Belén', N'Solís Ramos', CAST(640.00 AS Decimal(5, 2)), CAST(N'2025-02-06T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.55 AS Decimal(5, 2)), N'0910000036@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (37, N'CEDULA', N'0910000037', N'Carlos Manuel', N'Vera Cedeño', CAST(630.00 AS Decimal(5, 2)), CAST(N'2025-02-07T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.69 AS Decimal(5, 2)), N'0910000037@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (38, N'CEDULA', N'0910000038', N'Samantha Nicole', N'Alcívar Paz', CAST(620.00 AS Decimal(5, 2)), CAST(N'2025-02-08T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.48 AS Decimal(5, 2)), N'0910000038@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (39, N'CEDULA', N'0910000039', N'Ricardo Javier', N'Bravo Molina', CAST(610.00 AS Decimal(5, 2)), CAST(N'2025-02-09T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.81 AS Decimal(5, 2)), N'0910000039@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (40, N'CEDULA', N'0910000040', N'Daniela Sofía', N'Intriago Mero', CAST(600.00 AS Decimal(5, 2)), CAST(N'2025-02-10T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.42 AS Decimal(5, 2)), N'0910000040@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (41, N'CEDULA', N'0910000041', N'José Antonio', N'Reinoso Paredes', CAST(590.00 AS Decimal(5, 2)), CAST(N'2025-02-11T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.65 AS Decimal(5, 2)), N'0910000041@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (42, N'CEDULA', N'0910000042', N'Karen Michelle', N'Mendoza Vera', CAST(580.00 AS Decimal(5, 2)), CAST(N'2025-02-12T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.79 AS Decimal(5, 2)), N'0910000042@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (43, N'CEDULA', N'0910000043', N'Bryan Esteban', N'Sánchez Loor', CAST(570.00 AS Decimal(5, 2)), CAST(N'2025-02-13T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.70 AS Decimal(5, 2)), N'0910000043@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (44, N'CEDULA', N'0910000044', N'Valentina Paz', N'Ortega Ruiz', CAST(560.00 AS Decimal(5, 2)), CAST(N'2025-02-14T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.53 AS Decimal(5, 2)), N'0910000044@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (45, N'CEDULA', N'0910000045', N'Marco Vinicio', N'Delgado Torres', CAST(550.00 AS Decimal(5, 2)), CAST(N'2025-02-15T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.60 AS Decimal(5, 2)), N'0910000045@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (46, N'CEDULA', N'0910000046', N'Natalia Fernanda', N'Zambrano Vélez', CAST(540.00 AS Decimal(5, 2)), CAST(N'2025-02-16T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.83 AS Decimal(5, 2)), N'0910000046@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (47, N'CEDULA', N'0910000047', N'Kevin David', N'Mero Cedeño', CAST(530.00 AS Decimal(5, 2)), CAST(N'2025-02-17T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.67 AS Decimal(5, 2)), N'0910000047@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (48, N'CEDULA', N'0910000048', N'Pamela Andrea', N'García Chica', CAST(520.00 AS Decimal(5, 2)), CAST(N'2025-02-18T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.40 AS Decimal(5, 2)), N'0910000048@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (49, N'CEDULA', N'0910000049', N'Cristian Alejandro', N'Loor Pincay', CAST(510.00 AS Decimal(5, 2)), CAST(N'2025-02-19T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.62 AS Decimal(5, 2)), N'0910000049@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (50, N'CEDULA', N'0910000050', N'Laura Stefany', N'Cañarte Ruiz', CAST(500.00 AS Decimal(5, 2)), CAST(N'2025-02-20T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.85 AS Decimal(5, 2)), N'0910000050@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (51, N'CEDULA', N'0910000051', N'Fernando Miguel', N'Pico Loor', CAST(490.00 AS Decimal(5, 2)), CAST(N'2025-02-21T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.64 AS Decimal(5, 2)), N'0910000051@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (52, N'CEDULA', N'0910000052', N'Carolina Estefanía', N'Zambrano Ruiz', CAST(480.00 AS Decimal(5, 2)), CAST(N'2025-02-22T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.57 AS Decimal(5, 2)), N'0910000052@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (53, N'CEDULA', N'0910000053', N'Alex Mauricio', N'Mero Santana', CAST(470.00 AS Decimal(5, 2)), CAST(N'2025-02-23T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.70 AS Decimal(5, 2)), N'0910000053@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (54, N'CEDULA', N'0910000054', N'Daniela Paola', N'Vera Pincay', CAST(460.00 AS Decimal(5, 2)), CAST(N'2025-02-24T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.82 AS Decimal(5, 2)), N'0910000054@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (55, N'CEDULA', N'0910000055', N'Jorge Armando', N'Loor Cedeño', CAST(450.00 AS Decimal(5, 2)), CAST(N'2025-02-25T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.61 AS Decimal(5, 2)), N'0910000055@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (56, N'CEDULA', N'0910000056', N'Pamela Nicole', N'García Mendoza', CAST(440.00 AS Decimal(5, 2)), CAST(N'2025-02-26T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.52 AS Decimal(5, 2)), N'0910000056@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (57, N'CEDULA', N'0910000057', N'Luis Enrique', N'Alcívar Mora', CAST(430.00 AS Decimal(5, 2)), CAST(N'2025-02-27T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.68 AS Decimal(5, 2)), N'0910000057@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (58, N'CEDULA', N'0910000058', N'Valeria Belén', N'Paz Delgado', CAST(420.00 AS Decimal(5, 2)), CAST(N'2025-02-28T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.46 AS Decimal(5, 2)), N'0910000058@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (59, N'CEDULA', N'0910000059', N'Cristian Eduardo', N'Reyes Zambrano', CAST(410.00 AS Decimal(5, 2)), CAST(N'2025-03-01T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.84 AS Decimal(5, 2)), N'0910000059@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (60, N'CEDULA', N'0910000060', N'Andrea Michelle', N'Bravo López', CAST(400.00 AS Decimal(5, 2)), CAST(N'2025-03-02T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.38 AS Decimal(5, 2)), N'0910000060@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (61, N'CEDULA', N'0910000061', N'Kevin Sebastián', N'Mendoza Pico', CAST(390.00 AS Decimal(5, 2)), CAST(N'2025-03-03T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.63 AS Decimal(5, 2)), N'0910000061@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (62, N'CEDULA', N'0910000062', N'Natalia Andrea', N'Vélez Torres', CAST(380.00 AS Decimal(5, 2)), CAST(N'2025-03-04T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.81 AS Decimal(5, 2)), N'0910000062@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (63, N'CEDULA', N'0910000063', N'Juan Esteban', N'Cruz Mero', CAST(370.00 AS Decimal(5, 2)), CAST(N'2025-03-05T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.69 AS Decimal(5, 2)), N'0910000063@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (64, N'CEDULA', N'0910000064', N'Melissa Fernanda', N'Ortega Ruiz', CAST(360.00 AS Decimal(5, 2)), CAST(N'2025-03-06T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.51 AS Decimal(5, 2)), N'0910000064@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (65, N'CEDULA', N'0910000065', N'Oscar Patricio', N'Delgado Vera', CAST(350.00 AS Decimal(5, 2)), CAST(N'2025-03-07T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.59 AS Decimal(5, 2)), N'0910000065@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (66, N'CEDULA', N'0910000066', N'Sofía Carolina', N'Mero Zambrano', CAST(340.00 AS Decimal(5, 2)), CAST(N'2025-03-08T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.86 AS Decimal(5, 2)), N'0910000066@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (67, N'CEDULA', N'0910000067', N'Ricardo Javier', N'Pincay Loor', CAST(330.00 AS Decimal(5, 2)), CAST(N'2025-03-09T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.66 AS Decimal(5, 2)), N'0910000067@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (68, N'CEDULA', N'0910000068', N'Camila Daniela', N'Reinoso Paz', CAST(320.00 AS Decimal(5, 2)), CAST(N'2025-03-10T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.35 AS Decimal(5, 2)), N'0910000068@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (69, N'CEDULA', N'0910000069', N'Bryan Alexander', N'Mora Cedeño', CAST(310.00 AS Decimal(5, 2)), CAST(N'2025-03-11T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.88 AS Decimal(5, 2)), N'0910000069@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (70, N'CEDULA', N'0910000070', N'Paola Cristina', N'Vargas Mero', CAST(300.00 AS Decimal(5, 2)), CAST(N'2025-03-12T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.30 AS Decimal(5, 2)), N'0910000070@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (71, N'CEDULA', N'0910000071', N'David Fernando', N'López Ruiz', CAST(290.00 AS Decimal(5, 2)), CAST(N'2025-03-13T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.58 AS Decimal(5, 2)), N'0910000071@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (72, N'CEDULA', N'0910000072', N'Gabriela Estefanía', N'Chica Andrade', CAST(280.00 AS Decimal(5, 2)), CAST(N'2025-03-14T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.83 AS Decimal(5, 2)), N'0910000072@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (73, N'CEDULA', N'0910000073', N'Jonathan Andrés', N'Cedeño Paz', CAST(270.00 AS Decimal(5, 2)), CAST(N'2025-03-15T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.65 AS Decimal(5, 2)), N'0910000073@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (74, N'CEDULA', N'0910000074', N'María José', N'Torres Lino', CAST(260.00 AS Decimal(5, 2)), CAST(N'2025-03-16T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.47 AS Decimal(5, 2)), N'0910000074@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (75, N'CEDULA', N'0910000075', N'Ángel Mauricio', N'Santana Pico', CAST(250.00 AS Decimal(5, 2)), CAST(N'2025-03-17T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.56 AS Decimal(5, 2)), N'0910000075@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (76, N'CEDULA', N'0910000076', N'Lucía Fernanda', N'Vera Ruiz', CAST(240.00 AS Decimal(5, 2)), CAST(N'2025-03-18T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.87 AS Decimal(5, 2)), N'0910000076@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (77, N'CEDULA', N'0910000077', N'Carlos Andrés', N'Mero Delgado', CAST(230.00 AS Decimal(5, 2)), CAST(N'2025-03-19T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.62 AS Decimal(5, 2)), N'0910000077@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (78, N'CEDULA', N'0910000078', N'Daniela Nicole', N'Paz Zambrano', CAST(220.00 AS Decimal(5, 2)), CAST(N'2025-03-20T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.28 AS Decimal(5, 2)), N'0910000078@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (79, N'CEDULA', N'0910000079', N'Luis Alberto', N'Reyes Pico', CAST(210.00 AS Decimal(5, 2)), CAST(N'2025-03-21T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.90 AS Decimal(5, 2)), N'0910000079@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (80, N'CEDULA', N'0910000080', N'Andrea Belén', N'Molina Loor', CAST(200.00 AS Decimal(5, 2)), CAST(N'2025-03-22T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.25 AS Decimal(5, 2)), N'0910000080@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (81, N'CEDULA', N'0910000081', N'Kevin Mateo', N'Cruz Vera', CAST(195.00 AS Decimal(5, 2)), CAST(N'2025-03-23T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.55 AS Decimal(5, 2)), N'0910000081@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (82, N'CEDULA', N'0910000082', N'Natalia Sofía', N'Espinoza Ruiz', CAST(190.00 AS Decimal(5, 2)), CAST(N'2025-03-24T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.84 AS Decimal(5, 2)), N'0910000082@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (83, N'CEDULA', N'0910000083', N'Diego Alejandro', N'Mero Paz', CAST(185.00 AS Decimal(5, 2)), CAST(N'2025-03-25T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.60 AS Decimal(5, 2)), N'0910000083@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (84, N'CEDULA', N'0910000084', N'Paula Andrea', N'Loor Andrade', CAST(180.00 AS Decimal(5, 2)), CAST(N'2025-03-26T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.45 AS Decimal(5, 2)), N'0910000084@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (85, N'CEDULA', N'0910000085', N'Marco Esteban', N'Vélez Cedeño', CAST(175.00 AS Decimal(5, 2)), CAST(N'2025-03-27T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.54 AS Decimal(5, 2)), N'0910000085@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (86, N'CEDULA', N'0910000086', N'Valentina Isabel', N'Torres Pico', CAST(170.00 AS Decimal(5, 2)), CAST(N'2025-03-28T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.89 AS Decimal(5, 2)), N'0910000086@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (87, N'CEDULA', N'0910000087', N'Bryan Mauricio', N'Mendoza Lino', CAST(165.00 AS Decimal(5, 2)), CAST(N'2025-03-29T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.58 AS Decimal(5, 2)), N'0910000087@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (88, N'CEDULA', N'0910000088', N'Camilo Andrés', N'Santana Vera', CAST(160.00 AS Decimal(5, 2)), CAST(N'2025-03-30T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.22 AS Decimal(5, 2)), N'0910000088@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (89, N'CEDULA', N'0910000089', N'Samantha Nicole', N'Paz Mero', CAST(155.00 AS Decimal(5, 2)), CAST(N'2025-03-31T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.92 AS Decimal(5, 2)), N'0910000089@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (90, N'CEDULA', N'0910000090', N'José Miguel', N'Ruiz Cedeño', CAST(150.00 AS Decimal(5, 2)), CAST(N'2025-04-01T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.20 AS Decimal(5, 2)), N'0910000090@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (91, N'CEDULA', N'0910000091', N'Laura Belén', N'Chávez Pico', CAST(148.00 AS Decimal(5, 2)), CAST(N'2025-04-02T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.53 AS Decimal(5, 2)), N'0910000091@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (92, N'CEDULA', N'0910000092', N'Andrés Felipe', N'Mero Ruiz', CAST(146.00 AS Decimal(5, 2)), CAST(N'2025-04-03T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.86 AS Decimal(5, 2)), N'0910000092@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (93, N'CEDULA', N'0910000093', N'Karla Estefanía', N'Lino Andrade', CAST(144.00 AS Decimal(5, 2)), CAST(N'2025-04-04T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.57 AS Decimal(5, 2)), N'0910000093@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (94, N'CEDULA', N'0910000094', N'Juan Sebastián', N'Paz Torres', CAST(142.00 AS Decimal(5, 2)), CAST(N'2025-04-05T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.41 AS Decimal(5, 2)), N'0910000094@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (95, N'CEDULA', N'0910000095', N'Mónica Paola', N'Vera Cedeño', CAST(140.00 AS Decimal(5, 2)), CAST(N'2025-04-06T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.52 AS Decimal(5, 2)), N'0910000095@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (96, N'CEDULA', N'0910000096', N'Oscar Alejandro', N'Reyes Ruiz', CAST(138.00 AS Decimal(5, 2)), CAST(N'2025-04-07T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.88 AS Decimal(5, 2)), N'0910000096@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (97, N'CEDULA', N'0910000097', N'Daniela Fernanda', N'Mendoza Pico', CAST(136.00 AS Decimal(5, 2)), CAST(N'2025-04-08T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.56 AS Decimal(5, 2)), N'0910000097@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (98, N'CEDULA', N'0910000098', N'Ricardo Andrés', N'Cedeño Loor', CAST(134.00 AS Decimal(5, 2)), CAST(N'2025-04-09T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.24 AS Decimal(5, 2)), N'0910000098@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (99, N'CEDULA', N'0910000099', N'Paola Andrea', N'Torres Zambrano', CAST(132.00 AS Decimal(5, 2)), CAST(N'2025-04-10T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.93 AS Decimal(5, 2)), N'0910000099@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (100, N'CEDULA', N'0910000100', N'Luis Antonio', N'Mora Vera', CAST(130.00 AS Decimal(5, 2)), CAST(N'2025-04-11T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.18 AS Decimal(5, 2)), N'0910000100@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (101, N'CEDULA', N'0910000101', N'Carlos Andrés', N'Pico Loor', CAST(685.00 AS Decimal(5, 2)), CAST(N'2025-04-12T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.64 AS Decimal(5, 2)), N'0910000101@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (102, N'CEDULA', N'0910000102', N'Andrea Belén', N'Zambrano Ruiz', CAST(680.00 AS Decimal(5, 2)), CAST(N'2025-04-13T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.58 AS Decimal(5, 2)), N'0910000102@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (103, N'CEDULA', N'0910000103', N'Luis Fernando', N'Mero Santana', CAST(675.00 AS Decimal(5, 2)), CAST(N'2025-04-14T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.71 AS Decimal(5, 2)), N'0910000103@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (104, N'CEDULA', N'0910000104', N'Daniela Paola', N'Vera Pincay', CAST(670.00 AS Decimal(5, 2)), CAST(N'2025-04-15T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.80 AS Decimal(5, 2)), N'0910000104@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (105, N'CEDULA', N'0910000105', N'Jorge Armando', N'Loor Cedeño', CAST(665.00 AS Decimal(5, 2)), CAST(N'2025-04-16T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.61 AS Decimal(5, 2)), N'0910000105@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (106, N'CEDULA', N'0910000106', N'Pamela Nicole', N'García Mendoza', CAST(660.00 AS Decimal(5, 2)), CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.53 AS Decimal(5, 2)), N'0910000106@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (107, N'CEDULA', N'0910000107', N'Ricardo Javier', N'Alcívar Mora', CAST(655.00 AS Decimal(5, 2)), CAST(N'2025-04-18T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.68 AS Decimal(5, 2)), N'0910000107@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (108, N'CEDULA', N'0910000108', N'Valeria Belén', N'Paz Delgado', CAST(650.00 AS Decimal(5, 2)), CAST(N'2025-04-19T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.46 AS Decimal(5, 2)), N'0910000108@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (109, N'CEDULA', N'0910000109', N'Cristian Eduardo', N'Reyes Zambrano', CAST(645.00 AS Decimal(5, 2)), CAST(N'2025-04-20T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.83 AS Decimal(5, 2)), N'0910000109@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (110, N'CEDULA', N'0910000110', N'Andrea Michelle', N'Bravo López', CAST(640.00 AS Decimal(5, 2)), CAST(N'2025-04-21T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.38 AS Decimal(5, 2)), N'0910000110@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (111, N'CEDULA', N'0910000111', N'Kevin Sebastián', N'Mendoza Pico', CAST(635.00 AS Decimal(5, 2)), CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.63 AS Decimal(5, 2)), N'0910000111@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (112, N'CEDULA', N'0910000112', N'Natalia Andrea', N'Vélez Torres', CAST(630.00 AS Decimal(5, 2)), CAST(N'2025-04-23T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.81 AS Decimal(5, 2)), N'0910000112@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (113, N'CEDULA', N'0910000113', N'Juan Esteban', N'Cruz Mero', CAST(625.00 AS Decimal(5, 2)), CAST(N'2025-04-24T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.69 AS Decimal(5, 2)), N'0910000113@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (114, N'CEDULA', N'0910000114', N'Melissa Fernanda', N'Ortega Ruiz', CAST(620.00 AS Decimal(5, 2)), CAST(N'2025-04-25T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.51 AS Decimal(5, 2)), N'0910000114@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (115, N'CEDULA', N'0910000115', N'Oscar Patricio', N'Delgado Vera', CAST(615.00 AS Decimal(5, 2)), CAST(N'2025-04-26T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.59 AS Decimal(5, 2)), N'0910000115@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (116, N'CEDULA', N'0910000116', N'Sofía Carolina', N'Mero Zambrano', CAST(610.00 AS Decimal(5, 2)), CAST(N'2025-04-27T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.86 AS Decimal(5, 2)), N'0910000116@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (117, N'CEDULA', N'0910000117', N'Ricardo Javier', N'Pincay Loor', CAST(605.00 AS Decimal(5, 2)), CAST(N'2025-04-28T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.66 AS Decimal(5, 2)), N'0910000117@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (118, N'CEDULA', N'0910000118', N'Camila Daniela', N'Reinoso Paz', CAST(600.00 AS Decimal(5, 2)), CAST(N'2025-04-29T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.35 AS Decimal(5, 2)), N'0910000118@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (119, N'CEDULA', N'0910000119', N'Bryan Alexander', N'Mora Cedeño', CAST(595.00 AS Decimal(5, 2)), CAST(N'2025-04-30T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.88 AS Decimal(5, 2)), N'0910000119@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (120, N'CEDULA', N'0910000120', N'Paola Cristina', N'Vargas Mero', CAST(590.00 AS Decimal(5, 2)), CAST(N'2025-05-01T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.30 AS Decimal(5, 2)), N'0910000120@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (121, N'CEDULA', N'0910000121', N'David Fernando', N'López Ruiz', CAST(585.00 AS Decimal(5, 2)), CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.58 AS Decimal(5, 2)), N'0910000121@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (122, N'CEDULA', N'0910000122', N'Gabriela Estefanía', N'Chica Andrade', CAST(580.00 AS Decimal(5, 2)), CAST(N'2025-05-03T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.82 AS Decimal(5, 2)), N'0910000122@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (123, N'CEDULA', N'0910000123', N'Jonathan Andrés', N'Cedeño Paz', CAST(575.00 AS Decimal(5, 2)), CAST(N'2025-05-04T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.65 AS Decimal(5, 2)), N'0910000123@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (124, N'CEDULA', N'0910000124', N'María José', N'Torres Lino', CAST(570.00 AS Decimal(5, 2)), CAST(N'2025-05-05T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.47 AS Decimal(5, 2)), N'0910000124@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (125, N'CEDULA', N'0910000125', N'Ángel Mauricio', N'Santana Pico', CAST(565.00 AS Decimal(5, 2)), CAST(N'2025-05-06T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.56 AS Decimal(5, 2)), N'0910000125@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (126, N'CEDULA', N'0910000126', N'Lucía Fernanda', N'Vera Ruiz', CAST(560.00 AS Decimal(5, 2)), CAST(N'2025-05-07T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.87 AS Decimal(5, 2)), N'0910000126@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (127, N'CEDULA', N'0910000127', N'Carlos Andrés', N'Mero Delgado', CAST(555.00 AS Decimal(5, 2)), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.62 AS Decimal(5, 2)), N'0910000127@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (128, N'CEDULA', N'0910000128', N'Daniela Nicole', N'Paz Zambrano', CAST(550.00 AS Decimal(5, 2)), CAST(N'2025-05-09T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.28 AS Decimal(5, 2)), N'0910000128@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (129, N'CEDULA', N'0910000129', N'Luis Alberto', N'Reyes Pico', CAST(545.00 AS Decimal(5, 2)), CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.90 AS Decimal(5, 2)), N'0910000129@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (130, N'CEDULA', N'0910000130', N'Andrea Belén', N'Molina Loor', CAST(540.00 AS Decimal(5, 2)), CAST(N'2025-05-11T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.25 AS Decimal(5, 2)), N'0910000130@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (131, N'CEDULA', N'0910000131', N'Natalia Sofía', N'Espinoza Ruiz', CAST(245.00 AS Decimal(5, 2)), CAST(N'2025-07-31T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.84 AS Decimal(5, 2)), N'0910000181@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (132, N'CEDULA', N'0910000132', N'Diego Alejandro', N'Mero Paz', CAST(240.00 AS Decimal(5, 2)), CAST(N'2025-08-01T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'NO', N'SI', CAST(0.60 AS Decimal(5, 2)), N'0910000182@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (133, N'CEDULA', N'0910000133', N'Paula Andrea', N'Loor Andrade', CAST(235.00 AS Decimal(5, 2)), CAST(N'2025-08-02T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'SI', N'SI', N'NO', N'NO', CAST(0.45 AS Decimal(5, 2)), N'0910000183@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (134, N'CEDULA', N'0910000134', N'Marco Esteban', N'Vélez Cedeño', CAST(230.00 AS Decimal(5, 2)), CAST(N'2025-08-03T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.54 AS Decimal(5, 2)), N'0910000184@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (135, N'CEDULA', N'0910000135', N'Samantha Nicole', N'Paz Mero', CAST(225.00 AS Decimal(5, 2)), CAST(N'2025-08-04T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.92 AS Decimal(5, 2)), N'0910000185@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (136, N'CEDULA', N'0910000136', N'Ricardo Andrés', N'Cedeño Loor', CAST(220.00 AS Decimal(5, 2)), CAST(N'2025-08-05T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.24 AS Decimal(5, 2)), N'0910000186@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (137, N'CEDULA', N'0910000137', N'Paola Andrea', N'Torres Zambrano', CAST(215.00 AS Decimal(5, 2)), CAST(N'2025-08-06T00:00:00.000' AS DateTime), N'NO', N'SI', N'SI', N'NO', N'NO', N'NO', N'SI', CAST(0.93 AS Decimal(5, 2)), N'0910000187@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (138, N'CEDULA', N'0910000138', N'Luis Antonio', N'Mora Vera', CAST(210.00 AS Decimal(5, 2)), CAST(N'2025-08-07T00:00:00.000' AS DateTime), N'NO', N'NO', N'NO', N'NO', N'SI', N'NO', N'NO', CAST(0.18 AS Decimal(5, 2)), N'0910000188@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (139, N'CEDULA', N'0910000139', N'Mónica Paola', N'Vera Cedeño', CAST(205.00 AS Decimal(5, 2)), CAST(N'2025-08-08T00:00:00.000' AS DateTime), N'NO', N'SI', N'NO', N'NO', N'NO', N'SI', N'NO', CAST(0.52 AS Decimal(5, 2)), N'0910000189@postulante.edu.ec')
GO
INSERT [dbo].[postulantes] ([id_postulante], [tipo_documento], [identificacion], [nombres], [apellidos], [puntaje], [fecha_inscripcion], [has_titulo_superior], [condicion_socioeconomica], [discapacidad], [pueblos_nacionalidades], [merito_academico], [ruralidad], [territorialidad], [vulnerabilidad], [correo]) VALUES (140, N'CEDULA', N'0910000140', N'Oscar Alejandro', N'Reyes Ruiz', CAST(200.00 AS Decimal(5, 2)), CAST(N'2025-08-09T00:00:00.000' AS DateTime), N'NO', N'NO', N'SI', N'NO', N'SI', N'NO', N'NO', CAST(0.88 AS Decimal(5, 2)), N'0910000190@postulante.edu.ec')
GO
SET IDENTITY_INSERT [dbo].[postulantes] OFF
GO
SET IDENTITY_INSERT [dbo].[preferencias_carrera] ON 
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (1, 1, 12, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (2, 2, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (3, 3, 1, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (4, 4, 3, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (5, 5, 4, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (6, 6, 12, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (7, 7, 5, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (8, 8, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (9, 9, 12, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (10, 10, 6, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (11, 11, 7, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (12, 12, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (13, 13, 9, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (14, 14, 10, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (15, 15, 12, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (16, 16, 11, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (17, 17, 10, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (18, 18, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (19, 19, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (20, 20, 7, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (21, 21, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (22, 22, 5, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (23, 23, 4, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (24, 24, 3, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (25, 25, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (26, 26, 1, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (27, 27, 2, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (28, 28, 3, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (29, 29, 4, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (30, 30, 5, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (31, 31, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (32, 32, 7, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (33, 33, 8, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (34, 34, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (35, 35, 10, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (36, 36, 11, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (37, 37, 12, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (38, 38, 11, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (39, 39, 10, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (40, 40, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (41, 41, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (42, 42, 7, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (43, 43, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (44, 44, 5, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (45, 45, 4, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (46, 46, 3, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (47, 47, 2, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (48, 48, 1, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (49, 49, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (50, 50, 3, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (51, 51, 12, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (52, 52, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (53, 53, 1, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (54, 54, 3, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (55, 55, 4, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (56, 56, 12, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (57, 57, 5, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (58, 58, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (59, 59, 12, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (60, 60, 6, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (61, 61, 7, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (62, 62, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (63, 63, 9, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (64, 64, 10, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (65, 65, 12, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (66, 66, 11, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (67, 67, 10, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (68, 68, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (69, 69, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (70, 70, 7, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (71, 71, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (72, 72, 5, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (73, 73, 4, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (74, 74, 3, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (75, 75, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (76, 76, 1, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (77, 77, 2, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (78, 78, 3, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (79, 79, 4, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (80, 80, 5, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (81, 81, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (82, 82, 7, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (83, 83, 8, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (84, 84, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (85, 85, 10, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (86, 86, 11, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (87, 87, 12, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (88, 88, 11, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (89, 89, 10, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (90, 90, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (91, 91, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (92, 92, 7, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (93, 93, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (94, 94, 5, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (95, 95, 4, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (96, 96, 3, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (97, 97, 2, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (98, 98, 1, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (99, 99, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (100, 100, 3, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (101, 101, 12, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (102, 102, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (103, 103, 1, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (104, 104, 3, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (105, 105, 4, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (106, 106, 12, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (107, 107, 5, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (108, 108, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (109, 109, 12, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (110, 110, 6, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (111, 111, 7, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (112, 112, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (113, 113, 9, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (114, 114, 10, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (115, 115, 12, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (116, 116, 11, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (117, 117, 10, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (118, 118, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (119, 119, 8, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (120, 120, 7, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (121, 121, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (122, 122, 5, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (123, 123, 4, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (124, 124, 3, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (125, 125, 2, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (126, 126, 1, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (127, 127, 2, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (128, 128, 3, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (129, 129, 4, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (130, 130, 5, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (131, 131, 6, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (132, 132, 7, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (133, 133, 8, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (134, 134, 9, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (135, 135, 10, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (136, 136, 11, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (137, 137, 12, 2, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (138, 138, 11, 1, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (139, 139, 10, 3, N'PENDIENTE', NULL)
GO
INSERT [dbo].[preferencias_carrera] ([id_preferencia], [id_postulante], [id_carrera], [prioridad], [estado_asignacion], [fecha_procesamiento]) VALUES (140, 140, 1, 1, N'PENDIENTE', NULL)
GO
SET IDENTITY_INSERT [dbo].[preferencias_carrera] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__administ__2A586E0B92757E23]    Script Date: 19/1/2026 0:01:41 ******/
ALTER TABLE [dbo].[administradores] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__administ__415B7BE513E3A384]    Script Date: 19/1/2026 0:01:41 ******/
ALTER TABLE [dbo].[administradores] ADD UNIQUE NONCLUSTERED 
(
	[cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Asignaciones_Proceso]    Script Date: 19/1/2026 0:01:41 ******/
CREATE NONCLUSTERED INDEX [IX_Asignaciones_Proceso] ON [dbo].[asignaciones_finales]
(
	[id_proceso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__carreras__40F9A20666E0D77A]    Script Date: 19/1/2026 0:01:41 ******/
ALTER TABLE [dbo].[carreras] ADD UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Carrera_Codigo]    Script Date: 19/1/2026 0:01:41 ******/
ALTER TABLE [dbo].[carreras] ADD  CONSTRAINT [UQ_Carrera_Codigo] UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__postulan__C196DEC73E168B8A]    Script Date: 19/1/2026 0:01:41 ******/
ALTER TABLE [dbo].[postulantes] ADD UNIQUE NONCLUSTERED 
(
	[identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Postulante_Identificacion]    Script Date: 19/1/2026 0:01:41 ******/
ALTER TABLE [dbo].[postulantes] ADD  CONSTRAINT [UQ_Postulante_Identificacion] UNIQUE NONCLUSTERED 
(
	[identificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Postulantes_Puntaje]    Script Date: 19/1/2026 0:01:41 ******/
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
PRINT 'Base de datos AsignacionCuposULEAM actualizada correctamente.'