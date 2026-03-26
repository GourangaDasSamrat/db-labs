-- All LIKE patterns are compatible between PG and MySQL
SELECT
    *
FROM
    goats
WHERE
    NAME LIKE 'A%';

SELECT
    *
FROM
    goats
WHERE
    NAME LIKE '%i';

SELECT
    *
FROM
    goats
WHERE
    NAME LIKE '%y%';

SELECT
    *
FROM
    goats
WHERE
    nationality LIKE '___';

SELECT
    *
FROM
    goats
WHERE
    nationality LIKE '_a%';