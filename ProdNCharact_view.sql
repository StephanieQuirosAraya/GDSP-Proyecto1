-- -------------------------------------------------------------------------------------
-- products, characteristicXProduct, characteristics
USE Food_services;

DROP VIEW IF EXISTS ProdNCharact;
CREATE VIEW ProdNCharact
AS
SELECT prod.`Name` ProductName, prod.`Description`, prod.Price, PictureID, charact.`Name` Caracteristica, MaxSelection
FROM Products prod
INNER JOIN CharacteristicsPerProduct characXprod ON prod.ProductID = characXprod.ProductID
INNER JOIN Characteristics charact ON charact.CharacteristicID = characXprod.CharacteristicID;

-- SELECT * from ProdNCharact;