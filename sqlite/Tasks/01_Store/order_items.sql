DROP TABLE IF EXISTS ord_items;
CREATE TABLE ord_items (
    items_id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    ord_id TEXT NOT NULL,
    p_id TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (ord_id) REFERENCES orders (ord_id) ON DELETE CASCADE,
    FOREIGN KEY (p_id) REFERENCES products (p_id) ON DELETE CASCADE
);