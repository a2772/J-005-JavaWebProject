CREATE DATABASE IF NOT EXISTS school;
-- Nomenclatura:
-- sp->StoredProcedure
-- t->Table
-- c->Catalog (Table but rarely changes)
-- 


			-- USANDO BD
USE school;



			-- Borrando las tablas que existen en cascada
            
-- Tablas
DROP TABLE IF EXISTS t_persona;
DROP TABLE IF EXISTS t_horario;
DROP TABLE IF EXISTS t_intervalo_dia;
DROP TABLE IF EXISTS t_intervalo;

-- Catálogos



			-- CREANDO TABLAS
            
-- Catálogos


-- Tablas
CREATE TABLE t_intervalo(
	id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);
CREATE TABLE t_intervalo_dia(-- INtervalos de tiempo por día
	id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dia VARCHAR(9) UNIQUE NOT NULL,
    intervalo_1 SMALLINT UNSIGNED NOT NULL,intervalo_2 SMALLINT UNSIGNED,intervalo_3 SMALLINT UNSIGNED,
    intervalo_4 SMALLINT UNSIGNED,intervalo_5 SMALLINT UNSIGNED,intervalo_6 SMALLINT UNSIGNED,
    intervalo_7 SMALLINT UNSIGNED,intervalo_8 SMALLINT UNSIGNED,
    FOREIGN KEY (dia) REFERENCES c_dia_semana(id),
    FOREIGN KEY (intervalo_1) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_2) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_3) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_4) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_5) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_6) REFERENCES t_intervalo(id),
    FOREIGN KEY (intervalo_7) REFERENCES t_intervalo(id),FOREIGN KEY (intervalo_8) REFERENCES t_intervalo(id)
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
    sexo VARCHAR(6) NOT NULL
);
CREATE TABLE t_trabajador(
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
    persona INT UNSIGNED NOT NULL UNIQUE,
    rfc VARCHAR(150) NOT NULL,
    sueldo VARCHAR(100) NOT NULL,
    FOREIGN KEY (persona) REFERENCES t_persona(id)
);


			-- Insercciones iniciales

-- Insercciones a los catálogos
INSERT INTO c_dia_semana (dia) VALUES ('Lunes'),('Martes'),('Miércoles'),('Jueves'),('Viernes'),('Sábado'),('Domingo');
INSERT INTO c_sexo(sexo) VALUES ('Hombre'),('Mujer'),('No Especifica');
INSERT INTO c_tipo_perfil(perfil,descripcion) VALUES 
	('Administrador','Administrador del sistema de gestión escolar, todos los permisos'),
    ('Profesor','Profesor, entra como un trabajador e imparte y evalúa alumnos'),
    ('Alumno','Estudiante de un programa escolar');

-- Insercciones a las tablas
INSERT INTO t_intervalo_dia (dia,hora_inicio,hora_fin) VALUES 
    (1,'07:00:00','08:30:00'),(1,'08:30:00','10:30:00'),(1,'10:00:00','11:30:00'),(1,'11:30:00','13:00:00'),
	(2,'07:00:00','08:30:00'),(2,'08:30:00','10:30:00'),(2,'10:00:00','11:30:00'),(2,'11:30:00','13:00:00');
INSERT INTO t_horario (intervalo_dia_1) VALUES (2);



			-- Stored Procedures

-- Desplegables
DROP PROCEDURE IF EXISTS sp_get_desplegable;
DELIMITER %
CREATE PROCEDURE sp_get_desplegable(IN numero_desplegable_insi SMALLINT)
BEGIN
	IF numero_desplegable_insi=1 THEN 
		SELECT * FROM c_dia_semana ORDER BY id ASC;
    END IF;
END %
DELIMITER ;






			-- PRUEBA
-- SELECT

-- CALL
CALL sp_get_desplegable(1);