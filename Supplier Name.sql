CREATE TABLE suppliers (
         supplier_id INT, 
         supplier_name VARCHAR(100)
     );
     CREATE TABLE contracts (
         contract_id INT, 
         supplier_id INT, 
         company_name VARCHAR(100)
     );
     INSERT INTO suppliers VALUES 
         (1, 'Supplier A'), 
         (2, 'Supplier B'), 
         (3, 'Supplier C');
     INSERT INTO contracts VALUES 
         (1, 1, 'HDFC Bank'), 
         (2, 2, 'ICICI Bank'), 
         (3, 1, 'Axis Bank');

SELECT * FROM SUPPLIERS

SELECT * FROM CONTRACTS

/*
Find all suppliers who supply to HDFC Bank.
*/

SELECT S.SUPPLIER_NAME
FROM SUPPLIERS S
JOIN CONTRACTS C
ON S.SUPPLIER_ID = C.SUPPLIER_ID
WHERE C.COMPANY_NAME = 'HDFC Bank'




