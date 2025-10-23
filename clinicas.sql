CREATE SCHEMA clinicas;
USE clinicas;

CREATE TABLE clinica (
	id_clinica INT auto_increment primary key,
    nombre VARCHAR (50) NOT NULL
	);

CREATE TABLE obra_social (
	id_obra_social INT auto_increment primary key,
    nombre VARCHAR (50) NOT NULL,
    gravado_exento VARCHAR (50)
    );

CREATE TABLE paciente (
	id_paciente INT auto_increment primary key,
    nombre VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    dni VARCHAR (20) NOT NULL,
    email VARCHAR (254) NOT NULL,
    domicilio VARCHAR (50) NOT NULL,
    id_obra_social INT NOT NULL,
    FOREIGN KEY (id_obra_social) REFERENCES obra_social (id_obra_social)
    );

CREATE TABLE historia_clinica (
	id_historia INT auto_increment primary key,
    id_paciente INT NOT NULL,
    antecedentes VARCHAR (200),
    observaciones VARCHAR (200),
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
    );
    
CREATE TABLE farmacia (
	id_farmacia INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	ubicacion VARCHAR(100)
);

CREATE TABLE medicamento (
	id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	formato VARCHAR(50),
	stock INT DEFAULT 0,
	precio DECIMAL(10,2),
	id_farmacia INT,
	FOREIGN KEY (id_farmacia) REFERENCES farmacia(id_farmacia)
);

CREATE TABLE practica_medica (
	id_practica INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	descripcion VARCHAR(255)
);

CREATE TABLE especialidad (
	id_especialidad INT auto_increment primary key,
    nombre VARCHAR (50)
    );
    
CREATE TABLE medico (
	id_medico INT auto_increment primary key,
    nombre VARCHAR (50) NOT NULL,
    apellido VARCHAR (50) NOT NULL,
    matricula VARCHAR (50) NOT NULL,
    id_especialidad INT NOT NULL,
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
    );

CREATE TABLE medico_especialidad (
	id_medico_especialidad INT auto_increment primary key,
    id_medico INT NOT NULL,
    id_especialidad INT NOT NULL,
    duracion_turno INT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
    );
    
CREATE TABLE disponibilidad (
	id_disponibilidad INT auto_increment primary key,
    id_medico_especialidad INT NOT NULL,
    dias DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    duracion_min_override INT,
    FOREIGN KEY (id_medico_especialidad) REFERENCES medico_especialidad (id_medico_especialidad)
    );
    
CREATE TABLE turno (
	id_turno INT auto_increment primary key,
    id_clinica INT NOT NULL,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    duracion VARCHAR (50),
    consultorio VARCHAR (50),
    FOREIGN KEY (id_clinica) REFERENCES clinica (id_clinica),
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente)
    );
    
CREATE TABLE turno_practica (
	id_turno_practica INT AUTO_INCREMENT PRIMARY KEY,
	id_turno INT NOT NULL,
	id_practica INT NOT NULL,
	FOREIGN KEY (id_turno) REFERENCES turno(id_turno),
	FOREIGN KEY (id_practica) REFERENCES practica_medica(id_practica)
);
    
ALTER TABLE medico
DROP FOREIGN KEY medico_ibfk_1,
DROP COLUMN id_especialidad;

INSERT INTO clinica (nombre) VALUES 
('Clínica San Martín de Porres'),
('Clínica San Bernardo'),
('Hospital Mar de Ajo');

INSERT INTO obra_social (nombre, gravado_exento) VALUES 
('OSDE', 'Gravado'),
('IOMA', 'Exento'),
('Galeno', 'Gravado'),
('Federada Salud', 'Exento'),
('Medife', 'Gravado'),
('Omint', 'Exento'),
('OSPEDYC', 'Gravado'),
('PAMI', 'Exento'),
('Sancor Salud', 'Gravado'),
('Swiss Medical', 'Exento'),
('Particular', 'Exento'),
('UOCRA', 'Exento'),
('OSECAC', 'Gravado'),
('OSPRERA', 'Exento'),
('OSUTHGRA', 'Gravado');

INSERT INTO especialidad (nombre) VALUES 
('Anestesiologia'),
('Cardiologia'),
('Cirujia General'),
('Endocrinologia'),
('Ginecologia'),
('Gastroenterologia'),
('Hematologia'),
('Nefrologia'),
('Neumonologia'),
('Neurologia'),
('Oftalmologia'),
('Dermatología'),
('Clinica Medica'),
('Pediatría'),
('Neumonologia');

