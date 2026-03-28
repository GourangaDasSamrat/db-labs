-- 1. Drop Table (Disabling checks to avoid dependency errors)
SET
    FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS goat_achievements;

SET
    FOREIGN_KEY_CHECKS = 1;

-- 2. Create Table
CREATE TABLE
    goat_achievements (
        id CHAR(36) PRIMARY KEY DEFAULT(UUID()),
        -- goat_id must be CHAR(36) to match your goats table id
        goat_id CHAR(36) NOT NULL,
        title VARCHAR(200) NOT NULL,
        year_achieved INT NOT NULL,
        category VARCHAR(50) NOT NULL,
        DESCRIPTION TEXT,
        -- Foreign Key Definition
        CONSTRAINT fk_achievements_goat FOREIGN KEY (goat_id) REFERENCES goats (id) ON DELETE CASCADE,
        -- Check Constraints (MySQL 8.0.16+)
        CONSTRAINT check_category CHECK (
            category IN (
                'Olympic',
                'World Championship',
                'Grand Slam',
                'League Title',
                'Individual Award',
                'Record'
            )
        ),
        CONSTRAINT check_year CHECK (year_achieved BETWEEN 1900 AND 2100)
    ) ENGINE = InnoDB;

-- 3. Create Index
CREATE INDEX idx_achievements_goat_id ON goat_achievements (goat_id);

-- 4. Insert Data (MySQL supports the INSERT ... SELECT syntax)
-- Lionel Messi
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'FIFA World Cup',
    2022,
    'World Championship',
    'Finally won the trophy in Qatar.'
FROM
    goats
WHERE
    NAME = 'Lionel Messi';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Ballon d''Or',
    2023,
    'Individual Award',
    'Record eighth Ballon d''Or.'
FROM
    goats
WHERE
    NAME = 'Lionel Messi';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Copa America',
    2021,
    'World Championship',
    'First international trophy with Argentina.'
FROM
    goats
WHERE
    NAME = 'Lionel Messi';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'UEFA Champions League',
    2015,
    'League Title',
    'Won with FC Barcelona.'
FROM
    goats
WHERE
    NAME = 'Lionel Messi';

-- Michael Phelps
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Olympic Gold — 200m Butterfly',
    2008,
    'Olympic',
    'Part of record 8-gold-medal haul in Beijing.'
FROM
    goats
WHERE
    NAME = 'Michael Phelps';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Olympic Gold — 100m Butterfly',
    2008,
    'Olympic',
    'Won by 0.01 second in Beijing.'
FROM
    goats
WHERE
    NAME = 'Michael Phelps';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'World Record — 400m IM',
    2008,
    'Record',
    'Set world record of 4:03.84 in Beijing.'
FROM
    goats
WHERE
    NAME = 'Michael Phelps';

-- Usain Bolt
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Olympic Gold — 100m',
    2008,
    'Olympic',
    'First Olympic 100m gold in Beijing.'
FROM
    goats
WHERE
    NAME = 'Usain Bolt';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'World Record — 100m',
    2009,
    'Record',
    'Set 9.58s world record in Berlin.'
FROM
    goats
WHERE
    NAME = 'Usain Bolt';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Olympic Gold — 200m',
    2016,
    'Olympic',
    'Third consecutive 200m Olympic gold.'
FROM
    goats
WHERE
    NAME = 'Usain Bolt';

-- Simone Biles
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'World Championship All-Around',
    2023,
    'World Championship',
    'Sixth world all-around title.'
FROM
    goats
WHERE
    NAME = 'Simone Biles';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Olympic Gold — All-Around',
    2016,
    'Olympic',
    'Dominated Rio Olympics with four golds.'
FROM
    goats
WHERE
    NAME = 'Simone Biles';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Paris Olympic Gold',
    2024,
    'Olympic',
    'Returned to Olympics and won team gold.'
FROM
    goats
WHERE
    NAME = 'Simone Biles';

-- Tiger Woods
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'The Masters',
    2019,
    'Grand Slam',
    'Historic comeback victory at Augusta.'
FROM
    goats
WHERE
    NAME = 'Tiger Woods';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'PGA Championship',
    1999,
    'Grand Slam',
    'Dominated by 5 strokes at Medinah.'
FROM
    goats
WHERE
    NAME = 'Tiger Woods';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Career Grand Slam',
    2000,
    'Individual Award',
    'Youngest to complete career grand slam.'
FROM
    goats
WHERE
    NAME = 'Tiger Woods';

-- Magnus Carlsen
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'FIDE World Chess Championship',
    2013,
    'World Championship',
    'Became World Champion at age 22.'
FROM
    goats
WHERE
    NAME = 'Magnus Carlsen';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Peak Elo Rating 2882',
    2014,
    'Record',
    'Highest FIDE rating ever recorded.'
FROM
    goats
WHERE
    NAME = 'Magnus Carlsen';

-- Tom Brady
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Super Bowl LV',
    2021,
    'League Title',
    'Won with Tampa Bay Buccaneers aged 43.'
FROM
    goats
WHERE
    NAME = 'Tom Brady';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Super Bowl XLIX',
    2015,
    'League Title',
    'Epic comeback vs Seattle Seahawks.'
FROM
    goats
WHERE
    NAME = 'Tom Brady';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'NFL MVP Award',
    2017,
    'Individual Award',
    'Named league MVP at age 40.'
FROM
    goats
WHERE
    NAME = 'Tom Brady';

-- Lewis Hamilton
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'F1 World Championship',
    2020,
    'World Championship',
    'Seventh title equaling Schumacher''s record.'
FROM
    goats
WHERE
    NAME = 'Lewis Hamilton';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'F1 World Championship',
    2014,
    'World Championship',
    'First title with Mercedes AMG.'
FROM
    goats
WHERE
    NAME = 'Lewis Hamilton';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        DESCRIPTION
    )
SELECT
    id,
    'Most F1 Race Wins',
    2020,
    'Record',
    'Surpassed Schumacher''s record of 91 wins.'
FROM
    goats
WHERE
    NAME = 'Lewis Hamilton';


-- 5. Queries
-- Count achievements per athlete
SELECT
    g.name,
    g.sport,
    COUNT(a.id) AS total_achievements
FROM
    goats g
    LEFT JOIN goat_achievements a ON a.goat_id = g.id
GROUP BY
    g.id,
    g.name,
    g.sport
ORDER BY
    total_achievements DESC;

-- Latest achievement per athlete
-- MySQL doesn't have "DISTINCT ON". We use a Window Function (ROW_NUMBER) instead.
SELECT
    NAME,
    sport,
    title AS latest_achievement,
    year_achieved
FROM
    (
        SELECT
            g.name,
            g.sport,
            a.title,
            a.year_achieved,
            ROW_NUMBER() OVER (
                PARTITION BY
                    g.name
                ORDER BY
                    a.year_achieved DESC
            ) AS rn
        FROM
            goats g
            JOIN goat_achievements a ON a.goat_id = g.id
    ) AS t
WHERE
    rn = 1
ORDER BY
    NAME;

-- Olympic achievements only
SELECT
    g.name,
    g.nationality,
    COUNT(a.id) AS olympic_golds
FROM
    goats g
    JOIN goat_achievements a ON a.goat_id = g.id
WHERE
    a.category = 'Olympic'
GROUP BY
    g.id,
    g.name,
    g.nationality
ORDER BY
    olympic_golds DESC;