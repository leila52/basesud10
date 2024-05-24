delimiter //

drop trigger if exists actualizarpapeleria//
create trigger actualizarpapeleria
before delete on original for each row

begin

    declare cont int ;
    declare nombrepa varchar(30);
    select nombre from papelera into nombrepa;
    set cont=1;
    if old.nombre = nombrepa then
        cont=cont+1;
        insert into papelera
        values(old.id,old.nombre,cont);
    end if;
     insert into papelera
    values(old.id,old.nombre,cont);

end //

delimiter ;