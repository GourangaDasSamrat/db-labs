/* NOTE
Calculate average earnings per sport and filter players
earning above their sport's average.
 */
WITH
    avg_yearly_earnings AS (
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
    INNER JOIN avg_yearly_earnings a ON p.sport = a.sport
WHERE
    p.yearly_earnings > a.avg_earnings;