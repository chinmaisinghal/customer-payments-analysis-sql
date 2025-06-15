Use bank_db;

-- Create 'payments' table
CREATE TABLE payments (
    payment_id VARCHAR(150),
    order_id VARCHAR(150), 
    payment_date DATE, 
    payment_amount FLOAT, 
    payment_method VARCHAR(100), 
    payment_status VARCHAR(100),
    PRIMARY KEY (payment_id)
);

-- View payments
SELECT * FROM payments;

-- Drop payments table
-- DROP TABLE payments;

-- Create 'customer_orders' table
CREATE TABLE customer_orders (
    order_id VARCHAR(150),
    customer_id INT,
    order_date DATE, 
    order_amount FLOAT, 
    shipping_address TEXT, 
    order_status VARCHAR(100),
    PRIMARY KEY (order_id)
);

-- View customer orders
SELECT * FROM customer_orders;


-- Order count by status
SELECT 
    order_status, 
    COUNT(*) AS total_orders
FROM customer_orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Monthly Sales Trend (Only Completed Payments)
SELECT 
    DATE_FORMAT(p.payment_date, '%Y-%m') AS sales_month,
    SUM(p.payment_amount) AS total_sales
FROM payments p
JOIN customer_orders o ON p.order_id = o.order_id
WHERE LOWER(p.payment_status) = 'completed'
GROUP BY sales_month
ORDER BY sales_month;

-- Monthly Order Volume
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM customer_orders
GROUP BY order_month
ORDER BY order_month;


#Task 2: Customer Analysis

-- Orders per Customer
SELECT 
    customer_id,
    COUNT(*) AS total_orders
FROM customer_orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- Repeat Customers
SELECT 
    customer_id
FROM customer_orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- New vs Repeat Orders by Month
WITH first_order AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM customer_orders
    GROUP BY customer_id
),
orders_with_type AS (
    SELECT 
        o.customer_id,
        o.order_date,
        CASE 
            WHEN o.order_date = f.first_order_date THEN 'New'
            ELSE 'Repeat'
        END AS order_type
    FROM customer_orders o
    JOIN first_order f ON o.customer_id = f.customer_id
)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    order_type,
    COUNT(*) AS order_count
FROM orders_with_type
GROUP BY order_month, order_type
ORDER BY order_month;


# Task 3: Payment Status Analysis

-- Total payments by status
SELECT 
    LOWER(payment_status) AS payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status
ORDER BY total_payments DESC;

-- Failed payments per month
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS failure_month,
    COUNT(*) AS failed_payments
FROM payments
WHERE LOWER(payment_status) = 'failed'
GROUP BY failure_month
ORDER BY failure_month;


# Task 4: Order Details Report

SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_amount,
    o.order_status,
    p.payment_id,
    p.payment_date,
    p.payment_amount,
    p.payment_method,
    p.payment_status
FROM customer_orders o
LEFT JOIN payments p ON o.order_id = p.order_id
ORDER BY o.order_date;


# Customer Retention Report

WITH first_order AS (
    SELECT 
        customer_id,
        DATE_FORMAT(MIN(order_date), '%Y-%m') AS first_order_month
    FROM customer_orders
    GROUP BY customer_id
)
SELECT 
    f.first_order_month,
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.customer_id) AS retained_customers
FROM customer_orders o
JOIN first_order f ON o.customer_id = f.customer_id
GROUP BY f.first_order_month, order_month
ORDER BY f.first_order_month, order_month;



