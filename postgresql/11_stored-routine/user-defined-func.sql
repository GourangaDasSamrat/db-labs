-- create or replace function
CREATE
OR REPLACE FUNCTION goat_age_category (p_age INT) RETURNS TEXT AS $$
BEGIN
    IF p_age < 25 THEN
        RETURN 'Young';
    ELSIF p_age BETWEEN 25 AND 35 THEN
        RETURN 'Prime';
    ELSE
        RETURN 'Veteran';
    END IF;
END;
$$ LANGUAGE plpgsql;

-- use that func
SELECT
    NAME,
    goat_age_category (age)
FROM
    goats;