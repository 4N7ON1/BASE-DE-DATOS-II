use db_biblioteca;

#EN ESTA PARTE HAREMOS USO DE LOS TRIGERRS

#HAREMOS DOS ADUTORIAS

CREATE TABLE COPIA_ESTUDIANTES
(
Nombre VARCHAR(20),
Apellido VARCHAR(20),
Fecha DATE,
edad integer,
Id_prestamo INTEGER,
FOREIGN KEY (Id_prestamo) REFERENCES Prestamos (Id_prestamo)
);

CREATE TRIGGER GUARDA_DATOS_DEPUES
    BEFORE INSERT ON estudiantes
    FOR EACH ROW
    BEGIN
        INSERT INTO COPIA_ESTUDIANTES(Nombre, Apellido, Fecha, edad, Id_prestamo)
        VALUES(NEW.Nombre, NEW.Apellido, NEW.Fecha, NEW.edad, NEW.Id_prestamo);

    end;

INSERT INTO estudiantes(Id_estudiante, Nombre, Apellido, Fecha, edad, Id_prestamo)VALUES
(9,'JOEL','LOPEZ','2002-07-13',24,2);
INSERT INTO estudiantes(Id_estudiante, Nombre, Apellido, Fecha, edad, Id_prestamo)VALUES
(10,'EVER','ROJAS','2001-12-13',28,3);

SELECT*
FROM COPIA_ESTUDIANTES;

CREATE TABLE GUARDA_LIBROS
(
    NombreLibro  VARCHAR(25),
    Codigo_autor VARCHAR(50),
    Codigo_editorial VARCHAR(50),
    Fecha_lanzamiento DATE,
    Id_autor INTEGER,
    Id_editorial INTEGER,
    FOREIGN KEY (Id_autor) REFERENCES Autores (Id_autor),
    FOREIGN KEY (Id_editorial) REFERENCES Editorial (Id_editorial)
);


CREATE TRIGGER LIBROS_GUARDADOS_DATOS
    AFTER insert ON libros
    FOR EACH ROW
    BEGIN
        INSERT INTO GUARDA_LIBROS(NombreLibro, Codigo_autor, Codigo_editorial, Fecha_lanzamiento, Id_autor, Id_editorial)
        VALUES (NEW.NombreLibro, NEW.Codigo_autor, NEW.Codigo_editorial, NEW.Fecha_lanzamiento, new.Id_autor, new.Id_editorial);

  end;

insert into libros(id_libro, nombrelibro, codigo_autor, codigo_editorial, fecha_lanzamiento, id_autor, id_editorial)
values (9,'LA TIERRA PERDIDA','1234HGF123','D123D1','1781-09-22',3,3);

SELECT*
FROM guarda_libros;

#HAREMOS UN TRIGGERS DE VERIFICACION

alter table bibliotecario add column password varchar(50);
alter table bibliotecario add column usuario varchar(50);

create or replace  trigger genera_password_usuario
before insert on bibliotecario
for each row                                 #FOR EACH=PARA CADA FILA           before = despues
begin
    #substring de cada dos palabras inciales
    set new.usuario=concat(substring(new.nombre,1,2),substring(new.apellido,1,2));
    set new.password = concat(substring(new.nombre,1,2),substring(new.apellido,1,2),substring(new.ci,1,2));
end;

insert into bibliotecario(id_bibliotecario, nombre, apellido, ci, Id_estudiante, HORARIO)
values (3,'AURON','TORREZ','8U482LP',9,'8am-14pm');

select*
from bibliotecario;