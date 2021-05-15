-- Cursors
DELIMITER //

CREATE PROCEDURE cursors() 
BEGIN   
    DECLARE UserID, LocationID  BIGINT;  
    DECLARE `Name`, LastName1, LastName2 varchar(50);
    DECLARE Birthdate Date;
    DECLARE Email varchar(320);
    DECLARE cursorUsers CURSOR FOR SELECT UserID, `Name`, LastName1, LastName2, Birthdate, Email, LocationID FROM Food_services.Users;
    Open cursorUsers;
	fetch cursorUsers into UserID, `Name`, LastName1, LastName2, Birthdate, Email, LocationID;
	while UserID < 3 do
		SELECT CONCAT(UserID, `Name`, LastName1, LastName2, Birthdate, Email, LocationID) AS ConcatenatedString;
		fetch cursorUsers into UserID, `Name`, LastName1, LastName2, Birthdate, Email, LocationID;
	end while;
	close cursorUsers;
END; //

DELIMITER ;

CALL cursors();


