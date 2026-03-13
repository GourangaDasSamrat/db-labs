-- concat
SELECT
    CONCAT (name, ' ', nationality) AS Concaved
FROM
    goats;

-- concat with separator
SELECT
    CONCAT_WS (' ', name, nationality) AS Concaved
FROM
    goats;