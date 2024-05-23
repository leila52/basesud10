create table
    triggers (num int primary key, let varchar(20));

delimiter //

drop trigger if exists num_mayor_existentes//
-- Creamos un trigger llamado num_mayor_existentes que se ejecutará antes
-- de una operación de inserción en la tabla triggers
create trigger num_mayor_existentes
before insert on triggers for each row

begin
-- Declaramos una variable para almacenar el valor máximo actual de la columna num en la tabla triggers
    declare maximo_valor int default 0;
    -- Seleccionamos el valor máximo de la columna num de la tabla triggers y lo almacenamos en la variable maximo_valor
    select max(num) from triggers into maximo_valor;
    -- Si el nuevo valor de num a insertar (new.num) es menor o igual al valor máximo actual
    if new.num <= maximo_valor then
        -- Generamos un error y mostramos un mensaje indicando que el número debe ser mayor que el mayor de la tabla
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El número a introducir debe ser mayor que el mayor de la tabla";
    end if;
end //

delimiter ;

insert into triggers (num, let) values (1, 'segundo');
mysql> insert into triggers (num, let) values (2, 'segundo');

mysql> select * from triggers;
+-----+---------+
| num | let     |
+-----+---------+
|   1 | segundo |
|   2 | segundo |
+-----+---------+
mysql> insert into triggers (num, let) values (1, 'segundo');
ERROR 1644 (45000): El número a introducir debe ser mayor que el mayor de la tabla
mysql> insert into triggers (num, let) values (4, 'cuarto');
Query OK, 1 row affected (0.00 sec)

mysql> insert into triggers (num, let) values (2, 'cuarto');
ERROR 1644 (45000): El número a introducir debe ser mayor que el mayor de la tabla
mysql> insert into triggers (num, let) values (3, 'cuarto');
ERROR 1644 (45000): El número a introducir debe ser mayor que el mayor de la tabla