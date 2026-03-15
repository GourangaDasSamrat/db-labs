-- Many-to-Many: goats <-> sponsors via goat_sponsors junction table
-- One goat can have many sponsors. One sponsor can back many goats.
-- The junction table holds FKs to both sides plus extra deal data.
-- The composite PK (goat_id, sponsor_id) prevents duplicate pairs.
DROP TABLE IF EXISTS goat_sponsors CASCADE;

DROP TABLE IF EXISTS sponsors CASCADE;

CREATE TABLE
    sponsors (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        brand_name VARCHAR(150) NOT NULL UNIQUE,
        industry VARCHAR(100) NOT NULL,
        country VARCHAR(100) NOT NULL,
        founded_year INT,
        CONSTRAINT check_founded CHECK (
            founded_year IS NULL
            OR founded_year > 1800
        )
    );

-- Junction table: the composite PK is what makes this many-to-many.
-- Each unique (goat_id, sponsor_id) pair is one deal row.
CREATE TABLE
    goat_sponsors (
        goat_id UUID NOT NULL REFERENCES goats (id) ON DELETE CASCADE,
        sponsor_id UUID NOT NULL REFERENCES sponsors (id) ON DELETE CASCADE,
        deal_value_usd BIGINT,
        start_year INT NOT NULL,
        end_year INT, -- NULL means currently active
        is_primary BOOLEAN NOT NULL DEFAULT FALSE,
        PRIMARY KEY (goat_id, sponsor_id),
        CONSTRAINT check_deal_years CHECK (
            end_year IS NULL
            OR end_year >= start_year
        ),
        CONSTRAINT check_start_year CHECK (start_year >= 1900)
    );

CREATE INDEX idx_gs_goat_id ON goat_sponsors (goat_id);

CREATE INDEX idx_gs_sponsor_id ON goat_sponsors (sponsor_id);

INSERT INTO
    sponsors (brand_name, industry, country, founded_year)
VALUES
    ('Nike', 'Sportswear', 'USA', 1964),
    ('Adidas', 'Sportswear', 'Germany', 1949),
    ('Red Bull', 'Energy Drinks', 'Austria', 1987),
    ('Mercedes-Benz', 'Automotive', 'Germany', 1926),
    ('Rolex', 'Luxury Watches', 'Switzerland', 1905),
    ('Gatorade', 'Sports Drinks', 'USA', 1965),
    ('Emirates', 'Aviation', 'UAE', 1985),
    ('Pepsi', 'Beverages', 'USA', 1893),
    ('Under Armour', 'Sportswear', 'USA', 1996),
    (
        'Tag Heuer',
        'Luxury Watches',
        'Switzerland',
        1860
    );

-- Lionel Messi
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    35000000,
    2001,
    NULL,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lionel Messi'
    AND s.brand_name = 'Adidas';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    5000000,
    2008,
    2023,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lionel Messi'
    AND s.brand_name = 'Pepsi';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    4000000,
    2018,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lionel Messi'
    AND s.brand_name = 'Rolex';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    2000000,
    2015,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lionel Messi'
    AND s.brand_name = 'Emirates';

-- Michael Jordan
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    100000000,
    1984,
    NULL,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Michael Jordan'
    AND s.brand_name = 'Nike';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    18000000,
    1991,
    2023,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Michael Jordan'
    AND s.brand_name = 'Gatorade';

-- Tiger Woods
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    200000000,
    1996,
    2016,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Tiger Woods'
    AND s.brand_name = 'Nike';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    10000000,
    2016,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Tiger Woods'
    AND s.brand_name = 'Rolex';

-- Usain Bolt
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    10000000,
    2003,
    2017,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Usain Bolt'
    AND s.brand_name = 'Adidas';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    3000000,
    2008,
    2016,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Usain Bolt'
    AND s.brand_name = 'Gatorade';

-- Lewis Hamilton
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    60000000,
    2013,
    NULL,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lewis Hamilton'
    AND s.brand_name = 'Mercedes-Benz';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    5000000,
    2016,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lewis Hamilton'
    AND s.brand_name = 'Tag Heuer';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    2000000,
    2018,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Lewis Hamilton'
    AND s.brand_name = 'Emirates';

