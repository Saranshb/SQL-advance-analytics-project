/* Data Segmentation
	Group the data based on specific range
	Helps understand the correlation btw 2 measures
		Measue By Measure
		ex- tot products by sales range
		ex- tot customers by age

Segment products into cost ranges and count how many products fall into each segment
*/

With prod_segment as (
Select
product_key,
product_name,
cost,
Case
	When cost < 100 then 'below 100'
	When cost between 100 and 500 then 'between 100-500'
	When cost between 500 and 1000 then 'between 500-1000'
	Else 'Above 1000'
End as cost_range
from gold.dim_products
)

Select
cost_range,
count(product_key) as tot_prod
from prod_segment
group by cost_range


----Sub query----

SELECT
    cost_range,
    COUNT(product_key) AS tot_prod
FROM (
    SELECT
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'below 100'
            WHEN cost BETWEEN 100 AND 500 THEN 'between 100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN 'between 500-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
) AS prod_segment
GROUP BY cost_range;