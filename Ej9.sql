create table
    tab1 (a int, b int, primary key (a, b));

insert into
    tab1
values
    (4, 7),
    (1, 8),
    (-11, 9),
    (6, -3);

create table
    tab2 (a int);

delimiter //

drop procedure if exists agregar_datos_tab2_segun_tab1//
-- Creamos el procedimiento almacenado agregar_datos_tab2_segun_tab1
create procedure agregar_datos_tab2_segun_tab1()
begin
    --Declaramos variables
    declare acumulador int default 0;-- Acumulador para la columna b
    declare x int; -- Variable para la columna a
    declare y int; -- Variable para la columna b
    --estas tres lineas si o si
    declare done boolean default false;
    -- Declaramos un cursor para seleccionar las columnas a y b de tab1
    declare c1 cursor for select a, b from tab1;
    -- Declaramos un manejador para el final del cursor
    declare continue handler for SQLSTATE '02000' set done = true;

    -- Borramos los datos de tab2 antes de insertar nuevos datos
    delete from tab2;
    -- Abrimos el cursor
    open c1;
    -- Bucle para recorrer el cursor
    c1_loop: loop
        -- Obtenemos los valores del cursor en las variables x y y
        --fech es seleccionar fila
        fetch c1 into x, y;

        -- Si se alcanza el final del cursor, se sale del bucle
        if done then
            leave c1_loop;
        end if;
        -- Sumamos el valor de y al acumulador
        set acumulador = acumulador + y;

        -- Si x es un número par, insertamos el acumulador en tab2
        if x % 2 = 0 then
            insert into tab2 values (acumulador);
        end if;
    end loop c1_loop;
    close c1;
end //

delimiter ;


 select * from tab2;
Empty set (0.01 sec)

mysql> select * from tab1;
+-----+----+
| a   | b  |
+-----+----+
| -11 |  9 |
|   1 |  8 |
|   4 |  7 |
|   6 | -3 |
+-----+----+
4 rows in set (0.00 sec)

mysql> call agregar_datos_tab2_segun_tab1();
Query OK, 0 rows affected (0.03 sec)

mysql> select * from tab2;
+------+
| a    |
+------+
|   24 |
|   21 |
+------+