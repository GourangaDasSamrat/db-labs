-- sub str
SELECT
    SUBSTRING(name, 1, 6) AS name
FROM
    goats;

-- replace
SELECT
    REPLACE (nationality, 'U', 'M') AS updated_nationality
FROM
    goats
WHERE
    nationality = 'USA';

-- reverse
SELECT
    REVERSE (sport)
FROM
    goats;

-- left
SELECT
    LEFT (name, 5)
FROM
    goats;

-- right
SELECT
    RIGHT (name, 5)
FROM
    goats;

-- position
SELECT
    nationality,
    POSITION('A' IN nationality)
FROM
    goats;