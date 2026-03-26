CREATE TABLE IF NOT EXISTS
    players (
        id INT AUTO_INCREMENT PRIMARY KEY,
        NAME VARCHAR(100) NOT NULL,
        `RANK` INT NOT NULL,
        POINT INT NOT NULL DEFAULT 0,
        age INT CHECK (age > 0),
        nationality VARCHAR(100) NOT NULL,
        CONSTRAINT unique_player_name UNIQUE (NAME),
        CONSTRAINT unique_rank UNIQUE (`RANK`),
        CONSTRAINT positive_rank CHECK (`RANK` > 0),
        CONSTRAINT positive_point CHECK (POINT >= 0)
    ) ENGINE = InnoDB;
