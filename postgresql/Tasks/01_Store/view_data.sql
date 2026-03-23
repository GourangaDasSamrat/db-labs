SELECT
    c.cust_name AS customer_name,
    o.ord_date AS DATE,
    p.p_name AS product_name,
    p.price AS price,
    oi.quantity AS quantity,
    (oi.quantity * p.price) AS total_price
FROM
    ord_items oi
    JOIN products p ON oi.p_id = p.p_id
    JOIN orders o ON oi.ord_id = o.ord_id
    JOIN customers c ON o.cust_id = c.cust_id