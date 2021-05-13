-- -------------------------------------------------------------------------------------
-- commerce, location, hours
USE Food_services;

DROP VIEW IF EXISTS comNloc;
CREATE VIEW comNloc
AS
SELECT com.`Name` CommerceName, PictureURL, loc.`Description` Address, Latitude, Longitude,
	   StartTime, EndTime
FROM Commerces com
INNER JOIN Locations loc ON loc.LocationID = com.LocationID
INNER JOIN Pictures pic ON pic.PictureID = com.PictureID
INNER JOIN BusinessHours hours ON hours.CommerceID = com.CommerceID;

-- SELECT * from comNloc;