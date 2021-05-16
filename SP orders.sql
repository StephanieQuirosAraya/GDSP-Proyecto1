USE Food_services;

DROP PROCEDURE IF EXISTS getOrders;
DELIMITER $$

CREATE PROCEDURE getOrders (
	IN userName NVARCHAR(50)
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

	SELECT Carrito.users, orderID, TotalProducts, Cancelled, Carrito.PostTime, 
	   Carrito.`Name`, Price, TotalUnit, ClientInstructions
	FROM Orders 
    INNER JOIN (Select * FROM ProductNCarts) as Carrito ON Carrito.ShoppingCartID = Orders.ShoppingCartID
    WHERE Carrito.users = userName;
    
END$$
DELIMITER ;

-- CALL getOrders ('User5179');