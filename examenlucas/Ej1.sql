/*Crea un programa llamado max3pol, que no recibe parámetros, y que inserte en la nueva tabla maxpolizas las tres pólizas de seguros más altas de cada marca de automóvil, de la base de datos vehículos. (Atención, puede tardar 5-20 segundos en ejecutarse).
Inicialmente deberá borrar datos de la tabla maxpolizas si tuviese, y después insertar una fila con cada marca y tres ceros. Después recorriendo todas las pólizas irá actualizando las tres pólizas más altas de cada marca de vehículo.
No todas las marcas tienen tres pólizas, por lo que algunas tienen uno, dos o hasta tres ceros.*/

Tabla maxpolizas
create table maxpolizas(
marca varchar(30), max1 int, max2 int, max3 int);

/*Rúbrica
- 0,6p Crea el programa adecuado.
- 0,3p Borra las filas de la tabla maxpolizas.
- 0,6p Inicializa la tabla maxpolizas con todos los departamentos y salarios a cero, borrando si había algo antes.
- 1,5p usa un cursor para recorrer todas las pólizas.
- 1p inserta los salarios más altos de cada departamento, sustituyendo a los anteriores.
- 1p funciona completamente.*/

/*Ejemplo de ejecución
El resultado al ejecutarse debe ser:*/

call max3pol();
Query OK, 0 rows affected (3,87 sec)
select * from maxpolizas;
marca	    max1	max2	max3
ABARTH	    547	    0	    0
ALFA ROMEO	0	    0	    0
ASTON MART	0	    0	    0
AUDI	    1800	1760	1683
BENTLEY	    1350	1350	900
BMW	        1800	1800	1500
…	        …	    …	    …
SEAT	    1622	1500	1500
SKODA	    1650	1650	1650
SMART	    845	    0	    0
SSANGYONG	1160	0	    0
SUBARU	    800	    600	    0
SUZUKI	    1500	1500	1000
TATA	    800	    600	    0
TOYOTA	    1650	1500	1500
VOLKSWAGEN	1800	1800	1800
VOLVO	    1800	1800	1800

-- -- -- -- -- -- -- -- -- --
-- -- -- -- -- -- -- -- -- --

create table
    maxpolizas (marca varchar(30), max1 int, max2 int, max3 int);

-- -- -- -- -- -- -- -- -- --

delimiter //

drop procedure if exists max3pol//

create procedure max3pol()
begin
    declare marca varchar(20);
    declare max1 int default 0;
    declare max2 int default 0;
    declare max3 int default 0;
    declare done boolean default false;
    declare c1 cursor for select distinct a.marca from automoviles a left join polizas p on a.matricula = p.matricula;
    declare continue handler for SQLSTATE '02000' set done = true;

    delete from maxpolizas;

    open c1;
    inicializar_tabla:loop
        fetch c1 into marca;

        if done then
            leave inicializar_tabla;
        end if;

        insert into maxpolizas values (marca, 0, 0, 0);
    end loop inicializar_tabla;
    close c1;

    open c1;
    actualizar_tabla:loop
        fetch c1 into marca;

        select cuantia from polizas where matricula in (select matricula from automoviles where marca = marca) into max1;

        if done then
            leave actualizar_tabla;
        end if;

        update maxpolizas set max1 = cuantia where marca = marca;
    end loop actualizar_tabla;
    close c1;
end //

delimiter ;

select p.cuantia from polizas p left join automoviles a on p.matricula = a.matricula where a.marca = "ASTON MART" order by p.cuantia desc limit 3;