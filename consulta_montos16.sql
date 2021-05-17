Select `UserName`,`Amount`,`PostTime` from Transactions WHERE `PaymentErrorID` <=> null
ORDER BY YEAR(`PostTime`) AND MONTH(`PostTime`);

