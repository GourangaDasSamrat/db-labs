CREATE TABLE
    IF NOT EXISTS players (
        id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(100),
        RANK INT,
        point INT,
        age INT,
        nationality VARCHAR(100)
    );