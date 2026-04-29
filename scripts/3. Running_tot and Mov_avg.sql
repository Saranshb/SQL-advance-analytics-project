/* Cumulative Analysis
	Aggregate the data progressively over the time 
	Helps to understand whether our business is growing or declining
			--Running total sales by year
			--Moving average sales by month

-Calculate total sales per month 
-and the running total of sales over time
*/
Select
Ord_date,
Tot_sales,
Sum(Tot_sales) Over(Order by Ord_date) as Running_total_sales, --Running Total = revenue growth(accumulation)
Avg(Avg_price) Over(Order by Ord_date) as Moving_average --Moving avg = making data less jumpy(Smoothing )
From
(
Select
DateTrunc(year, order_date) as Ord_date,
Sum(sales_amount) as Tot_sales,
Avg(price) as Avg_price
From gold.fact_sales
Where order_date is Not Null
Group by DateTrunc(year, order_date)
) t
