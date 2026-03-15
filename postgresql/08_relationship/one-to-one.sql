-- One-to-One: goats <-> goat_profiles
-- Each goat has exactly one profile. The UNIQUE constraint on goat_id
-- is what enforces the "one" side — without it this would be one-to-many.
DROP TABLE IF EXISTS goat_profiles CASCADE;

CREATE TABLE
    goat_profiles (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        goat_id UUID NOT NULL UNIQUE REFERENCES goats (id) ON DELETE CASCADE, -- UNIQUE = one-to-one
        nickname VARCHAR(100),
        debut_year INT NOT NULL,
        career_titles INT NOT NULL DEFAULT 0,
        est_net_worth_usd BIGINT,
        biography TEXT,
        CONSTRAINT check_debut_year CHECK (debut_year >= 1900),
        CONSTRAINT check_titles_positive CHECK (career_titles >= 0)
    );

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
                name = 'Alyssa Healy'
        ),
        'Heals',
        2010,
        4,
        5000000,
        'Australian wicketkeeper-batter and captain of the Women''s national team.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Magnus Carlsen'
        ),
        'The Mozart of Chess',
        2004,
        5,
        50000000,
        'Norwegian prodigy who became the highest-rated chess player in history.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Lionel Messi'
        ),
        'La Pulga',
        2004,
        44,
        600000000,
        'Eight-time Ballon d''Or winner and 2022 FIFA World Cup champion.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Michael Jordan'
        ),
        'Air Jordan',
        1984,
        6,
        3000000000,
        'Six NBA championships; widely considered the greatest basketball player ever.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Aryna Sabalenka'
        ),
        'Sasha',
        2015,
        20,
        30000000,
        'Belarusian power-hitter with back-to-back Australian Open titles.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Michael Phelps'
        ),
        'The Baltimore Bullet',
        2000,
        28,
        100000000,
        'Most decorated Olympian of all time with 28 Olympic medals (23 gold).'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Usain Bolt'
        ),
        'Lightning Bolt',
        2001,
        8,
        90000000,
        'Jamaican sprinter holding world records in 100m and 200m.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Tom Brady'
        ),
        'The GOAT',
        2000,
        7,
        350000000,
        'Seven-time Super Bowl champion across three franchises.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Tiger Woods'
        ),
        'Tiger',
        1996,
        82,
        1000000000,
        '15-time major champion; revitalized global interest in golf.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Wayne Gretzky'
        ),
        'The Great One',
        1979,
        4,
        250000000,
        'Holds 61 NHL records; only player to score over 200 points in a season.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Simone Biles'
        ),
        'The GOAT',
        2013,
        37,
        16000000,
        'Has more World Championship medals than any gymnast in history.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Lewis Hamilton'
        ),
        'LH44',
        2007,
        7,
        300000000,
        'Seven-time Formula One World Champion; equal record with Michael Schumacher.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Muhammad Ali'
        ),
        'The Greatest',
        1960,
        3,
        50000000,
        'Three-time heavyweight boxing world champion and cultural icon.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Jon Jones'
        ),
        'Bones',
        2008,
        14,
        10000000,
        'Longest-reigning UFC light heavyweight champion; also UFC heavyweight champion.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Kelly Slater'
        ),
        'The King',
        1990,
        11,
        20000000,
        '11-time World Surf League champion; youngest and oldest to win the title.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Lin Dan'
        ),
        'Super Dan',
        2000,
        6,
        30000000,
        'Only player to win all nine major BWF titles; two-time Olympic champion.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Ma Long'
        ),
        'The Dragon',
        2005,
        22,
        50000000,
        'First player to complete the "super grand slam" in table tennis.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Katie Ledecky'
        ),
        'The Ledecky Express',
        2012,
        19,
        15000000,
        'Dominant distance swimmer with seven Olympic gold medals.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Ronnie O''Sullivan'
        ),
        'The Rocket',
        1992,
        7,
        15000000,
        'Seven-time World Snooker Champion; known for highest centuries and fastest maximum break.'
    ),
    (
        (
            SELECT
                id
            FROM
                goats
            WHERE
                name = 'Eddy Merckx'
        ),
        'The Cannibal',
        1965,
        11,
        10000000,
        'Won all five cycling monuments and all three Grand Tours multiple times.'
    );

-- Simple JOIN: every goat with their profile
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

-- LEFT JOIN to show goats with no profile (nulls appear at the bottom)
SELECT
    g.name,
    g.sport,
    p.est_net_worth_usd
FROM
    goats g
    LEFT JOIN goat_profiles p ON p.goat_id = g.id
ORDER BY
    p.est_net_worth_usd DESC NULLS LAST
LIMIT
    5;

-- Longest careers calculated from debut year to now
SELECT
    g.name,
    g.sport,
    p.debut_year,
    (
        EXTRACT(
            YEAR
            FROM
                NOW ()
        ) - p.debut_year
    ) AS career_years
FROM
    goats g
    JOIN goat_profiles p ON p.goat_id = g.id
ORDER BY
    career_years DESC;