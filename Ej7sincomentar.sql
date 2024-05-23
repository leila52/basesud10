delimiter //

drop trigger if exists actualizar_saldo_cuenta//

create trigger actualizar_saldo_cuenta
after insert on movimiento for each row

begin
    update cuenta set saldo = saldo + new.cantidad where cod_cuenta = new.cod_cuenta;
end //

delimiter ;

insert into movimiento values (11111111, "2011-04-18", 1500, 57, 1);
insert into movimiento values (33333333, "2011-04-18", -3000, 58, 5);