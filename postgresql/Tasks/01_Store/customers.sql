CREATE EXTENSION IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS customers;

CREATE TABLE
    customers (
        cust_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        cust_name TEXT NOT NULL
    );