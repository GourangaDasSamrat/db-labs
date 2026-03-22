-- 1. Drop the table if it exists
DROP TABLE IF EXISTS goats;

-- 2. Create the table
-- Note: SQLite does not have a "pgcrypto" extension.
-- We use TEXT for the ID. If your environment supports it,
-- you can use (HEX(RANDOMBLOB(16))) for a UUID-like string.
CREATE TABLE goats (
    id TEXT PRIMARY KEY DEFAULT (
        lower(hex(randomblob(4))) || '-' ||
        lower(hex(randomblob(2))) || '-4' ||
        substr(lower(hex(randomblob(2))),2) || '-' ||
        substr('89ab',abs(random()) % 4 + 1, 1) ||
        substr(lower(hex(randomblob(2))),2) || '-' ||
        lower(hex(randomblob(6)))
    ),
    name TEXT NOT NULL,
    sport TEXT NOT NULL,
    world_rank INTEGER NOT NULL,
    age INTEGER NOT NULL,
    nationality TEXT NOT NULL,

    -- Constraints
    CONSTRAINT uq_one_goat_per_sport UNIQUE (sport),
    CONSTRAINT uq_goat_name UNIQUE (name),
    CONSTRAINT check_positive_age CHECK (age > 0),
    CONSTRAINT check_positive_rank CHECK (world_rank > 0)
);

-- 3. Insert 20 legendary records
-- Note: We omit 'id' so the DEFAULT UUID generator triggers.
INSERT INTO goats (name, sport, world_rank, age, nationality)
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
    ('Lewis Hamilton', 'Formula One', 12, 41, 'United Kingdom'),
    ('Muhammad Ali', 'Boxing', 13, 74, 'USA'),
    ('Jon Jones', 'MMA', 14, 38, 'USA'),
    ('Kelly Slater', 'Surfing', 15, 54, 'USA'),
    ('Lin Dan', 'Badminton', 16, 42, 'China'),
    ('Ma Long', 'Table Tennis', 17, 37, 'China'),
    ('Katie Ledecky', 'Distance Swimming', 18, 28, 'USA'),
    ('Ronnie O''Sullivan', 'Snooker', 19, 50, 'United Kingdom'),
    ('Eddy Merckx', 'Cycling', 20, 80, 'Belgium');

-- 4. Query the data
SELECT * FROM goats ORDER BY world_rank ASC;