delimiter //

drop function if exists decimales//

create function decimales(n double, num_decimales int)
returns varchar(20)
deterministic

begin
    declare numero varchar(20);
    declare parte_entera varchar(20);
    declare decimales varchar(20);

    set numero = cast(n as char(20));
    set parte_entera = left(numero, locate(".", numero) - 1);
    set decimales = right(numero, length(numero) - locate(".", numero));

    if num_decimales = 0 then
        return cast(round(n) as char);
    else
        if length(decimales) < num_decimales or length(decimales) = 0 then
            return rpad(numero, length(parte_entera) + 1 + num_decimales, "0");
        else            
            return cast(round(n, num_decimales) as char);
        end if;
    end if;    
end //

delimiter ;

--Ver las funciones de la bd
show function status where db = "ejercicios_ud10";