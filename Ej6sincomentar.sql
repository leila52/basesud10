create table
    triggers (num int primary key, let varchar(20));

delimiter //

drop trigger if exists num_mayor_existentes//

create trigger num_mayor_existentes
before insert on triggers for each row

begin
    declare maximo_valor int default 0;
    select max(num) from triggers into maximo_valor;
    if new.num <= maximo_valor then
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El número a introducir debe ser mayor que el mayor de la tabla";
    end if;
end //

delimiter ;