delimiter //

drop procedure if exists insertar_numeros_inferiores//

create procedure insertar_numeros_inferiores (n int) 
begin
    declare i int default 0;
    
    insertar_numero: loop
        set i = i + 1;
        
        if i >= n then
            leave insertar_numero;
        end if;

        call insertar_numero(i);
    end loop;
end //

delimiter ;