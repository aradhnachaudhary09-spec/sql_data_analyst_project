CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region_id INT
);
INSERT INTO customers VALUES
(101, 'Arjun Sharma', 1),
(102, 'Priya Verma', 2),
(103, 'Rahul Singh', 3),
(104, 'Sneha Kapoor', 4),
(105, 'Amit Jain', 1);
--TABLE REGION
CREATE TABLE region(
region_id INT PRIMARY KEY,
region_name VARCHAR(100),
category VARCHAR(50)
);
INSERT INTO region values
(1,'North'),
(2,'South'),
(3,'East'),
(4,'West');
--PRODUCT TABLE
CREATE TABLE products(
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50));
INSERT INTO products values
(201,'Laptop','Electronics'),
(202, 'Mobile', 'Electronics'),
(203, 'Chair', 'Furniture'),
(204, 'Table', 'Furniture'),
(205, 'Headphones', 'Accessories');
--SALES TABLE
CREATE TABLE sales(
order_id INT PRIMARY KEY,
customer_id INT,
product_id INT,
order_date DATE,
quantity INT,
order_amount DECIMAL(10,2),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO sales VALUES
(1001, 101, 201, '2025-01-10', 1, 55000),
(1002, 102, 202, '2025-01-12', 2, 40000),
(1003, 103, 203, '2025-02-05', 3, 15000),
(1004, 104, 204, '2025-02-20', 1, 12000),
(1005, 105, 205, '2025-03-01', 4, 8000),
(1006, 101, 202, '2025-03-10', 1, 20000),
(1007, 102, 201, '2025-03-15', 1, 60000),
(1008, 103, 205, '2025-04-01', 2, 4000);
--top 5 customer by revenue
SELECT 
    c.customer_name,
    SUM(s.order_amount) AS total_spent
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;
--highest revenue region
SELECT 
    r.region_name,
    SUM(s.order_amount) AS total_revenue
FROM sales s
JOIN customers c
ON s.customer_id = c.customer_id
JOIN regions r
ON c.region_id = r.region_id
GROUP BY r.region_name
ORDER BY total_revenue DESC;
--monthly sales trend
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(order_amount) AS monthly_sales
FROM sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
--best selling product
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;
--product category revenue
SELECT 
    p.category,
    SUM(s.order_amount) AS category_revenue
FROM products p
JOIN sales s
ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;
--average order values
SELECT 
    AVG(order_amount) AS avg_order_value
FROM sales;
--customer with multiple order
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM sales
GROUP BY customer_id
HAVING COUNT(order_id) > 1;
--find null values
SELECT* FROM sales
where order_amount is null;
-- remove null values
DELETE FROM sales
WHERE order_amount is null;
-- rank customer by revenue
SELECT 
    c.customer_name,
    SUM(s.order_amount) AS total_spent,
    RANK() OVER(ORDER BY SUM(s.order_amount) DESC) AS customer_rank
FROM customers c
JOIN sales s
ON c.customer_id = s.customer_id
GROUP BY c.customer_name;










