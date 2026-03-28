DROP TABLE IF EXISTS products;

CREATE TABLE products (
    p_id CHAR(36) PRIMARY KEY,
    p_name TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);
