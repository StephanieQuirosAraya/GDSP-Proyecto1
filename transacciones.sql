use Food_services;

-- Transaction para agregar un producto ---------------------------
DROP PROCEDURE IF EXISTS addProducts;
DELIMITER $$

CREATE PROCEDURE addProducts 
(
	IN commerceName NVARCHAR(50), -- para buscar el commerceId
    IN pName NVARCHAR(50), -- niombre del producto
    IN pDescription NVARCHAR(50), -- descripcion del producto
    IN pPrice INT, -- costo del producto
    IN pAvailable BIT, -- Si esta disponible o no el producto
    IN pCatName NVARCHAR(50), -- nombre de la categoria del producto
	IN pPictureURL VARCHAR(128),-- el url de la imagen del producto
	OUT lastPictureURL BIGINT, -- id de la imagen del producto
	OUT lastProduct BIGINT -- id del producto a insertar
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
	
		INSERT INTO Products (`Name`, `Description`, Price, Available, 
		ProductCategoryID, PictureID)
		VALUES
		(pName, pDescription, pPrice, pAvailable, @ProductCategoryID,
		lastPictureURL);
		
		SELECT LAST_INSERT_ID() INTO lastProduct;
		
		INSERT INTO ProductsPerCommerce (ProductID, CommerceID)
		VALUES
		(lastProduct, @commerceId);
		
    COMMIT;
    
END$$
DELIMITER ;

-- agregarle caracteristicas a un producto -----------------------------------

DROP PROCEDURE IF EXISTS addCharacteristicProduct;
DELIMITER $$

CREATE PROCEDURE addCharacteristicProduct 
(
	cName NVARCHAR(50), -- nombre de la caracteristica
    cDescription NVARCHAR(200), -- descripcion de la caracteristica
    cMaxSelection TINYINT, -- max selection
    pCatName NVARCHAR(50), -- nombre de la categoria del producto para sacar el id
    cValue NVARCHAR(50), -- vaslor que contiene la caracteristica
    pName NVARCHAR(50), -- nombre del producto para sacar el id
    cOpName NVARCHAR(50), -- nombre de la caracteristica opcional
    cOpExtraPrice INT -- precio extra de la caracteristica opcional
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
	
	SET @ProductCategoryID = -1;
	SELECT IFNULL(ProductCategoryID, @ProductCategoryID) INTO @ProductCategoryID 
	FROM ProductCategories WHERE TRIM(`name`)=pCatName;

	IF (@ProductCategoryID=-1) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    END IF;
    
    SET @ProductID = -1;
	SELECT IFNULL(ProductID, @ProductID) INTO @ProductID FROM Products
	WHERE TRIM(`Name`)=pName;

	IF (@ProductID=-1) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    END IF;

	START TRANSACTION;
		INSERT INTO Characteristics (`Name`, `Description`, MaxSelection, @ProductCategoryID)
        VALUES
        (cName, cDescription, cMaxSelection, ProductCategoryID);
        
        SELECT LAST_INSERT_ID() INTO @CatID;
	
		INSERT INTO CharacteristicsPerProduct (`Value`, ProductID, CharacteristicID)
        VALUES
        (cValue, @ProductID, @CatID);
		
		INSERT INTO	CharacteristicOptions (`Name`, ExtraPrice, CharacteristicID)
        VALUES
        (cOpName, cOpExtraPrice, @CatID);
		
    COMMIT;
    
END$$
DELIMITER ;