DROP TABLE IF EXISTS ord_items;

CREATE TABLE
    ord_items (
        items_id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        ord_id UUID NOT NULL,
        p_id UUID NOT NULL,
        quantity INTEGER NOT NULL CHECK (quantity > 0),
        CONSTRAINT fk_order FOREIGN KEY (ord_id) REFERENCES orders (ord_id) ON DELETE CASCADE,
        CONSTRAINT fk_product FOREIGN KEY (p_id) REFERENCES products (p_id) ON DELETE CASCADE
    );