create database defensahito2;
use defensahito2;

CREATE TABLE autor
(
    id_autor    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name        VARCHAR(100),
    nacionality VARCHAR(50)
);

CREATE TABLE book
(
    id_book   INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    codigo    VARCHAR(25)                        NOT NULL,
    isbn      VARCHAR(50),
    title     VARCHAR(100),
    editorial VARCHAR(50),
    pages     INTEGER,
    id_autor  INTEGER,
    FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE category
(
    id_cat  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    type    VARCHAR(50),
    id_book INTEGER,
    FOREIGN KEY (id_book) REFERENCES book (id_book)
);

CREATE TABLE users
(
    id_user  INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    ci       VARCHAR(15)                        NOT NULL,
    fullname VARCHAR(100),
    lastname VARCHAR(100),
    address  VARCHAR(150),
    phone    INTEGER
);

CREATE TABLE prestamos
(
    id_prestamo    INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    id_book        INTEGER,
    id_user        INTEGER,
    fec_prestamo   DATE,
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

-- 1

select concat(u.fullname,' ',u.lastname) as Nombre_completo, u.ci as CI_User ,b.title as Libro_Prestado,c.type as Categoria
from users u
inner join prestamos p on u.id_user = p.id_user
inner join book b on p.id_book = b.id_book
inner join category c on b.id_book = c.id_book
where type = 'comedia' or type = 'manga';

-- 2

select Count(*), b.editorial, pages
from book b
inner join category c on b.id_book = c.id_book
where b.editorial = 'ibrani' and b.pages > 90;

create or replace function EJ2(editorial VARCHAR(100), pages int)  RETURNS varchar(1000)
    BEGIN
       RETURN (select Count( b.pages)
                      from users AS U
                   inner join prestamos p on U.id_user = p.id_user
                   inner join book b on p.id_book = b.id_book
                   where b.editorial = editorial
                 and b.pages > pages);

     END;

select EJ2('IBRANI', 90);

-- 3

create or replace function EJ3(editorial varchar(50),categoria varchar(50))  RETURNS varchar(200)
    BEGIN
       DECLARE EC varchar(200) default '';

            set EC = concat('EDITORIAL: ' ,editorial,', ','CATEGORIA: ',categoria);
            RETURN EC ;

     END;

select EJ3('ibrani','manga');

create or replace function EJ3_2(pages int)  RETURNS varchar(200)
    BEGIN
       DECLARE Pa varchar(100) DEFAULT '';

    if pages mod 2  = 0
       then
       set Pa = CONCAT('PAR : ', pages);
           else
         set Pa = CONCAT('IMPAR: ', pages);
       end if;
            RETURN Pa ;

     END;

select EJ3_2(90);

select EJ3(b.editorial,c.type)as DESCRIPTION, EJ3_2(b.pages)as PAGES
from users as u
inner join prestamos p on u.id_user = p.id_user
inner join book b on p.id_book = b.id_book
inner join category c on b.id_book = c.id_book
where editorial= 'IBRANI' and type = 'MANGA';

-- 4

create or replace function EJ2(editorial VARCHAR(100), pages int)  RETURNS varchar(1000)
    BEGIN
       RETURN (select Count( b.pages)
                      from users AS U
                   inner join prestamos p on U.id_user = p.id_user
                   inner join book b on p.id_book = b.id_book
                   where b.editorial = editorial
                 and b.pages > pages);

     END;

select count(*)
from prestamos as p
inner join book b on p.id_book = b.id_book
where year(fec_prestamo) = '2018'
