
DROP DATABASE IF EXISTS bot_cent_profe;
CREATE DATABASE bot_cent_profe CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE bot_cent_profe;

CREATE TABLE administrativo (
    usuario VARCHAR(50) PRIMARY KEY,
    contrasena VARCHAR(255) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    dni VARCHAR(20) NOT NULL UNIQUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE alumno (
    dni VARCHAR(20) PRIMARY KEY,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE carrera (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    anio INT NOT NULL,
    id_carrera INT NOT NULL,
    FOREIGN KEY (id_carrera) REFERENCES carrera(id) ON DELETE CASCADE,
    UNIQUE KEY unique_curso (nombre, anio, id_carrera)
) ENGINE=InnoDB;

CREATE TABLE aviso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE pertenece (
    dni_alumno VARCHAR(20) NOT NULL,
    id_curso INT NOT NULL,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (dni_alumno, id_curso),
    FOREIGN KEY (dni_alumno) REFERENCES alumno(dni) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id) ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE envia (
    usuario_admin VARCHAR(50) NOT NULL,
    id_aviso INT NOT NULL,
    id_curso INT NOT NULL,
    fecha_hora_envio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (usuario_admin, id_aviso, id_curso),
    FOREIGN KEY (usuario_admin) REFERENCES administrativo(usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_aviso) REFERENCES aviso(id) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_alumno_apellido ON alumno(apellido);
CREATE INDEX idx_curso_carrera ON curso(id_carrera);
CREATE INDEX idx_aviso_fecha ON aviso(fecha);
CREATE INDEX idx_envia_fecha ON envia(fecha_hora_envio);
CREATE INDEX idx_envia_carrera ON envia(id_curso);
CREATE INDEX idx_envia_aviso ON envia(id_aviso);

INSERT INTO administrativo (usuario, contrasena, apellido, nombre, dni) VALUES
('admin001', '$2y$10$abcdefghijklmnopqrstuv', 'García', 'María', '30123456'),
('admin002', '$2y$10$wxyzabcdefghijklmnopqr', 'Rodríguez', 'Carlos', '28765432'),
('admin003', '$2y$10$stuvwxyzabcdefghijklmn', 'López', 'Ana', '32456789');

INSERT INTO carrera (nombre) VALUES
('Ingeniería en Sistemas'),
('Licenciatura en Administración'),
('Contador Público'),
('Ingeniería Industrial'),
('Licenciatura en Marketing');

INSERT INTO alumno (dni, apellido, nombre, telefono) VALUES
('40123456', 'Martínez', 'Juan', '2996-123456'),
('41234567', 'Fernández', 'Laura', '2996-234567'),
('42345678', 'González', 'Pedro', '2996-345678'),
('43456789', 'Sánchez', 'María', '2996-456789'),
('44567890', 'Romero', 'Lucas', '2996-567890'),
('45678901', 'Torres', 'Valentina', '2996-678901'),
('46789012', 'Díaz', 'Mateo', '2996-789012'),
('47890123', 'Álvarez', 'Sofía', '2996-890123'),
('48901234', 'Vargas', 'Joaquín', '2996-901234'),
('49012345', 'Castro', 'Camila', '2996-012345');

INSERT INTO curso (nombre, anio, id_carrera) VALUES
('Programación I', 1, 1),
('Matemática I', 1, 1),
('Algoritmos y Estructuras de Datos', 2, 1),
('Base de Datos', 2, 1),
('Programación Orientada a Objetos', 3, 1),

('Introducción a la Administración', 1, 2),
('Economía I', 1, 2),
('Gestión de Recursos Humanos', 2, 2),
('Marketing Estratégico', 3, 2),

('Contabilidad Básica', 1, 3),
('Derecho I', 1, 3),
('Costos y Presupuestos', 2, 3),
('Impuestos I', 3, 3),

('Física I', 1, 4),
('Química General', 1, 4),
('Procesos Industriales', 2, 4),

('Fundamentos del Marketing', 1, 5),
('Comportamiento del Consumidor', 2, 5),
('Publicidad y Medios', 3, 5);

INSERT INTO pertenece (dni_alumno, id_curso) VALUES
('40123456', 1), ('40123456', 2), ('40123456', 3),

('41234567', 1), ('41234567', 2), ('41234567', 4),

('42345678', 6), ('42345678', 7), ('42345678', 8),

('43456789', 10), ('43456789', 11), ('43456789', 12),

('44567890', 14), ('44567890', 15), ('44567890', 16),

('45678901', 17), ('45678901', 18), ('45678901', 19),

('46789012', 1), ('46789012', 2), ('46789012', 5),

('47890123', 6), ('47890123', 7), ('47890123', 9),

('48901234', 10), ('48901234', 11), ('48901234', 13),

('49012345', 3), ('49012345', 4), ('49012345', 5);

INSERT INTO aviso (titulo, mensaje, fecha) VALUES
('Inicio de Clases 2025', 
 'Informamos a todos los alumnos que el inicio del ciclo lectivo 2025 será el día 15 de marzo. Por favor verificar horarios en el sistema.', 
 '2025-02-15 10:00:00'),

('Inscripción a Exámenes Finales', 
 'Se encuentra abierta la inscripción para los exámenes finales del turno abril/mayo. Fecha límite: 20 de marzo.', 
 '2025-03-01 09:30:00'),

('Nuevos Cursos Optativos', 
 'Se incorporan nuevos cursos optativos para todas las carreras. Consultar en secretaría académica.', 
 '2025-03-10 14:00:00'),

('Mantenimiento del Sistema', 
 'El sistema estará fuera de servicio el día sábado 25 de marzo de 8:00 a 12:00 hs por tareas de mantenimiento.', 
 '2025-03-20 16:45:00'),

('Becas Disponibles', 
 'Se abren inscripciones para becas de estudio correspondientes al año 2025. Requisitos disponibles en la web institucional.', 
 '2025-03-25 11:20:00'),

('Actualización de Planes de Estudio', 
 'Se informa sobre modificaciones en los planes de estudio vigentes a partir del próximo cuatrimestre.', 
 '2025-04-05 15:30:00'),

('Charla Informativa Carreras', 
 'Invitamos a una charla informativa sobre las carreras ofrecidas. Confirmar asistencia.', 
 '2025-04-10 11:00:00');

INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin001', 1, 1, '2025-02-15 10:05:00'),
('admin001', 1, 2, '2025-02-15 10:06:00'),
('admin001', 1, 3, '2025-02-15 10:07:00');

-- Aviso 2: Exámenes - admin002 lo envía a algunas carreras
INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin002', 2, 1, '2025-03-01 09:35:00'),
('admin002', 2, 3, '2025-03-01 09:36:00'),
('admin002', 2, 4, '2025-03-01 09:37:00');

-- Aviso 3: Cursos Optativos - admin003 lo envía a todas, admin001 reenvía a algunas
INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin003', 3, 1, '2025-03-10 14:05:00'),
('admin003', 3, 2, '2025-03-10 14:06:00'),
('admin003', 3, 3, '2025-03-10 14:07:00'),
('admin003', 3, 4, '2025-03-10 14:08:00'),
('admin003', 3, 5, '2025-03-10 14:09:00'),
('admin001', 3, 2, '2025-03-11 09:00:00'),
('admin001', 3, 5, '2025-03-11 09:01:00');

-- Aviso 4: Mantenimiento - admin001 a todas
INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin001', 4, 1, '2025-03-20 16:50:00'),
('admin001', 4, 2, '2025-03-20 16:51:00'),
('admin001', 4, 3, '2025-03-20 16:52:00'),
('admin001', 4, 4, '2025-03-20 16:53:00'),
('admin001', 4, 5, '2025-03-20 16:54:00');

INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin002', 5, 1, '2025-03-25 11:25:00'),
('admin002', 5, 2, '2025-03-25 11:26:00'),
('admin002', 5, 4, '2025-03-25 11:27:00');

INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin001', 6, 1, '2025-04-05 15:35:00'),
('admin002', 6, 2, '2025-04-05 15:36:00'),
('admin002', 6, 3, '2025-04-05 15:37:00'),
('admin003', 6, 4, '2025-04-05 15:38:00'),
('admin003', 6, 5, '2025-04-05 15:39:00');

INSERT INTO envia (usuario_admin, id_aviso, id_curso, fecha_hora_envio) VALUES
('admin003', 7, 1, '2025-04-10 11:05:00'),
('admin003', 7, 2, '2025-04-10 11:06:00'),
('admin003', 7, 3, '2025-04-10 11:07:00'),
('admin003', 7, 4, '2025-04-10 11:08:00'),
('admin003', 7, 5, '2025-04-10 11:09:00');

