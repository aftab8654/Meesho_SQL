DROP TABLE orders;

CREATE TABLE orders (
    reason_for_credit_entry   VARCHAR(50),
    sub_order_no              VARCHAR(50),   -- no PRIMARY KEY
    order_date                DATE,
    customer_state            VARCHAR(100),
    product_name              TEXT,
    sku                       VARCHAR(100),
    size                      VARCHAR(50),
    quantity                  INT,
    supplier_listed_price     DECIMAL(10,2),
    supplier_discounted_price DECIMAL(10,2)
);
-- Total number of orders

SELECT COUNT(*) AS total_orders FROM orders;


-- Orders by status (Delivered, Cancelled, RTO, etc.)

SELECT reason_for_credit_entry, COUNT(*) AS total
FROM orders
GROUP BY reason_for_credit_entry;


-- Total sales revenue (discounted price × quantity)

SELECT SUM(supplier_discounted_price * quantity) AS total_revenue
FROM orders
WHERE reason_for_credit_entry = 'DELIVERED';


-- Top 5 states by number of orders

SELECT customer_state, COUNT(*) AS total
FROM orders
GROUP BY customer_state
ORDER BY total DESC
LIMIT 5;


-- Orders per day

SELECT order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY order_date;


-- Top 5 best-selling products

SELECT product_name, SUM(quantity) AS total_qty
FROM orders
WHERE reason_for_credit_entry = 'DELIVERED'
GROUP BY product_name
ORDER BY total_qty DESC
LIMIT 5;


-- Top 5 SKUs by revenue

SELECT sku, SUM(supplier_discounted_price * quantity) AS revenue
FROM orders
GROUP BY sku
ORDER BY revenue DESC
LIMIT 5;


-- Average listed price vs discounted price

SELECT AVG(supplier_listed_price) AS avg_listed,
       AVG(supplier_discounted_price) AS avg_discounted
FROM orders;


-- Orders by size

SELECT size, COUNT(*) AS total_orders
FROM orders
GROUP BY size;


-- Percentage of cancelled orders

SELECT 
  (COUNT(*) FILTER (WHERE reason_for_credit_entry = 'CANCELLED')::decimal / COUNT(*)) * 100 AS cancel_rate
FROM orders;


-- Highest priced product delivered

SELECT * FROM orders
WHERE reason_for_credit_entry = 'DELIVERED'
ORDER BY supplier_discounted_price DESC
LIMIT 1;


-- Total revenue by state

SELECT customer_state, SUM(supplier_discounted_price * quantity) AS revenue
FROM orders
WHERE reason_for_credit_entry = 'DELIVERED'
GROUP BY customer_state
ORDER BY revenue DESC;


-- Most returned orders (RTO_COMPLETE) by state

SELECT customer_state, COUNT(*) AS rto_orders
FROM orders
WHERE reason_for_credit_entry = 'RTO_COMPLETE'
GROUP BY customer_state
ORDER BY rto_orders DESC;


-- Daily revenue trend

SELECT order_date, SUM(supplier_discounted_price * quantity) AS daily_revenue
FROM orders
WHERE reason_for_credit_entry = 'DELIVERED'
GROUP BY order_date
ORDER BY order_date;


-- Orders with more than 1 quantity

SELECT * FROM orders
WHERE quantity > 1;


-- Difference between listed price and discounted price

SELECT product_name, (supplier_listed_price - supplier_discounted_price) AS discount
FROM orders;


-- Total discount given overall

SELECT SUM((supplier_listed_price - supplier_discounted_price) * quantity) AS total_discount
FROM orders;


-- Top 5 days with maximum orders

SELECT order_date, COUNT(*) AS total_orders
FROM orders
GROUP BY order_date
ORDER BY total_orders DESC
LIMIT 5;


-- Find most popular size

SELECT size, COUNT(*) AS total
FROM orders
GROUP BY size
ORDER BY total DESC
LIMIT 1;


-- Average revenue per order

SELECT AVG(supplier_discounted_price * quantity) AS avg_revenue_per_order
FROM orders
WHERE reason_for_credit_entry = 'DELIVERED';
