Select `UserName`,`Amount`,`PostTime` from Transactions WHERE `PaymentErrorID` <=> null
ORDER BY `PostTime`;


insert into `Food_services`.`Transactions`(`TransactionID`,`PostTime`, `Amount`, `Currency`,`Description`,`ReferenceNumber`,`UserName`, `ComputerName`, `IP`, `Checksum`, `UserID`, `PaymentStatusID`) 
VALUES(1,'2019-12-31',20000, 1, "First transaction", 1, "Javier", "Javier's computer", 21313, 1, 1, 1);

insert into `PaymentStatus`(`PaymentStatusID`,`Name`,`Description`)
VALUES(1, "First","First") ;

insert into `Food_services`.`Transactions`(`TransactionID`,`PostTime`, `Amount`, `Currency`,`Description`,`ReferenceNumber`,`UserName`, `ComputerName`, `IP`, `Checksum`, `UserID`, `PaymentStatusID`) 
VALUES(2,'2012-11-21',465400, 1, "Second transaction", 2, "Daniel", "Daniel's computer", 24544, 1, 2, 2);

insert into `PaymentStatus`(`PaymentStatusID`,`Name`,`Description`)
VALUES(2, "Second","Second") ;