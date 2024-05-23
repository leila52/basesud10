create table
    fibo (
        posicion int,
        valor int,
        primary key (posicion, valor)
    );

-- -- -- -- -- -- -- -- -- --

/*Mirar solución versión con selects*/

delimiter //

drop procedure if exists insertar_datos_fibonacci//

create procedure insertar_datos_fibonacci (n int)
begin
    declare n1 int default 1;
    declare n2 int default 1;
    declare n3 int;
    declare pos int default 0;

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