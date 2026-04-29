/*1. Change Over Time Analysis

	Analyze sales performance over time --> Track trends and identify seasonality in your Data
		-Determines revenue over the years/months
		-Best/Worst year/months
		-Are we gaining customers over time 
*/
Select 
	Year(order_date) as Order_year,
	Concat('Q', DATEPART(QUARTER, order_date)) as Order_Quarter,
	SUM(sales_amount) as Tot_Sales,
	Count(Distinct customer_key) as Tot_customers,
	Sum(quantity) as Tot_quantity
From gold.fact_sales
Where order_date IS Not Null
Group by Year(order_date), DATEPART(QUARTER, order_date) 
Order by Year(order_date), DATEPART(QUARTER, order_date) 