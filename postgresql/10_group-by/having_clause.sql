SELECT
    product_name,
    SUM(total_price) AS calculated_price
FROM
    billing_info
GROUP BY
    product_name
HAVING
    SUM(total_price) > 6500;