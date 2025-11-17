-- first of all I create a temporary table that stores date value as texts so that I can import from the csv file because
-- in csv the date has different formats

CREATE TABLE temp_superstore (
    row_id INT,
    order_id VARCHAR(30),
    order_date TEXT,
    ship_date TEXT,
    ship_mode VARCHAR(30),
    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(30),
    country VARCHAR(50),
    city VARCHAR(50),
    state_name VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(30),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);
-- after that I import data from csv file to the temp table by using import
-- while doing that I also encountered issue regarding double quotes. I had to go the csv and change that from there itself.
-- was a tiresome process

-- just checking to see whether the data has successfully been imported tpo the table or not.
select * from temp_superstore;
-- ok so I got it in the temp table.

--now I create the final table
CREATE TABLE superstore_sales (
    row_id INT,
    order_id VARCHAR(30),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(30),
    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(30),
    country VARCHAR(50),
    city VARCHAR(50),
    state_name VARCHAR(50),   
    postal_code VARCHAR(20),
    region VARCHAR(30),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(200),
    sales NUMERIC,
    quantity INT,
    discount NUMERIC,
    profit NUMERIC
);

-- I insert the data from temp table to the final table by changing the dates from text to date type

INSERT INTO superstore_sales 
SELECT 
    row_id, order_id,
    TO_DATE(order_date, 'MM-DD-YYYY'),
    TO_DATE(ship_date, 'MM-DD-YYYY'),
    ship_mode, customer_id, customer_name, segment, country, city, state_name,
    postal_code, region, product_id, category, sub_category, product_name,
    sales, quantity, discount, profit
FROM temp_superstore;

-- now lets see whether we have got data in the final table or not

Select * from superstore_sales;

-- since we got the csv file into into our final table; we drop the temp_table

DROP TABLE temp_superstore;

-- so so so we finally got the data into the table ; didn't expect it to take this long though; damn!!!
