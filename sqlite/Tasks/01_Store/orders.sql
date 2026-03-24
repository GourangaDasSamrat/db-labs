DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    ord_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    ord_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    cust_id TEXT NOT NULL,
    FOREIGN KEY (cust_id) REFERENCES customers (cust_id) ON DELETE CASCADE
);