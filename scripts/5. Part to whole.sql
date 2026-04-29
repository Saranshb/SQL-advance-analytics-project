/* Part to Whole Analysis - Proportional Analysis	
	Analyze how an individual part is performing compared to the overall,
	allowing us to understand which category has the greatest impact on the business(like how a pie chart is divided into multiple categories)
		(measure/total(measure))* 100 by(dimension)
		ex- sales/tot sales*100 by category

Which categories contribute the most to overall sales?
*/

with category_sales as
(select
p.category,
sum(f.sales_amount) as tot_sales
from gold.fact_sales as f
left join gold.dim_products as p
ON p.product_key = f.product_key
group by p.category
)

select *,
sum(tot_sales) over() as overall_sales,
Concat(Round((Cast(tot_sales as Float)/sum(tot_sales) over()) *100, 2), '%') as Sales_in_perc --cast tot_sales as float, otherwise result will be 0
from category_sales
order by tot_sales desc

----Using Window Fu.---

Select
p.category,
sum(f.sales_amount) as tot_sales,
sum(sum(f.sales_amount)) over() as overall_sales,
concat(
	round((
	cast(sum(f.sales_amount) as float)/sum(sum(f.sales_amount)) over()*100
	),2), '%') as overall_sales

From gold.fact_sales as f
Left join gold.dim_products as p
ON f.product_key = p.product_key
Group by p.category


