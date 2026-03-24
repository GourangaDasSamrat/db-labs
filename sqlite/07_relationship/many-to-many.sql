PRAGMA foreign_keys = ON;

-- 1. Create the Sponsors table
DROP TABLE IF EXISTS sponsors;
CREATE TABLE sponsors (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    brand_name VARCHAR(150) NOT NULL UNIQUE,
    industry VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    founded_year INT,
    CONSTRAINT check_founded CHECK (founded_year > 1800)
);

-- 2. Create the Junction Table (The "N:N" Bridge)
DROP TABLE IF EXISTS goat_sponsors;
CREATE TABLE goat_sponsors (
    goat_id TEXT NOT NULL,
    sponsor_id TEXT NOT NULL,
    deal_value_usd BIGINT,
    start_year INT NOT NULL,
    is_primary BOOLEAN DEFAULT 0,
    -- Composite Primary Key ensures no duplicate athlete-sponsor pairs
    PRIMARY KEY (goat_id, sponsor_id),
    FOREIGN KEY (goat_id) REFERENCES goats (id) ON DELETE CASCADE,
    FOREIGN KEY (sponsor_id) REFERENCES sponsors (id) ON DELETE CASCADE
);

-- Populate Sponsors
INSERT INTO sponsors (brand_name, industry, country, founded_year)
VALUES
    ('Nike', 'Sportswear', 'USA', 1964),
    ('Adidas', 'Sportswear', 'Germany', 1949),
    ('Red Bull', 'Beverages', 'Austria', 1987),
    ('Rolex', 'Luxury Goods', 'Switzerland', 1905),
    ('Apple', 'Technology', 'USA', 1976),
    ('Visa', 'Finance', 'USA', 1958);

-- Create Many-to-Many Links
INSERT INTO goat_sponsors (goat_id, sponsor_id, deal_value_usd, start_year, is_primary)
VALUES
    -- Lionel Messi (Nike, Adidas, Apple)
    ((SELECT id FROM goats WHERE name = 'Lionel Messi'), (SELECT id FROM sponsors WHERE brand_name = 'Adidas'), 30000000, 2006, 1),
    ((SELECT id FROM goats WHERE name = 'Lionel Messi'), (SELECT id FROM sponsors WHERE brand_name = 'Apple'), 20000000, 2023, 0),

    -- Michael Jordan (Nike)
    ((SELECT id FROM goats WHERE name = 'Michael Jordan'), (SELECT id FROM sponsors WHERE brand_name = 'Nike'), 150000000, 1984, 1),

    -- Lewis Hamilton (Rolex, Mercedes/Monster)
    ((SELECT id FROM goats WHERE name = 'Lewis Hamilton'), (SELECT id FROM sponsors WHERE brand_name = 'Rolex'), 10000000, 2013, 0),

    -- Tiger Woods (Nike, Rolex)
    ((SELECT id FROM goats WHERE name = 'Tiger Woods'), (SELECT id FROM sponsors WHERE brand_name = 'Nike'), 40000000, 1996, 1),
    ((SELECT id FROM goats WHERE name = 'Tiger Woods'), (SELECT id FROM sponsors WHERE brand_name = 'Rolex'), 8000000, 2011, 0),

    -- Max Verstappen/Kelly Slater (Red Bull)
    ((SELECT id FROM goats WHERE name = 'Kelly Slater'), (SELECT id FROM sponsors WHERE brand_name = 'Red Bull'), 2000000, 2010, 1),

    -- Usain Bolt (Visa, Puma/Adidas equivalent)
    ((SELECT id FROM goats WHERE name = 'Usain Bolt'), (SELECT id FROM sponsors WHERE brand_name = 'Visa'), 5000000, 2012, 0),

    -- Aryna Sabalenka (Nike)
    ((SELECT id FROM goats WHERE name = 'Aryna Sabalenka'), (SELECT id FROM sponsors WHERE brand_name = 'Nike'), 3000000, 2017, 1);