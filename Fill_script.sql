-- ---------------------------------------------------------------
-- CommerceTypes
INSERT INTO CommerceTypes (`Name`, `Description`, PriorityNumber)
VALUES 
('Gran empresa', 'Cuenta con 250 trabajadores o más. Supera los 50 millones de euros en el negocio anual.', 0),
('Mediana empresa', 'Deben contar con no más de 250 trabajadores. En este tipo de empresa el volumen 
de negocio anual se debe situar por debajo de los 50 millones de euros.', 1),
('Pequeña empresa', 'La cantidad de efectivos de la empresa debe ser inferior a las 50 personas. 
Deben tener un volumen de negocios anual no superior a los 10 millones de euros.', 2),
('Microempresa', 'La entidad debe tener menos de 10 trabajadores, ya sean asalariados, socios, 
trabajadores temporales o propietarios.', 3);
-- SELECT * FROM CommerceTypes;
-- ---------------------------------------------------------------
-- Location
DROP PROCEDURE IF EXISTS fillLocation;
delimiter //
CREATE PROCEDURE fillLocation(pCantidad INT)
BEGIN
  DECLARE n INT DEFAULT 0;
  DECLARE lat DOUBLE;
  DECLARE lon DOUBLE;
  
  WHILE n < pCantidad DO
    SET lat = RAND() * 90;
    SET lon = RAND() * 180;
    INSERT INTO Locations (`Description`, Latitude, Longitude)
	VALUE (CONCAT("Descripción de la ubicación."), lat, lon);
    SET n = n + 1;
  END WHILE;
END //
delimiter ;

call fillLocation(50);
-- select * from Locations;
-- ---------------------------------------------------------------
-- Pictures 
DROP PROCEDURE IF EXISTS fillPictures;
delimiter //
CREATE PROCEDURE fillPictures(pCantidad INT)
BEGIN
  DECLARE n INT DEFAULT 0;
  DECLARE rand INT;

  WHILE n < pCantidad DO
	SET rand =  FLOOR(RAND() * 1000 + 1);
    INSERT INTO Pictures (PictureURL)
    VALUE (CONCAT("www.example.com/",rand,"image"));
    SET n = n + 1;
  END WHILE;  
END //
delimiter ;

call fillPictures(100);
-- select * from Pictures;
-- ---------------------------------------------------------------
-- Commerces
DROP PROCEDURE IF EXISTS fillCommerces;
delimiter //
CREATE PROCEDURE fillCommerces(pCantidad INT)
BEGIN
  DECLARE n INT DEFAULT 0;
  DECLARE rand1 BIGINT;
  DECLARE rand2 BIGINT;
  DECLARE rand3 BIGINT;
  DECLARE pict BIGINT;
  DECLARE ttype BIGINT;
  DECLARE loc BIGINT;
  SELECT MAX(PictureID) INTO pict FROM Pictures;
  SELECT MAX(CommerceTypeID) INTO ttype FROM CommerceTypes;
  SELECT MAX(LocationID) INTO loc FROM Locations;

  WHILE n < pCantidad DO
    SET rand1 = FLOOR(RAND() * pict + 1);
    SET rand2 = FLOOR(RAND() * ttype + 1);
    SET rand3 = FLOOR(RAND() * loc + 1);
    INSERT INTO Commerces (`Name`, PictureID, CommerceTypeID, LocationID)
    VALUE (CONCAT("Comercio", rand1, rand2, rand3), rand1, rand2, rand3);
    SET n = n + 1;
  END WHILE;
END //
delimiter ;

call fillCommerces(100);
-- select * from Commerces;
-- ---------------------------------------------------------------
-- ProductCategories
INSERT INTO ProductCategories (`Name`)
VALUES  ("Comida"), ("Esenciales"), ("Farmacia"),
        ("Mascotas"), ("Alcohol"), ("Utiles");

-- select * from ProductCategories;
-- ---------------------------------------------------------------
-- Products
DROP PROCEDURE IF EXISTS fillProducts;
delimiter //
CREATE PROCEDURE fillProducts(pCantidad INT)
BEGIN
  DECLARE n INT DEFAULT 0;
  DECLARE rand1 INT;
  DECLARE rand2 BIGINT;
  DECLARE rand3 BIGINT;
  DECLARE booleano BIT;
  DECLARE maxCat BIGINT;
  DECLARE maxPic BIGINT;
  SELECT MAX(ProductCategoryID) INTO maxCat FROM ProductCategories;
  SELECT MAX(PictureID) INTO maxPic FROM Pictures;
  
  WHILE n < pCantidad DO
	IF RAND()<=0.2 THEN		-- AVAILABLE
		SET booleano = 0;
	ELSE 
		SET booleano = 1;
    END IF;
    SET rand1 = FLOOR(RAND() * (40000-100) + 100); -- PRICE
    SET rand2 = FLOOR(RAND() * maxCat + 1);      -- PRODUCT CATEGORY
    SET rand3 = FLOOR(RAND() * maxPic + 1);      -- PICTUREID
    INSERT INTO Products (`Name`, `Description`, Price, Available, ProductCategoryID, PictureID)
    VALUE (CONCAT("Producto ", rand1,rand2,rand3), CONCAT("Descripción del Producto"), rand1, booleano, rand2, rand3);
    SET n = n + 1;
  END WHILE;
END //
delimiter ;

call fillProducts(100);
-- select * from Products;
-- ---------------------------------------------------------------
-- ProductsPerCommerce
DROP PROCEDURE IF EXISTS fillProdXComm;
delimiter //
CREATE PROCEDURE fillProdXComm()
BEGIN
  DECLARE n INT DEFAULT 1;	-- id del comercio
  DECLARE i INT DEFAULT 0;
  DECLARE cantComercios BIGINT;
  DECLARE rand1 BIGINT;
  DECLARE cantProd INT;
  DECLARE maxProd BIGINT;
  DECLARE tmp BIGINT;
  
  SELECT MAX(ProductID) INTO maxProd FROM Products; 
  SELECT MAX(CommerceID) INTO cantComercios FROM Commerces; 
  
  WHILE n <= cantComercios DO
	set i = FLOOR(RAND() * 5 + 1);
    while i > 0 DO
		
        set rand1 = FLOOR(RAND() * maxProd + 1);
        
        SELECT ProductID into tmp FROM ProductsPerCommerce where CommerceID=n AND ProductID=rand1;
        if isnull(tmp) then
			INSERT INTO ProductsPerCommerce (ProductID, CommerceID)
			VALUE (rand1, n);
        end if;
        
        set i = i - 1;
    END WHILE;
	set n = n + 1;
  END WHILE;

END //
delimiter ;

call fillProdXComm();
-- select * from ProductsPerCommerce order by CommerceID, ProductID desc;

-- ----------------------------------------------------------------------




-- Users
DROP PROCEDURE IF EXISTS fillUsers;
delimiter //
CREATE PROCEDURE fillUsers(pCantidad INT)
BEGIN
	DECLARE n INT DEFAULT 0;
    DECLARE rand1 int;
    DECLARE rand2 BIGINT;
    DECLARE fecha datetime;
    DECLARE maxLocation BIGINT;
    
    SELECT MAX(LocationID) INTO maxLocation FROM Locations;
    
    WHILE n < pCantidad DO
		SET rand1 = FLOOR(RAND() * (9999-1000) + 1);
        set rand2 = FLOOR(RAND() * maxLocation + 1);
		set fecha = date_sub(now(), INTERVAL floor(rand() * 365) DAY);
		set fecha = date_sub(fecha, INTERVAL floor(rand() * (100-12) + 12) YEAR);

		INSERT INTO Users (`Name`, LastName1, LastName2, Birthdate, Email, `Password`, LocationID)
		VALUES (CONCAT("User",rand1), CONCAT("LastName", rand1), CONCAT("Second", rand1), 
				fecha, "e-mail", AES_ENCRYPT('password', 'keyword'), rand2);
		
        SET n = n + 1;
    END WHILE;
END //
delimiter ;

call fillUsers(100);
-- select * from Users;

-- ----------------------------------------------------------------------

-- Carts
DROP PROCEDURE IF EXISTS fillCarts;
delimiter //
CREATE PROCEDURE fillCarts(pCantidad INT)
BEGIN
	DECLARE n INT DEFAULT 0;
    DECLARE maxUser BIGINT;
    DECLARE maxCommerce BIGINT;
    DECLARE rand1 BIGINT;
    DECLARE rand2 BIGINT;
    
    SELECT MAX(UserID) INTO maxUser FROM Users;
	SELECT MAX(CommerceID) INTO maxCommerce FROM Commerces;
    
    WHILE n < pCantidad DO
		SET rand1 = FLOOR(RAND() * maxUser + 1);
        SET rand2 = FLOOR(RAND() * maxCommerce + 1);
		INSERT INTO ShoppingCarts (TotalProducts, PostTime, Cancelled, UserID, CommerceID)
        VALUES (0, NOW(), 0, rand1, rand2);
        SET n = n + 1;
    END WHILE;
END //
delimiter ;

call fillCarts(100);
-- select * from ShoppingCarts;

-- ---------------------------------------------------------------

-- Productos por carrito
DROP PROCEDURE IF EXISTS fillProdXcart;
delimiter //
CREATE PROCEDURE fillProdXcart(pCantidad INT)
BEGIN
	DECLARE n INT DEFAULT 0;
	declare maxProduct bigint;
    declare maxCart bigint;
    declare rand1 bigint;
    declare rand2 bigint;
    declare rand3 tinyint;
    declare total int;
    
    SET SQL_SAFE_UPDATES = 0;
    
    SELECT MAX(ProductID) INTO maxProduct FROM Products;
    SELECT MAX(ShoppingCartID) INTO maxCart FROM ShoppingCarts;
    
    while n < pCantidad do
    
		set rand1 = FLOOR(RAND() * maxProduct + 1);	-- product id
        set rand2 = FLOOR(RAND() * maxCart + 1); -- cart id
        set rand3 = floor(rand()*9+1); -- cantidad de producto
		
		INSERT INTO ProductsPerCart (ClientInstructions, TotalUnit, ProductID, ShoppingCartID)
		VALUES ('', rand3, rand1, rand2);
        
        update ShoppingCarts set TotalProducts = TotalProducts + rand3
        where ShoppingCartID=rand2;
        
		set n = n + 1;
    end while;
    
    SET SQL_SAFE_UPDATES = 1;
    
END //
delimiter ;

call fillProdXcart(100);

-- select * from ProductsPerCart;
-- select * from ShoppingCarts;
-- ---------------------------------------------------------------

DROP PROCEDURE IF EXISTS fillCharact;
delimiter //
CREATE PROCEDURE fillCharact (pCantidad INT)
BEGIN
	-- le asigna pCantidad de caracteristicas a cada categoria de productos existente
	declare n int default 0;
    declare prodCat bigint;
    declare rand1 int;
    declare rand2 int;
    
	SELECT MAX(ProductCategoryID) INTO prodCat FROM ProductCategories;
    
    while prodCat > 0 do
		set n = 0;
		while n < pCantidad do
			set rand1 = FLOOR(RAND() * 9000 + 1000);
            set rand2 = RAND();
            if rand2 < 0.5 then
				set rand2 = FLOOR(RAND()* 8 + 2);	-- seleccion multiple de 2 a 10
            else
				set rand2 = 1;	-- es una caracteristica en la que se puede seleccionar solo una opcion
            end if;
			insert into Characteristics (`Name`, `Description`, MaxSelection, ProductCategoryID)
            values (CONCAT('Caracteristica', rand1), CONCAT('Descripcion', rand1), rand2, prodCat);
			set n = n + 1;
        end while;
		set prodCat = prodCat - 1;
    end while;
    
END //
delimiter ;

call fillCharact(2);
-- select * from Characteristics;

-- ---------------------------------------------------------------
