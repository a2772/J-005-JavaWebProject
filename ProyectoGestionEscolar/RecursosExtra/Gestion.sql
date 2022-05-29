CREATE DATABASE IF NOT EXISTS school;
-- Nomenclatura:
-- sp  -> StoredProcedure
-- t   -> Table
-- c   -> Catalog (Table but rarely changes)
-- tgr -> Trigger


			-- USANDO BD
USE school;



			-- Borrando las tablas que existen en cascada
            
-- Tablas
DROP TABLE IF EXISTS t_usuario;
DROP TABLE IF EXISTS t_alumno;
DROP TABLE IF EXISTS t_administrador;
DROP TABLE IF EXISTS t_profesor;
DROP TABLE IF EXISTS t_trabajador;
DROP TABLE IF EXISTS t_persona;
DROP TABLE IF EXISTS t_horario;
DROP TABLE IF EXISTS t_intervalo_dia;
DROP TABLE IF EXISTS t_intervalo;

-- Catálogos
DROP TABLE IF EXISTS c_cubiculo;
DROP TABLE IF EXISTS c_edificio;



			-- CREANDO TABLAS
            
-- Catálogos
CREATE TABLE c_edificio(
	id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    edificio VARCHAR(50)
);
CREATE TABLE c_cubiculo(
	id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cubiculo VARCHAR(30),
    edificio TINYINT UNSIGNED,
    FOREIGN KEY (edificio) REFERENCES c_edificio(id)
);

-- Tablas
CREATE TABLE t_intervalo(
	id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);
CREATE TABLE t_intervalo_dia(-- INtervalos de tiempo por día
	id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dia VARCHAR(9) NOT NULL,
    intervalo_1 SMALLINT UNSIGNED NOT NULL,intervalo_2 SMALLINT UNSIGNED,intervalo_3 SMALLINT UNSIGNED,
    intervalo_4 SMALLINT UNSIGNED,intervalo_5 SMALLINT UNSIGNED,intervalo_6 SMALLINT UNSIGNED,
    intervalo_7 SMALLINT UNSIGNED,intervalo_8 SMALLINT UNSIGNED,intervalo_9 SMALLINT UNSIGNED,intervalo_10 SMALLINT UNSIGNED,
    FOREIGN KEY (intervalo_1) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_2) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_3) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_4) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_5) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_6) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_7) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_8) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_9) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_10) REFERENCES t_intervalo(id)
);
CREATE TABLE t_horario(
	id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    intervalo_dia_1 SMALLINT UNSIGNED NOT NULL,
    intervalo_dia_2 SMALLINT UNSIGNED,
    intervalo_dia_3 SMALLINT UNSIGNED,
    intervalo_dia_4 SMALLINT UNSIGNED,
    intervalo_dia_5 SMALLINT UNSIGNED,-- 5 Días, de lunes a viernes
    FOREIGN KEY (intervalo_dia_1) REFERENCES t_intervalo_dia(id),
    FOREIGN KEY (intervalo_dia_2) REFERENCES t_intervalo_dia(id),
    FOREIGN KEY (intervalo_dia_3) REFERENCES t_intervalo_dia(id),
    FOREIGN KEY (intervalo_dia_4) REFERENCES t_intervalo_dia(id),
    FOREIGN KEY (intervalo_dia_5) REFERENCES t_intervalo_dia(id)
);
CREATE TABLE t_persona(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    ap_first VARCHAR(100) NOT NULL,
    ap_second VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo VARCHAR(13) NOT NULL
);
CREATE TABLE t_trabajador(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    persona INT UNSIGNED NOT NULL UNIQUE,
    rfc VARCHAR(150) NOT NULL,
    sueldo VARCHAR(100) NOT NULL,
    FOREIGN KEY (persona) REFERENCES t_persona(id)
);
CREATE TABLE t_profesor(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    trabajador INT UNSIGNED NOT NULL UNIQUE,
    cubiculo SMALLINT UNSIGNED,
    horario_atencion SMALLINT UNSIGNED,
    FOREIGN KEY (trabajador) REFERENCES t_trabajador(id),
    FOREIGN KEY (cubiculo) REFERENCES c_cubiculo(id),
    FOREIGN KEY (horario_atencion) REFERENCES t_horario(id)
);
CREATE TABLE t_administrador(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    persona INT UNSIGNED NOT NULL UNIQUE,
    FOREIGN KEY (persona) REFERENCES t_persona(id)
);
-- PENDIENTE

CREATE TABLE t_alumno(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    persona INT UNSIGNED NOT NULL UNIQUE,
    rfc VARCHAR(150) NOT NULL,
    sueldo VARCHAR(100) NOT NULL,
    FOREIGN KEY (persona) REFERENCES t_persona(id)
);
CREATE TABLE t_usuario(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    pass VARCHAR(30),
    persona INT UNSIGNED NOT NULL UNIQUE,
    FOREIGN KEY (persona) REFERENCES t_persona (id)
);

			-- Insercciones iniciales

