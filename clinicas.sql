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
    

    

    

    

    
