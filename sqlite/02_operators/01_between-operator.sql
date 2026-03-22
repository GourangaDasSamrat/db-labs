-- Between operator
SELECT
    *
FROM
    goats
WHERE
    world_rank BETWEEN 2 AND 8;

-- Not Between operator
SELECT
    *
FROM
    goats
WHERE
    world_rank NOT BETWEEN 2 AND 8;