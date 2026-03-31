-- rank number
SELECT
    nickname,
    est_net_worth_usd,
    RANK() OVER (
        ORDER BY
            est_net_worth_usd DESC
    ) AS rank_val
FROM
    goat_profiles;

-- dens rank
SELECT
    nickname,
    est_net_worth_usd,
    DENSE_RANK() OVER (
        ORDER BY
            est_net_worth_usd DESC
    ) AS dense_rank_val
FROM
    goat_profiles;