USE Food_services;

DROP PROCEDURE IF EXISTS getProductOptions;
DELIMITER $$
-- recibe un nombre de producto y retorna todas sus caracteristicas y opciones
CREATE PROCEDURE getProductOptions( pProduct VARCHAR(50))
BEGIN
	DECLARE INVALID_FUND INT DEFAULT(53000);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;

        IF (ISNULL(@message)) THEN -- excepcion forzada del programador
			SET @message = 'Error';            
        ELSE
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        ROLLBACK;
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;
	SET autocommit = 0;

	-- usa la vista de ProdNCharact
	select ProductName, `Description`, Price, PictureURL, Caracteristica, MaxSelection,
		   opt.`Name` Opcion, ExtraPrice        
	from ProdNCharact
	INNER JOIN CharacteristicOptions opt on opt.CharacteristicID = ProdNCharact.CharacteristicID
	inner join Pictures pic on pic.PictureID = ProdNCharact.PictureID
    where ProductName = pProduct;

END$$
DELIMITER ;

-- CALL getProductOptions ('Producto 13791322');
-- select * from Products;