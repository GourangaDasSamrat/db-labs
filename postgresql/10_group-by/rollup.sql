SELECT
    COALESCE(product_name, 'Total'),
    SUM(total_price) AS calculated_price
FROM
    billing_info
GROUP BY
    ROLLUP (product_name)
ORDER BY
    calculated_price