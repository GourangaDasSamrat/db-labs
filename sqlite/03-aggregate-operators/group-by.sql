-- Count athletes per nationality
SELECT
    nationality,
    COUNT(name)
FROM
    goats
GROUP BY
    nationality;

-- Sum of ages per nationality
SELECT
    nationality,
    SUM(age)
FROM
    goats
GROUP BY
    nationality;