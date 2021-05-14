USE Food_services;

DROP PROCEDURE IF EXISTS getUserPermissions;
DELIMITER $$

CREATE PROCEDURE getUserPermissions(
	IN pUserEmail VARCHAR(320),
    OUT informacion JSON
)

BEGIN
    
	DECLARE INVALID_USER INT DEFAULT(53000);
	SET  @userId = 0;
	SELECT IFNULL(userId,@userId) INTO @userId FROM Users
    WHERE Email = pUserEmail LIMIT 1; 

	IF (@userId = 0) THEN
		SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = INVALID_USER; -- handle this
    END IF;

	SELECT `Name` INTO @UserName,LastName1 INTO @LastName1,LastName2 INTO @LastName2 FROM Users
    INNER JOIN
    SELECT PostTime INTO @PostTime FROM PermissionsPerUser
    ON UserID = @userId
    INNER JOIN 
    SELECT `Name` INTO @PermissionName,`Description` INTO @PermissionDescription,`Enabled` INTO @Enabled as(0 = "enabled" or 1 = "disabled") FROM Permissions
    ON PermissionsPerUser.PermissionID = Permissions.PermissionID;
    informacion =
    {"UserName" : @UserName,
    "LastName1" : @LastName1,
    "LastName2" : @LastName2,
    "PostTime" : @PostTime,
    "PermissionName" : @PermissionName,
    "Description" : @PermissionDescription,
    "Enabled" : @Enabled
    }
    RETURN informacion;
    
END$$
DELIMITER ;

CALL getUserOrders();