INSERT INTO paciente (nombre, apellido, dni, email, domicilio, id_obra_social) VALUES
('Juan', 'Pérez', '12345678', 'juanp@mail.com', 'Calle Falsa 123', 1),
('María', 'Gómez', '23456789', 'mariag@mail.com', 'Av Siempreviva 742', 2),
('Lucas', 'Martínez', '34567890', 'lucasm@mail.com', 'Córdoba 101', 1),
('Sofía', 'Romero', '45678901', 'sofiar@mail.com', 'Salta 202', 2),
('Diego', 'Fernández', '56789012', 'diegof@mail.com', 'Belgrano 303', 1),
('Ana', 'Suárez', '67890123', 'anas@mail.com', 'Mendoza 404', 2),
('Tomás', 'López', '78901234', 'tomasl@mail.com', 'San Juan 505', 1),
('Lucía', 'Díaz', '89012345', 'luciad@mail.com', 'Jujuy 606', 2),
('Martín', 'Sánchez', '90123456', 'martins@mail.com', 'Neuquén 707', 1),
('Camila', 'Torres', '11223344', 'camilat@mail.com', 'Chaco 808', 2),
('Julián', 'Ruiz', '22334455', 'julianr@mail.com', 'Formosa 909', 1),
('Valentina', 'Molina', '33445566', 'valen@mail.com', 'Santa Fe 100', 2),
('Franco', 'Aguilar', '44556677', 'francoa@mail.com', 'La Pampa 200', 1),
('Micaela', 'Morales', '55667788', 'mica@mail.com', 'Misiones 300', 2),
('Bruno', 'Castro', '66778899', 'brunoc@mail.com', 'Tucumán 400', 1);

INSERT INTO medico (nombre, apellido, matricula) VALUES
('Carlos', 'Lopez', 'MAT001'),
('Ana', 'Ruiz', 'MAT002'),
('Pedro', 'García', 'MAT003'),
('Luciana', 'Navarro', 'MAT004'),
('Jorge', 'Ortega', 'MAT005'),
('Carla', 'Bianchi', 'MAT006'),
('Federico', 'Romano', 'MAT007'),
('Laura', 'Paz', 'MAT008'),
('Santiago', 'Ríos', 'MAT009'),
('Julia', 'Silva', 'MAT010'),
('Ezequiel', 'Ibáñez', 'MAT011'),
('Paula', 'Mendez', 'MAT012'),
('Diego', 'Costa', 'MAT013'),
('Agustina', 'Ferrari', 'MAT014'),
('Hernán', 'Delgado', 'MAT015');

INSERT INTO medico_especialidad (id_medico, id_especialidad, duracion_turno) VALUES
(1, 1, 30),
(2, 2, 20),
(3, 3, 25),
(4, 1, 30),
(5, 2, 20),
(6, 3, 25),
(7, 1, 30),
(8, 2, 20),
(9, 3, 25),
(10, 1, 30),
(11, 2, 20),
(12, 3, 25),
(13, 1, 30),
(14, 2, 20),
(15, 3, 25);

INSERT INTO disponibilidad (id_medico_especialidad, dias, hora_inicio, hora_fin, duracion_min_override) VALUES
(1, '2025-10-10', '08:00:00', '12:00:00', NULL),
(2, '2025-10-10', '13:00:00', '16:00:00', NULL),
(3, '2025-10-10', '09:00:00', '11:00:00', NULL),
(4, '2025-10-10', '10:00:00', '14:00:00', NULL),
(5, '2025-10-10', '15:00:00', '18:00:00', NULL),
(6, '2025-10-10', '07:00:00', '09:00:00', NULL),
(7, '2025-10-10', '10:00:00', '13:00:00', NULL),
(8, '2025-10-10', '14:00:00', '17:00:00', NULL),
(9, '2025-10-10', '08:30:00', '11:30:00', NULL),
(10, '2025-10-10', '09:30:00', '12:30:00', NULL),
(11, '2025-10-10', '11:00:00', '14:00:00', NULL),
(12, '2025-10-10', '12:00:00', '15:00:00', NULL),
(13, '2025-10-10', '07:30:00', '10:30:00', NULL),
(14, '2025-10-10', '10:15:00', '13:15:00', NULL),
(15, '2025-10-10', '16:00:00', '18:00:00', NULL);

