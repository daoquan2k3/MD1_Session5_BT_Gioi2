CREATE table ss5_gioi2.products (
    product_id SERIAL PRIMARY KEY ,
    product_name VARCHAR(50),
    category VARCHAR(50)
);

CREATE table ss5_gioi2.sales (
    sale_id SERIAL primary key ,
    product_id INT references ss5_gioi2.products(product_id),
    sale_date DATE,
    quantity INT,
    total_price INT
);

INSERT INTO ss5_gioi2.products (product_id, product_name, category) VALUES
    (1, 'Laptop Dell', 'Electronics'),
    (2, 'IPhone15', 'Electronics'),
    (3, 'Bàn học gỗ', 'Furniture'),
    (4, 'Ghế xoay', 'Furniture');

INSERT INTO ss5_gioi2.sales(sale_id, product_id, sale_date, quantity, total_price) VALUES
    (1, 1, '2025-01-10', 2, 2200),
    (2, 2, '2025-01-15', 3, 3300),
    (3, 3, '2025-02-10', 5, 2500),
    (4, 4, '2025-02-18', 4, 1600),
    (5, 1, '2025-03-01', 1, 1100),
    (6, 2, '2025-04-05', 2, 2200);


--1
SELECT
    p.category AS category,
    SUM(s.total_price) AS total_revenue,
    EXTRACT(MONTH FROM s.sale_date) AS month
FROM ss5_gioi2.products p
JOIN ss5_gioi2.sales s on p.product_id = s.product_id
WHERE EXTRACT(MONTH FROM s.sale_date) IN (1, 2)
AND EXTRACT(YEAR FROM s.sale_date) = 2025
GROUP BY p.category, EXTRACT(MONTH FROM s.sale_date);
--2
SELECT
    p.category AS category,
    SUM(s.total_price) AS total_revenue,
    EXTRACT(MONTH FROM s.sale_date) AS month
FROM ss5_gioi2.products p
JOIN ss5_gioi2.sales s on p.product_id = s.product_id
WHERE EXTRACT (MONTH FROM s.sale_date) IN (1)
AND EXTRACT(YEAR FROM s.sale_date) = 2025
GROUP BY p.category, EXTRACT(MONTH FROM s.sale_date)
UNION
SELECT
    p.category AS category,
    SUM(s.total_price) AS total_revenue,
    EXTRACT(MONTH FROM s.sale_date) AS month
FROM ss5_gioi2.products p
         JOIN ss5_gioi2.sales s on p.product_id = s.product_id
WHERE EXTRACT (MONTH FROM s.sale_date) IN (2)
  AND EXTRACT(YEAR FROM s.sale_date) = 2025
GROUP BY p.category, EXTRACT(MONTH FROM s.sale_date);

--3
SELECT
    p.category AS category,
    EXTRACT(MONTH FROM s.sale_date) AS month
FROM ss5_gioi2.products p
         JOIN ss5_gioi2.sales s on p.product_id = s.product_id
WHERE EXTRACT(MONTH FROM s.sale_date) IN (1)
GROUP BY p.category, EXTRACT(MONTH FROM s.sale_date)
INTERSECT
SELECT
    p.category AS category,
    EXTRACT(MONTH FROM s.sale_date) AS month
FROM ss5_gioi2.products p
         JOIN ss5_gioi2.sales s on p.product_id = s.product_id
WHERE EXTRACT(MONTH FROM s.sale_date) IN (2)
GROUP BY p.category, EXTRACT(MONTH FROM s.sale_date);

--4
SELECT
    p.category,
    s.total_price AS max_sale_amount,
    2 AS month
FROM ss5_gioi2.products p
JOIN ss5_gioi2.sales s ON p.product_id = s.product_id
WHERE EXTRACT(MONTH FROM s.sale_date) = 2
AND EXTRACT(YEAR FROM s.sale_date) = 2025
AND s.total_price = (
    SELECT MAX(total_price)
    FROM ss5_gioi2.sales s2
    WHERE EXTRACT(MONTH FROM s2.sale_date) = 2
    AND EXTRACT(YEAR FROM s2.sale_date) = 2025
);

--5