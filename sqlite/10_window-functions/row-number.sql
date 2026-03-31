-- row number
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            nickname
    ) AS row_num,
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
        ORDER BY
            price DESC
    ) AS item_number,
    customer_name,
    product_name,
    price
FROM
    billing_info;