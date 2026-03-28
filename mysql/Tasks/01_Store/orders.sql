DROP TABLE IF EXISTS orders;

CREATE TABLE
    orders (
        ord_id CHAR(36) PRIMARY KEY,
        ord_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        cust_id CHAR(36) NOT NULL,
        CONSTRAINT fk_customer FOREIGN KEY (cust_id) REFERENCES customers (cust_id) ON DELETE CASCADE
    );