-- Simone Biles
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    8000000,
    2016,
    NULL,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Simone Biles'
    AND s.brand_name = 'Nike';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    2500000,
    2016,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Simone Biles'
    AND s.brand_name = 'Gatorade';

-- Michael Phelps
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    5000000,
    2010,
    NULL,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Michael Phelps'
    AND s.brand_name = 'Under Armour';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    3000000,
    2014,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Michael Phelps'
    AND s.brand_name = 'Tag Heuer';

-- Tom Brady
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    8000000,
    2010,
    2022,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Tom Brady'
    AND s.brand_name = 'Under Armour';

-- Aryna Sabalenka
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    4000000,
    2021,
    NULL,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Aryna Sabalenka'
    AND s.brand_name = 'Adidas';

INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    1500000,
    2022,
    NULL,
    FALSE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Aryna Sabalenka'
    AND s.brand_name = 'Red Bull';

-- Wayne Gretzky
INSERT INTO
    goat_sponsors (
        goat_id,
        sponsor_id,
        deal_value_usd,
        start_year,
        end_year,
        is_primary
    )
SELECT
    g.id,
    s.id,
    5000000,
    1985,
    1999,
    TRUE
FROM
    goats g,
    sponsors s
WHERE
    g.name = 'Wayne Gretzky'
    AND s.brand_name = 'Rolex';

-- Full matrix: every deal with athlete and sponsor details
SELECT
    g.name AS athlete,
    g.sport,
    s.brand_name AS sponsor,
    s.industry,
    gs.deal_value_usd,
    gs.start_year,
    gs.end_year,
    gs.is_primary,
    CASE
        WHEN gs.end_year IS NULL THEN 'Active'
        ELSE 'Ended'
    END AS status
FROM
    goats g
    JOIN goat_sponsors gs ON gs.goat_id = g.id
    JOIN sponsors s ON s.id = gs.sponsor_id
ORDER BY
    g.world_rank,
    gs.is_primary DESC;

-- Which athletes does Nike sponsor?
SELECT
    g.name,
    g.sport,
    gs.deal_value_usd,
    gs.start_year
FROM
    goats g
    JOIN goat_sponsors gs ON gs.goat_id = g.id
    JOIN sponsors s ON s.id = gs.sponsor_id
WHERE
    s.brand_name = 'Nike';

-- Which sponsors back the most athletes?
SELECT
    s.brand_name,
    s.industry,
    COUNT(DISTINCT gs.goat_id) AS athletes_sponsored,
    SUM(gs.deal_value_usd) AS total_investment_usd
FROM
    sponsors s
    JOIN goat_sponsors gs ON gs.sponsor_id = s.id
GROUP BY
    s.id,
    s.brand_name,
    s.industry
ORDER BY
    athletes_sponsored DESC,
    total_investment_usd DESC;

-- Athletes sponsored by BOTH Nike and Adidas (set intersection via EXISTS)
SELECT
    g.name,
    g.sport
FROM
    goats g
WHERE
    EXISTS (
        SELECT
            1
        FROM
            goat_sponsors gs
            JOIN sponsors s ON s.id = gs.sponsor_id
        WHERE
            gs.goat_id = g.id
            AND s.brand_name = 'Nike'
    )
    AND EXISTS (
        SELECT
            1
        FROM
            goat_sponsors gs
            JOIN sponsors s ON s.id = gs.sponsor_id
        WHERE
            gs.goat_id = g.id
            AND s.brand_name = 'Adidas'
    );

-- Total active sponsorship income per athlete
SELECT
    g.name,
    g.sport,
    SUM(gs.deal_value_usd) AS total_active_usd
FROM
    goats g
    JOIN goat_sponsors gs ON gs.goat_id = g.id
WHERE
    gs.end_year IS NULL
GROUP BY
    g.id,
    g.name,
    g.sport
ORDER BY
    total_active_usd DESC;

-- Goat with comma-separated sponsor list using STRING_AGG
SELECT
    g.name,
    g.sport,
    STRING_AGG (
        s.brand_name,
        ', '
        ORDER BY
            gs.is_primary DESC,
            s.brand_name
    ) AS sponsors
FROM
    goats g
    JOIN goat_sponsors gs ON gs.goat_id = g.id
    JOIN sponsors s ON s.id = gs.sponsor_id
GROUP BY
    g.id,
    g.name,
    g.sport
ORDER BY
    g.world_rank;