En una base de datos disponemos de la siguiente tabla con sus datos:
create table duraciones(
    codigo int,
    salida time,
    llegada time
);
insert into duraciones values (1,"8:00","10:00"),(2,"7:30","11:15"),(3,"10:15","15:45");
Se pide un programa que reciba un código y una duración en minutos como retraso y consultando el tiempo en minutos que transcurre entre la salida y llegada del código dado, se le sume el segundo parámetro, devolviendo el número de minutos totales.
Ejemplo de ejecución

Teniendo la tabla duraciones los datos antes insertados sin más cambios:
select * from duraciones;
codigo 	salida       
	 llegada     
1 	08:00:00	10:00:00
2 	07:30:00	11:15:00
3 	10:15:00	15:45:00

select duracion(1,10);
duracion(1,10)
130

select duracion(2,0);
duracion(2,0)
225

select duracion(3,35);
duracion(3,35)
365



delimiter //
create function duracion(codigo_param int,retraso int)
returns int 
deterministic
begin
    declare duracion_total int;
    select TIMESTAMPDIFF(MINUTE, salida, llegada) INTO duracion_total
    from furaciones
    where codigo=codigo_param;

    set duracion_total=duracion_total+retraso;
    return duracion_total;
end//
delimiter;


