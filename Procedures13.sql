DROP PROCEDURE IF EXISTS acc_registerProduct;
DELIMITER $$

CREATE PROCEDURE acc_registerProduct
(
	pProductID BIGINT,
    pDescription NVARCHAR(200),
    pPrice INT,
    pAvailable BIT,
    pProductCategoryI INT,
    PPictureID BIGINT	,
    pFundName VARCHAR(60),
    pName NVARCHAR(50),
    OUT pRegisterProductId BIGINT
)