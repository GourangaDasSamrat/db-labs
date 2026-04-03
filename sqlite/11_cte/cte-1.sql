WITH avg_yearly_earnings AS (
    SELECT
        sport,
        AVG(yearly_earnings) AS avg_earnings
    FROM
        players
    GROUP BY
        sport
)
SELECT
    p.name,
    p.sport,
    p.yearly_earnings,
    a.avg_earnings
FROM
    players p
    JOIN avg_yearly_earnings a ON p.sport = a.sport
WHERE
    p.yearly_earnings > a.avg_earnings;