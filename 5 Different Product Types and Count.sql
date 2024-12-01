CREATE TABLE customers (
         customer_id INT, 
         customer_name VARCHAR(100)
     );
     CREATE TABLE products (
         product_id INT, 
         product_name VARCHAR(100)
     );
     CREATE TABLE purchases (
         purchase_id INT, 
         customer_id INT, 
         product_id INT, 
         amount DECIMAL(10, 2), 
         purchase_date DATE
     );
     INSERT INTO customers VALUES 
         (1, 'Alice'), 
         (2, 'Bob'), 
         (3, 'Charlie'), 
         (4, 'Diana');
     INSERT INTO products VALUES 
         (1, 'Laptop'), 
         (2, 'Smartphone'), 
         (3, 'Tablet'), 
         (4, 'Headphones'), 
         (5, 'Smartwatch'), 
         (6, 'Camera'), 
         (7, 'Printer'), 
         (8, 'Monitor');
     INSERT INTO purchases VALUES 
         (1, 1, 1, 1000.00, '2023-01-10'), 
         (2, 1, 2, 500.00, '2023-02-15'), 
         (3, 1, 3, 300.00, '2023-03-20'), 
         (4, 1, 4, 150.00, '2023-04-25'), 
         (5, 1, 5, 200.00, '2023-05-30'), 
         (6, 1, 6, 400.00, '2023-06-01'), 
         (7, 2, 2, 600.00, '2023-03-05'), 
         (8, 2, 1, 1100.00, '2023-02-10'), 
         (9, 2, 7, 200.00, '2023-07-11'), 
         (10, 3, 4, 150.00, '2023-01-15');


SELECT * FROM CUSTOMERS
SELECT * FROM PRODUCTS
SELECT * FROM PURCHASES

/*
Identify customers who have purchased more than 5 different product types 
and their total spending in the last year, along with the product types they bought.
*/


SELECT 
    c.customer_id, 
    c.customer_name, 
    COUNT(DISTINCT p.product_id) AS product_types, 
    SUM(pu.amount) AS total_spending
FROM customers c 
JOIN purchases pu ON c.customer_id = pu.customer_id 
JOIN products p ON pu.product_id = p.product_id 
WHERE pu.purchase_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY c.customer_id, c.customer_name 
HAVING COUNT(DISTINCT p.product_id) > 5;

