En una base de datos disponemos de estas dos tablas:
create table original( id int, nombre varchar(20));
create table papelera( id int, nombre varchar(20), numero int);
insert into original values (1,"Piedra"),(2,"Metal"),(3,"Papel"),(4,"Bronce"),(5,"Madera");

Se necesita que cada vez que se borre una fila de la tabla original:

    Si no hay una fila con el mismo nombre en la tabla papelera se inserta, con el mismo id y nombre, y número a 0.
    Si ya hay una fila con el mismo nombre en la tabla papelera, se incrementa el número.

Ejemplo de ejecución

Papelera está inicialmente vacía.
select * from original;
id 	nombre
1 	Piedra
2 	Metal
3 	Papel
4 	Bronce
5 	Madera

delete  from original where id = 2;
select * from papelera;
id 	nombre 	numero
2 	Metal 	1
insert into original values (6,"Metal");
delete from original where id >3;
select * from papelera;
id 	nombre 	numero
2 	Metal 	2
4 	Bronce 	1
5 	Madera 	1

Rúbrica

    Crea el programa adecuado para la tarea (0,6p).
    Activación correcta del programa (0,4p).
    Detecta si hay filas en la tabla papelera (0,8p)
    Inserta en papelera si no hay filas. (0,6p)
    Actualiza si hay filas. (0,6p)





DELIMITER //

drop trigger if exists after_delete_original//
CREATE TRIGGER after_delete_original
AFTER DELETE ON original
FOR EACH ROW
BEGIN
    DECLARE num_rows INT;
    SELECT COUNT(*) INTO num_rows FROM papelera WHERE nombre = OLD.nombre;
    
    IF num_rows = 0 THEN
        INSERT INTO papelera (id, nombre, numero) VALUES (OLD.id, OLD.nombre, 1);
    ELSE
        UPDATE papelera
        SET numero = numero + 1
        WHERE nombre = OLD.nombre;
    END IF;
END;
//

DELIMITER ;
