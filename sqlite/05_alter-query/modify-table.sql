-- SQLite does not support ALTER COLUMN.
-- 1. Create a new table with the desired schema
CREATE TABLE
    goats_new (
        id UUID PRIMARY KEY,
        name VARCHAR(150) NOT NULL,
        sport VARCHAR(100) NOT NULL,
        world_rank INT NOT NULL,
        age INT NOT NULL,
        nationality VARCHAR(100) NOT NULL DEFAULT 'unknown' -- Changed type, default, and NOT NULL
    );

-- 2. Copy data from the old table
INSERT INTO
    goats_new (id, name, sport, world_rank, age, nationality)
SELECT
    id,
    name,
    sport,
    world_rank,
    age,
    nationality
FROM
    goats;

-- 3. Drop the old table and rename the new one
DROP TABLE goats;

ALTER TABLE goats_new
RENAME TO goats;