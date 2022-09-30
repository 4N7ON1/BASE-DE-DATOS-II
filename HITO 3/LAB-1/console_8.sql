create database Hito3;
use Hito3;

set @admin = 'ADMIN';
select @admin;

set @admin = 'Gustavo';

create or replace function ejmplo() returns varchar(50)
begin
    declare respuesta varchar(50) default '';
    if @admin = 'Admin'
    then
        set respuesta ='Usuario Admin';
    else
        set respuesta = 'Usuario Invitado';
    end if;
    return respuesta;
end;
select ejmplo();

create or replace function ejmplo_v2() returns varchar(50)
begin
    declare respuesta varchar(50) default '';
    case
        when @admin = 'Admin' then set respuesta = 'Usuario Admin';
        when @admin = 'Guest' then set respuesta = 'Usuario Invitado';
        else set respuesta = 'Usuario Nuevo';
    end case;
    return respuesta;
end;

select ejmplo_v2();

set @admin = 'Guest';

-- crear una variable global de nombre precio
-- creae na funcion que maneje case
--  si el precio es mayor a 10 y memor igual a 20 retornar el mensaje basico
--  si el precio es mayor a 20 y memor igual a 30 retornar el mensaje intermedio
--  si el precio es mayor a 30 y memor igual a 50 retornar el mensaje superior
--  si el precio es mayor a 50  retorna el mernsaje carrisimo

set @precio = 15;
set @precio = 200;
set @precio = 30;
set @precio = 60;

create or replace function precio() returns varchar(50)
begin
    declare respuesta varchar(50) default '';
    case
        when @precio >10 and  @precio <=20 then set respuesta = 'Basico';
        when @precio >20 and @precio <=30 then set respuesta = 'Intermedio';
        when @precio >30 and @precio <=50 then set respuesta = 'Superior';
        when @precio >50 then set respuesta = 'Carisimo';
        else set respuesta = 'Precio Nuevo';
    end case;
    return respuesta;
end;

select precio();

-- crear una funcion que reciba un parametro integer
--  la funcion debe retornar un texto TEXT como respuesta
-- el parametro es un valor numerico credit number
-- si es mayor a 50000 es PlATINIUM
-- si es mayor igual a 10000 y menor igual a 50000 es GOLD
-- si es menor a 10000 es SILVER
-- la funvcion debe retornar indicando si ese cliente es PLANTINIUM, GOLD o SILVER en base  al valor del credit_numnber


set @Credit_Number = 15000;


create or replace function precio() returns varchar(50)
begin
    declare respuesta varchar(50) default '';
    case
        when @Credit_Number >50000  then set respuesta = 'PLATINIUM';
        when @Credit_Number >=10000 and @Credit_Number <=50000 then set respuesta = 'Gold';
        when @Credit_Number <10000 then set respuesta = 'Silver';
        else set respuesta = 'Precio Nuevo';
    end case;
    return respuesta;
end;

select precio();

-- bucle para numeros primos

create or replace function numbers(limitWhile integer) returns text
begin
    declare x integer default! 1;
    declare str text default '';

      while x <= limitWhile do
          set str = concat(str, x , ',');
          set x = x + 1;
          end while;
    return str;
end;

select numbers(10);