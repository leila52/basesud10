DELIMITER //

CREATE PROCEDURE max3pol()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE marca_temp VARCHAR(30);
    DECLARE poliza_temp INT;
    DECLARE cur_polizas CURSOR FOR
        SELECT marca, poliza FROM vehiculos;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Borra los datos anteriores de la tabla maxpolizas
    DELETE FROM maxpolizas;
    
    -- Inserta una fila con cada marca y tres ceros
    INSERT INTO maxpolizas (marca, max1, max2, max3)
    SELECT DISTINCT marca, 0, 0, 0 FROM vehiculos;
    
    -- Abre el cursor para recorrer todas las pólizas
    OPEN cur_polizas;
    
    read_loop: LOOP
        FETCH cur_polizas INTO marca_temp, poliza_temp;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Actualiza las tres pólizas más altas de cada marca
        UPDATE maxpolizas
        SET max3 = CASE
                    WHEN poliza_temp > max1 THEN max2
                    WHEN poliza_temp > max2 THEN max3
                    WHEN poliza_temp > max3 THEN poliza_temp
                    ELSE max3
                   END,
            max2 = CASE
                    WHEN poliza_temp > max1 THEN max1
                    WHEN poliza_temp > max2 THEN poliza_temp
                    ELSE max2
                   END,
            max1 = CASE
                    WHEN poliza_temp > max1 THEN poliza_temp
                    ELSE max1
                   END
        WHERE marca = marca_temp;
    END LOOP;
    
    CLOSE cur_polizas;
END //

DELIMITER ;
