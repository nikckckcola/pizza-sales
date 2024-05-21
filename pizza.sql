-- the sum of the total price of all pizzas
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

--the avarage amount spent per order (dividing the total revenue by the total number of orders)
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales;

--the sum of the quantititties of all pizzas sold
SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;

--the total number of orders placed
SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales;

--the average number of pizzas dols per order (dividing the total number of pizzas sold by the total number of orders)
SELECT CAST((CAST(SUM(quantity) AS DECIMAL(10, 2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))) AS DECIMAL (10,2)) 
AS Avg_Pizzas_Per_Order FROM pizza_sales;

----------------------------------------------------------------
--daily trend for total orders
SELECT DAYNAME(order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);

--hourly trend for total orders
SELECT HOUR(order_time) AS order_hours, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

--% of sales by pizza category
SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) 
AS PCT
FROM pizza_sales 
WHERE MONTH(order_date) = 1 
GROUP BY pizza_category;

--% of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE QUARTER(order_date) = 1) AS DECIMAL(10,2))
AS PCT
FROM pizza_sales 
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

--total pizzas sold by category
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category;

--top 5 best sellers by total pizzas sold
SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 5;

--worst 5 pizzas by total pizzas sold
SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;

SELECT * FROM pizza_sales;