-- lag
SELECT
    nickname,
    est_net_worth_usd,
    LAG(est_net_worth_usd) OVER (
        ORDER BY
            est_net_worth_usd
    )
FROM
    goat_profiles;

-- lead
SELECT
    nickname,
    est_net_worth_usd,
    (
        est_net_worth_usd - LEAD(est_net_worth_usd) OVER (
            ORDER BY
                est_net_worth_usd DESC
        )
    ) AS net_worth_diff
FROM
    goat_profiles;