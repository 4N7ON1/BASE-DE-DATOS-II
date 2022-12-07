use db_biblioteca;
#1. Consultas SQL que maneja JOINS = 5 Consultas

#mostraremos los nombres y apellidos de los estudiantes que se prestaron hasta la fecha de hoy

select Nombre,Apellido,edad, fec_prestamo
from prestamos
inner join estudiantes e on prestamos.Id_prestamo = e.Id_prestamo
where fec_prestamo<'2022-12-07';

#mostraremos todos los datos de los libros que tienen el editorial='NATURA'

select  editorial.nombre, l.nombrelibro, l.codigo_autor, l.codigo_editorial, l.fecha_lanzamiento
from editorial
inner join libros l on editorial.Id_editorial = l.Id_editorial
where Nombre='NATURA';

#Mostraremos los nombres de los autores mas la fecha de prestamo que hicieron los estudiantes mayores a 20 años

select (autores.Nombre)as AUTORES,NombreLibro,fec_prestamo,e2.Nombre,e2.Apellido,e2.edad
from autores
inner join libros l on autores.Id_autor = l.Id_autor
inner join editorial e on l.Id_editorial = e.Id_editorial
inner join prestamos p on l.Id_libro = p.Id_libro
inner join devoluciones d on p.Id_devolucion = d.Id_devolucion
inner join estudiantes e2 on p.Id_prestamo = e2.Id_prestamo
where edad >20;

#Mostrame todos los datos del bibliotecario que presto a estudiantes menores a 15 años
#adicionalmente mostrame a que estudiantes presto(solo nombres y edad)

select b.nombre,b.apellido,b.ci,b.HORARIO,estudiantes.Nombre,edad
from estudiantes
inner join bibliotecario b on estudiantes.Id_estudiante = b.Id_estudiante
where edad <15;

#mostrame los nombres de los estudiantes y que libro mas la fecha en que se les presto y en la que devolvieron

select e.Nombre,NombreLibro,fec_prestamo,devoluciones.Fecha
from devoluciones
inner join prestamos p on devoluciones.Id_devolucion = p.Id_devolucion
inner join estudiantes e on p.Id_prestamo = e.Id_prestamo
inner join libros l on p.Id_libro = l.Id_libro

