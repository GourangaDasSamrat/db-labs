-- length
SELECT
    name,
    LENGTH (name)
FROM
    goats;

-- upper case
SELECT
    UPPER(name)
FROM
    goats;

-- lower case
SELECT
    LOWER(name)
FROM
    goats;

-- trim
SELECT
    TRIM('   Hello!   ');