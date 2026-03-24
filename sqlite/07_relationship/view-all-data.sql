-- 1. FULL OVERVIEW (1:1)
-- Shows every Goat and their specific Profile details
SELECT
    g.name,
    g.sport,
    g.nationality,
    p.nickname,
    p.debut_year,
    p.career_titles,
    p.biography
FROM goats g
LEFT JOIN goat_profiles p ON g.id = p.goat_id
ORDER BY g.world_rank ASC;

-- 2. ACHIEVEMENT LOG (1:M)
-- Shows every individual trophy/record for every athlete
SELECT
    g.name,
    a.year_achieved,
    a.title,
    a.category,
    a.description
FROM goats g
JOIN goat_achievements a ON g.id = a.goat_id
ORDER BY g.name, a.year_achieved DESC;

-- 3. SPONSORSHIP DEALS (N:N)
-- Shows the bridge between athletes and global brands
SELECT
    g.name AS athlete,
    s.brand_name AS sponsor,
    s.industry,
    gs.deal_value_usd,
    gs.start_year
FROM goats g
JOIN goat_sponsors gs ON g.id = gs.goat_id
JOIN sponsors s ON s.id = gs.sponsor_id
ORDER BY gs.deal_value_usd DESC;

-- 4. THE "MASTER VIEW" (Aggregated)
-- One row per athlete with counts of their achievements and sponsors
SELECT
    g.name,
    g.sport,
    p.career_titles,
    (SELECT COUNT(*) FROM goat_achievements WHERE goat_id = g.id) AS total_logged_achievements,
    (SELECT COUNT(*) FROM goat_sponsors WHERE goat_id = g.id) AS total_sponsors,
    p.est_net_worth_usd
FROM goats g
LEFT JOIN goat_profiles p ON g.id = p.goat_id
ORDER BY p.est_net_worth_usd DESC;