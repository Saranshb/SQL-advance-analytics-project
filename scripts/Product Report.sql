/* 
================================
Product Report
================================

Purpose: 
	-This report consolidates key product matrics and behaviors 

Highlights: 
	1.Gather essential fields such as product names, categories, sub-categories, and cost.
	2.Segments products to identify High-Performers, Mid-range and Low-Performers.
	3.Aggregates product level metrics:
		-total orders
		-total sales
		-total quantity sold
		-total customers(unique)
		-lifespan(in months)
		-average selling price
	4.Calculates valuable KPIs:
		-recency(months since last order)
		-average order revenue
		-average monthly revenue
=================================
*/

Create VIEW gold.report_products as
With base_query as
(
-------------------------------
-- 1) Base Query
-------------------------------
Select
f.order_number,
f.customer_key,
f.order_date,
f.sales_amount,
f.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
From gold.fact_sales as f
Left Join gold.dim_products as p
On f.product_key = p.product_key
Where order_date is not null
)


,prod_aggregation as
-------------------------------
-- 2) Product Aggregation
-------------------------------
(
Select
product_key,
product_name,
category,
subcategory,
cost,
count(Distinct order_number) as Tot_orders,
count(Distinct customer_key) as Tot_customers,
sum(sales_amount) as Tot_sales,
sum(quantity) as Tot_quantity,
Max(order_date) as Last_sale_date,
DateDiff(Month, Min(order_date), Max(order_date)) as Lifespan,
Round(Avg(Cast(sales_amount as Float) / Nullif(quantity, 0)), 2) as Avg_selling_price
From base_query

Group by
	product_key,
	product_name,
	category,
	subcategory,
	cost
)
-------------------------------
-- 3) Final Query
-------------------------------

Select
product_key,
product_name,
category,
subcategory,
cost,
Last_sale_date,
DateDiff(Month, Last_sale_date, Getdate()) as recency_in_months, --recency in months for last sale
Case
	When Tot_sales > 50000 Then 'High Performer'
	When Tot_sales >= 10000 Then 'Mid Range'
	Else 'Low Performer'
End as Product_segment,
Lifespan,
Tot_orders,
Tot_customers,
Tot_sales,
Tot_quantity,
Avg_selling_price,
--Compute average order revenue
Case 
	When Tot_orders = 0 Then 0
	Else Tot_sales / Tot_orders
End as Avg_order_revenue,

-- Average monthly revenue
Case 
	When Tot_orders = 0 Then Tot_sales
	Else Tot_sales / lifespan
End as Avg_monthly_revenue
From prod_aggregation