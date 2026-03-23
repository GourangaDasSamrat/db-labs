-- sub str
-- SQLite uses SUBSTR(string, start, length)
SELECT
    SUBSTR (name, 1, 6) AS name
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
-- SQLite does NOT have a built-in REVERSE function.
-- You would typically need a custom extension or handle this in your application code.
SELECT
    'REVERSE not supported in native SQLite' AS sport;

-- left
-- Handled using SUBSTR(string, 1, n)
SELECT
    SUBSTR (name, 1, 5)
FROM
    goats;

-- right
-- Handled using SUBSTR(string, -n)
SELECT
    SUBSTR (name, -5)
FROM
    goats;

-- position
-- SQLite uses INSTR(string, substring) which returns the 1-based index
SELECT
    nationality,
    INSTR (nationality, 'A')
FROM
    goats;