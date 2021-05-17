use Food_services;

DROP PROCEDURE IF EXISTS productsPerPrice;
DELIMITER &&

CREATE PROCEDURE productsPerPrice(
	IN priceRestrintion NVARCHAR(15) -- recibe el nombre de la categoria que quiere de los rangos de productos
)
	BEGIN

	CASE TRIM(priceRestrintion)
		WHEN 'Barato' THEN 
			SELECT concat(`Name`, `Description`, Price) FROM Products
			Where 0 < Price and Price <= 3000;
		WHEN 'Medio' THEN 
			SELECT concat(`Name`, `Description`, Price) FROM Products
			Where 3000 < Price and Price <= 10000;
		WHEN 'Caro' THEN 
			SELECT concat(`Name`, `Description`, Price) FROM Products
			Where Price > 10000;
		ELSE
			SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_FUND;
    END CASE;
  END;
  &&
  DELIMITER ;

call productsPerPrice('Barato');
