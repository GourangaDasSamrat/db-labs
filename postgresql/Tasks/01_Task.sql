-- 1. Drop the table if it exists to ensure a clean start
DROP TABLE IF EXISTS goats;

-- 2. Enable the pgcrypto extension to generate random UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 3. Create the table with UUID and strict constraints
CREATE TABLE
    goats (
        -- id uses UUID instead of INT for unpredictable, MongoDB-style IDs
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        name VARCHAR(150) NOT NULL,
        sport VARCHAR(100) NOT NULL,
        world_rank INT NOT NULL,
        age INT NOT NULL,
        nationality VARCHAR(100) NOT NULL,

        -- Constraint: Ensures each sport has only one designated 'GOAT'
        CONSTRAINT uq_one_goat_per_sport UNIQUE (sport),
        -- Constraint: Prevents duplicate athlete names
        CONSTRAINT uq_goat_name UNIQUE (name),
        -- Logical checks for data validity
        CONSTRAINT check_positive_age CHECK (age > 0),
        CONSTRAINT check_positive_rank CHECK (world_rank > 0)
    );

-- 4. Insert 20 legendary records (ID is auto-generated)
INSERT INTO
    goats (name, sport, world_rank, age, nationality)
VALUES
    ('Alyssa Healy', 'Cricket', 1, 35, 'Australia'),
    ('Magnus Carlsen', 'Chess', 2, 35, 'Norway'),
    ('Lionel Messi', 'Soccer', 3, 38, 'Argentina'),
    ('Michael Jordan', 'Basketball', 4, 63, 'USA'),
    ('Aryna Sabalenka', 'Tennis', 5, 27, 'Belarus'),
    ('Michael Phelps', 'Swimming', 6, 40, 'USA'),
    ('Usain Bolt', 'Athletics', 7, 39, 'Jamaica'),
    ('Tom Brady', 'American Football', 8, 48, 'USA'),
    ('Tiger Woods', 'Golf', 9, 50, 'USA'),
    ('Wayne Gretzky', 'Ice Hockey', 10, 65, 'Canada'),
    ('Simone Biles', 'Gymnastics', 11, 28, 'USA'),
    (
        'Lewis Hamilton',
        'Formula One',
        12,
        41,
        'United Kingdom'
    ),
    ('Muhammad Ali', 'Boxing', 13, 74, 'USA'),
    ('Jon Jones', 'MMA', 14, 38, 'USA'),
    ('Kelly Slater', 'Surfing', 15, 54, 'USA'),
    ('Lin Dan', 'Badminton', 16, 42, 'China'),
    ('Ma Long', 'Table Tennis', 17, 37, 'China'),
    (
        'Katie Ledecky',
        'Distance Swimming',
        18,
        28,
        'USA'
    ),
    (
        'Ronnie O''Sullivan',
        'Snooker',
        19,
        50,
        'United Kingdom'
    ),
    ('Eddy Merckx', 'Cycling', 20, 80, 'Belgium');

-- 5. Query the data to verify the results
SELECT
    *
FROM
    goats
ORDER BY
    world_rank ASC;