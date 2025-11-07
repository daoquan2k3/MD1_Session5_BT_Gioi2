CREATE TABLE ss5_gioi2.customers (
    customer_id SERIAL PRIMARY KEY ,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE ss5_gioi2.orders (
    order_id SERIAL PRIMARY KEY ,
    customer_id INT REFERENCES ss5_gioi2.customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE ss5_gioi2.order_item (
    item_id SERIAL PRIMARY KEY ,
    order_id INT REFERENCES ss5_gioi2.orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10, 2)
);

--1
SELECT
    c.customer_name AS customer_name,
    o.order_date AS order_date,
    o.total_amount AS total_amount
FROM ss5_gioi2.customers c
JOIN ss5_gioi2.orders o on c.customer_id = o.customer_id;

--2
SELECT
    SUM(o.total_amount),
    AVG(o.total_amount),
    MAX(o.total_amount),
    MIN(o.total_amount),
    COUNT(o.order_id)
FROM ss5_gioi2.orders o ;

--3
SELECT
    c.city,
    SUM(o.total_amount) AS total_amount
FROM ss5_gioi2.customers c
JOIN ss5_gioi2.orders o on c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

--4
SELECT
    c.customer_name,
    o.order_date,
    oi.quantity,
    oi.price
FROM ss5_gioi2.customers c
JOIN ss5_gioi2.orders o on c.customer_id = o.customer_id
JOIN ss5_gioi2.order_item oi on o.order_id = oi.order_id;
--5
SELECT
    c.customer_id,
    SUM(o.total_amount) AS total_revenue
FROM ss5_gioi2.customers c
JOIN ss5_gioi2.orders o on c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING SUM(o.total_amount) >= (SELECT MAX(o2.total_amount) FROM ss5_gioi2.orders o2 );

--6
SELECT city FROM ss5_gioi2.customers

UNION

SELECT c.city
FROM ss5_gioi2.orders o
JOIN ss5_gioi2.customers c ON o.customer_id = c.customer_id;


SELECT city FROM ss5_gioi2.customers

INTERSECT

SELECT c.city
FROM ss5_gioi2.orders o
JOIN ss5_gioi2.customers c ON o.customer_id = c.customer_id;
