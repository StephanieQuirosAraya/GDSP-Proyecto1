SELECT IF(MAX(`Transactions`.`TransactionID`)-MIN(`Transactions`.`TransactionID`) >= 15, "VOLUMEN ALTO",
if(MAX(`Transactions`.`TransactionID`)-MIN(`Transactions`.`TransactionID`) >= 10, "VOLUMEN MEDIO","VOLUMEN BAJO")) VALOR 
from `Transactions` WHERE MONTH(`Transactions`.`PostTime`) = 12 AND `PostTime` BETWEEN '2019-11-20' AND '2020-12-31';

