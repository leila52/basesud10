reate table nums(a int);
insert into nums values(4), (7), (1), (8), (-23), (12), (-8);

delimiter //
drop function if exists sumamal()//
create function sumamal()
returns int
reads sql data
begin
declare acumulador int default 0;
declare x int default 0;

declare done boolean default false;
declare c cursor for select a from nums;
declare continue handler for SQLSTATE '02000' set done = TRUE;
open c;

c_loop: LOOP
    fetch c into x;
    if done then
        leave c_loop;
    end if;
    if (x % 2 = 0) then
        set acumulador = acumulador + x;
    else
        set acumulador = acumulador - x;
    end if;
end LOOP c_loop;
close c;
return acumulador;
end //
delimiter ;