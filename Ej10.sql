create table
    nums (id int);

insert into nums values (4), (7), (5), (10), ();

delimiter //
-- Eliminamos la función sumatoriomal si ya existe, para evitar conflictos al crear una nueva
drop function if exists sumatoriomal//

-- Creamos la función sumatoriomal
create function sumatoriomal()
returns int
--solo lee datos y no los modifica y para coger los selects 
reads sql data

begin
    declare sumatorio int default 0; -- Variable para almacenar el sumatorio
    declare n int; -- Variable para almacenar el valor actual del cursor

    declare done boolean default false;-- Variable de control para el cursor
    -- Declaramos un cursor para seleccionar los valores de la columna id de la tabla nums
    declare c1 cursor for select id from nums;
    -- Declaramos un manejador para el final del cursor
    declare continue handler for SQLSTATE '02000' set done = true;

    -- Abrimos el cursor
    open c1;

    -- Bucle para recorrer el cursor
    c1_loop: loop
        -- Obtenemos el valor del cursor en la variable n
        --fetch coge la fila del select id from nums;
        fetch c1 into n;

        -- Si se alcanza el final del cursor, se sale del bucle
        if done then
            leave c1_loop;
        end if;
        
        -- Si el valor de n es par, se suma al sumatorio; 
        --si es impar, se resta del sumatorio
        if n % 2 = 0 then
            set sumatorio = sumatorio + n;
        else
            set sumatorio = sumatorio - n;
        end if;
    end loop c1_loop;
    close c1;

    return sumatorio;
end//

delimiter ;

--para mostrar el sumatorio
select sumatoriomal();
