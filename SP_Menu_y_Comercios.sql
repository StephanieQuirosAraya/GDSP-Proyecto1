USE Food_services;

DROP PROCEDURE IF EXISTS getCommerceOfMenu;
DELIMITER $$
-- recibe el nombre del tipo de menu, retorna los restaurantes de ese tipo
CREATE PROCEDURE getCommerceOfMenu ( pMenu VARCHAR(50) )
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

	-- usa la vista de comNloc
	select menu.`Name` MenuType, CommerceName, PictureURL, Address, Latitude, Longitude, StartTime, EndTime
    from MenuTypes menu
    INNER JOIN (
		select comNloc.CommerceName, PictureURL, Address, Latitude, Longitude, StartTime, EndTime, MenuTypeID
        from comNloc
		INNER JOIN MenusPerCommerce menXcom ON menXcom.CommerceID = comNloc.CommerceID
    ) as comInfo ON comInfo.MenuTypeID = menu.MenuTypeID
    where menu.`Name` = pMenu;

END$$
DELIMITER ;

-- CALL getCommerceOfMenu ("Americana"); 
-- select * from MenuTypes;