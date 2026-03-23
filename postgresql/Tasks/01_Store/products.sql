DROP TABLE IF EXISTS products;

CREATE TABLE
    products (
        p_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        p_name TEXT NOT NULL,
        price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
    );