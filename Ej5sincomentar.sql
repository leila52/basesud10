delimiter //

drop function if exists PAD//

create function PAD (cadena varchar(100), relleno varchar(10), longitud int, sentido varchar(1))
returns varchar(200)
deterministic

begin
    declare cadena_modificada varchar(200);
    declare longitud_restante int default length(relleno);
    set cadena_modificada = cadena;


    if sentido = "R" then
        while length(cadena_modificada) < longitud do
            if length(cadena_modificada) + length(relleno) > longitud then
                set longitud_restante = longitud - length(cadena_modificada);
            end if;
            set cadena_modificada = concat(cadena_modificada, left(relleno, longitud_restante));
        end while;
    end if;

    if sentido = "L" then
        while length(cadena_modificada) < longitud do
            if length(cadena_modificada) + length(relleno) > longitud then
                set longitud_restante = longitud - length(cadena_modificada);
            end if;
            set cadena_modificada = concat(right(relleno, longitud_restante), cadena_modificada);
        end while;
    end if;


    return cadena_modificada;
end //

delimiter ;