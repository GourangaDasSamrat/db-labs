-- 1. MySQL doesn't use CASCADE with DROP TABLE.
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS goat_profiles;

SET FOREIGN_KEY_CHECKS = 1;

-- 2. Create Table
CREATE TABLE
    goat_profiles (
        -- Primary ID can be VARCHAR or CHAR, but let's stick to CHAR for consistency
        id CHAR(36) PRIMARY KEY DEFAULT(UUID()),
        -- This MUST be CHAR(36) to match goats.id
        goat_id CHAR(36) NOT NULL UNIQUE,
        nickname VARCHAR(100),
        debut_year INT NOT NULL,
        career_titles INT NOT NULL DEFAULT 0,
        est_net_worth_usd BIGINT,
        biography TEXT,
        CONSTRAINT fk_goat FOREIGN KEY (goat_id) REFERENCES goats (id) ON DELETE CASCADE,
        CONSTRAINT check_debut_year CHECK (debut_year >= 1900),
        CONSTRAINT check_titles_positive CHECK (career_titles >= 0)
    ) ENGINE = InnoDB;

-- 3. Insert Data
-- The subqueries for IDs remain the same.
-- Note: Ensure the 'goats' table 'id' column is also VARCHAR(36).
INSERT INTO
    goat_profiles (
        goat_id,
        nickname,
        debut_year,
        career_titles,
        est_net_worth_usd,
        biography
    )
VALUES
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Alyssa Healy'
        ),
        'Heals',
        2010,
        4,
        5000000,
        'Australian...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Magnus Carlsen'
        ),
        'The Mozart of Chess',
        2004,
        5,
        50000000,
        'Norwegian...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Lionel Messi'
        ),
        'La Pulga',
        2004,
        44,
        600000000,
        'Eight-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Michael Jordan'
        ),
        'Air Jordan',
        1984,
        6,
        3000000000,
        'Six NBA...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Aryna Sabalenka'
        ),
        'Sasha',
        2015,
        20,
        30000000,
        'Belarusian...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Michael Phelps'
        ),
        'The Baltimore Bullet',
        2000,
        28,
        100000000,
        'Most decorated...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Usain Bolt'
        ),
        'Lightning Bolt',
        2001,
        8,
        90000000,
        'Jamaican...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Tom Brady'
        ),
        'The GOAT',
        2000,
        7,
        350000000,
        'Seven-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Tiger Woods'
        ),
        'Tiger',
        1996,
        82,
        1000000000,
        '15-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Wayne Gretzky'
        ),
        'The Great One',
        1979,
        4,
        250000000,
        'Holds 61...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Simone Biles'
        ),
        'The GOAT',
        2013,
        37,
        16000000,
        'Has more...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Lewis Hamilton'
        ),
        'LH44',
        2007,
        7,
        300000000,
        'Seven-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Muhammad Ali'
        ),
        'The Greatest',
        1960,
        3,
        50000000,
        'Three-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Jon Jones'
        ),
        'Bones',
        2008,
        14,
        10000000,
        'Longest-reigning...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Kelly Slater'
        ),
        'The King',
        1990,
        11,
        20000000,
        '11-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Lin Dan'
        ),
        'Super Dan',
        2000,
        6,
        30000000,
        'Only player...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Ma Long'
        ),
        'The Dragon',
        2005,
        22,
        50000000,
        'First player...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Katie Ledecky'
        ),
        'The Ledecky Express',
        2012,
        19,
        15000000,
        'Dominant...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Ronnie O''Sullivan'
        ),
        'The Rocket',
        1992,
        7,
        15000000,
        'Seven-time...'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                NAME = 'Eddy Merckx'
        ),
        'The Cannibal',
        1965,
        11,
        10000000,
        'Won all five...'
    );

-- 4. Simple JOIN
SELECT
    g.name,
    g.sport,
    g.nationality,
    p.nickname,
    p.debut_year,
    p.career_titles,
    p.est_net_worth_usd
FROM
    goats g
    JOIN goat_profiles p ON p.goat_id = g.id
ORDER BY
    g.world_rank;

-- 5. LEFT JOIN
-- MySQL doesn't use 'NULLS LAST'. Instead, we use a boolean sort trick.
SELECT
    g.name,
    g.sport,
    p.est_net_worth_usd
FROM
    goats g
    LEFT JOIN goat_profiles p ON p.goat_id = g.id
ORDER BY
    (p.est_net_worth_usd IS NULL),
    p.est_net_worth_usd DESC
LIMIT
    5;

-- 6. Year Extraction
-- MySQL uses YEAR(NOW()) instead of EXTRACT.
SELECT
    g.name,
    g.sport,
    p.debut_year,
    (YEAR(NOW()) - p.debut_year) AS career_years
FROM
    goats g
    JOIN goat_profiles p ON p.goat_id = g.id
ORDER BY
    career_years DESC;