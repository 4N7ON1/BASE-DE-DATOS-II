CREATE DATABASE DB_Biblioteca;
USE DB_Biblioteca;
DROP DATABASE  DB_Biblioteca;
CREATE TABLE Estudiantes
(
     Id_estudiante INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
     Nombre VARCHAR(20),
     Apellido VARCHAR(20),
     Fecha DATE,
     edad integer,
     Id_prestamo INTEGER,
     FOREIGN KEY (Id_prestamo) REFERENCES Prestamos (Id_prestamo)
);


CREATE TABLE Prestamos
(
    Id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Id_devolucion  INTEGER,
    Id_libro       INTEGER,
    fec_prestamo   DATE,
    FOREIGN KEY (Id_devolucion) REFERENCES Devoluciones (Id_devolucion),
    FOREIGN KEY (Id_libro) REFERENCES Libros (Id_libro)
);

CREATE  TABLE Devoluciones
(
    Id_devolucion INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Id_prestamo INTEGER,
    Fecha DATE


);

CREATE TABLE Libros
(
    Id_libro    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    NombreLibro  VARCHAR(25),
    Codigo_autor VARCHAR(50),
    Codigo_editorial VARCHAR(50),
    Fecha_lanzamiento DATE,
    Id_autor INTEGER,
    Id_editorial INTEGER,
    FOREIGN KEY (Id_autor) REFERENCES Autores (Id_autor),
    FOREIGN KEY (Id_editorial) REFERENCES Editorial (Id_editorial)
);

CREATE TABLE Autores
(
    Id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombre      VARCHAR(20),
    Apellido    VARCHAR(50),
    Nacionalidad VARCHAR(20)
);

CREATE TABLE Editorial
(
    Id_editorial INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nombre       VARCHAR(30)
);
CREATE TABLE Bibliotecario
(
    id_bibliotecario INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    ci VARCHAR(150),
    Id_estudiante INTEGER,
    FOREIGN KEY (Id_estudiante) REFERENCES Estudiantes (Id_estudiante)
);
ALTER TABLE Bibliotecario ADD COLUMN HORARIO VARCHAR(50);

INSERT INTO Editorial(Id_editorial, Nombre) VALUES
(1,'VISOR'),
(2,'RENACIMIENTO'),
(3,'MIRAHADAS'),
(4,'NATURA'),
(5,'IMPEDIMENTA');

INSERT INTO Autores(Id_autor, Nombre, Apellido, Nacionalidad) VALUES
(1,'JOSE','LUIS BORGER','ROMA'),
(2,'MARIO','VARGAS LIOSA','INGLATERRA'),
(3,'GABRIEL','GARZIA MENDOZA','ESPAÑA'),
(4,'ISABEL','ILLANDEL','MEXICO'),
(5,'ALFONSINA','STOMI','EEUU');

INSERT INTO Libros(Id_libro, NombreLibro, Codigo_autor, Codigo_editorial, Fecha_lanzamiento, Id_autor, Id_editorial) VALUES
(1,'VIAJE AL FIN DE LA NOCHE','123VFN','22233344','1932-04-11',1,1);
INSERT INTO Libros(Id_libro, NombreLibro, Codigo_autor, Codigo_editorial, Fecha_lanzamiento, Id_autor, Id_editorial) VALUES
(2,'Don Quijote de la Mancha','123DQM','11144455','1605-07-23',2,2),
(3,'Los cuentos de Canterbury','123LCC','33355577','1971-10-04',3,3),
(4,'LAS MIL Y UNA NOCHES','123LMN','12345678','1543-11-27',4,4),
(5,'DECAMERON','123DCN','987654321','1999-11-13',5,5),
(6,'FICCIONES','123FCC','999888777','1881-10-15',5,5),
(7,'EL EXTRANJERO','123EXT','555666777','1761-06-06',3,3),
(8,'GRANDES ESPERANZAS','123ESP','000111222','2000-01-21',4,4);

INSERT INTO Devoluciones(Id_devolucion, Id_prestamo, Fecha) VALUES
(1,1,'2022-12-11'),
(2,2,'2022-12-07'),
(3,3,'2022-12-05'),
(4,4,'2022-11-22'),
(5,5,'2022-11-18');

INSERT INTO Prestamos(Id_prestamo, Id_devolucion, Id_libro, fec_prestamo) VALUES
(1,1,1,'2022-09-09'),
(2,2,5,'2022-09-07'),
(3,3,3,'2022-09-05'),
(4,4,6,'2022-08-20'),
(5,5,8,'2022-08-18');

INSERT INTO Estudiantes(Id_estudiante, Nombre, Apellido,edad, Fecha, Id_prestamo) VALUES
(1,'MARCO ANTONIO','CALLE VAQUIATA',20,'2002-11-13',1),
(2,'IRIS','MISHEL VELASCO',19,'2002-11-11',2),
(3,'ILIA','SARZO',15,'2006-07-08',3),
(4,'JHON','TORREZ',22,'2003-03-21',4),
(5,'EXTERMINADOR','JUICIO FINAL',25,'1999-06-06',5);
INSERT INTO Estudiantes(Id_estudiante, Nombre, Apellido,edad, Fecha, Id_prestamo) VALUES
(6,'ROSARIO','KANTUTA',13,'2011-10-21',4);

INSERT INTO bibliotecario(ID_BIBLIOTECARIO, NOMBRE, APELLIDO, CI,HORARIO, ID_ESTUDIANTE)VALUES
(1,'JHON','TRAVOLTA','123456LP','8AM-14PM',1),
(2,'JIMENA','LAURA','654321CBB','14PM-8PM',2);
INSERT INTO bibliotecario(ID_BIBLIOTECARIO, NOMBRE, APELLIDO, CI,HORARIO, ID_ESTUDIANTE)VALUES
(4,'ROCKY','SILVESTRE','12326CBB','8AM-14PM',6);


