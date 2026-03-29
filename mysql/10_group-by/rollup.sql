SELECT
    COALESCE(product_name, 'Total') AS product_name,
    SUM(total_price) AS calculated_price
FROM
    billing_info
GROUP BY
    product_name
WITH
    ROLLUP
ORDER BY
    calculated_price;