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

-- SELECT * from CommerceNProducts;
-- SELECT * FROM ProductsPerCommerce ORDER BY CommerceID;
