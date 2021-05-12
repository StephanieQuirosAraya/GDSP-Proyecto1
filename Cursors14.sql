-- Cursors
DELIMITER //

CREATE PROCEDURE cursors() 
BEGIN   
    DECLARE UserID, LocationID  BIGINT;  
    DECLARE `Name`, LastName1, LastName2 varchar(50);
    DECLARE Birthdate Date;
    DECLARE Email varchar(320);
    DECLARE `Password` varbinary(300);
    
    DECLARE cursorUsers CURSOR FOR SELECT * FROM dbo.Users;
    Open cursorUsers;
	fetch cursorUsers into UserID, `Name`, LastName1, LastName2, Birthdate, Email, `Password`, LocationID;
	while(@@fetch_status = 0) do
	SELECT UserID +" "+ `Name`+" "+ LastName1+" "+ LastName2+" "+ Birthdate+" "+ Email+" "+ `Password`+" "+ LocationID;
	fetch cursorUsers into UserID, `Name`, LastName1, LastName2, Birthdate, Email, `Password`, LocationID;
	end while;
	close cursorUsers;
END; //

DELIMITER ;

CALL cursors();