INSERT INTO turno (id_clinica, id_medico, id_paciente, fecha, hora, duracion, consultorio) VALUES
(1, 1, 1, '2025-10-10', '08:30:00', '30 minutos', '1A'),
(1, 2, 2, '2025-10-10', '13:20:00', '20 minutos', '2B'),
(1, 3, 3, '2025-10-10', '09:15:00', '25 minutos', '3C'),
(1, 4, 4, '2025-10-10', '10:00:00', '30 minutos', '4D'),
(1, 5, 5, '2025-10-10', '15:30:00', '20 minutos', '5E'),
(1, 6, 6, '2025-10-10', '07:15:00', '25 minutos', '6F'),
(1, 7, 7, '2025-10-10', '10:30:00', '30 minutos', '7G'),
(1, 8, 8, '2025-10-10', '14:10:00', '20 minutos', '8H'),
(1, 9, 9, '2025-10-10', '08:45:00', '25 minutos', '9I'),
(1, 10, 10, '2025-10-10', '10:00:00', '30 minutos', '10J'),
(1, 11, 11, '2025-10-10', '11:30:00', '20 minutos', '11K'),
(1, 12, 12, '2025-10-10', '12:10:00', '25 minutos', '12L'),
(1, 13, 13, '2025-10-10', '08:00:00', '30 minutos', '13M'),
(1, 14, 14, '2025-10-10', '10:45:00', '20 minutos', '14N'),
(1, 15, 15, '2025-10-10', '16:30:00', '25 minutos', '15O');

INSERT INTO farmacia (nombre, ubicacion) VALUES
('White-Ford', 'Brendan Mountains'),
('Bray and Sons', 'Oconnell Knoll'),
('Brown and Sons', 'Roberts Forge'),
('Jackson Inc', 'John Greens'),
('Brown-Watson', 'Felicia Garden'),
('Brown, Howard and Cunningham', 'Charles Junctions'),
('George-Delacruz', 'Hayes Stream'),
('Smith Ltd', 'Amy Glen'),
('Poole-Cobb', 'Brenda Lodge'),
('Garcia, Whitaker and Taylor', 'Todd Place');

INSERT INTO medicamento (nombre, formato, stock, precio, id_farmacia) VALUES
('Even', 'Inyectable', 78, 110.00, 2),
('Law', 'Comprimido', 107, 155.82, 1),
('My', 'Inyectable', 189, 134.78, 2),
('Author', 'Comprimido', 57, 137.48, 1),
('Baby', 'Inyectable', 56, 324.50, 2),
('Turn', 'Comprimido', 164, 335.71, 1),
('Him', 'Comprimido', 158, 236.10, 1),
('News', 'Comprimido', 136, 140.88, 2),
('Animal', 'Comprimido', 141, 439.00, 2),
('Down', 'Comprimido', 167, 314.49, 2);

INSERT INTO practica_medica (nombre, descripcion) VALUES
('Electrocardiograma', 'Estudio que registra la actividad eléctrica del corazón.'),
('Radiografía de Tórax', 'Imagen diagnóstica que permite visualizar pulmones y corazón.'),
('Ecografía Abdominal', 'Exploración por ultrasonido de los órganos abdominales.'),
('Análisis de Sangre', 'Evaluación de componentes sanguíneos para diagnóstico general.'),
('Espirometría', 'Prueba para medir la capacidad pulmonar y detectar enfermedades respiratorias.'),
('Resonancia Magnética', 'Técnica de imagen avanzada que permite ver tejidos blandos con detalle.'),
('Tomografía Computada', 'Exploración con rayos X para obtener imágenes detalladas del cuerpo.'),
('Ecografía Mamaria', 'Estudio por ultrasonido para evaluar tejido mamario.'),
('Audiometría', 'Prueba para determinar el nivel de audición de un paciente.'),
('Colonoscopía', 'Estudio que examina el interior del colon con una cámara flexible.');


CREATE OR REPLACE VIEW vw_turnos_completos AS
SELECT
    t.id_turno,
    c.nombre AS clinica,
    CONCAT(p.nombre, ' ', p.apellido) AS paciente,
    p.dni,
    os.nombre AS obra_social,
    CONCAT(m.nombre, ' ', m.apellido) AS medico,
    e.nombre AS especialidad,
    t.fecha,
    t.hora,
    t.duracion,
    t.consultorio
