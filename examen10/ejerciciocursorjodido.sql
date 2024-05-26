Crea un programa llamado max3pol, que no recibe parámetros, y que inserte en la nueva tabla maxpolizas las tres pólizas de seguros más altas de cada marca de automóvil, de la base de datos vehículos. (Atención, puede tardar 5-20 segundos en ejecutarse).

Inicialmente deberá borrar datos de la tabla maxpolizas si tuviese, y después insertar una fila con cada marca y tres ceros. Después recorriendo todas las pólizas irá actualizando las tres pólizas más altas de cada marca de vehículo.

No todas las marcas tienen tres pólizas, por lo que algunas tienen uno, dos o hasta tres ceros.
Tabla maxpolizas

create table maxpolizas(
marca varchar(30),
max1 int,
max2 int,
max3 int);
Rúbrica

    0,6p Crea el programa adecuado.
    0,3p Borra las filas de la tabla maxpolizas.
    0,6p Inicializa la tabla maxpolizas con todos los departamentos y salarios a cero, borrando si había algo antes.
    1,5p usa un cursor para recorrer todas las pólizas.
    1p inserta los salarios más altos de cada departamento, sustituyendo a los anteriores.
    1p funciona completamente.

Ejemplo de ejecución

El resultado al ejecutarse debe ser:

call max3pol();

Query OK, 0 rows affected (3,87 sec)

select * from maxpolizas;
marca 	max1 	max2 	max3
ABARTH 	547 	0 	0
ALFA ROMEO 	0 	0 	0
ASTON MART 	0 	0 	0
AUDI 	1800 	1760 	1683
BENTLEY 	1350 	1350 	900
BMW 	1800 	1800 	1500
… 	… 	… 	…
SEAT 	1622 	1500 	1500
SKODA 	1650 	1650 	1650
SMART 	845 	0 	0
SSANGYONG 	1160 	0 	0
SUBARU 	800 	600 	0
SUZUKI 	1500 	1500 	1000
TATA 	800 	600 	0
TOYOTA 	1650 	1500 	1500
VOLKSWAGEN 	1800 	1800 	1800
VOLVO 	1800 	1800 	1800
Total 57 filas



drop table if exists maxpolizas;
create table maxpolizas(
marca varchar(30),
max1 int,
max2 int,
max3 int);

delimiter //
drop procedure if exists max3pol;
create procedure max3pol()
begin
    declare pol, maxp1,maxp2,maxp3 int;
    declare mar, marca2 varchar(40);
    declare done boolean default false;
    declare c1 cursor for select a.marca, p.cuantia from automoviles a join polizas p on a.matricula = p.matricula;
    declare continue handler for SQLSTATE '02000' set done=true;

    delete from maxpolizas;
    insert into maxpolizas select distinct marca,0,0,0 from automoviles;

    open c1;
    c1_loop: loop
        fetch c1 into mar, pol;
        if done then
            leave c1_loop;
        end if;
        select max1, max2, max3 from maxpolizas where marca = mar into maxp1,maxp2,maxp3;
        if pol > maxp1 then
            update maxpolizas set max1 = pol where marca = mar;
            update maxpolizas set max2 = maxp1 where marca = mar;
            update maxpolizas set max3 = maxp2 where marca = mar;
        else
            if pol > maxp2 then
            update maxpolizas set max2 = pol where marca = mar;
            update maxpolizas set max3 = maxp2 where marca = mar;
            else
                if pol > maxp3 then
                    update maxpolizas set max3 = pol where marca = mar;
                end if;
            end if;
        end if;

    end loop c1_loop;
    close c1;
end //
delimiter ;

