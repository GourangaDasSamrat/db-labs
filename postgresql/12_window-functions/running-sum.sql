-- running sum
SELECT
    nickname,
    career_titles,
    biography,
    est_net_worth_usd,
    SUM(est_net_worth_usd) OVER (
        ORDER BY
            est_net_worth_usd
    )
FROM
    goat_profiles;