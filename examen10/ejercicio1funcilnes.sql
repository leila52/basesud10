En una base de datos disponemos de la siguiente tabla con sus datos:
create table retrasos(
    codigo int,
    dias int
);
insert into retrasos values (1,10),(2,7),(3,15);
Se pide un programa que al recibir una fecha y un número, busque dicho número en la tabla retrasos como columna código, y el número indicado en dias se añada a la fecha, siendo esta nueva fecha lo que devuelva.
No entra en el ejercicio que no exista el código, si devuelve null se considera correcto.
Ejemplo de ejecución

Teniendo la tabla retrasos los datos antes insertados sin más cambios:
select * from retraso;
codigo 	dias
1 	10
2 	7
3 	15

select retraso("2024-05-01",1);
retraso("2024-05-01",1)
2024-05-11

select retraso("2024-05-01",2);
retraso("2024-05-01",2)
2024-05-08

select retraso("2024-05-01",3);
retraso("2024-05-01",3)
2024-05-16

Rúbrica

    Crea el programa adecuado para la tarea (0,5p).
    Recibe los parámetros necesarios son sus tipos correctos (0,3p).
    Selecciona el número de días de retraso de la tabla retrasos (0,4p)
    Suma los días de retraso a la fecha (0,4p)
    Devuelve el dato correcto (0,4p)


create table retrasos(
    codigo int,
    dias int
);

insert into retrasos values (1,10),(2,7),(3,15);

delimiter //
drop function if exists retraso//
create function retraso(fecha date, cod int)
returns date
reads sql data
begin
    declare ret int;
    select dias from retrasos where codigo = cod into ret;
    select date_add(fecha, interval ret day) into fecha;
    return fecha;
end //
delimiter ;

select retraso("2024-05-01",1);

select retraso("2024-05-01",2);

select retraso("2024-05-01",3);


