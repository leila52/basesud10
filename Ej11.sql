create table
    nums2 (id int primary key);

delimiter //

drop procedure if exists LMAX//
-- Creamos el procedimiento almacenado LMAX
create procedure LMAX()
begin
    declare antecesor int default 0;-- Variable para almacenar el valor anterior del cursor
    declare actual int default 0; -- Variable para almacenar el valor actual del cursor
    declare predecesor int default 0; -- Variable para almacenar el valor previo al anterior del cursor


    --esto siempre siempre
    declare done boolean default false;
    declare c1 cursor for select id from nums;
    declare continue handler for SQLSTATE '02000' set done = true;

    -- Abrimos el cursor
    open c1;
    -- Bucle para recorrer el cursor
   c1_loop: loop
        -- Obtenemos el valor del cursor en la variable actual
        fetch c1 into actual;

        -- Si se alcanza el final del cursor, salimos del bucle
        if done then
            leave c1_loop;
        end if;

        -- Verificamos si actual es un máximo local
        if actual > antecesor and actual > predecesor then
            -- Insertamos el máximo local en la tabla nums2
            insert into nums2 values (actual);
        end if;

        -- Actualizamos los valores de antecesor y predecesor
        set predecesor = antecesor;
        set antecesor = actual;
    end loop c1_loop;

    -- Cerramos el cursor
    close c1; 
end//

delimiter ;


