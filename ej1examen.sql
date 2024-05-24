delimiter //

drop function if exists duracion//

create function duracion (codigo int, retraso int)
returns int
reads sql data

begin
    declare duracion int default 0;
    declare salida1 int;
    declare llegada1 int;
    declare retraso1 int;
    declare done boolean default false;
    declare c1 cursor for select * from duraciones;
    declare continue handler for SQLSTATE '02000' set done = true;
    open c1;
    c1_loop: loop
        fetch c1 into codigo;
        if done then
            leave c1_loop;
        end if;

        set salida1= (date_format(salida,"%H")*60)+date_format(salida,"%i");
        set llegada1=(date_format(llegada,"%H")*60)+date_format(llegada,"%i");
        set retraso1=retraso;
        set duracion=(llegada1-salida1)+retraso1;
    end loop c1_loop;
    close c1;
    return duracion;

end //

delimiter ;



    declare c2 cursor for select concat((date_format(llegada,"%H")*60)+date_format(llegada,"%i")) as tiempollegada from duraciones;



select concat((date_format(salida,"%H")*60)+date_form(salida,"%i")) as tiemposalida,concat((date_format(llegada,"%H")*60)+date_form(llegada,"%i"))as tiempollegada from duraciones;


select concat((date_format(salida,"%H")*60)+date_format(salida,"%i")) as tiempo ,concat((date_format(llegada,"%H")*60)+date_format(llegada,"%i")) as tiempollegada from duraciones;






