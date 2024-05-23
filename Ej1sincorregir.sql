create database ejercicios_ud10;

use ejercicios_ud10;

create table
    par (numero int);

create table
    impar (numero int);

-- -- -- -- -- -- -- -- -- --

delimiter //

drop procedure if exists insertar_numero//

create procedure insertar_numero (n int) 
begin 
    if n % 2 = 0 then
        insert into par values (n);
    else
        insert into impar values (n);
    end if;
end //

delimiter ;

--Usar el procedimiento
call insertar_numero(3);

--Ver los procedimientos de la bd
show procedure status where db = "ejercicios_ud10";