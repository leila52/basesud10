create table
    nums2 (id int primary key);

delimiter //

drop procedure if exists LMAX//

create procedure LMAX()
begin
    declare antecesor int default 0;
    declare actual int default 0;
    declare predecesor int default 0;

    declare done boolean default false;
    declare c1 cursor for select id from nums;
    declare continue handler for SQLSTATE '02000' set done = true;

    open c1;
    c1_loop: loop
        fetch c1 into actual;

        if done then
            leave c1_loop;
        end if;

        if actual > antecesor and actual > predecesor then
            insert into nums2 values (actual);
            set antecesor = actual;
            set actual = predecesor;
            set predecesor = 0;
        end if;
    end loop c1_loop;
    close c1; 
end//

delimiter ;