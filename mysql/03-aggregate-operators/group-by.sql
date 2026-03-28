SELECT
    nationality,
    COUNT(name)
FROM
    goats
GROUP BY
    nationality;

SELECT
    nationality,
    SUM(age)
FROM
    goats
GROUP BY
    nationality;