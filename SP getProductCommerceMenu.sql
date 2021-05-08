USE Food_services;


DROP PROCEDURE IF EXISTS getProductCommerceMenu;
DELIMITER $$

CREATE PROCEDURE getProductCommerceMenu (
)
BEGIN
	-- crear un sistema de código errores 
	DECLARE INVALID_FUND INT DEFAULT(53000);

	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        
        IF (ISNULL(@message)) THEN -- quiere decir q es una excepcion forzada del programador
			SET @message = 'aqui saco el mensaje de un catalogo de mensajes que fue creado por equipo de desarrollo';            
        ELSE
            SET @message = CONCAT('Internal error: ', @message);
        END IF;
        
        ROLLBACK;
        
        RESIGNAL SET MESSAGE_TEXT = @message;
	END;

	SET autocommit = 0;

	SELECT * from CommerceNProducts;
    
    SELECT commer.`Name` CommerceName, Menu.`Name` MenuName, pictureURL MenuPicture FROM Commerces commer
    INNER JOIN (SELECT CommerceID, MenuT.`Name`, pictureURL FROM MenuTypes MenuT
    INNER JOIN MenusPerCommerce menu ON menu.MenuTypeID = MenuT.MenuTypeID
    INNER JOIN Pictures pict ON pict.PictureID = MenuT.PictureID) as Menu 
    ON Menu.CommerceID = commer.CommerceID;
    
END$$
DELIMITER ;

CALL getProductCommerceMenu();