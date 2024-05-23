create table
    fibo (
        posicion int,
        valor int,
        primary key (posicion, valor)
    );

-- -- -- -- -- -- -- -- -- --

/*Mirar solución versión con selects*/
/*Crear uno o varios procedimientos que reciba un número como
 parámetro de entrada. Insertará todos los números pertenecientes
  a la serie fibonacci en la tabla que sean menores al parámetro.*/

delimiter //

drop procedure if exists insertar_datos_fibonacci//

create procedure insertar_datos_fibonacci (n int)
begin
    declare n1 int default 1;
    declare n2 int default 1;
    declare n3 int;
    declare pos int default 0;

    -- Insertará todos los números pertenecientes a la serie fibonacci
    -- en la tabla que sean menores al parámetro.
    if n2 < n then
        insert into fibo values (pos, n1), (pos + 1, n2);
        set pos = pos + 2;  
    end if;

    insertar_pos_valor: loop
        set n3 = n1 + n2;

        if n3 >= n then
            leave insertar_pos_valor;
        end if;

        insert into fibo values (pos, n3);

        set n1 = n2;
        set n2 = n3;
        set pos = pos + 1;
    end loop;
end //

delimiter ;

call insertar_datos_fibonacci (104);

 select * from fibo;
+----------+-------+
| posicion | valor |
+----------+-------+
|        0 |     1 |
|        1 |     1 |
|        2 |     2 |
|        3 |     3 |
|        4 |     5 |
|        5 |     8 |
|        6 |    13 |
|        7 |    21 |
|        8 |    34 |
|        9 |    55 |
|       10 |    89 |
+----------+-------+