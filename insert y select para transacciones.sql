use Food_services;

-- SELECTS PARA VER LAS TABKLAS
SELECT * FROM Commerces;
SELECT * FROM CommerceTypes;
SELECT * FROM Products;
SELECT * FROM Pictures;
SELECT * FROM Locations;
SELECT * FROM ProductCategories;
SELECT * FROM ProductsPerCommerce;

-- INSERTS EN TABLAS PARA USAR TRANSACTION (addProduct)
INSERT INTO Pictures (PictureID, PictureURL)
VALUES
(0,'HTTP');

INSERT INTO Locations (LocationID, `Description`, Latitude, Longitude)
VALUES
(0,'HTTP',0,0);

INSERT INTO CommerceTypes (`Name`,`Description`,PriorityNumber)
VALUES
('SOda','SODA',1),
('Restaurante','RESTAURANTE',5);

INSERT INTO Commerces (CommerceID,`Name`, CommerceTypeID, PictureID, LocationID)
VALUES
(1,'Soda Miguel',1,1,1),
(2,'Restaurante CostaRica',2,1,1);

INSERT INTO ProductCategories (`Name`)
VALUES
('Comida'),
('Postre');

-- LLAMADA A TRANSACCION (addProduct)
call addProducts('Soda Miguel','Arroz con pollo', 'Arroz y pollo', 1000,
0,'Comida','http:aRROZ', @lasPicture, @lastProduct);

