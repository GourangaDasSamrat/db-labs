DROP TABLE IF EXISTS customers;

CREATE TABLE
    customers (
        cust_id CHAR(36) PRIMARY KEY,
        cust_name TEXT NOT NULL
    );
