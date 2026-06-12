Create table Region (Id int primary key identity (1,1),
Nombre varchar(50) not null
);
Create table Departamento (Id int identity (1,1) primary key,
Nombre varchar(50) not null,
IdRegion int not null,

constraint Fk_Departamento_Region
Foreign key(IdRegion)
references Region(Id)
);
Create table Ciudad (Id int identity (1,1) primary key,
Nombre varchar(50) not null,
IdDepartamento int not null,

constraint Fk_Ciudad_Departamento
Foreign key(IdDepartamento)
references Departamento(Id)
);
Create table Menu (Id int primary key identity (1,1),
Nombre varchar(50) null,
IdPadre Int null
);
Create table Rol(Id int primary key identity(1,1),
Rol varchar(70) not null
)
Create table MenuRol (Id int identity(1,1) primary key,
IdMenu int null,
IdRol int not null,

constraint Fk_MenuRol_Menu
Foreign key(IdMenu)
references Menu(Id),

constraint Fk_MenuRol_Rol
Foreign key(IdRol)
references Rol(Id)
);
create table AdministradorCentro (Id int primary key identity(1,1),
TipoDocumento varchar(50) not null,
NumeroDocumento varchar(50) not null,
Nombre varchar(50) not null,
Apellido varchar(50) not null,
Correo varchar(100) not null,
Contraseña varchar(50) not null,
Telefono varchar(50) not null,
IdRol int not null,

constraint Fk_AdministradorCentro_Rol
Foreign key(IdRol)
references Rol(Id)
);
Create table CentroFormacion (Id int identity (1,1) primary key,
Nombre varchar(50) not null,
Direccion varchar(50) not null,
IdCiudad int not null,
IdAdministradorCentro int not null,

constraint Fk_CentroFormacion_AdministradorCentro
Foreign key(IdAdministradorCentro)
references AdministradorCentro(Id),

constraint Fk_CentroFormacion_Ciudad
Foreign key(IdCiudad)
references Ciudad(Id)
);
Create table Competencia (Id int primary key identity (1,1),
Nombre varchar(50) not null,
Descripcion varchar(100) not null
);
create table Programa (Id int identity (1,1)primary key,
Codigo varchar(50) not null,
Nombre varchar(100) not null,
NivelFormacion varchar(50) not null,
Duracion varchar(50) not null,
Estado varchar(50)not null,
IdCompetencia int not null,

constraint Fk_Programa_Competencia
Foreign key(IdCompetencia)
references Competencia(Id)
);
Create table CentroPrograma (Id int identity (1,1)primary key,
IdCentroFormacion int not null,
IdPrograma int not null,

constraint Fk_CentroPrograma_CentroFormacion
Foreign key(IdCentroFormacion)
references CentroFormacion(Id),

constraint Fk_CentroPrograma_Programa
Foreign key(IdPrograma)
references Programa(Id)
);
Create table TipoPlan (Id int primary key identity(1,1),
Nombre varchar(50) not null
);
Create table Evidencia (Id int primary key identity(1,1),
Evidencia varchar(50) not null,
Descripcion varchar(50) null
);
create table Calificacion (Id int primary key identity(1,1),
Calificacion varchar(50) not null
);
create table Criterio (Id int primary key identity (1,1),
Nombre varchar(50) not null,
Descripcion varchar(50) not null
);
Create table Area (Id int primary key identity(1,1),
Nombre varchar(50) not null
);
Create table Instructor (Id int identity(1,1) primary key,
TipoDocumento varchar(50) not null,
NumeroDocumento varchar(50) not null,
Nombre varchar(50) not null,
Apellido varchar(50) not null,
Correo varchar(50) not null,
Contraseña varchar(50) not null,
Telefono varchar(50) not null,
IdArea int not null,
IdRol int not null,

constraint Fk_Instructor_Area
Foreign key(IdArea)
references Area(Id),

constraint Fk_Instructor_Rol
Foreign key(IdRol)
references Rol(Id)
);
Create table Ficha (Id int identity(1,1) primary Key,
Codigo varchar(50) not null,
FechaInicio date not null,
FechaFin date not null,
Jornada varchar(50) not null,
Descripcion varchar(500) not null,
Estado varchar(50) not null,
IdPrograma int not null,

constraint Fk_Ficha_Programa
Foreign key(IdPrograma)
references Programa(Id)
);
Create table FichaInstructor (Id int identity(1,1)primary key,
IdFicha int not null,
IdInstructor int not null,

constraint Fk_FichaInstructor_Ficha
Foreign key(IdFicha)
references Ficha(Id),

constraint Fk_FichaInstructor_Instructor
Foreign key(IdInstructor)
references Instructor(Id)
);
Create table Actividad(Id int primary key identity (1,1),
Nombre varchar(50)not null
);
Create table Estado (Id int primary key identity (1,1),
TipoEstado varchar(50) not null
);
Create table Aprendiz (Id int identity (1,1) primary key,
TipoDocumento varchar(50) not null,
NumeroDocumento varchar(50) not null,
Nombre varchar(50) not null,
Apellido varchar(50) not null,
Correo varchar(50) not null,
Contraseña varchar(50) not null,
Telefono varchar(50) not null,
IdEstado int not null,
IdRol int not null,

constraint Fk_Aprendiz_Estado
Foreign key(IdEstado)
references Estado(Id),

constraint Fk_Aprendiz_Rol
Foreign key(IdRol)
references Rol(Id)
);
Create table AprendizFicha (Id int identity (1,1) primary key,
IdAprendiz int not null,
IdFicha int not null,

constraint Fk_AprendizFicha_Aprendiz
Foreign key(IdAprendiz)
references Aprendiz(Id),

constraint Fk_AprendizFicha_Ficha
Foreign key(IdFicha)
references Ficha(Id)
);
Create table PlanMejoramiento (Id int identity (1,1) primary key,
FechaAsignacion date not null,
Observaciones varchar(500) not null,
FechaLimite date not null,
EstadoPlan varchar(50),
IdActividad int not null,
IdTipoPlan int not null,
IdInstructor int not null,

constraint Fk_PlanMejoramiento_Actividad
Foreign key(IdActividad)
references Actividad(Id),

constraint Fk_PlanMejoramiento_TipoPlann
Foreign key(IdTipoPlan)
references TipoPlan(Id),

constraint Fk_PlanMejoramiento_Instructor
Foreign key(IdInstructor)
references Instructor(Id)
);
Create table AprendizPlan (Id int identity (1,1) primary key,
IdAprendiz int not null,
IdPlanMejoramiento int not null,
IdEvidencia int not null,

constraint Fk_AprendizPlan_Aprendiz
Foreign key(IdAprendiz)
references Aprendiz(Id),

constraint Fk_AprendizPlan_PlanMejoramiento
Foreign key(IdPlanMejoramiento)
references PlanMejoramiento(Id),

constraint Fk_AprendizPlan_Evidencia
Foreign key(IdEvidencia)
references Evidencia(Id)
);
create table CriterioEvaluacion (Id int identity(1,1) primary key,
IdAprendiz int not null,
IdCriterio int not null,
IdEvidencia int not null,
IdCalificacion int not null,
IdPlanMejoramiento int not null,
Observacion varchar(500) null,

constraint Fk_CriterioEvaluacion_Aprendiz
Foreign key(IdAprendiz)
references Aprendiz(Id),

constraint Fk_CriterioEvaluacion_Criterio
Foreign key(IdCriterio)
references Criterio(Id),

constraint Fk_CriterioEvaluacion_Evidencia
Foreign key(IdEvidencia)
references Evidencia(Id),

constraint Fk_CriterioEvaluacion_Calificacion
Foreign key(IdCalificacion)
references Calificacion(Id),

constraint Fk_CriterioEvaluacion_PlanMejoramiento
Foreign key(IdPlanMejoramiento)
references PlanMejoramiento(Id)
);
