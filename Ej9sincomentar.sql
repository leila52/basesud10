create table
    tab1 (a int, b int, primary key (a, b));

insert into
    tab1
values
    (4, 7),
    (1, 8),
    (-11, 9),
    (6, -3);

create table
    tab2 (a int);

delimiter //

drop procedure if exists agregar_datos_tab2_segun_tab1//

create procedure agregar_datos_tab2_segun_tab1()
begin
    declare acumulador int default 0;
    declare x int;
    declare y int;

    declare done boolean default false;
    declare c1 cursor for select a, b from tab1;
    declare continue handler for SQLSTATE '02000' set done = true;

    delete from tab2;

    open c1;
    c1_loop: loop
        fetch c1 into x, y;

        if done then
            leave c1_loop;
        end if;
        
        set acumulador = acumulador + y;

        if x % 2 = 0 then
            insert into tab2 values (acumulador);
        end if;
    end loop c1_loop;
    close c1;
end //

delimiter ;

call agregar_datos_tab2_segun_tab1();