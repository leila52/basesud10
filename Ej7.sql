En la base de datos banca, hemos de crear un trigger que cuando se inserte un nuevo movimiento, tendrá reflejo en la tabla cuentas, actualizando su saldo.
Ha de afectar a las nuevas inserciones, no ha de tener en cuenta los movimientos previos que había en la tabla movimiento.

delimiter //

drop trigger if exists actualizar_saldo_cuenta//
-- Creamos un trigger llamado actualizar_saldo_cuenta que se ejecutará 
--después de una operación de inserción en la tabla movimiento
create trigger actualizar_saldo_cuenta
after insert on movimiento for each row

begin
-- Actualizamos la tabla cuenta, sumando la cantidad del nuevo movimiento al saldo de la cuenta correspondiente
    update cuenta set saldo = saldo + new.cantidad where cod_cuenta = new.cod_cuenta;
end //

delimiter ;

insert into movimiento values (11111111, "2011-04-18", 1500, 57, 1);
insert into movimiento values (33333333, "2011-04-18", -3000, 58, 5);