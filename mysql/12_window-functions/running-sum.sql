-- running sum
SELECT
    nickname,
    career_titles,
    biography,
    est_net_worth_usd,
    SUM(est_net_worth_usd) OVER (
        ORDER BY
            est_net_worth_usd
    ) AS running_total
FROM
    goat_profiles;