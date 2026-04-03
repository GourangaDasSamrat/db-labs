/* NOTE:
This query uses a Common Table Expression (CTE) to calculate
the average earnings per sport, then joins it back to the
original table to filter for players earning above their
sport's average.
 */
WITH
    avg_yearly_earnings AS (
        SELECT
            sport,
            AVG(yearly_earnings) AS avg_yearly_earnings
        FROM
            players
        GROUP BY
            sport
    )
SELECT
    p.name,
    p.sport,
    p.yearly_earnings,
    a.avg_yearly_earnings
FROM
    players p
    JOIN avg_yearly_earnings a ON p.sport = a.sport
WHERE
    p.yearly_earnings > a.avg_yearly_earnings;