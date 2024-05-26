Crear un trigger para la base de datos teléfonos que impida insertar una llamada si se da uno de estos dos casos.

    Que un número se llame a sí mismo.
    Que la llamada comience después de terminar.

En los dos casos impedirá que se inserte, pero en cada caso mostrará un mensaje de error con la razón que no cumple.

Rúbrica

    (0,5p) Se crea el programa adecuado
    (0,5p) Se ejecuta cada vez que se inserta en la tabla llamada.
    (0,3p) Comprueba el remitente y el destinatario.
    (0,3p) Impide insertar si ambos números son el mismo.
    (0,1p) En tal caso muestra el mensaje: Un número no puede llamarse a sí mismo
    (0,3p) Comprueba las horas de inicio y finalización.
    (0,3p) Impide insertar si la llamada empieza después de terminar.
    (0,1p) En tal caso muestra el mensaje: La llamada no puede empezar después de terminar
    (0,6p) funciona completamente.

    Ejemplo de ejecución

El resultado al ejecutarse debe ser:

insert into llamada values (620020200,620020200,"2022-01-01 11:10:10","2022-01-01 11:15:10");

ERROR 1644 (45000): Un número no puede llamarse a sí mismo

insert into llamada values (620020202,620020200,"2022-01-01 11:10:10","2022-01-01 11:15:10");

Query OK, 1 row affected (0,15 sec)

insert into llamada values (620020203,620020200,"2022-01-01 11:20:10","2022-01-01 11:15:10");

ERROR 1644 (45000): La llamada no puede empezar después de terminar

insert into llamada values (620020203,620020200,"2022-01-01 11:20:10","2022-01-01 11:25:10");

Query OK, 1 row affected (0,02 sec)

Para dejar el estado de la BD como estaba antes, además de poderse usar transacciones, se puede ejecutar las dos siguientes sentencias:
delete from llamada where numerorem = 620020202 and numerodes = 620020200 and finicio ="2022-01-01 11:10:10";
delete from llamada where numerorem = 620020203 and numerodes = 620020200 and finicio ="2022-01-01 11:20:10";



solucion:

drop trigger if exists errorllamadas;
delimiter //
create trigger errorllamadas
before insert on llamada
for each row
begin
    if new.numerorem = new.numerodes then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Un número no puede llamarse a sí mismo';
    end if;
    if new.finicio > new.ffin then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La llamada no puede empezar después de terminar';
    end if;

end//


insert into llamada values (620020200,620020200,"2022-01-01 11:10:10","2022-01-01 11:15:10");

insert into llamada values (620020202,620020200,"2022-01-01 11:10:10","2022-01-01 11:15:10");

insert into llamada values (620020203,620020200,"2022-01-01 11:20:10","2022-01-01 11:15:10");

insert into llamada values (620020203,620020200,"2022-01-01 11:20:10","2022-01-01 11:25:10");

delete from llamada where numerorem = 620020202 and numerodes = 620020200 and finicio ="2022-01-01 11:10:10";

delete from llamada where numerorem = 620020203 and numerodes = 620020200 and finicio ="2022-01-01 11:20:10";