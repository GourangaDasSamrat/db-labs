-- 1. Drop Tables (Handle dependencies)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS goat_sponsors;
DROP TABLE IF EXISTS sponsors;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. Create Sponsors Table
CREATE TABLE sponsors (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    brand_name VARCHAR(150) NOT NULL UNIQUE,
    industry VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    founded_year INT,
    CONSTRAINT check_founded CHECK (founded_year IS NULL OR founded_year > 1800)
) ENGINE = InnoDB;

-- 3. Create Junction Table (Many-to-Many)
CREATE TABLE goat_sponsors (
    goat_id CHAR(36) NOT NULL,
    sponsor_id CHAR(36) NOT NULL,
    deal_value_usd BIGINT,
    start_year INT NOT NULL,
    end_year INT, -- NULL means currently active
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (goat_id, sponsor_id),
    CONSTRAINT fk_gs_goat FOREIGN KEY (goat_id) REFERENCES goats (id) ON DELETE CASCADE,
    CONSTRAINT fk_gs_sponsor FOREIGN KEY (sponsor_id) REFERENCES sponsors (id) ON DELETE CASCADE,
    CONSTRAINT check_deal_years CHECK (end_year IS NULL OR end_year >= start_year),
    CONSTRAINT check_start_year CHECK (start_year >= 1900)
) ENGINE = InnoDB;

-- 4. Create Indexes
CREATE INDEX idx_gs_goat_id ON goat_sponsors (goat_id);
CREATE INDEX idx_gs_sponsor_id ON goat_sponsors (sponsor_id);

-- 5. Insert Sponsors
INSERT INTO sponsors (brand_name, industry, country, founded_year)
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
    ('Tag Heuer', 'Luxury Watches', 'Switzerland', 1860);

-- 6. Insert Junction Data (Example: Messi)
-- Using CROSS JOIN logic (comma in FROM) works the same in MySQL
INSERT INTO goat_sponsors (goat_id, sponsor_id, deal_value_usd, start_year, end_year, is_primary)
SELECT g.id, s.id, 35000000, 2001, NULL, TRUE
FROM goats g, sponsors s
WHERE g.name = 'Lionel Messi' AND s.brand_name = 'Adidas';

-- ... (Repeat similar INSERT logic for other athletes as provided in your PG code) ...

-- 7. QUERIES

-- Matrix Query
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
FROM goats g
JOIN goat_sponsors gs ON gs.goat_id = g.id
JOIN sponsors s ON s.id = gs.sponsor_id
ORDER BY g.world_rank, gs.is_primary DESC;

-- Sponsors with most athletes
SELECT
    s.brand_name,
    s.industry,
    COUNT(DISTINCT gs.goat_id) AS athletes_sponsored,
    SUM(gs.deal_value_usd) AS total_investment_usd
FROM sponsors s
JOIN goat_sponsors gs ON gs.sponsor_id = s.id
GROUP BY s.id, s.brand_name, s.industry
ORDER BY athletes_sponsored DESC, total_investment_usd DESC;

-- Comma-separated list using GROUP_CONCAT
-- Note: MySQL syntax differs slightly from STRING_AGG
SELECT
    g.name,
    g.sport,
    GROUP_CONCAT(
        s.brand_name
        ORDER BY gs.is_primary DESC, s.brand_name
        SEPARATOR ', '
    ) AS sponsors
FROM goats g
JOIN goat_sponsors gs ON gs.goat_id = g.id
JOIN sponsors s ON s.id = gs.sponsor_id
GROUP BY g.id, g.name, g.sport
ORDER BY g.world_rank;