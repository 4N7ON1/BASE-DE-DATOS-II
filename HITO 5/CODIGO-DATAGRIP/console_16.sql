USE db_biblioteca;

#Crearemos una funcion donde devulva todos los datos del estudiante de mayor edad


create or replace function edad_mayor()
returns integer
begin
    return(
    select max(edad)
    from estudiantes
        );
end;

select*
from estudiantes
where edad=edad_mayor();

#Crearemos una funcion donde devulva todos los datos del estudiante de menor  edad

create or replace function edad_menor()
returns integer
begin
    return(
    select min(edad)
    from estudiantes
        );
end;

select*
from estudiantes
where edad=edad_menor();

#Crearemos un funcion que devuelva todos lo datos del estudiante segun su nombre y fecha de nacimiento
#la funcion debe de recibir dos parametros

create or replace function buscar_estu(nombres varchar(20),fecha date)
returns text
begin
    return (
        select Id_estudiante
        from estudiantes e
        where e.Nombre=nombres and e.Fecha=fecha
        );
end;

select id_estudiante, nombre, apellido, fecha, id_prestamo,edad
from estudiantes
where id_estudiante=buscar_estu('JHON','2003-03-21');

#Crearemos una funcion que busque su fecha de lanzamiento  segun el nombre y su autor

create or replace function buscar_libro(nomlibro VARCHAR(50), autor VARCHAR(50))
returns VARCHAR(50)
begin
    return (
            select Fecha_lanzamiento
            from autores
            inner join libros l on autores.Id_autor = l.Id_autor
            where NombreLibro=nomlibro and Nombre=autor

    );
end;

SELECT buscar_libro('Don Quijote de la Mancha','MARIO');


#crear un funcion que permita concatenar nombres y apellidos de la tabla estudiantes

CREATE or replace function concatenamos_nombres_apellidos(nombres VARCHAR(20), apellidos varchar(20))
    RETURNS VARCHAR(100)
begin
    declare resultado VARCHAR(100) DEFAULT '';
    set resultado = concat('Nombres: ', nombres, ' Apellidos: ', apellidos);
    return resultado;
end;
SELECT concatenamos_nombres_apellidos('MARCO', 'CALLE') as datos;
select concatenamos_nombres_apellidos(Nombre,Apellido) as datos_de_estudiantes
from estudiantes;


#Crear un Funcion con la condicionante when, then

set @dueño='admin';


create or replace function ejercicio_5()
returns text
begin
declare respuesta text default '';
if @dueño = 'admin'
    then
    set respuesta='Usuario Admin';
    else
    set respuesta='Usuario invitado';
end if;
return respuesta;
end;

select ejercicio_5()

#crear una serie del 1 al 10

create or replace function ejercicio_6(limite int)
returns text
begin
    declare x int default 1;
    declare serie text default '';

    while x<=limite do
        set serie=concat(serie,x,',');
        set x=x+1;
        end while;
    return serie;
end;

select ejercicio_6(10)