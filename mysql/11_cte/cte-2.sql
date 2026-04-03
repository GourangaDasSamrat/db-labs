/* Identify the "Alpha" earner for each sport.
 */
WITH
    max_yearly_earnings AS (
        SELECT
            sport,
            MAX(yearly_earnings) AS max_earnings
        FROM
            players
        GROUP BY
            sport
    )
SELECT
    p.name,
    p.sport,
    p.yearly_earnings
FROM
    players p
    INNER JOIN max_yearly_earnings m ON p.sport = m.sport
WHERE
    p.yearly_earnings = m.max_earnings;