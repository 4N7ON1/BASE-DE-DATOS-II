
create database hito_4;
USE hito_4;

DROP TABLE  users;

CREATE TABLE autor
(
id_autor INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
name VARCHAR(100),
nacionality VARCHAR(50)
);


CREATE TABLE book
(
id_book INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
codigo VARCHAR(25) NOT NULL,
isbn VARCHAR(50),
title VARCHAR(100),
editorial VARCHAR(50),
pages INTEGER,
id_autor INTEGER,
FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);


CREATE TABLE category
(
id_cat INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
type VARCHAR(50),
id_book INTEGER,
FOREIGN KEY (id_book) REFERENCES book (id_book)
);


CREATE TABLE users
(
id_user INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
ci VARCHAR(15) NOT NULL,
fullname VARCHAR(100),
lastname VARCHAR(100),
address VARCHAR(150),
phone INTEGER
);


CREATE TABLE prestamos
(
id_prestamo INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
id_book INTEGER,
id_user INTEGER,
fec_prestamo DATE,
fec_devolucion DATE,
FOREIGN KEY (id_book) REFERENCES book (id_book),
FOREIGN KEY (id_user) REFERENCES users (id_user)
);


INSERT INTO autor (name, nacionality)
VALUES ('autor_name_1', 'Bolivia'),
        ('autor_name_2', 'Argentina'),
        ('autor_name_3', 'Mexico'),
        ('autor_name_4', 'Paraguay');

INSERT INTO book (codigo, isbn, title, editorial, pages, id_autor)
VALUES ('codigo_book_1', 'isbn_1', 'title_book_1', 'NOVA', 30, 1),
        ('codigo_book_2', 'isbn_2', 'title_book_2', 'NOVA II', 25, 1),
        ('codigo_book_3', 'isbn_3', 'title_book_3', 'NUEVA SENDA', 55, 2),
        ('codigo_book_4', 'isbn_4', 'title_book_4', 'IBRANI', 100, 3),
        ('codigo_book_5', 'isbn_5', 'title_book_5', 'IBRANI', 200, 4),
        ('codigo_book_6', 'isbn_6', 'title_book_6', 'IBRANI', 85, 4);

INSERT INTO category (type, id_book)
VALUES ('HISTORIA', 1),
        ('HISTORIA', 2),
        ('COMEDIA', 3),
        ('MANGA', 4),
        ('MANGA', 5),
        ('MANGA', 6);

INSERT INTO users (ci, fullname, lastname, address, phone)
VALUES ('111 cbba', 'user_1', 'lastanme_1', 'address_1', 111),
        ('222 cbba', 'user_2', 'lastanme_2', 'address_2', 222),
        ('333 cbba', 'user_3', 'lastanme_3', 'address_3', 333),
        ('444 lp', 'user_4', 'lastanme_4', 'address_4', 444),
        ('555 lp', 'user_5', 'lastanme_5', 'address_5', 555),
        ('666 sc', 'user_6', 'lastanme_6', 'address_6', 666),
        ('777 sc', 'user_7', 'lastanme_7', 'address_7', 777),
        ('888 or', 'user_8', 'lastanme_8', 'address_8', 888);

INSERT INTO prestamos (id_book, id_user, fec_prestamo, fec_devolucion)
VALUES (1, 1, '2017-10-20', '2017-10-25'),
        (2, 2, '2017-11-20', '2017-11-22'),
        (3, 3, '2018-10-22', '2018-10-27'),
        (4, 3, '2018-11-15', '2017-11-20'),
        (5, 4, '2018-12-20', '2018-12-25'),
        (6, 5, '2019-10-16', '2019-10-18');

SELECT * FROM users;

#CREAR UNA VISTA QUE SE LLAME BOOK CONTENT



CREATE OR REPLACE VIEW BOOK_CONTENT AS
SELECT BOOK.TITLE AS TitleBook,
       BOOK.EDITORIAL AS EditorialBook,
       BOOK.PAGES AS PagesBook,
        (
          case
              when book.pages>10 and book.pages<=30 then 'contenido basico'
              when book.pages>30 and book.pages<=80 then 'contenido mediano'
              when book.pages>80 and book.pages<=150 then 'contenido superior'
              when book.pages>150 then 'contenido avanzado'
            end
        ) AS TypeContentBook
FROM BOOK;


