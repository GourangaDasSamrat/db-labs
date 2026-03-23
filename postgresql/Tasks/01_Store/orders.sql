DROP TABLE IF EXISTS orders;

CREATE TABLE
    orders (
        ord_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        ord_date TIMESTAMP
        WITH
            TIME ZONE DEFAULT CURRENT_TIMESTAMP,
            cust_id UUID NOT NULL,
            CONSTRAINT fk_customer FOREIGN KEY (cust_id) REFERENCES customers (cust_id) ON DELETE CASCADE
    );