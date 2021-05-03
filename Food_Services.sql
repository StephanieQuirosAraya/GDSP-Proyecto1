-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Food_services
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Food_services
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Food_services` DEFAULT CHARACTER SET utf8 ;
USE `Food_services` ;

-- -----------------------------------------------------
-- Table `Food_services`.`Applications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Applications` (
  `ApplicationID` TINYINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  PRIMARY KEY (`ApplicationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Modules` (
  `ModuleID` TINYINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `ApplicationID` TINYINT NOT NULL,
  PRIMARY KEY (`ModuleID`),
  INDEX `fk_Modules_Applications_idx` (`ApplicationID` ASC) VISIBLE,
  CONSTRAINT `fk_Modules_Applications`
    FOREIGN KEY (`ApplicationID`)
    REFERENCES `Food_services`.`Applications` (`ApplicationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Permissions` (
  `PermissionID` SMALLINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  `Code` VARCHAR(10) NOT NULL,
  `Enabled` BIT NOT NULL,
  `Deleted` BIT NOT NULL,
  `ModuleID` TINYINT NOT NULL,
  PRIMARY KEY (`PermissionID`),
  INDEX `fk_Permissions_Modules1_idx` (`ModuleID` ASC) VISIBLE,
  CONSTRAINT `fk_Permissions_Modules1`
    FOREIGN KEY (`ModuleID`)
    REFERENCES `Food_services`.`Modules` (`ModuleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Roles` (
  `RoleID` TINYINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  PRIMARY KEY (`RoleID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`PermissionsPerRole`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`PermissionsPerRole` (
  `PostTime` DATETIME NOT NULL,
  `Deleted` BIT NOT NULL,
  `LastUpdate` DATETIME NOT NULL,
  `UserInChargeID` BIGINT NOT NULL,
  `RoleID` TINYINT NOT NULL,
  `PermissionID` SMALLINT NOT NULL,
  INDEX `fk_PermissionsPerRole_Permissions1_idx` (`PermissionID` ASC) VISIBLE,
  INDEX `fk_PermissionsPerRole_Roles1_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `fk_PermissionsPerRole_Permissions1`
    FOREIGN KEY (`PermissionID`)
    REFERENCES `Food_services`.`Permissions` (`PermissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PermissionsPerRole_Roles1`
    FOREIGN KEY (`RoleID`)
    REFERENCES `Food_services`.`Roles` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Locations` (
  `LocationID` BIGINT NOT NULL AUTO_INCREMENT,
  `Description` NVARCHAR(200) NOT NULL,
  `Latitude` DOUBLE NOT NULL,
  `Longitude` DOUBLE NOT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Users` (
  `UserID` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `LastName1` NVARCHAR(50) NOT NULL,
  `LastName2` NVARCHAR(50) NULL,
  `Birthdate` DATE NOT NULL,
  `Email` VARCHAR(320) NOT NULL,
  `Password` VARBINARY(300) NOT NULL,
  `LocationID` BIGINT NOT NULL,
  PRIMARY KEY (`UserID`),
  INDEX `fk_Users_Locations1_idx` (`LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_Users_Locations1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `Food_services`.`Locations` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`PermissionsPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`PermissionsPerUser` (
  `PostTime` DATETIME NOT NULL,
  `Deleted` BIT NOT NULL,
  `LastUpdate` DATETIME NOT NULL,
  `Checksum` VARBINARY(200) NOT NULL,
  `UserInChargeID` BIGINT NOT NULL,
  `PermissionID` SMALLINT NOT NULL,
  `UserID` BIGINT NOT NULL,
  INDEX `fk_PermissionsPerUser_Permissions1_idx` (`PermissionID` ASC) VISIBLE,
  INDEX `fk_PermissionsPerUser_Users1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_PermissionsPerUser_Permissions1`
    FOREIGN KEY (`PermissionID`)
    REFERENCES `Food_services`.`Permissions` (`PermissionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PermissionsPerUser_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`RolesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`RolesPerUser` (
  `PostTime` DATETIME NOT NULL,
  `Deleted` BIT NOT NULL,
  `IP` INT NOT NULL,
  `Checksum` VARBINARY(200) NOT NULL,
  `LastUpdate` DATETIME NOT NULL,
  `RoleID` TINYINT NOT NULL,
  `UserID` BIGINT NOT NULL,
  INDEX `fk_RolesPerUser_Roles1_idx` (`RoleID` ASC) VISIBLE,
  INDEX `fk_RolesPerUser_Users1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_RolesPerUser_Roles1`
    FOREIGN KEY (`RoleID`)
    REFERENCES `Food_services`.`Roles` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RolesPerUser_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Pictures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Pictures` (
  `PictureID` BIGINT NOT NULL AUTO_INCREMENT,
  `PictureURL` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`PictureID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`CommerceTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`CommerceTypes` (
  `CommerceTypeID` TINYINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  `PriorityNumber` TINYINT NOT NULL,
  PRIMARY KEY (`CommerceTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Commerces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Commerces` (
  `CommerceID` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `PictureID` BIGINT NOT NULL,
  `CommerceTypeID` TINYINT NOT NULL,
  `LocationID` BIGINT NOT NULL,
  PRIMARY KEY (`CommerceID`),
  INDEX `fk_Commerces_Pictures1_idx` (`PictureID` ASC) VISIBLE,
  INDEX `fk_Commerces_CommerceTypes1_idx` (`CommerceTypeID` ASC) VISIBLE,
  INDEX `fk_Commerces_Locations1_idx` (`LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_Commerces_Pictures1`
    FOREIGN KEY (`PictureID`)
    REFERENCES `Food_services`.`Pictures` (`PictureID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commerces_CommerceTypes1`
    FOREIGN KEY (`CommerceTypeID`)
    REFERENCES `Food_services`.`CommerceTypes` (`CommerceTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commerces_Locations1`
    FOREIGN KEY (`LocationID`)
    REFERENCES `Food_services`.`Locations` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`BusinessHours`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`BusinessHours` (
  `BusinessHourID` BIGINT NOT NULL AUTO_INCREMENT,
  `StartTime` DATETIME NOT NULL,
  `EndTime` TIME NOT NULL,
  `CommerceID` BIGINT NOT NULL,
  PRIMARY KEY (`BusinessHourID`),
  INDEX `fk_BusinessHours_Commerces1_idx` (`CommerceID` ASC) VISIBLE,
  CONSTRAINT `fk_BusinessHours_Commerces1`
    FOREIGN KEY (`CommerceID`)
    REFERENCES `Food_services`.`Commerces` (`CommerceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`MenuTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`MenuTypes` (
  `MenuTypeID` TINYINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `PictureID` BIGINT NOT NULL,
  PRIMARY KEY (`MenuTypeID`),
  INDEX `fk_MenuTypes_Pictures1_idx` (`PictureID` ASC) VISIBLE,
  CONSTRAINT `fk_MenuTypes_Pictures1`
    FOREIGN KEY (`PictureID`)
    REFERENCES `Food_services`.`Pictures` (`PictureID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`MenusPerCommerce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`MenusPerCommerce` (
  `CommerceID` BIGINT NOT NULL,
  `MenuTypeID` TINYINT NOT NULL,
  INDEX `fk_MenusPerCommerce_Commerces1_idx` (`CommerceID` ASC) VISIBLE,
  INDEX `fk_MenusPerCommerce_MenuTypes1_idx` (`MenuTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_MenusPerCommerce_Commerces1`
    FOREIGN KEY (`CommerceID`)
    REFERENCES `Food_services`.`Commerces` (`CommerceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MenusPerCommerce_MenuTypes1`
    FOREIGN KEY (`MenuTypeID`)
    REFERENCES `Food_services`.`MenuTypes` (`MenuTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`PicturesPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`PicturesPerUser` (
  `PostTime` DATETIME NOT NULL,
  `Default` BIT NOT NULL,
  `UserID` BIGINT NOT NULL,
  `PictureID` BIGINT NOT NULL,
  INDEX `fk_PicturesPerUser_Users1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_PicturesPerUser_Pictures1_idx` (`PictureID` ASC) VISIBLE,
  CONSTRAINT `fk_PicturesPerUser_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PicturesPerUser_Pictures1`
    FOREIGN KEY (`PictureID`)
    REFERENCES `Food_services`.`Pictures` (`PictureID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`PhoneNumbersPerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`PhoneNumbersPerUser` (
  `PhoneNumber` TEXT(8) NOT NULL,
  `InUse` BIT NOT NULL,
  `UserID` BIGINT NOT NULL,
  INDEX `fk_PhoneNumberPerUser_Users1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_PhoneNumberPerUser_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`ProductCategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`ProductCategories` (
  `ProductCategoryID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`ProductCategoryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Products` (
  `ProductID` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  `Price` INT NOT NULL,
  `Available` BIT NOT NULL,
  `ProductCategoryID` INT NOT NULL,
  `PictureID` BIGINT NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `fk_Products_ProductCategories1_idx` (`ProductCategoryID` ASC) VISIBLE,
  INDEX `fk_Products_Pictures1_idx` (`PictureID` ASC) VISIBLE,
  CONSTRAINT `fk_Products_ProductCategories1`
    FOREIGN KEY (`ProductCategoryID`)
    REFERENCES `Food_services`.`ProductCategories` (`ProductCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Products_Pictures1`
    FOREIGN KEY (`PictureID`)
    REFERENCES `Food_services`.`Pictures` (`PictureID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`ProductsPerCommerce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`ProductsPerCommerce` (
  `ProductID` BIGINT NOT NULL,
  `CommerceID` BIGINT NOT NULL,
  INDEX `fk_ProductsPerCommerce_Commerces1_idx` (`CommerceID` ASC) VISIBLE,
  INDEX `fk_ProductsPerCommerce_Products1_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_ProductsPerCommerce_Commerces1`
    FOREIGN KEY (`CommerceID`)
    REFERENCES `Food_services`.`Commerces` (`CommerceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductsPerCommerce_Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Food_services`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Characteristics`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Characteristics` (
  `CharacteristicID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  `MaxSelection` TINYINT NOT NULL,
  `ProductCategoryID` INT NOT NULL,
  PRIMARY KEY (`CharacteristicID`),
  INDEX `fk_Characteristics_ProductCategories1_idx` (`ProductCategoryID` ASC) VISIBLE,
  CONSTRAINT `fk_Characteristics_ProductCategories1`
    FOREIGN KEY (`ProductCategoryID`)
    REFERENCES `Food_services`.`ProductCategories` (`ProductCategoryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`CharacteristicOptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`CharacteristicOptions` (
  `CharacteristicOptionID` TINYINT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `ExtraPrice` INT NULL,
  `CharacteristicID` INT NOT NULL,
  PRIMARY KEY (`CharacteristicOptionID`),
  INDEX `fk_CharacteristicOptions_Characteristics1_idx` (`CharacteristicID` ASC) VISIBLE,
  CONSTRAINT `fk_CharacteristicOptions_Characteristics1`
    FOREIGN KEY (`CharacteristicID`)
    REFERENCES `Food_services`.`Characteristics` (`CharacteristicID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`CharacteristicsPerProduct`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`CharacteristicsPerProduct` (
  `CharacteristicPerProductID` INT NOT NULL AUTO_INCREMENT,
  `Value` NVARCHAR(50) NULL,
  `ProductID` BIGINT NOT NULL,
  `CharacteristicID` INT NOT NULL,
  PRIMARY KEY (`CharacteristicPerProductID`),
  INDEX `fk_CharacteristicsPerProduct_Products1_idx` (`ProductID` ASC) VISIBLE,
  INDEX `fk_CharacteristicsPerProduct_Characteristics1_idx` (`CharacteristicID` ASC) VISIBLE,
  CONSTRAINT `fk_CharacteristicsPerProduct_Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Food_services`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CharacteristicsPerProduct_Characteristics1`
    FOREIGN KEY (`CharacteristicID`)
    REFERENCES `Food_services`.`Characteristics` (`CharacteristicID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`ShoppingCarts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`ShoppingCarts` (
  `ShoppingCartID` BIGINT NOT NULL AUTO_INCREMENT,
  `TotalProducts` TINYINT NOT NULL,
  `PostTime` DATETIME NOT NULL,
  `Cancelled` BIT NOT NULL,
  `UserID` BIGINT NOT NULL,
  `CommerceID` BIGINT NOT NULL,
  PRIMARY KEY (`ShoppingCartID`),
  INDEX `fk_ShoppingCarts_Users1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_ShoppingCarts_Commerces1_idx` (`CommerceID` ASC) VISIBLE,
  CONSTRAINT `fk_ShoppingCarts_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ShoppingCarts_Commerces1`
    FOREIGN KEY (`CommerceID`)
    REFERENCES `Food_services`.`Commerces` (`CommerceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`ProductsPerCart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`ProductsPerCart` (
  `ProductsPerCartID` BIGINT NOT NULL AUTO_INCREMENT,
  `ClientInstructions` NVARCHAR(200) NOT NULL,
  `TotalUnit` TINYINT NOT NULL,
  `ProductID` BIGINT NOT NULL,
  `ShoppingCartID` BIGINT NOT NULL,
  PRIMARY KEY (`ProductsPerCartID`),
  INDEX `fk_ProductsPerCart_Products1_idx` (`ProductID` ASC) VISIBLE,
  INDEX `fk_ProductsPerCart_ShoppingCarts1_idx` (`ShoppingCartID` ASC) VISIBLE,
  CONSTRAINT `fk_ProductsPerCart_Products1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Food_services`.`Products` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ProductsPerCart_ShoppingCarts1`
    FOREIGN KEY (`ShoppingCartID`)
    REFERENCES `Food_services`.`ShoppingCarts` (`ShoppingCartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`UserChoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`UserChoices` (
  `ProductsPerCartID` BIGINT NOT NULL,
  `CharacteristicID` INT NOT NULL,
  `CharacteristicOptionID` TINYINT NOT NULL,
  INDEX `fk_UserChoices_ProductsPerCart1_idx` (`ProductsPerCartID` ASC) VISIBLE,
  INDEX `fk_UserChoices_Characteristics1_idx` (`CharacteristicID` ASC) VISIBLE,
  INDEX `fk_UserChoices_CharacteristicOptions1_idx` (`CharacteristicOptionID` ASC) VISIBLE,
  CONSTRAINT `fk_UserChoices_ProductsPerCart1`
    FOREIGN KEY (`ProductsPerCartID`)
    REFERENCES `Food_services`.`ProductsPerCart` (`ProductsPerCartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserChoices_Characteristics1`
    FOREIGN KEY (`CharacteristicID`)
    REFERENCES `Food_services`.`Characteristics` (`CharacteristicID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_UserChoices_CharacteristicOptions1`
    FOREIGN KEY (`CharacteristicOptionID`)
    REFERENCES `Food_services`.`CharacteristicOptions` (`CharacteristicOptionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`PaymentErrors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`PaymentErrors` (
  `PaymentErrorID` INT NOT NULL AUTO_INCREMENT,
  `Description` NVARCHAR(200) NOT NULL,
  PRIMARY KEY (`PaymentErrorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`PaymentStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`PaymentStatus` (
  `PaymentStatusID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(50) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  PRIMARY KEY (`PaymentStatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Transactions` (
  `TransactionID` BIGINT NOT NULL AUTO_INCREMENT,
  `PostTime` DATETIME NOT NULL,
  `Amount` DOUBLE NOT NULL,
  `Currency` NVARCHAR(3) NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  `ReferenceNumber` BIGINT NOT NULL,
  `UserName` NVARCHAR(50) NOT NULL,
  `ComputerName` NVARCHAR(50) NOT NULL,
  `IP` INT NOT NULL,
  `Checksum` VARBINARY(200) NOT NULL,
  `UserID` BIGINT NOT NULL,
  `PaymentErrorID` INT NULL,
  `PaymentStatusID` INT NOT NULL,
  PRIMARY KEY (`TransactionID`),
  INDEX `fk_Transactions_Users1_idx` (`UserID` ASC) VISIBLE,
  INDEX `fk_PaymentAttemps_PaymentErrors1_idx` (`PaymentErrorID` ASC) VISIBLE,
  INDEX `fk_PaymentAttemps_PaymentStatus1_idx` (`PaymentStatusID` ASC) VISIBLE,
  CONSTRAINT `fk_Transactions_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentAttemps_PaymentErrors1`
    FOREIGN KEY (`PaymentErrorID`)
    REFERENCES `Food_services`.`PaymentErrors` (`PaymentErrorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PaymentAttemps_PaymentStatus1`
    FOREIGN KEY (`PaymentStatusID`)
    REFERENCES `Food_services`.`PaymentStatus` (`PaymentStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Orders` (
  `OrderID` BIGINT NOT NULL AUTO_INCREMENT,
  `PostTime` DATETIME NOT NULL,
  `ShoppingCartID` BIGINT NOT NULL,
  `TransactionID` BIGINT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_ShoppingCarts1_idx` (`ShoppingCartID` ASC) VISIBLE,
  INDEX `fk_Orders_PaymentAttemps1_idx` (`TransactionID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_ShoppingCarts1`
    FOREIGN KEY (`ShoppingCartID`)
    REFERENCES `Food_services`.`ShoppingCarts` (`ShoppingCartID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_PaymentAttemps1`
    FOREIGN KEY (`TransactionID`)
    REFERENCES `Food_services`.`Transactions` (`TransactionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Cards` (
  `UserID` BIGINT NOT NULL,
  `CardNumber` VARBINARY(300) NOT NULL,
  `PAN` VARBINARY(300) NOT NULL,
  `Name` VARBINARY(300) NOT NULL,
  `ExpirationDate` VARBINARY(300) NOT NULL,
  `Checksum` VARBINARY(300) NOT NULL,
  INDEX `fk_Cards_Users1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Cards_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`LogTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`LogTypes` (
  `LogTypeID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(15) NULL,
  PRIMARY KEY (`LogTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Sources`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Sources` (
  `SourceID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(15) NOT NULL,
  PRIMARY KEY (`SourceID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Severity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Severity` (
  `SeverityID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(15) NOT NULL,
  PRIMARY KEY (`SeverityID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`EntityTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`EntityTypes` (
  `EntityTypeID` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(15) NOT NULL,
  PRIMARY KEY (`EntityTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Food_services`.`Logs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Food_services`.`Logs` (
  `LogID` BIGINT NOT NULL AUTO_INCREMENT,
  `PostTime` DATETIME NOT NULL,
  `Description` NVARCHAR(200) NOT NULL,
  `ComputerName` NVARCHAR(50) NOT NULL,
  `UserName` NVARCHAR(50) NOT NULL,
  `IP` INT NOT NULL,
  `ReferenceID1` BIGINT NULL,
  `ReferenceID2` BIGINT NULL,
  `OldValue` NVARCHAR(200) NOT NULL,
  `NewValue` NVARCHAR(200) NOT NULL,
  `Checksum` VARBINARY(200) NOT NULL,
  `LogTypeID` INT NOT NULL,
  `SourceID` INT NOT NULL,
  `SeverityID` INT NOT NULL,
  `EntityTypeID` INT NOT NULL,
  `UserID` BIGINT NOT NULL,
  PRIMARY KEY (`LogID`),
  INDEX `fk_Logs_LogTypes1_idx` (`LogTypeID` ASC) VISIBLE,
  INDEX `fk_Logs_Sources1_idx` (`SourceID` ASC) VISIBLE,
  INDEX `fk_Logs_Severity1_idx` (`SeverityID` ASC) VISIBLE,
  INDEX `fk_Logs_EntityTypes1_idx` (`EntityTypeID` ASC) VISIBLE,
  INDEX `fk_Logs_Users1_idx` (`UserID` ASC) VISIBLE,
  CONSTRAINT `fk_Logs_LogTypes1`
    FOREIGN KEY (`LogTypeID`)
    REFERENCES `Food_services`.`LogTypes` (`LogTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_Sources1`
    FOREIGN KEY (`SourceID`)
    REFERENCES `Food_services`.`Sources` (`SourceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_Severity1`
    FOREIGN KEY (`SeverityID`)
    REFERENCES `Food_services`.`Severity` (`SeverityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_EntityTypes1`
    FOREIGN KEY (`EntityTypeID`)
    REFERENCES `Food_services`.`EntityTypes` (`EntityTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logs_Users1`
    FOREIGN KEY (`UserID`)
    REFERENCES `Food_services`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
