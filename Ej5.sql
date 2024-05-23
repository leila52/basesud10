delimiter //

drop function if exists PAD//

-- Creamos la función `PAD` que toma cuatro parámetros:
-- `cadena` (la cadena de caracteres original a modificar),
-- `relleno` (la cadena de caracteres para rellenar),
-- `longitud` (la longitud total deseada de la cadena resultante),
-- `sentido` (el sentido del relleno, 'R' para derecha y 'L' para izquierda)
create function PAD (cadena varchar(100), relleno varchar(10), longitud int, sentido varchar(1))
returns varchar(200)
deterministic

begin
    -- Declaramos una variable para almacenar la cadena modificada y
    -- otra para calcular la longitud restante de relleno necesario
    declare cadena_modificada varchar(200);
    declare longitud_restante int default length(relleno);
    -- Inicializamos `cadena_modificada` con la cadena original
    set cadena_modificada = cadena;

    -- Si `sentido` es 'R' (rellenar a la derecha)
    if sentido = "R" then
    -- Mientras la longitud de `cadena_modificada` sea menor que la longitud deseada
        while length(cadena_modificada) < longitud do
            -- Si al agregar `relleno` se excede la longitud deseada,
            -- ajustamos `longitud_restante` para que se agregue solo lo necesario
            --cadena seria hola y relleno t en total 5 seria menor a 7
            if length(cadena_modificada) + length(relleno) > longitud then
                set longitud_restante = longitud - length(cadena_modificada);
            end if;
            -- Concatenamos `relleno` (o parte de él) a la derecha de `cadena_modificada`
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

 select PAD("hola","t", 6, "L");
+-------------------------+
| PAD("hola","t", 6, "L") |
+-------------------------+
| tthola                  |
+-------------------------+


select PAD("hola","x",7,"R");
+-----------------------+
| PAD("hola","x",7,"R") |
+-----------------------+
| holaxxx               |
+-----------------------+