CREATE OR REPLACE VIEW BOOK_CONTEN_V2 AS
SELECT BOOK.TITLE AS TitleBook,
       BOOK.EDITORIAL AS EditorialBook,
       BOOK.PAGES AS PagesBook,
       COUNT_PAGES(BOOK.pages) AS TypeContentBook
FROM BOOK;

SELECT* FROM BOOK_CONTEN_V2;

CREATE OR REPLACE FUNCTION COUNT_PAGES(NUMERO INTEGER)
RETURNS VARCHAR(40)
BEGIN
    DECLARE RESPUESTA VARCHAR(40) DEFAULT '';

    case
    when NUMERO>10 and NUMERO<=30 then SET RESPUESTA= 'contenido basico';
    when NUMERO>30 and NUMERO<=80 then SET RESPUESTA='contenido mediano';
    when NUMERO>80 and NUMERO<=150 then SET RESPUESTA='contenido superior';
    when NUMERO>150 then SET RESPUESTA= 'contenido avanzado';
    end CASE;

RETURN RESPUESTA;
end;

# LA VISTA DEBERA SER BOOKANDUSERS
# LA VISTA DEBGERA TENER LAS SIGUENTES COLUMNAS BOOK_DETAIL, AUTOR_DETAIL
# EL ONJETIVO ES MOSTRARLOS LIBROS DOMDE CUYOS AUTORES SEAN DE NACIONALIDAD BOLIVIANA O ARGENTINA

CREATE OR REPLACE VIEW BookAndUsers as
select concat(book.title,'-',book.editorial,'-',CATEGORY.TYPE) as BOOK_DETAIL,
       concat(autor.name,'-',autor.nacionality) as AUTOR_DETAIL
FROM BOOK
INNER JOIN AUTOR ON book.id_autor = autor.id_autor
INNER JOIN CATEGORY ON book.id_book = category.id_book
WHERE AUTOR.nacionality='BOLIVIA'OR autor.nacionality='ARGENTINA';

SELECT * FROM bookandusers;
#////////////////////////////////////////////////////////
#////////   TRIGERS      ////////////////////////////
#///////////////////////////////////////////////////////

CREATE TABLE numeros
(
  numero BIGINT PRIMARY KEY NOT NULL,
  cuadrado BIGINT,
  cubo BIGINT,
  raizCuadrada REAL
);

INSERT INTO numeros(NUMERO) VALUES(2);

SELECT* FROM NUMEROS;


CREATE OR REPLACE TRIGGER TR_NUMEROS
    BEFORE INSERT ON NUMEROS
    FOR EACH ROW
    BEGIN
       DECLARE  ValorCuadrado INTEGER DEFAULT 0;
       DECLARE VALOR_CUBO INTEGER DEFAULT 0;
       DECLARE VALOR_RAIZ_CUADRADA REAL DEFAULT 0;

       SET ValorCuadrado= POW(NEW.NUMERO,2);
       SET VALOR_CUBO= POW(NEW.numero,3);
       SET VALOR_RAIZ_CUADRADA=SQRT(NEW.NUMERO);

       SET NEW.cuadrado=ValorCuadrado;
       SET NEW.cubo=VALOR_CUBO;
       SET NEW.raizCuadrada=VALOR_RAIZ_CUADRADA;
    END;

INSERT INTO numeros(NUMERO) VALUES(5);

SELECT* FROM NUMEROS;

CREATE TABLE AUDIT_CATEGORIA
(
   operation    CHAR(1)   NOT NULL, -- ('D', 'U', 'I')
   stamp        TIMESTAMP NOT NULL,
   userid       TEXT      NOT NULL,
   hostname     TEXT      NOT NULL,
   #columnas adicionales de la tabla AUTOR
   name         TEXT      NOT NULL,
   TYPE     TEXT      NOT NULL,
   ID_BOOK  TEXT      NOT NULL
);

CREATE OR REPLACE TRIGGER TR_AUDIT_CATEGORY
    BEFORE UPDATE ON category
    FOR EACH ROW
    BEGIN
        DECLARE TYPECAT TEXT DEFAULT '';
        DECLARE IDBOOKCAT TEXT DEFAULT '';

        SET TYPECAT=NEW.type;
        SET IDBOOKCAT= NEW.id_book;

        INSERT INTO  AUDIT_CATEGORIA(OPERATION, STAMP, USERID, HOSTNAME, TYPE, ID_BOOK)
            SELECT 'U',NOW(),USER(),@@HOSTNAME,TYPECAT,IDBOOKCAT;

    END;

SELECT* FROM AUDIT_CATEGORIA;