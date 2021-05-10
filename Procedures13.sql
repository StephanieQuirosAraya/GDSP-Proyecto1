
CREATE TEMPORARY TABLE IF NOT EXISTS temporaryCart(
 TotalProducts tinyint
, PostTime DATETIME
, Cancelled BIT
, UserName NVARCHAR(50)
, commerceName NVARCHAR(50));

INSERT INTO temporaryCart(CartId, TotalProducts, PostTime, Cancelled, UserId, CommerceId)
VALUES(1111, 2, date(), 1, 1111, 1);


DROP PROCEDURE IF EXISTS acc_registerProduct;
DELIMITER $$

CREATE PROCEDURE acc_addShopingCart
(
	IN TotalProducts tinyint, -- para buscar el commerceId
    IN PostTime DATETIME,
    IN Cancelled BIT, -- niombre del producto
    IN UserName NVARCHAR(50),
    IN commerceName NVARCHAR(50) -- descripcion del producto
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
	
    SET @commerceId = -1;
	SELECT IFNULL(commerceId, @commerceId) INTO @commerceId FROM Commerces com
	WHERE TRIM(`Name`)=commerceName;

	IF (@commerceId=-1) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    END IF;
	
	SET @ProductCategoryID = -1;
	SELECT IFNULL(ProductCategoryID, @ProductCategoryID) INTO @ProductCategoryID 
	FROM ProductCategories WHERE TRIM(`name`)=pCatName;

	IF (@ProductCategoryID=-1) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    END IF;

	START TRANSACTION;
		WHILE contador 
		
    COMMIT;
    
END$$
DELIMITER ;








