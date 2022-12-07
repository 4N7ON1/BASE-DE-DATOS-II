use db_biblioteca;

#utilizamos la primera consulta para la creacion de una vista

create or replace  view prestar_fecha_actual as
select Nombre,Apellido,edad, fec_prestamo
from prestamos
inner join estudiantes e on prestamos.Id_prestamo = e.Id_prestamo
where fec_prestamo<'2022-12-07';

select*
from prestar_fecha_actual;

#utilizamos la segunda  consulta para la creacion de una vista

create or replace  view busca_editorial as
select editorial.nombre,
       id_libro,
       nombrelibro,
       codigo_autor,
       codigo_editorial,
       fecha_lanzamiento,
       id_autor
from editorial
inner join libros l on editorial.Id_editorial = l.Id_editorial
where Nombre='NATURA';

select*
from busca_editorial;

#utilizamos la tercera  consulta para la creacion de una vista

create or replace view busca_mayores_20 as
select (autores.Nombre)as AUTORES,NombreLibro,fec_prestamo,e2.Nombre,e2.Apellido,e2.edad
from autores
inner join libros l on autores.Id_autor = l.Id_autor
inner join editorial e on l.Id_editorial = e.Id_editorial
inner join prestamos p on l.Id_libro = p.Id_libro
inner join devoluciones d on p.Id_devolucion = d.Id_devolucion
inner join estudiantes e2 on p.Id_prestamo = e2.Id_prestamo
where edad >15;

select*
from busca_mayores_20;

#crearemoss una vista donde tendremos que cencatenar el nombre y apellido y tiene que decir full_name
# donde la edad sera years
# donde los que no devolvieron el libro hasta la fecha actual se dira 'DEUDOR'

CREATE OR REPLACE VIEW BUSCAR_DEUDOR AS
select CONCAT(Nombre,'-',Apellido) as full_name,
       edad as years,
       case
           when d.Fecha>'2022-12-05' then 'DEUDOR'
        end as fecha_en_la_que_devolvio
from libros
inner join prestamos p on libros.Id_libro = p.Id_libro
inner join estudiantes e on p.Id_prestamo = e.Id_prestamo
inner join devoluciones d on p.Id_devolucion = d.Id_devolucion;


SELECT*
FROM BUSCAR_DEUDOR;


#Creamos una vista que te muestre todos los datos de los estudiantes  y que si
#son mayores o igual  a 18 años ponerlos 'mayor de edad' y si son menores a 18 años poner 'menor de edad'

create or replace view saber_que_edad as
select concat(Nombre,' ',Apellido) as NOMBRE_COMPLETO,
       case
           when edad >=18 then 'mayor de edad'
           when edad <18 then'menor de edad'
        end as EDAD_DE_LOS_ESTUDIANTES,
       Fecha,
       Id_estudiante
from estudiantes;

select EDAD_DE_LOS_ESTUDIANTES
from saber_que_edad;

select*
from saber_que_edad;