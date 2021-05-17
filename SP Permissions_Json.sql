USE Food_services;

DROP PROCEDURE IF EXISTS getUserPermissions;
DELIMITER $$

CREATE PROCEDURE getUserPermissions(
	pUserEmail VARCHAR(320)
)

BEGIN
    
	DECLARE INVALID_USER INT DEFAULT(53000);
	SET  @userId = 0;
	SELECT IFNULL(userId,@userId) INTO @userId FROM Users
    WHERE Users.Email = pUserEmail LIMIT 1; 

	IF (@userId = 0) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_USER; -- handle this
    END IF;

	SELECT `Name`, LastName1, LastName2 INTO @UserName, @LastName1, @LastName2 FROM Users
    WHERE UserID = @userId;
    SELECT PostTime, PermissionID INTO @PostTime, @PermissionID FROM PermissionsPerUser
    where UserID = @userId;
    SELECT `Name`,`Description`,`Enabled` INTO @PermissionName, @PermissionDescription, @Enabled FROM Permissions
    WHERE PermissionID = @PermissionID;
    
    SELECT JSON_OBJECT('UserName', @UserName, 'LastName1', @LastName1, 'LastName2',@LastName2,'PostTime',@PostTime,'PermissionName',@PermissionName,'Description',@PermissionDescription,'Enabled',@Enabled);
    
    
END$$
DELIMITER ;


-- CALL getUserPermissions("User5369@e-mail.com");