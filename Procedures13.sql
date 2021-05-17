DROP TEMPORARY TABLE IF EXISTS temporaryLocation;
CREATE TEMPORARY TABLE IF NOT EXISTS temporaryLocation(
 LocationID binary(16)
, `Description` varchar(200)
, Latitude double
, Longitude double);

DROP PROCEDURE IF EXISTS fillTempTable;
DELIMITER //

CREATE PROCEDURE fillTempTable
(
	pLocationID binary(16) 
)
BEGIN
	set @counter = 1;
    while @counter <= 3 do
		set @descTemp = ELT(@counter,'Next to the college', 'Close to the park', 'behind the store');
		set @latitudeTemp = ELT(@counter,12.0, 15.24, 98.45);
		set @longitudeTemp = ELT(@counter,1234.0, 125.24, 912.5);
		 
         insert into temporaryLocation(LocationID, `Description`, Latitude, Longitude)
         values(pLocationID, @descTemp, @latitudeTemp, @longitudeTemp);
         
         set @counter = @counter +1;
	end while;
END //
DELIMITER ;


DROP PROCEDURE IF EXISTS insertNregist;
DELIMITER //
CREATE PROCEDURE insertNregist(
	pLocationID binary(16) 
)
begin
    insert into Food_services.`Locations`(`Description`, Latitude, Longitude)
    select `Description`, Latitude, Longitude from temporaryLocation t
	where t.`LocationID` = pLocationID;
END //
DELIMITER ;

SET @LocationID = uuid_to_bin(uuid());
call fillTempTable(@LocationID);
call insertNregist(@LocationID);

select * from Food_services.`Locations`;



