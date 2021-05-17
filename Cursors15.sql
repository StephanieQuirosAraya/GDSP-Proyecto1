-- Cursors
DROP PROCEDURE IF EXISTS cursors;

DELIMITER //

CREATE PROCEDURE cursors() 
BEGIN   
    DECLARE pUserID, pLocationID  BIGINT;  
    DECLARE pName, pLastName1, pLastName2 varchar(50);
    DECLARE pBirthdate Date;
    DECLARE pEmail varchar(320);
    DECLARE cursorUsers CURSOR FOR SELECT UserID, `Name`, LastName1, LastName2, Birthdate, Email, LocationID FROM Food_services.Users;
    Open cursorUsers;
	fetch cursorUsers into pUserID, pName, pLastName1, pLastName2, pBirthdate, pEmail, pLocationID;
    select pUserID;
	while pUserID <= 1 do
		SELECT CONCAT("UserID: ", pUserID," Nombre: ", pName," Apellido1: ", pLastName1," Apellido2: ", pLastName2," Fecha nacimiento: ", pBirthdate," Email: ", pEmail," LocationID: ", pLocationID) AS INFO;
		fetch cursorUsers into pUserID, pName, pLastName1, pLastName2, pBirthdate, pEmail, pLocationID;
	end while;
	close cursorUsers;
END; //

DELIMITER ;

CALL cursors();


