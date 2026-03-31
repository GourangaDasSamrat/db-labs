-- row number
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            nickname
    ),
    nickname,
    career_titles,
    biography,
    est_net_worth_usd
FROM
    goat_profiles;

-- partition by
SELECT
    ROW_NUMBER() OVER (
        PARTITION BY
            product_name
    ),
    customer_name,
    product_name,
    price
FROM
    billing_info;