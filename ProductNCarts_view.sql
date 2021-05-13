USE Food_services;
-- products, products per cart, cart, user VIEW
DROP VIEW IF EXISTS ProductNCarts;
CREATE VIEW ProductNCarts
AS
SELECT Users.`Name` users, carts.ShoppingCartID, TotalProducts, Cancelled, carts.PostTime, 
	   prod.`Name`, Price, TotalUnit, ClientInstructions
FROM Products prod
INNER JOIN ProductsPerCart prodXCart ON prodXCart.ProductID = prod.ProductID
INNER JOIN ShoppingCarts carts ON carts.ShoppingCartID = prodXCart.ShoppingCartID
INNER JOIN Users ON Users.UserID = carts.UserID
order by Users.UserID, ShoppingCartID;

-- SELECT * from ProductNCarts;

