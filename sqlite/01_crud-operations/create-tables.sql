CREATE TABLE
    IF NOT EXISTS players (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        RANK INTEGER NOT NULL,
        point INTEGER NOT NULL DEFAULT 0,
        age INTEGER CHECK (age > 0),
        nationality TEXT NOT NULL,

        CONSTRAINT unique_player_name UNIQUE (name),
        CONSTRAINT unique_rank UNIQUE (RANK),
        CONSTRAINT positive_rank CHECK (RANK > 0),
        CONSTRAINT positive_point CHECK (point >= 0)
    );