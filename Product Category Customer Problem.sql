CREATE TABLE products (
         product_id INT, 
         product_name VARCHAR(100), 
         category_id INT
     );
     CREATE TABLE categories (
         category_id INT, 
         category_name VARCHAR(100)
     );
     CREATE TABLE online_reviews (
         review_id INT, 
         product_id INT, 
         customer_id INT
     );
     CREATE TABLE physical_reviews (
         review_id INT, 
         product_id INT, 
         customer_id INT
     );
     INSERT INTO categories VALUES 
         (1, 'Electronics'), 
         (2, 'Books'), 
         (3, 'Clothing'), 
         (4, 'Home Appliances');
     INSERT INTO products VALUES 
         (1, 'Smartphone', 1), 
         (2, 'Laptop', 1), 
         (3, 'Novel', 2), 
         (4, 'Shirt', 3), 
         (5, 'Washing Machine', 4);
     INSERT INTO online_reviews VALUES 
         (1, 1, 1), 
         (2, 1, 2), 
         (3, 2, 1), 
         (4, 3, 3);
     INSERT INTO physical_reviews VALUES 
         (1, 1, 3), 
         (2, 2, 1), 
         (3, 3, 2), 
         (4, 4, 4);

SELECT * FROM CATEGORIES
SELECT * FROM PRODUCTS
SELECT * FROM ONLINE_REVIEWS
SELECT * FROM PHYSICAL_REVIEWS
/*
List all products sold in different categories that have received reviews from at least 3 unique customers
across both online and physical stores.
*/


--PRODUCTS SOLD IN DIFFERENT CATEGORIES
--BOTH ONLINE AND PHYSICAL STORES
-- REVIEWS FROM ATLEAST 3 CUSTOMER
	
--APPROACH 1
WITH all_reviews AS (
    SELECT 
        product_id,
        customer_id
    FROM online_reviews
    UNION 
    SELECT 
        product_id,
        customer_id
    FROM physical_reviews
),
customer_counts AS (
    SELECT 
        ar.product_id,
        COUNT(DISTINCT ar.customer_id) AS unique_customers
    FROM all_reviews ar
    GROUP BY ar.product_id
),
eligible_products AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category_id
    FROM products p
    JOIN customer_counts cc
    ON p.product_id = cc.product_id
    WHERE cc.unique_customers >= 3
)
SELECT 
    ep.product_name,
    c.category_name
FROM eligible_products ep
JOIN categories c
ON ep.category_id = c.category_id;


--APPROACH 2

SELECT 	p.product_id,
		p.product_name, 
		c.category_name 
FROM products p 
JOIN categories c ON p.category_id = c.category_id 
JOIN online_reviews o ON p.product_id = o.product_id 
JOIN physical_reviews ph ON p.product_id = ph.product_id 
GROUP BY p.product_id, p.product_name, c.category_name 
HAVING COUNT(DISTINCT o.customer_id) + COUNT(DISTINCT ph.customer_id) >= 3;