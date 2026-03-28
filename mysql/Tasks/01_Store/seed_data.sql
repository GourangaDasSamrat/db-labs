-- Insert Products
INSERT INTO products (p_id, p_name, price) VALUES
(UUID(), 'iPhone 15 Pro', 999.00),
(UUID(), 'iPhone 15', 799.00),
(UUID(), 'MacBook Air M3', 1099.00),
(UUID(), 'MacBook Pro 14"', 1599.00),
(UUID(), 'iPad Pro 11"', 799.00),
(UUID(), 'iPad Air', 599.00),
(UUID(), 'Apple Watch Ultra 2', 799.00),
(UUID(), 'Apple Watch Series 9', 399.00),
(UUID(), 'AirPods Pro (2nd Gen)', 249.00),
(UUID(), 'AirPods Max', 549.00);

-- Insert Customers
INSERT INTO customers (cust_id, cust_name) VALUES
(UUID(), 'Steve Rogers'),
(UUID(), 'Tony Stark'),
(UUID(), 'Wanda Maximoff'),
(UUID(), 'Natasha Romanoff');

-- Insert Orders (One for each customer)
INSERT INTO orders (ord_id, cust_id)
SELECT UUID(), cust_id FROM customers;

-- Insert Order Items (2 random products per order)
INSERT INTO ord_items (items_id, ord_id, p_id, quantity)
SELECT
    UUID(),
    ord_id,
    p_id,
    FLOOR(1 + (RAND() * 3))
FROM (
    SELECT
        o.ord_id,
        p.p_id,
        ROW_NUMBER() OVER(PARTITION BY o.ord_id ORDER BY RAND()) as rn
    FROM orders o
    CROSS JOIN products p
) as ranked_products
WHERE rn <= 2;