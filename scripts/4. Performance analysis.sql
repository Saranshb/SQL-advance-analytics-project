/* Performance Analysis
	Comparing the current value/measure to a target value/measure
	Helps in measuring the success and compare performance

Analyze the yearly performance of products 
by comparing each product's sale to both its average performance and
previous year's sales
*/
With yearly_product_sales as(
Select
Year(f.order_date) as order_year,s
p.product_name,
Sum(f.sales_amount) as current_sales
From gold.fact_sales as f
Left Join gold.dim_products as p
On f.product_key = p.product_key
Where f.order_date IS NOT NULL
Group by Year(f.order_date),
p.product_name
)

Select 
order_year,
product_name,
current_sales,
avg(current_sales) Over(Partition by product_name) as avg_sales,
current_sales - avg(current_sales) Over(Partition by product_name) as diff_avg_curr,
Case 
	When current_sales - avg(current_sales) Over(Partition by product_name) > 0 Then 'Above avg'
	When current_sales - avg(current_sales) Over(Partition by product_name) > 0 Then 'Below avg'
	Else 'Avg'
End as avg_change,
--Year-over-year Analysis
LAG(current_sales) Over(Partition by product_name Order by order_year) as prev_year_sales,
current_sales - LAG(current_sales) Over(Partition by product_name Order by order_year) as diff_prev_curr,
Case 
	When current_sales - Lag(current_sales) Over(Partition by product_name Order by order_year asc) > 0 Then 'Increase'
	When current_sales - Lag(current_sales) Over(Partition by product_name Order by order_year asc) < 0 Then 'Decrease'
	Else 'No Change'
End as prev_change
From yearly_product_sales
Order by product_name, order_year