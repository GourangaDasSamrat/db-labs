-- count
SELECT
    COUNT(id)
FROM
    goats;

-- sum
SELECT
    SUM(age)
FROM
    goats;

-- average
-- Note: In SQLite, AVG() always returns a floating point value.
SELECT
    AVG(age)
FROM
    goats;

-- min
SELECT
    name,
    age
FROM
    goats
WHERE
    age = (
        SELECT
            MIN(age)
        FROM
            goats
    );

-- max
SELECT
    name,
    age
FROM
    goats
WHERE
    age = (
        SELECT
            MAX(age)
        FROM
            goats
    );