CREATE TABLE
    IF NOT EXISTS players (
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        RANK INT NOT NULL,
        point INT NOT NULL DEFAULT 0,
        age INT CHECK (age > 0),
        nationality VARCHAR(100) NOT NULL,

        CONSTRAINT unique_player_name UNIQUE (name),
        CONSTRAINT unique_rank UNIQUE (RANK),
        CONSTRAINT positive_rank CHECK (RANK > 0),
        CONSTRAINT positive_point CHECK (point >= 0)
    );