/* =========================
   REGIONES
========================= */
INSERT INTO Region (Nombre)
VALUES 
('Boyacá'),
('Cundinamarca'),
('Antioquia');

/* =========================
   DEPARTAMENTOS
========================= */
INSERT INTO Departamento (Nombre, IdRegion)
VALUES
('Boyacá', 1),
('Cundinamarca', 2),
('Antioquia', 3);

/* =========================
   CIUDADES
========================= */
INSERT INTO Ciudad (Nombre, IdDepartamento)
VALUES
('Sogamoso', 1),
('Tunja', 1),
('Bogotá', 2),
('Medellín', 3);

INSERT INTO Rol(Rol)
VALUES
('Instructor'),
('Aprendiz'),
('AdministradorCentro');

INSERT INTO MenuRol(IdRol)
VALUES
(1),
(2),
(3);

/* =========================
   ADMINISTRADOR
========================= */
INSERT INTO AdministradorCentro
(TipoDocumento, NumeroDocumento, Nombre, Apellido, Correo, Contraseña, Telefono, IdRol)
VALUES
('CC', '1020304050', 'Carlos', 'Rodriguez', 'admin.cimm@sena.edu.co', 'Admin123', '3100000000',3);

/* =========================
   CENTROS DE FORMACION
========================= */
INSERT INTO CentroFormacion
(Nombre, Direccion, IdCiudad, IdAdministradorCentro)
VALUES
('SENA CIMM Sogamoso', 'Carrera 10 # 15-20', 1, 1),
('SENA Tunja', 'Calle 20 # 5-10', 2, 1),
('SENA Bogota', 'Avenida 68 # 30-15', 3, 1);

/* =========================
   COMPETENCIAS
========================= */
INSERT INTO Competencia (Nombre, Descripcion)
VALUES
('Ética y Cultura de Paz', 'Desarrollo de habilidades sociales, resolución de conflictos y construcción de un proyecto de vida sólido'),
('Tecnologías de la Información y la Comunicación', 'Uso eficiente de herramientas digitales, software de oficina e internet para la productividad');

/* =========================
   PROGRAMAS
========================= */
INSERT INTO Programa
(Codigo, Nombre, NivelFormacion, Duracion, Estado, IdCompetencia)
VALUES
('228118', 'Analisis y Desarrollo de Software', 'Tecnologo', '24 meses', 'Activo', 1),
('228120', 'Base de Datos', 'Tecnologo', '18 meses', 'Activo', 2);

/* =========================
   RELACION CENTRO - PROGRAMA
========================= */
INSERT INTO CentroPrograma
(IdCentroFormacion, IdPrograma)
VALUES
(1,1),
(1,2),
(2,1);

/* =========================
   CALIFICACIONES
========================= */
INSERT INTO Calificacion (Calificacion)
VALUES
('Aprobado'),
('No Aprobado');

/* =========================
   CRITERIOS
========================= */
INSERT INTO Criterio
(Nombre, Descripcion)
VALUES
('Producto', 'Evaluación de la evidencia entregada'),
('Conocimiento', 'Sustentación o explicación del trabajo realizado'),
('Desempeño', 'Capacidad para realizar mejoras o nuevas funcionalidades');

/* =========================
   TIPOS DE PLAN
========================= */
INSERT INTO TipoPlan (Nombre)
VALUES
('Plan Interno'),
('Plan por Comité');

/* =========================
   EVIDENCIAS
========================= */
INSERT INTO Evidencia (Evidencia, Descripcion)
VALUES
('evidencia_python.pdf', 'Archivo PDF evidencia de Python'),
('documentacion_proyecto.docx', 'Documento Word del proyecto'),
('diagrama_bd.jpg', 'Imagen JPG del modelo entidad relacion'),
('captura_sistema.png', 'Captura PNG del sistema'),
('entrega_final.zip', 'Archivo comprimido ZIP del proyecto');

/* =========================
   ACTIVIDADES
========================= */
INSERT INTO Actividad (Nombre)
VALUES
('Corregir proyecto'),
('Actualizar documentacion'),
('Entregar evidencia faltante');

/* =========================
   ESTADOS
========================= */
INSERT INTO Estado (TipoEstado)
VALUES
('En formacion');

/* =========================
   AREAS
========================= */
INSERT INTO Area (Nombre)
VALUES
('Desarrollo de Software'),
('Bases de Datos'),
('Diseño');

