CREATE DATABASE TEST;
USE TEST;
CREATE TABLE greeting(
id INT AUTO_INCREMENT PRIMARY KEY,
message VARCHAR(225));

INSERT INTO greeting(message)
VALUES
('HELLO VAISHNAVI');

SELECT message FROM greeting;

INSERT INTO greeting(message)
VALUES ('MODI'),('HEELO');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2)
);
INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(101, 'Laptop', 'Electronics', 500.00),
(102, 'Smartphone', 'Electronics', 300.00),
(103, 'Headphones', 'Electronics', 30.00),
(104, 'Keyboard', 'Electronics', 20.00),
(105, 'Mouse', 'Electronics', 15.00);

SELECT * FROM Products;
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date, total_price) VALUES
(1, 101, 5, '2024-01-01', 2500.00),
(2, 102, 3, '2024-01-02', 900.00),
(3, 103, 2, '2024-01-02', 60.00),
(4, 104, 4, '2024-01-03', 80.00),
(5, 105, 6, '2024-01-03', 90.00);
SELECT * FROM Sales;

SELECT product_name,unit_price FROM Products;
SELECT sale_id,sale_date FROM Sales;
SELECT * FROM Sales WHERE total_price>100;
SELECT * FROM Products WHERE category='Electronics';

SELECT sale_id,total_price 
FROM Sales
WHERE sale_date='2024-01-03'; 

SELECT product_id, product_name 
FROM Products
WHERE unit_price>100;

SELECT SUM(total_price) AS toatl_revenue
FROM Sales;

SELECT AVG(unit_price) AS average_unit_price
FROM  Products;

SELECT SUM(quantity_sold) AS total_quantity_sold 
FROM Sales;

SELECT sale_date, COUNT(*) AS Sales_count
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;  

SELECT Product_name,unit_price
FROM Products
ORDER BY unit_price DESC
LIMIT 1;

SELECT sale_id, product_id, total_price 
FROM Sales 
WHERE quantity_sold > 4;

SELECT product_name, unit_price
FROM Products
ORDER BY unit_price DESC;

SELECT ROUND(SUM(total_price), 2) AS total_sales 
FROM Sales;

SELECT AVG(total_price) AS average_total_price
FROM Sales;

SELECT sale_id, DATE_FORMAT(sale_date, '%Y-%m-%d')
AS formatted_date
FROM Sales;

SELECT SUM(Sales.total_price) AS toatl_revenue
FROM Sales
JOIN Products ON Sales.product_id=Products.product_id
WHERE products.category ='Electronics';

SELECT product_name, unit_price 
FROM Products 
WHERE unit_price BETWEEN 20 AND 600;

SELECT product_name, category 
FROM Products 
ORDER BY category ASC;

SELECT SUM(quantity_sold) AS total_quantity_sold 
FROM Sales 
JOIN Products ON Sales.product_id = Products.product_id 
WHERE Products.category = 'Electronics';

SELECT product_name, quantity_sold * unit_price AS total_price 
FROM Sales 
JOIN Products ON Sales.product_id = Products.product_id;

SELECT product_id, COUNT(*) AS sales_count 
FROM Sales 
GROUP BY product_id 
ORDER BY sales_count DESC 
LIMIT 1;

SELECT product_id, product_name 
FROM Products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Sales);

SELECT p.category, SUM(s.total_price) AS total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category;

SELECT category
FROM Products
GROUP BY category
ORDER BY AVG(unit_price) DESC
LIMIT 1;

SELECT p.product_name
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.total_price) > 30;

SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS month, COUNT(*) AS sales_count
FROM Sales s
GROUP BY month;

SELECT s.sale_id, p.product_name, s.total_price 
FROM Sales s 
JOIN Products p ON s.product_id = p.product_id 
WHERE p.product_name LIKE '%Smart%';

SELECT AVG(s.quantity_sold) AS average_quantity_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
WHERE p.unit_price > 100;

SELECT p.product_name, SUM(s.total_price) AS total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

SELECT s.sale_id, p.product_name
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

SELECT p.category, 
       SUM(s.total_price) AS category_revenue,
       (SUM(s.total_price) / (SELECT SUM(total_price) FROM Sales)) * 100 AS revenue_percentage
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue_percentage DESC
LIMIT 3;

SELECT p.product_name, SUM(s.total_price) AS total_revenue,
       RANK() OVER (ORDER BY SUM(s.total_price) DESC) AS revenue_rank
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

SELECT p.category, p.product_name, s.sale_date, 
       SUM(s.total_price) OVER (PARTITION BY p.category ORDER BY s.sale_date) AS running_total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

SELECT sale_id, 
       CASE 
           WHEN total_price > 200 THEN 'High'
           WHEN total_price BETWEEN 100 AND 200 THEN 'Medium'
           ELSE 'Low'
       END AS sales_category
FROM Sales;

SELECT *
FROM Sales
WHERE quantity_sold > (SELECT AVG(quantity_sold) FROM Sales);

SELECT sale_id, DATEDIFF(NOW(), sale_date) AS days_since_sale
FROM Sales;

SELECT sale_id,
       CASE 
           WHEN DAYOFWEEK(sale_date) IN (1, 7) THEN 'Weekend'
           ELSE 'Weekday'
       END AS day_type
FROM Sales;

SELECT p.product_name, 
       SUM(s.total_price) AS total_revenue, 
       (SUM(s.total_price) / (SELECT SUM(total_price) FROM Sales)) * 100 AS revenue_percentage 
FROM Sales s 
JOIN Products p ON s.product_id = p.product_id 
GROUP BY p.product_name 
ORDER BY revenue_percentage DESC 
LIMIT 3;

SELECT product_name, category, unit_price
FROM Products
WHERE product_id IN (
    SELECT product_id
    FROM Sales
    GROUP BY product_id
    HAVING SUM(quantity_sold) > (SELECT AVG(quantity_sold) FROM Sales)
);

SELECT *
FROM Sales
WHERE sale_date = '2024-01-03';