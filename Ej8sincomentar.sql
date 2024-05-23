delimiter //

drop trigger if exists actualizar_saldo_cuenta_con_beneficios//

create trigger actualizar_saldo_cuenta_con_beneficios
after insert on movimiento for each row

begin
    declare fecha_creacion_cuenta date;
    declare antiguedad_cuenta int;

    select fecha_creacion from cuenta where cod_cuenta = new.cod_cuenta into fecha_creacion_cuenta;
    set antiguedad_cuenta = timestampdiff(year, fecha_creacion_cuenta, new.fechahora);

    if new.cantidad > 1000 and antiguedad_cuenta > 2 and new.fechahora between "2012-01-01" and "2012-03-31" then
        update cuenta set saldo = saldo + new.cantidad + 100 where cod_cuenta = new.cod_cuenta;
    else
        update cuenta set saldo = saldo + new.cantidad where cod_cuenta = new.cod_cuenta;
    end if;
end //

delimiter ;

-- Inserts que no cumplen las condiciones
insert into movimiento values (11111111, "2012-03-18", 1500, 59, 1);
insert into movimiento values (55555555, "2011-04-18", -3000, 61, 5);

-- Insert que cumple las condiciones
insert into movimiento values (33333333, "2012-02-29", 1500, 60, 3);