/* =========================
   INSTRUCTORES
========================= */
INSERT INTO Instructor
(TipoDocumento, NumeroDocumento, Nombre, Apellido, Correo, Contraseña, Telefono, IdArea,IdRol)
VALUES
('CC', '111111111', 'Laura', 'Martinez', 'laura.martinez@sena.edu.co', '12345', '3111111111', 1, 1),

('CC', '222222222', 'Andres', 'Perez', 'andres.perez@sena.edu.co', '12345', '3222222222', 2, 1),

('CC', '333333333', 'Camila', 'Gomez', 'camila.gomez@sena.edu.co', '12345', '3333333333', 3, 1);

/* =========================
   FICHAS
========================= */
INSERT INTO Ficha
(Codigo, FechaInicio, FechaFin, Jornada, Descripcion, Estado, IdPrograma)
VALUES
('2875461', '2026-01-15', '2027-12-15', 'Mañana',
'Ficha ADSO SENA CIMM Sogamoso', 'Activa', 1);

/* =========================
   FICHA - INSTRUCTOR
========================= */
INSERT INTO FichaInstructor
(IdFicha, IdInstructor)
VALUES
(1,1),
(1,2),
(1,3);

/* =========================
   PLAN DE MEJORAMIENTO
   SOLO UNO
========================= */
INSERT INTO PlanMejoramiento
(FechaAsignacion, Observaciones, FechaLimite, EstadoPlan,
 IdActividad, IdTipoPlan,IdInstructor)
VALUES
('2026-06-01',
'El aprendiz debe corregir y entregar nuevamente las evidencias pendientes',
'2026-06-20',
'Pendiente',
1,
1,
1);

/* =========================
   APRENDICES
========================= */
INSERT INTO Aprendiz
(TipoDocumento, NumeroDocumento, Nombre, Apellido, Correo, Contraseña, Telefono, IdEstado, IdRol)
VALUES
('TI', '1001', 'Juan',      'Lopez',     'juan.lopez@soy.sena.edu.co',      '12345', '3000000001', 1, 2),
('TI', '1002', 'Maria',     'Perez',     'maria.perez@soy.sena.edu.co',     '12345', '3000000002', 1, 2),
('TI', '1003', 'Santiago',  'Rodriguez', 'santiago.rodriguez@soy.sena.edu.co','12345','3000000003', 1, 2),
('TI', '1004', 'Valentina', 'Gomez',     'valentina.gomez@soy.sena.edu.co', '12345', '3000000004', 1, 2),
('TI', '1005', 'Daniel',    'Castro',    'daniel.castro@soy.sena.edu.co',   '12345', '3000000005', 1, 2);

/* =========================
   APRENDIZ - FICHA
========================= */
INSERT INTO AprendizFicha
(IdAprendiz, IdFicha)
VALUES
(6,1),
(2,1),
(3,1),
(4,1),
(5,1);

/* =========================
   APRENDIZ - PLAN
   MISMO PLAN PARA TODOS
========================= */
INSERT INTO AprendizPlan
(IdAprendiz, IdPlanMejoramiento, IdEvidencia)
VALUES
(3,1,1),
(2,1,2);

-- Aprendiz 1 (Juan) - Plan 1
INSERT INTO CriterioEvaluacion 
    (IdAprendiz, IdPlanMejoramiento, IdCriterio, IdEvidencia, IdCalificacion, Observacion)
VALUES
(3, 1, 1, 1, 1, 'Entrega completa'),  -- Producto: Aprobado
(3, 1, 2, 1, 2, 'Le faltó sustentar'),  -- Conocimiento: No Aprobado
(3, 1, 3, 3, 1, 'Buenas mejoras');  -- Desempeño: Aprobado

-- Aprendiz 2 (María) - Plan 2
INSERT INTO CriterioEvaluacion 
    (IdAprendiz, IdPlanMejoramiento, IdCriterio, IdEvidencia, IdCalificacion, Observacion)
VALUES
(2, 2, 1, 2, 1, 'Muy completo'),  -- Producto: Aprobado
(2, 2, 2, 2, 1, 'Excelente sustentación'),  -- Conocimiento: Aprobado
(2, 2, 3, 2, 2, 'Debe mejorar');  -- Desempeño: No Aprobado