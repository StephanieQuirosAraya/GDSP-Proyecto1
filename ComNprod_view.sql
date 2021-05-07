-- ---------------------------------------------------------------
-- CommerceTypes
--INSERT INTO CommerceTypes (`Name`, `Description`, PriorityNumber)
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

call fillPictures(50);
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

call fillCommerces(20);
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

-- -------------------------------------------------------------------------------------
-- commerce, productsXcommerce, products
DROP VIEW IF EXISTS CommerceNProducts;
CREATE VIEW CommerceNProducts
AS
SELECT com.`Name` Comercio, prod.`Name` Producto, `Description`, Price Precio, 
Available Disponible, PictureURL
FROM Commerces com 
INNER JOIN ProductsPerCommerce prodXcom ON com.CommerceID = prodXcom.CommerceID
INNER JOIN Products prod ON prod.ProductID = prodXcom.ProductID
INNER JOIN Pictures pics ON pics.PictureID = prod.PictureID
order by com.CommerceID, prod.ProductID;

SELECT * from CommerceNProducts;
-- SELECT * FROM ProductsPerCommerce ORDER BY CommerceID;
