-- Creamos la tabla nums2 con una columna id como clave primaria
create table nums2 (
    id int primary key
);

-- Definimos el delimitador para el procedimiento almacenado
delimiter //

-- Eliminamos el procedimiento maximolocal si ya existe
drop procedure if exists maximolocal//

-- Creamos el procedimiento almacenado maximolocal
create procedure maximolocal()
begin
    -- Declaramos las variables necesarias
    declare anterior int;
    declare actual int;
    declare siguiente int;
    declare done boolean default false;
    
    -- Declaramos un cursor para seleccionar los valores de la columna a de la tabla nums
    declare c1 cursor for select a from nums;
    
    -- Declaramos un manejador para el final del cursor
    declare continue handler for SQLSTATE '02000' set done = TRUE;
    
    -- Borramos los datos existentes de la tabla nums2
    delete from nums2;
    
    -- Abrimos el cursor
    open c1;
    
    -- Obtenemos el primer valor del cursor en la variable actual
    fetch c1 into actual;
    
    -- Mostramos el primer valor obtenido
    select actual;
    
    -- Establecemos un valor inicial para la variable anterior
    set anterior = 100; -- Esto parece un valor arbitrario, ¿debería ser otro valor?
    
    -- Mostramos el valor inicial de anterior
    select anterior;
    
    -- Iniciamos un bucle para recorrer el cursor
    c1_loop: LOOP
        -- Obtenemos el siguiente valor del cursor en la variable siguiente
        fetch c1 into siguiente;
        
        -- Mostramos el siguiente valor obtenido
        select siguiente;
        
        -- Si se alcanza el final del cursor, salimos del bucle
        if done then
            leave c1_loop;
        end if;
        
        -- Comparamos actual con siguiente y anterior para determinar si es un máximo local
        if actual > siguiente then
            if actual > anterior then
                -- Si es un máximo local, lo insertamos en la tabla nums2
                insert into nums2 values (actual);
            end if;
        end if;
        
        -- Actualizamos los valores de anterior y actual para la próxima iteración
        set anterior = actual;
        set actual = siguiente;
    end LOOP c1_loop;
    
    -- Comprobamos si el último valor es un máximo local y lo insertamos si es necesario
    if actual > anterior then
        insert into nums2 values (actual);
    end if;
    
    -- Cerramos el cursor
    close c1;
    
    -- Mostramos los resultados de la tabla nums2
    select * from nums2;
end//

-- Restauramos el delimitador predeterminado
delimiter ;
