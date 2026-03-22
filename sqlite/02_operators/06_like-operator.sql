-- first word is `A`
SELECT
    *
FROM
    goats
WHERE
    name LIKE 'A%';

-- last word is `i`
SELECT
    *
FROM
    goats
WHERE
    name LIKE '%i';

-- middle word is `y`
SELECT
    *
FROM
    goats
WHERE
    name LIKE '%y%';

-- nationality is 3 character
SELECT
    *
FROM
    goats
WHERE
    nationality LIKE '___';

-- nationality 2nd character is a
SELECT
    *
FROM
    goats
WHERE
    nationality LIKE '_a%';