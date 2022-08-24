create database  funcion_de_agregacion;

use funcion_de_agregacion;

CREATE TABLE estudiantes
(
 id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombres VARCHAR(50),
 apellidos VARCHAR(50),
 edad INTEGER,
 gestion INTEGER,
 fono INTEGER,
 email VARCHAR(100),
 direccion VARCHAR(100),
 sexo VARCHAR(10)
);

select  est.*
from  estudiantes as est;

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

-- crear la consulta que modifique el campo gestion y que asigne
-- el valor 2022

update  estudiantes
set gestion = '2022'
where id_est > 0;

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);

CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);


INSERT INTO materias (nombre_mat, cod_mat) VALUES
('Introduccion a la Arquitectura','ARQ-101'),
 ('Urbanismo y Diseno','ARQ-102'),
 ('Dibujo y Pintura Arquitectonico','ARQ-103'),
 ('Matematica discreta','ARQ-104'),
 ('Fisica Basica','ARQ-105');

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES
(1, 1, '1er Semestre', 2015),
 (1, 2, '2do Semestre', 2015),
(2, 4, '1er Semestre', 2016),
(2, 3, '2do Semestre', 2016),
(3, 3, '2do Semestre', 2017),
(3, 1, '3er Semestre', 2017),
 (4, 4, '4to Semestre', 2017),
(5, 5, '5to Semestre', 2017);

select *
from materias;

-- Mostrar los nombres y apellidos de los estudiantes inscritos en la materia
-- ARQ-104, adicionalmente mostrar el nombre el nombre de la materia.


select est.nombres, est.apellidos, mat.nombre_mat
from inscripcion as ins
inner join estudiantes as est on ins.id_est = est.id_est
inner join materias mat on ins.id_mat = mat.id_mat

where mat.cod_mat= 'ARQ-104';

-- Contar cuantos registros tiene la tabla estudiantes

SELECT COUNT(est.id_est) as 'cantidad de estudiantes'
FROM estudiantes as est;

--  Contar cuántos valores tiene la columna id_est de la tabla estudiantes.
SELECT count(est.id_est)
FROM estudiantes AS est;

-- Mostrar el promedio de edad en la tabla estudiantes.

SELECT AVG(est.edad) as 'promedio de las edades'
FROM estudiantes AS est;

-- Mostrar la máxima edad que se tiene en la tabla estudiantes.

SELECT MAX(est.edad)  as 'maxima edad '
FROM estudiantes AS est;

-- Mostrar la mínima edad que se tiene en la estudiantes.

SELECT MIN(est.edad) as 'minima edad'
FROM estudiantes AS est;

-- determinar la maxima edad de los estudiantes de
-- cuyo genero sea masculino o femenino mayor a 20


select max(est.edad)
from estudiantes as est
where est.sexo ='masculino'  && est.edad > 20

--  Crear una función que devuelve el máximo valor del campo edad en
 -- la tabla estudiantes.

create or replace function get_max_edad()
        RETURNS integer
        begin
            return 10;
        end;

select get_max_edad();

create or replace function get_max_edad()
        RETURNS varchar(20)
        begin
            return 'wiliam barra';
        end;


select get_max_edad();


create or replace function get_max_edad()
        RETURNS integer
        begin
            return
                (
                    SELECT MAX(est.edad)
                   FROM estudiantes AS est
                );
        end;


select get_max_edad();


-- Crear una función que obtenga la menor edad de los estudiantes.

create or replace function get_Min_edad()
        RETURNS integer
        begin
            return
                (
                    SELECT Min(est.edad)
                   FROM estudiantes AS est
                );
        end;


select get_Min_edad();

--
create or replace function get_Avg_edad()
        RETURNS integer
        begin
            return
                (
                    SELECT Avg(est.edad)
                   FROM estudiantes AS est
                );
        end;


select get_Avg_edad();


-- 18

create or replace function get_max_edad_estudiantes()
        RETURNS integer
        begin
            return
                (
                    select max(est.edad)
         from estudiantes as est
                 where est.sexo ='masculino'
                );
        end;

select get_max_edad_estudiantes();



-- Mostrar el registro de la tabla estudiantes
 -- (nombre y apellidos) donde cuyo id_est sea el máximo.

create or replace function get_max_id_est()
        RETURNS int
        begin
            return
                (
               SELECT max(est.id_est)
                 FROM estudiantes AS est
                );
        end;

select get_max_id_est();

select nombres,apellidos
from estudiantes as est
where id_est = get_max_id_est()


create function SUMA_EDADES()  RETURNS int
    BEGIN
        RETURN
            (SELECT SUM(ESS.edad)
             FROM estudiantes AS ESS
             WHERE ESS.sexo='masculino'
             );
     END;


select nombres,apellidos
from estudiantes AS ES
WHERE SUMA_EDADES() %2 =0


#Mostrar todos los registros de la tabla estudiantes (nombres y apellidos) si la suma de las edades de las estudiantes femeninos sea par.
#Crear una función que obtenga la suma de las edades de las estudiantes femeninos.

create function SUMA_EDADES2()  RETURNS int
    BEGIN
        RETURN
            (SELECT SUM(ESS.edad)
             FROM estudiantes AS ESS
             WHERE ESS.sexo='femenino'
             );
     END;


select nombres,apellidos
from estudiantes AS ES
WHERE SUMA_EDADES() %2 =0


create function SUMA_EDADES3(SEXOEST VARCHAR(30))  RETURNS int
    BEGIN
       DECLARE SEXOEST INT DEFAULT 0;

            SELECT SUM(ESS.edad) INTO SEXOEST
             FROM estudiantes AS ESS
             WHERE ESS.sexo= SEXOEST;
             RETURN SEXOEST;

     END;


SELECT nombres,apellidos
    FROM estudiantes AS ES
WHERE SUMA_EDADES3('masculino') %2=1;

create function get_Avg1(sexoest varchar(20))
        RETURNS integer
        begin

            DECLARE EDADES REAL DEFAULT 0;


                    SELECT Avg(est.edad) INTO EDADES
                   FROM estudiantes AS est
                   WHERE  est.sexo = sexoest;
            return EDADES;

        end;


select get_Avg1 ('femenino') as sexo;

#Mostrar los registros de la tabla estudiantes (nombres y apellidos concatenados) y la edad en otra columna si la cantidad de estudiantes femeninos sea PAR.
#Utilice las funciones previamente creados.
#La función parametrizable para sumar edades en función al sexo( masculinos o femeninos).
#La función que concatena nombres y apelliDOS

SELECT CONCAT(nombres,apellidos) AS CONCATENADO
    FROM estudiantes AS EST


CREATE OR REPLACE FUNCTION getNombreCompleto(par1 VARCHAR(25), par2 VARCHAR(25))
    RETURNS VARCHAR(50)
BEGIN
    DECLARE concatenado VARCHAR(50) DEFAULT '';

    SET concatenado = CONCAT(par1, ' - ', par2);

    RETURN concatenado;

END;

SELECT getNombreCompleto('MARCO', 'CALLE') AS NOMBRES;

SELECT getNombreCompleto(est.nombres, est.apellidos) AS Fullname
FROM estudiantes AS est;

