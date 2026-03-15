-- View all tables and their data
-- Run this after all three relationship files have been executed.
-- All goats
SELECT
    *
FROM
    goats
ORDER BY
    world_rank;

-- All profiles joined with goat name
SELECT
    g.name,
    g.sport,
    p.nickname,
    p.debut_year,
    p.career_titles,
    p.est_net_worth_usd,
    p.biography
FROM
    goats g
    JOIN goat_profiles p ON p.goat_id = g.id
ORDER BY
    g.world_rank;

-- All achievements joined with goat name
SELECT
    g.name,
    g.sport,
    a.title,
    a.year_achieved,
    a.category,
    a.description
FROM
    goats g
    JOIN goat_achievements a ON a.goat_id = g.id
ORDER BY
    g.world_rank,
    a.year_achieved;

-- All sponsors
SELECT
    *
FROM
    sponsors
ORDER BY
    brand_name;

-- All sponsorship deals joined with both goat and sponsor names
SELECT
    g.name AS athlete,
    g.sport,
    s.brand_name AS sponsor,
    s.industry,
    gs.deal_value_usd,
    gs.start_year,
    gs.end_year,
    gs.is_primary
FROM
    goat_sponsors gs
    JOIN goats g ON g.id = gs.goat_id
    JOIN sponsors s ON s.id = gs.sponsor_id
ORDER BY
    g.world_rank,
    gs.is_primary DESC;

-- Row counts for every table at a glance
SELECT
    'goats' AS table_name,
    COUNT(*) AS row_count
FROM
    goats
UNION ALL
SELECT
    'goat_profiles',
    COUNT(*)
FROM
    goat_profiles
UNION ALL
SELECT
    'goat_achievements',
    COUNT(*)
FROM
    goat_achievements
UNION ALL
SELECT
    'sponsors',
    COUNT(*)
FROM
    sponsors
UNION ALL
SELECT
    'goat_sponsors',
    COUNT(*)
FROM
    goat_sponsors
ORDER BY
    table_name;