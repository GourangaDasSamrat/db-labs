-- Insert Products
INSERT INTO
    products (p_name, price)
VALUES
    ('iPhone 15 Pro', 999.00),
    ('iPhone 15', 799.00),
    ('MacBook Air M3', 1099.00),
    ('MacBook Pro 14"', 1599.00),
    ('iPad Pro 11"', 799.00),
    ('iPad Air', 599.00),
    ('Apple Watch Ultra 2', 799.00),
    ('Apple Watch Series 9', 399.00),
    ('AirPods Pro (2nd Gen)', 249.00),
    ('AirPods Max', 549.00);

-- Insert Customers and dummy Orders/Items
WITH
    inserted_customers AS (
        INSERT INTO
            customers (cust_name)
        VALUES
            ('Steve Rogers'),
            ('Tony Stark'),
            ('Wanda Maximoff'),
            ('Natasha Romanoff') RETURNING cust_id,
            cust_name
    ),
    inserted_orders AS (
        INSERT INTO
            orders (cust_id)
        SELECT
            cust_id
        FROM
            inserted_customers RETURNING ord_id,
            cust_id
    )
INSERT INTO
    ord_items (ord_id, p_id, quantity)
SELECT
    o.ord_id,
    p.p_id,
    (FLOOR(RANDOM () * 3) + 1) -- Random quantity between 1 and 3
FROM
    inserted_orders o
    CROSS JOIN LATERAL (
        SELECT
            p_id
        FROM
            products
        ORDER BY
            RANDOM ()
        LIMIT
            2
    ) p;