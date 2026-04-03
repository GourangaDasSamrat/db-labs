/* NOTE:
This query identifies the "Alpha" earner for each sport.
It first finds the maximum salary per sport category using a CTE,
then joins it back to the players table to retrieve the specific
player(s) matching that top figure.
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
    JOIN max_yearly_earnings m ON p.sport = m.sport
WHERE
    p.yearly_earnings = m.max_earnings;