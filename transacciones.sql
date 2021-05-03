
DROP PROCEDURE IF EXISTS modifyOrAddProducts;
DELIMITER $$

CREATE PROCEDURE modifyOrAddProducts --Products por comercio y productsx4
(
	commerceName NVARCHAR(50), -- para buscar el commerceId
    pName NVARCHAR(50), -- niombre del producto
    pDescription NVARCHAR(50), -- descripcion del producto
    pPrice INT, -- costo del producto
    pAviable BIT, -- Si esta disponible o no el producto
    pCatName NVARCHAR(50), -- nombre de la categoria del producto
	pPictureURL VARCHAR(128),-- el url de la imagen del producto
	lastPictureURL BIGINT, -- id de la imagen del producto
	lastProduct BIGINT -- id del producto a insertar
	-- caracteristicas serian mejor hacerlas en otro SP para 
	-- hacerlas dentro de un while y 
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
	INNER JOIN CommerceTypes comType ON com.CommerceTypesID = comType.CommerceTypesID
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
		INSERT INTO Pictures (PictureURL)
		VALUES
		(pPictureURL);
		
		SELECT LAST_INSERT_ID() INTO lastPictureURL;
	
		INSERT INTO Products (Name, Description, Price, Aviable, 
		ProductCategoryID, PictureID)
		VALUES
		(pName, pDescription, pPrice, pAviable, @ProductCategoryID,
		lastPictureURL);
		
		SELECT LAST_INSERT_ID() INTO lastProduct;
		
		INSERT INTO ProductsPerCommerce (ProductID, CommerceID)
		VALUES
		(lastProduct, @commerceId);
		
    COMMIT;
    
END$$
DELIMITER ;


call acc_registerTransaction('credit', 'casa', 
40000.00, NULL, 'BAC', 2, @lastId, @balance);