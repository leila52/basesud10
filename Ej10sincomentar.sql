create table
    nums (id int auto_increment primary key);

insert into nums values (2), (5), (9), (20), ();

delimiter //

drop function if exists sumatoriomal//

create function sumatoriomal()
returns int
reads sql data

begin
    declare sumatorio int default 0;
    declare n int;

    declare done boolean default false;
    declare c1 cursor for select id from nums;
    declare continue handler for SQLSTATE '02000' set done = true;

    open c1;
    c1_loop: loop
        fetch c1 into n;

        if done then
            leave c1_loop;
        end if;
        
        if n % 2 = 0 then
            set sumatorio = sumatorio + n;
        else
            set sumatorio = sumatorio - n;
        end if;
    end loop c1_loop;
    close c1;

    return sumatorio;
end//

delimiter ;