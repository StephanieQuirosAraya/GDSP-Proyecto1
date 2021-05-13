use Food_services;

-- SELECTS PARA VER LAS TABKLAS
SELECT * FROM Commerces;
SELECT * FROM CommerceTypes;
SELECT * FROM Products;
SELECT * FROM Pictures;
SELECT * FROM Locations;
SELECT * FROM ProductCategories;
SELECT * FROM ProductsPerCommerce;
SELECT * FROM Characteristics;
SELECT * FROM CharacteristicsPerProduct;
SELECT * FROM CharacteristicOptions;
SELECT * FROM CommerceTypes;
SELECT * FROM BusinessHours;
SELECT * FROM MenuTypes;
SELECT * FROM MenusPerCommerce;
SELECT * FROM ShoppingCarts;
SELECT * FROM Users;
SELECT * FROM Transactions;
SELECT * FROM ProductsPerCart;

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

INSERT INTO BusinessHours (StartTime, EndTime, CommerceID)
VALUES
(CURRENT_TIME(),CURRENT_TIME(),1),
(CURRENT_TIME(),CURRENT_TIME(),2);

INSERT INTO ShoppingCarts(TotalProducts, PostTime, Cancelled, UserID, CommerceID)
VALUES
(1,CURRENT_TIME(), 0, 1, 1);

INSERT INTO PaymentStatus (`Name`, `Description`)
VALUES
('HOLA', 'SS');

INSERT INTO Transactions (PostTime, Amount, Currency, `Description`, ReferenceNumber, UserName, 
ComputerName, IP, `Checksum`, UserID, PaymentStatusID)
VALUES
(CURRENT_TIME(), 1000, 'A', 'AA', 63552288, 'User5179', 'Lenovo', 123, 'Checksum', 1, 1);

INSERT INTO Orders (PostTime, ShoppingCartID, TransactionID)
VALUES
(CURRENT_TIME(),1,1);

INSERT INTO ProductsPerCart (ClientInstructions, TotalUnit, ProductID, ShoppingCartID)
VALUES
('Con salsas', 1, 1, 1);

-- LLAMADA A TRANSACCION (addProduct)
call addProducts('Soda Miguel','Arroz con pollo', 'Arroz y pollo', 1000,
0,'Comida','http:aRROZ', @lasPicture, @lastProduct);

CALL addCharacteristicProduct('Tamaño Porcion', 'El tamño de la porcion de arroz con pollo, se medira por 
el tamaño del plato', 1, 'Comida', 'Un plato de tamaño mediano', 'Arroz con pollo', 'Salsas', 0);

DELETE FROM Pictures where PictureID = 27;

SELECT CONCAT(commer.`Name`, ' ', `type`.`Name`, ' Abre: ', hours.StartTime, ' Cierra: ', hours.EndTime) 
'Informacion de los restaurantes'
FROM Commerces commer
INNER JOIN CommerceTypes `type` on commer.CommerceTypeID = `type`.CommerceTypeID
INNER JOIN BusinessHours hours on commer.CommerceID = hours.CommerceID;






