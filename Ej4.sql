delimiter //

drop function if exists decimales//

-- Creamos la función `decimales` que toma dos parámetros:
-- `n` (el número decimal a formatear) y `num_decimales` (el número de decimales deseado)
create function decimales(n double, num_decimales int)
returns varchar(20)
deterministic  -- Indica que la función siempre devolverá el mismo resultado para los mismos parámetros


begin
    -- Declarar variables para almacenar partes del número
    declare numero varchar(20);
    declare parte_entera varchar(20);
    declare decimales varchar(20);

    -- Convertir el número de entrada 'n' a una cadena de caracteres
    set numero = cast(n as char(20));
    -- Extraer la parte entera del número antes del punto decimal
    set parte_entera = left(numero, locate(".", numero) - 1);
    -- Extraer la parte decimal del número después del punto decimal
    set decimales = right(numero, length(numero) - locate(".", numero));

    -- Si se especifica que no se necesitan decimales
    if num_decimales = 0 then
        -- Redondear el número y devolverlo como una cadena
        --cast cast es una función que convierte un valor de un tipo de datos a otro.
        -- En este código, cast se usa para convertir números a cadenas de caracteres (varchar):
        return cast(round(n) as char);
    else
        -- Si la longitud de la parte decimal es menor que el número de decimales deseado, o no hay decimales
        if length(decimales) < num_decimales or length(decimales) = 0 then
            -- rpad=Rellenar la parte entera con ceros hasta alcanzar el número de decimales deseado
            return rpad(numero, length(parte_entera) + 1 + num_decimales, "0");
        else 
            -- Redondear el número a los decimales especificados y devolverlo como una cadena           
            return cast(round(n, num_decimales) as char);
        end if;
    end if;    
end //

delimiter ;


--para ver si la funcion funciona haces select de la funcion
select decimales(4.544, 7);

--Ver las funciones de la bd
show function status where db = "ejercicios_ud10";