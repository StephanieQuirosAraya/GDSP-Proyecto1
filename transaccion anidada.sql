USE Food_services;

DROP PROCEDURE IF EXISTS addMenu;
DELIMITER $$

 CREATE PROCEDURE addMenu 
(
	IN commerceName NVARCHAR(50), -- para buscar el commerceId
    IN menuName NVARCHAR(50), -- nombre del menu
    IN pictureMenu VARCHAR(128), -- Imagen del menu
    IN pName NVARCHAR(50), -- niombre del producto
    IN pDescription NVARCHAR(50), -- descripcion del producto
    IN pPrice INT, -- costo del producto
    IN pAvailable BIT, -- Si esta disponible o no el producto
    IN pCatName NVARCHAR(50), -- nombre de la categoria del producto
	IN pPictureURL VARCHAR(128), -- el url de la imagen del producto
    IN cName NVARCHAR(50), -- nombre de la caracteristica
    IN cDescription NVARCHAR(200), -- descripcion de la caracteristica
    IN cMaxSelection TINYINT, -- max selection
    IN cValue NVARCHAR(50), -- vaslor que contiene la caracteristica
    IN cOpName NVARCHAR(50), -- nombre de la caracteristica opcional
    IN cOpExtraPrice INT -- precio extra de la caracteristica opcional
)
BEGIN
	-- crear un sistema de código errores 
	-- DECLARE INVALID_FUND INT DEFAULT(53000);

	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION
	-- BEGIN
		-- GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        
        -- IF (ISNULL(@message)) THEN -- quiere decir q es una excepcion forzada del programador
			-- SET @message = 'aqui saco el mensaje de un catalogo de mensajes que fue creado por equipo de desarrollo';            
        -- ELSE
            -- SET @message = CONCAT('Internal error: ', @message);
        -- END IF;
        
        -- ROLLBACK;
        
        -- RESIGNAL SET MESSAGE_TEXT = @message;
	-- END;

	SET autocommit = 0;
	
    SET @commerceId = -1;
	SELECT IFNULL(CommerceID, @commerceId) INTO @commerceId FROM Commerces com
	WHERE TRIM(`Name`)=commerceName;

	-- IF (@commerceId=-1) THEN
		-- SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    -- END IF;
    
	START TRANSACTION;	
		INSERT INTO Pictures (PictureURL)
		VALUES
		(pictureMenu);
		
		SELECT LAST_INSERT_ID() INTO @PictureID;
	
		INSERT INTO MenuTypes (`Name`, PictureID)
		VALUES
		(menuName, @PictureID);
		
		SELECT LAST_INSERT_ID() INTO @MenuTypeID;
	
		INSERT INTO MenusPerCommerce (CommerceID, MenuTypeID)
		VALUES
		(@commerceId, @MenuTypeID);
    
    CALL addProductsT (commerceName, pName, pDescription, pPrice, pAvailable, 
    pCatName, pPictureURL, cName, cDescription, cMaxSelection, 
    cValue, cOpName, cOpExtraPrice);
    
    COMMIT;
    
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS addProductsT;
DELIMITER $$

CREATE PROCEDURE addProductsT
(
	IN commerceName NVARCHAR(50), -- para buscar el commerceId
    IN pName NVARCHAR(50), -- niombre del producto
    IN pDescription NVARCHAR(50), -- descripcion del producto
    IN pPrice INT, -- costo del producto
    IN pAvailable BIT, -- Si esta disponible o no el producto
    IN pCatName NVARCHAR(50), -- nombre de la categoria del producto
	IN pPictureURL VARCHAR(128),-- el url de la imagen del producto
    IN cName NVARCHAR(50), -- nombre de la caracteristica
    IN cDescription NVARCHAR(200), -- descripcion de la caracteristica
    IN cMaxSelection TINYINT, -- max selection
    IN cValue NVARCHAR(50), -- vaslor que contiene la caracteristica
    IN cOpName NVARCHAR(50), -- nombre de la caracteristica opcional
    IN cOpExtraPrice INT -- precio extra de la caracteristica opcional
	-- caracteristicas serian mejor hacerlas en otro SP para 
	-- hacerlas dentro de un while y 
)
BEGIN
	-- crear un sistema de código errores 
	-- DECLARE INVALID_FUND INT DEFAULT(53000);

	-- DECLARE EXIT HANDLER FOR SQLEXCEPTION
	-- BEGIN
		-- GET DIAGNOSTICS CONDITION 1 @err_no = MYSQL_ERRNO, @message = MESSAGE_TEXT;
        
        -- IF (ISNULL(@message)) THEN -- quiere decir q es una excepcion forzada del programador
			-- SET @message = 'aqui saco el mensaje de un catalogo de mensajes que fue creado por equipo de desarrollo';            
        -- ELSE
            -- SET @message = CONCAT('Internal error: ', @message);
        -- END IF;
        
        -- ROLLBACK;
        
       --  RESIGNAL SET MESSAGE_TEXT = @message;
	-- END;

	SET autocommit = 0;
	
    SET @commerceId = -1;
	SELECT IFNULL(commerceId, @commerceId) INTO @commerceId FROM Commerces com
	WHERE TRIM(`Name`)=commerceName;

	-- IF (@commerceId=-1) THEN
		-- SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    -- END IF;
	
	SET @ProductCategoryID = -1;
	SELECT IFNULL(ProductCategoryID, @ProductCategoryID) INTO @ProductCategoryID 
	FROM ProductCategories WHERE TRIM(`name`)=pCatName;

	-- IF (@ProductCategoryID=-1) THEN
		-- SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    -- END IF;
    
	START TRANSACTION;	
		INSERT INTO Pictures (PictureURL)
		VALUES
		(pPictureURL);
		
		SELECT LAST_INSERT_ID() INTO @lastPictureURL;
	
		INSERT INTO Products (`Name`, `Description`, Price, Available, 
		ProductCategoryID, PictureID)
		VALUES
		(pName, pDescription, pPrice, pAvailable, @ProductCategoryID,
		@lastPictureURL);
		
		SELECT LAST_INSERT_ID() INTO @lastProduct;
		
		INSERT INTO ProductsPerCommerce (ProductID, CommerceID)
		VALUES
		(@lastProduct, @commerceId);
    
    CALL addCharacteristicProduct(cName, cDescription, cMaxSelection, pCatName, cValue, 
    pName, cOpName, cOpExtraPrice);
    
    commit;
    
END$$
DELIMITER ;