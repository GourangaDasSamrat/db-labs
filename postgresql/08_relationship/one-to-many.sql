-- One-to-Many: goats (1) -> goat_achievements (many)
-- One goat can have many achievements. The FK goat_id has NO UNIQUE
-- constraint here, which is what allows multiple rows per goat.
DROP TABLE IF EXISTS goat_achievements CASCADE;

CREATE TABLE
    goat_achievements (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        goat_id UUID NOT NULL REFERENCES goats (id) ON DELETE CASCADE, -- no UNIQUE = one-to-many
        title VARCHAR(200) NOT NULL,
        year_achieved INT NOT NULL,
        category VARCHAR(50) NOT NULL CHECK (
            category IN (
                'Olympic',
                'World Championship',
                'Grand Slam',
                'League Title',
                'Individual Award',
                'Record'
            )
        ),
        description TEXT,
        CONSTRAINT check_year CHECK (year_achieved BETWEEN 1900 AND 2100)
    );

CREATE INDEX idx_achievements_goat_id ON goat_achievements (goat_id);

-- Lionel Messi
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lionel Messi';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lionel Messi';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lionel Messi';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lionel Messi';

-- Michael Phelps
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Michael Phelps';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Michael Phelps';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Michael Phelps';

-- Usain Bolt
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Usain Bolt';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Usain Bolt';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Usain Bolt';

-- Simone Biles
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Simone Biles';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Simone Biles';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Simone Biles';

-- Tiger Woods
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Tiger Woods';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Tiger Woods';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Tiger Woods';

-- Magnus Carlsen
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Magnus Carlsen';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Magnus Carlsen';

-- Tom Brady
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Tom Brady';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Tom Brady';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Tom Brady';

-- Lewis Hamilton
INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lewis Hamilton';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lewis Hamilton';

INSERT INTO
    goat_achievements (
        goat_id,
        title,
        year_achieved,
        category,
        description
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
    name = 'Lewis Hamilton';

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

-- All achievements for a specific athlete
SELECT
    g.name,
    a.title,
    a.year_achieved,
    a.category,
    a.description
FROM
    goats g
    JOIN goat_achievements a ON a.goat_id = g.id
WHERE
    g.name = 'Lionel Messi'
ORDER BY
    a.year_achieved;

-- Latest achievement per athlete using DISTINCT ON
SELECT DISTINCT
    ON (g.name) g.name,
    g.sport,
    a.title AS latest_achievement,
    a.year_achieved
FROM
    goats g
    JOIN goat_achievements a ON a.goat_id = g.id
ORDER BY
    g.name,
    a.year_achieved DESC;

-- Olympic achievements only, grouped by athlete
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