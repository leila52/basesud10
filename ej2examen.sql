DELIMITER //

CREATE TRIGGER after_delete_original
AFTER DELETE ON original
FOR EACH ROW
BEGIN
    DECLARE num_rows INT;
    
    -- Verificar si el nombre de la fila eliminada existe en la tabla papelera
    SELECT COUNT(*) INTO num_rows FROM papelera WHERE nombre = OLD.nombre;
    
    -- Si no hay filas con el mismo nombre en la tabla papelera, insertar con número 0
    IF num_rows = 0 THEN
        INSERT INTO papelera (id, nombre, numero) VALUES (OLD.id, OLD.nombre, 0);
    ELSE
        -- Si ya hay filas con el mismo nombre, incrementar el número
        UPDATE papelera
        SET numero = numero + 1
        WHERE nombre = OLD.nombre;
    END IF;
END;
//

DELIMITER ;


DELIMITER//
create trigger after_felete
after delete on original
fro each row
begin
    declare num_filas int;
    SELECTcount(*) into num_filas from papelera where nombre=old.nombre;
    if num_filas=0 then
        insert into papelerea(id,nombre,numero) values(old.id,old.nombre,0);
    else
        update papelera set numero = numero + 1 where nombre=old.nombre;
    end if;
end//
delimiter;