select * from pizza_sales

--Total Revenue--
Select sum(total_price) As Total_Revenue from pizza_sales

--Average Order Value (The average amount spent per order, calculated by dividing total revenue by the total number of orders--
Select sum(total_price) / count ( distinct order_id) as Avg_order_value from pizza_sales

--Total Pizza Sold--
Select sum(quantity) as Total_Pizza_Sold from pizza_sales

--Total Orders-- 
Select  count ( distinct order_id) as Total_orders from pizza_sales

--Average Pizzas Per Order (Total pizza sold/total order_id)--
Select sum(quantity) / count ( distinct order_id) as Average_Pizzas_Per_Order from pizza_sales

Select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as Average_Pizzas_Per_Order from pizza_sales

Select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) Average_Pizzas_Per_Order from pizza_sales


					--CHARTS REQUIREMENTS--
--Daily trend for total orders--
Select DATENAME(DW, order_date) as order_day, count(distinct order_id) as Total_orders from pizza_sales
Group by DATENAME(DW, order_date)

--Hourly Trend--
Select DATEPART(HOUR, order_time) as Order_hours, count(distinct order_id) as Total_orders from pizza_sales
Group by DATEPART(HOUR, order_time)
Order by DATEPART(HOUR, order_time)

--Percentage of sales per pizza category--
Select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) As PCT_0f_Total_sales
from pizza_sales
Group by  pizza_category

Select pizza_category,sum(total_price) as Total_sales, sum(total_price) * 100 /
(select sum(total_price) from pizza_sales) As PCT_0f_Total_sales
from pizza_sales
Group by  pizza_category --(To know the total sales too)--

Select pizza_category,sum(total_price) as Total_sales, sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales Where Month(order_date) = 1) As PCT_0f_Total_sales
from pizza_sales
Where Month(order_date) = 1 --(for month of January, you can indicate for any month you want)--
Group by  pizza_category

Select pizza_category,sum(total_price) as Total_sales, sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales Where Month(order_date) = 1) As PCT_0f_Total_sales
from pizza_sales
Where Datepart(Quarter, order_date) = 1 --(for quarter year, you can indicate for any quarter you want)--
Group by  pizza_category

--Percentage of sales per pizza size--
Select pizza_size, CAST(sum(total_price) As Decimal(10,2)) as Total_sales, CAST(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales) As Decimal(10,2)) As PCT
from pizza_sales
Group by  pizza_size
Order by PCT --DESC also--

--Percentage of sales per pizza size--
Select pizza_size, CAST(sum(total_price) As Decimal(10,2)) as Total_sales, CAST(sum(total_price) * 100 / 
(select sum(total_price) from pizza_sales Where DATEPART(quarter, order_date) = 1
) As Decimal(10,2)) As PCT
from pizza_sales
Where DATEPART(quarter, order_date) = 1
Group by  pizza_size
Order by PCT --DESC also--

--Total pizza sold by pizza category--
Select pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group by pizza_category 

--Top 5 Best Sellers By Total Pizza Sold--
Select TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group by pizza_name
Order by sum(quantity) DESC

--Bottom 5 Worst Sellers By Total Pizza sold--
Select TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group by pizza_name
Order by sum(quantity)

Select TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Where Month(order_date) = 8
Group by pizza_name
Order by sum(quantity)

Localhost (SQL Server 16.0.1135.2 - ZAINAB\HP)