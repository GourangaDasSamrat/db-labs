-- create or replace function
CREATE
OR REPLACE FUNCTION goat_age_category (p_age INT) RETURNS TEXT LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT AS $$
BEGIN
    RETURN CASE
        WHEN p_age < 25 THEN 'Young'
        WHEN p_age <= 35 THEN 'Prime'
        ELSE 'Veteran'
    END;
END;
$$;

-- use that func
SELECT
    NAME,
    goat_age_category (age) AS age_category
FROM
    goats;