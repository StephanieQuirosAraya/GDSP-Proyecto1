select * from `Locations`;

update `Locations` set latitude = -1 where LocationID = 1;
DELIMITER // 
CREATE TRIGGER LatitudeTrigg BEFORE UPDATE ON `Locations` FOR EACH ROW
BEGIN
	IF NEW.Latitude < 0 THEN
		SET NEW.Latitude = 0;
	END IF;
END; //	

