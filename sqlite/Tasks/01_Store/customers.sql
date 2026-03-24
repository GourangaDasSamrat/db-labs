-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- customers.sql
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    cust_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    cust_name TEXT NOT NULL
);