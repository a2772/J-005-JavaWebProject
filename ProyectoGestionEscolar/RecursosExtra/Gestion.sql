CREATE DATABASE school;
-- Nomenclatura:
-- sp->StoredProcedure
-- t->Table
-- c->Catalog (Table but rarely changes)
-- 


			-- USANDO BD
USE school;


			-- CREANDO TABLAS
-- Catálogos
CREATE TABLE c_dia_semana(
	id TINYINT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    dia VARCHAR(9) UNIQUE NOT NULL
);
-- Tablas


			-- Insercciones iniciales
-- Insercciones a los catálogos
INSERT INTO c_dia_semana (dia) values ('Lunes'),('Martes'),('Miércoles'),('Jueves'),('Viernes'),('Sábado'),('Domingo');


			-- Stored Procedures
DROP PROCEDURE IF EXISTS sp_get_desplegable;
DELIMITER %
CREATE PROCEDURE sp_get_desplegable(IN numero_desplegable_insi SMALLINT)
BEGIN
	IF numero_desplegable_insi=1 THEN 
		SELECT * FROM c_dia_semana ORDER BY id;
    END IF;
END %
DELIMITER ;






			-- PRUEBA
-- SELECT

-- CALL
CALL sp_get_desplegable(1);