/* 
================================
Customer Report
================================

Purpose: 
	-This report consolidates key customer matrics and behaviors 

Highlights: 
	1.Gather essential fields such as names, ages, and transactional details.
	2.Segments customers into categories (VIP, Regular, New) and age groups.
		-VIP: Customers with at least 12 months of history and spending more than $5000
		-Regular: Customers with at least 12 months of history and less more than $5000
		-New: Customers with a lifespan less than 12 months
	3.Aggregates customer level metrics:
		-total orders
		-total sales
		-total quantity purchased
		-total products
		-lifespan(in months)
	4.Calculates valuable KPIs:
		-recency(months since last order)
		-average order value
		-average monthly spend
=================================
*/

-----------------------------------
--Retrieving core columns- Base Query
-----------------------------------
Create VIEW gold.report_customers as
With first_query as
(
Select
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
Concat(c.first_name, ' ', c.last_name) as customer_name,
DATEDIFF(year, birthdate, getdate()) as age
From gold.fact_sales as f
Left Join gold.dim_customers as c
On f.customer_key = c.customer_key 
Where f.order_date is not null
)

-----------------------------------
--Customer Aggregations: Summarizes key matrics at the customer level
-----------------------------------
,customer_aggregation as
(
Select
customer_key,
customer_number,
customer_name,
age,
Count(Distinct order_number) as tot_orders,
Sum(sales_amount) as tot_sales,
Sum(quantity) as tot_quantity,
Count(Distinct product_key) as tot_products,
Max(order_date) as last_order,
DATEDIFF(MONTH, MIN(order_date), Max(order_date)) as lifespan
From first_query
Group by 
	customer_key,
	customer_number,
	customer_name,
	age
)

-----------------------------------
--Customer Segments into categories and age group
-----------------------------------
Select
customer_key,
customer_number,
customer_name,
age,
Case											--into age group
	When age < 20 Then 'Under 20'
	When age Between 20 And 29 Then '20-29'
	When age Between 30 And 39 Then '30-39'
	When age Between 40 And 49 Then '40-49'
	Else '50 and Above'
End as age_group,
Case											--into categories
	When lifespan >= 12 AND tot_sales > 5000 Then 'VIP'		
	When lifespan >= 12 AND tot_sales <= 5000 Then 'Regular'
	Else 'New'
End as customer_segment,
last_order,
DATEDIFF(MONTH, last_order, GETDATE()) as recency,  --recency in months
tot_orders,
tot_sales,
tot_quantity,
tot_products,
lifespan,
--Compute average order value
Case When tot_orders = 0 Then 0  --Using Case to avoid divding the results by 0
	Else tot_sales/tot_orders 
End as avg_order_value,
--Compute average monthly spend
Case When lifespan = 0 Then tot_sales --if customers exists only for 1 month, showing 0 will not reflect right data here
	Else tot_sales/lifespan
End as avg_monthly_spends
From customer_aggregation

