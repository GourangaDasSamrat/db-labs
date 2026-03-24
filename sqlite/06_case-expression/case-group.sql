SELECT
    CASE
        WHEN age < 18 THEN 'Young'
        WHEN age < 50 THEN 'Adult'
        WHEN age < 65 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_category,
    COUNT(id)
FROM
    goats
GROUP BY
    age_category;