-- Insercciones a los catálogos
INSERT INTO c_edificio (edificio) VALUES ('Culturales'),('Gestión Escolar'),('Ciencias Sociales'),('Desarrollo específico'),('Administración'),('Laboratorios Pesados'),
	('Laboratorios Ligeros'),('Posgrado');
INSERT INTO c_cubiculo (cubiculo,edificio) VALUES ('102-A',3),('103-B',3),('209-G',3),('202-A',4),('202-B',4),('105-A',5),('206-B',5),('307-C',5);

-- Insercciones a las tablas
INSERT INTO t_intervalo(hora_inicio,hora_fin) VALUES 
    ('07:00:00','08:30:00'),('08:30:00','10:00:00'),('10:00:00','11:30:00'),('11:30:00','13:00:00'),('13:00:00','14:30:00'),
    ('14:30:00','16:00:00'),('16:00:00','17:30:00'),('17:30:00','19:00:00'),('19:00:00','21:30:00'),('21:30:00','22:30:00');
INSERT INTO t_intervalo_dia (dia, intervalo_1,intervalo_2,intervalo_3,intervalo_4,intervalo_5,intervalo_6,intervalo_7,intervalo_8,intervalo_9,intervalo_10) VALUES 
	('Lunes', 1,2,3,4,null,null,null,null,null,null),('Martes', 2,3,4,null,null,null,null,null,null,null),
    ('Miércoles', 1,2,3,4,null,null,null,null,null,null),('Jueves', 2,3,4,null,null,null,null,null,null,null),
    ('Viernes', 1,2,3,4,null,null,null,null,null,null);
INSERT INTO t_horario (intervalo_dia_1,intervalo_dia_2,intervalo_dia_3,intervalo_dia_4,intervalo_dia_5) VALUES (1,2,3,4,5);



			-- Stored Procedures

-- Desplegables
-- DROP PROCEDURE IF EXISTS sp_get_desplegable;
-- DELIMITER %
-- CREATE PROCEDURE sp_get_desplegable(IN numero_desplegable_insi SMALLINT)
-- BEGIN
-- 	IF numero_desplegable_insi=1 THEN 
-- 		SELECT * FROM c_dia_semana ORDER BY id ASC;
--     END IF;
-- END %
-- DELIMITER ;

-- INSERCCIONES
-- sp_set_nuevo_usuario
DROP PROCEDURE IF EXISTS sp_set_nuevo_usuario;
DELIMITER %
-- Da de alta a un nuevo usuario. LLamar dentro de una transacción
CREATE PROCEDURE sp_set_nuevo_usuario(IN nombre_in VARCHAR(150),IN ap_first_in VARCHAR(100),IN ap_second_in VARCHAR(100),IN fecha_nacimiento_in DATE,
	IN sexo_in VARCHAR(13),IN usuario_in VARCHAR(100), IN pass_in VARCHAR(30),OUT id_persona_out INT UNSIGNED)
BEGIN
    DECLARE id_persona INT UNSIGNED;
	-- INSERTA PERSONA primero
	INSERT INTO t_persona (nombre,ap_first,ap_second,fecha_nacimiento,sexo) VALUES 
		(nombre_in,ap_first_in,ap_second_in, fecha_nacimiento_in, sexo_in);
	SELECT MAX(id) FROM t_persona INTO id_persona;
    -- Insertamos USUARIO después
    INSERT INTO t_usuario (usuario,pass,persona) VALUES (usuario_in,pass_in,id_persona);
    
    -- SELECCIONAMOS LA ID DE LA PERSONA para el out
    SET id_persona_out = id_persona;
END %
DELIMITER ;
-- sp_set_nuevo_administrador
DROP PROCEDURE IF EXISTS sp_set_nuevo_administrador;
DELIMITER %
-- Da de alta a un nuevo administrador
CREATE PROCEDURE sp_set_nuevo_administrador(IN nombre_in VARCHAR(150),IN ap_first_in VARCHAR(100),IN ap_second_in VARCHAR(100),IN fecha_nacimiento_in DATE,
	IN sexo_in VARCHAR(13),IN usuario_in VARCHAR(100), IN pass_in VARCHAR(30),-- Hasta quí es de persona
    IN trabajador_in INT UNSIGNED, IN cubiculo_in SMALLINT UNSIGNED, IN horario_atencion SMALLINT UNSIGNED)-- Insertando PROFESOR
BEGIN
	DECLARE id_persona_var INT UNSIGNED;
	START TRANSACTION;
    -- Insertamos persona
    CALL sp_set_nuevo_usuario(nombre_in,ap_first_in,ap_second_in,fecha_nacimiento_in,sexo_in,usuario_in,pass_in,id_persona_var);
	INSERT INTO t_profesor(
END %
DELIMITER ;


			-- PRUEBA
-- SELECT

-- CALL
CALL sp_get_desplegable(1);








