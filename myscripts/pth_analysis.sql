-- which categories contribute the most to overall sale?
WITH category_sales as (
SELECT
category,
SUM(sales_amount) total_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY category)

select
category,
total_sales,
sum(total_sales) over () overall_sales,
concat(ROUND((CAST (total_sales AS FLOAT) / sum(total_sales) over ())*100, 2), '%') as percentage_of_total
from category_sales
order by total_sales desc