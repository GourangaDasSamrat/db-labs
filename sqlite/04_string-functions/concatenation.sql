-- concat
-- SQLite uses the || operator for string concatenation
SELECT
    name || ' ' || nationality AS Concaved
FROM
    goats;

-- concat with separator
-- Since there is no CONCAT_WS, we manually join with the separator
SELECT
    name || ' ' || nationality AS Concaved
FROM
    goats;