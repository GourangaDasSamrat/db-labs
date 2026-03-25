-- create or replace procedure
CREATE
OR REPLACE PROCEDURE update_price (p_product_id UUID, p_new_price INT) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE products
    SET price = p_new_price
    WHERE p_id = p_product_id;
END;
$$;

-- call procedure
CALL update_price ('ae84ec59-54a3-4efb-8870-a7ecedb82341', 260);