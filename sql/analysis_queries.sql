-- in the next step , i.e. after loading the csv into final table and before performing analysis,
-- we perform data profiling, i.e. syatematic examination of data available through different data quality dimensions.

-- 1. Basic count: to check the completeness of data

SELECT COUNT(*) AS total_rows FROM superstore_sales;

-- in our table there are total 9994 rows. which also matches with total csv count. So the data is complete.

--2. Null analysis: 
SELECT 
    COUNT(*) - COUNT(order_id) AS null_orders,
    COUNT(*) - COUNT(customer_id) AS null_customers,
    COUNT(*) - COUNT(profit) AS null_profits
FROM superstore_sales;
-- there are no null values in the columns order_id, customer_id and profit. which could have affected our analysis process.

--3. Duplicate check:
-- Checking for completely identical rows (all columns same)
SELECT order_id, product_id, COUNT(*) as duplicate_count
FROM superstore_sales
GROUP BY order_id, product_id, quantity, sales, profit
HAVING COUNT(*) > 1;

-- so the result shows that the order-id with US-2014-150119 and product-id with FUR-CH-10002965 have duplicate count of 2. let me see it.
select * from superstore_sales where order_id= 'US-2014-150119' and product_id = 'FUR-CH-10002965';
-- so I checked and this row (3406 and 3407) is duplicated. I have to remove the duplicate row.

delete from superstore_sales where row_id =3407;

-- conforming whether it has been really deleted or not
SELECT row_id, order_id, product_id, product_name
FROM superstore_sales 
WHERE row_id IN (3406, 3407, 3408)
ORDER BY row_id;
-- so only 3407 was deleted. now no duplicate data remains. Its a normal db practice to have gaps due to deletion.

--4. data range checks: data type validation

-- Checking numeric ranges
SELECT 
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    MIN(profit) AS min_profit, 
    MAX(profit) AS max_profit,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity
FROM superstore_sales;
-- everything is within ranges

-- Checking date ranges
SELECT 
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM superstore_sales;
-- this is also in range.

--5. Categorical Data validation: whether it contains expected values or not; out of ordinary is sus
-- Checking valid categories
SELECT DISTINCT segment FROM superstore_sales; -- contains only consumer,corporate and Home office
SELECT DISTINCT category FROM superstore_sales; -- Furniture, Office supplies and Technology
SELECT DISTINCT ship_mode FROM superstore_sales;-- Standard Class, Second Class. Same Day and First Class
SELECT DISTINCT region FROM superstore_sales;-- South, West, East and Central

SELECT DISTINCT country FROM superstore_sales;
-- Should only be 'United States' for this dataset and only it was found.
-- no unexpected values were found so we are good to go.


-- Validating business rules
-- Rule: Order date should be before ship date
SELECT COUNT(*) AS invalid_ship_dates
FROM superstore_sales
WHERE ship_date < order_date;
--no invalid date found

-- Rule: Discount should be between 0-1
SELECT COUNT(*) AS invalid_discounts  
FROM superstore_sales
WHERE discount < 0 OR discount > 1;
-- no invalid discount found.

-- Now the actual analysis of the table begins.

--1. What is the total sales, total profit and the total quantity of sales in the company?
Select 
Sum(Sales) as total_sales,
Sum(Profit) as total_profit,
Sum(Quantity) as total_quantity
from superstore_sales;
-- The total sale is 2296919.4883 k , total profit is 286409.0805k and the total quantity is 37871.
-- I am writing these down for summary table fyi

--2. What is the sales by category?
Select category, 
Round (sum(sales),2) as sales
from superstore_sales group by category order by sales desc;
-- technology sales are top then furniture then office supplies

--3. What is the profit by region?
Select region, round(sum(profit),2) as profits
from superstore_sales group by region order by profits desc;
-- profits are generated in the order west, east, south, central

--4. What are the top 10 best selling products?
select product_name, count (sales) as total_sales
from superstore_sales group by product_name order by total_sales desc limit 10;
-- the most purchased product is Staple envelope.

--5. What are the monthly sales trend?
select date_trunc('month', order_date) as month,
sum(sales) as monthly_sales
from superstore_sales group by month order by month;
-- all the monthly sales for 4 years i.e. 48 months is shown. better to see in graphical representation for trend analysis.

--6. Who are the top 10 purchasing customers by amount?
select customer_name, sum(sales) as total_sales
from superstore_sales group by customer_name order by total_sales desc limit 10;
--company give sean miller a prize. he bought total sales of 25043

--7. What kind of relationship do discount and profit have?
select discount, round(avg(profit),2) as avg_profit
from superstore_sales group by discount order by discount;
-- so discount more than 20% does not lead to any profit for the store.

--8. How many time does it take on average from order to shipping?
SELECT 
    AVG(ship_date - order_date) AS avg_ship_time_days
FROM superstore_sales;
-- on average it takes 3.95 days so we can say 4 days.

--9. Which state buys the most products?
select state_name, sum(sales) as total_sales
from superstore_sales group by state_name order by sum(sales) desc limit 5;
-- california, new york, texas, washington and pennsylvania buy the most products.

--10. Which product does the state of california use most?
select product_name, sum(sales) as total_sales
from superstore_sales 
where state_name='California'
group by product_name order by total_sales desc limit 10;
-- californians use High Speed automatic Electric letter opener the most.