FROM turno t
JOIN clinica c ON t.id_clinica = c.id_clinica
JOIN paciente p ON t.id_paciente = p.id_paciente
JOIN obra_social os ON p.id_obra_social = os.id_obra_social
JOIN medico m ON t.id_medico = m.id_medico
JOIN medico_especialidad me ON me.id_medico = m.id_medico
JOIN especialidad e ON me.id_especialidad = e.id_especialidad;

CREATE OR REPLACE VIEW vw_disponibilidad_medico AS
SELECT
    m.id_medico,
    CONCAT(m.nombre, ' ', m.apellido) AS medico,
    e.nombre AS especialidad,
    d.dias,
    d.hora_inicio,
    d.hora_fin,
    COALESCE(d.duracion_min_override, me.duracion_turno) AS duracion_turno
FROM disponibilidad d
JOIN medico_especialidad me ON d.id_medico_especialidad = me.id_medico_especialidad
JOIN medico m ON me.id_medico = m.id_medico
JOIN especialidad e ON me.id_especialidad = e.id_especialidad;

CREATE OR REPLACE VIEW vw_pacientes_obra_social AS
SELECT
    p.id_paciente,
    CONCAT(p.nombre, ' ', p.apellido) AS nombre_completo,
    p.dni,
    p.email,
    p.domicilio,
    os.nombre AS obra_social,
    os.gravado_exento
FROM paciente p
JOIN obra_social os ON p.id_obra_social = os.id_obra_social;

CREATE OR REPLACE VIEW vw_medicos_especialidades AS
SELECT 
    m.id_medico,
    CONCAT(m.nombre, ' ', m.apellido) AS nombre_completo,
    e.nombre AS especialidad,
    me.duracion_turno
FROM medico m
JOIN medico_especialidad me ON m.id_medico = me.id_medico
JOIN especialidad e ON me.id_especialidad = e.id_especialidad;

CREATE OR REPLACE VIEW vw_historia_clinica_completa AS
SELECT 
    p.id_paciente,
    CONCAT(p.nombre, ' ', p.apellido) AS paciente,
    hc.antecedentes,
    hc.observaciones
FROM historia_clinica hc
JOIN paciente p ON hc.id_paciente = p.id_paciente;

DELIMITER //

CREATE FUNCTION fn_cantidad_turnos_por_paciente(paciente_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(*) INTO cantidad
    FROM turno
    WHERE id_paciente = paciente_id;

    RETURN cantidad;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION fn_nombre_completo_medico(medico_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_completo VARCHAR(100);

    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo
    FROM medico
    WHERE id_medico = medico_id;

    RETURN nombre_completo;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_registrar_turno (
    IN p_id_clinica INT,
    IN p_id_medico INT,
    IN p_id_paciente INT,
    IN p_fecha DATE,
    IN p_hora TIME,
    IN p_duracion VARCHAR(50),
    IN p_consultorio VARCHAR(50)
)
BEGIN
    INSERT INTO turno (id_clinica, id_medico, id_paciente, fecha, hora, duracion, consultorio)
    VALUES (p_id_clinica, p_id_medico, p_id_paciente, p_fecha, p_hora, p_duracion, p_consultorio);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_eliminar_turno (
    IN p_id_turno INT
)
BEGIN
    DELETE FROM turno WHERE id_turno = p_id_turno;
END //

DELIMITER ;

CREATE TABLE auditoria_turnos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT,
    id_medico INT,
    id_paciente INT,
    fecha_turno DATE,
    hora_turno TIME,
    registrado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE auditoria_baja_turnos (
    id_baja INT AUTO_INCREMENT PRIMARY KEY,
    id_turno INT,
    id_medico INT,
    id_paciente INT,
    fecha_turno DATE,
    hora_turno TIME,
    eliminado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_log_turno_insert
AFTER INSERT ON turno
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_turnos (id_turno, id_medico, id_paciente, fecha_turno, hora_turno)
    VALUES (NEW.id_turno, NEW.id_medico, NEW.id_paciente, NEW.fecha, NEW.hora);
END //

DELIMITER //

CREATE TRIGGER trg_log_turno_delete
AFTER DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_baja_turnos (id_turno, id_medico, id_paciente, fecha_turno, hora_turno)
    VALUES (OLD.id_turno, OLD.id_medico, OLD.id_paciente, OLD.fecha, OLD.hora);
END //

DELIMITER ;
