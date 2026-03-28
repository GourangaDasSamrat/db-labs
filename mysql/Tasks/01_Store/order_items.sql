DROP TABLE IF EXISTS ord_items;

CREATE TABLE
    ord_items (
        items_id CHAR(36) PRIMARY KEY,
        ord_id CHAR(36) NOT NULL,
        p_id CHAR(36) NOT NULL,
        quantity INTEGER NOT NULL CHECK (quantity > 0),
        CONSTRAINT fk_order FOREIGN KEY (ord_id) REFERENCES orders (ord_id) ON DELETE CASCADE,
        CONSTRAINT fk_product FOREIGN KEY (p_id) REFERENCES products (p_id) ON DELETE CASCADE
    );
