SELECT * FROM retail_sales

SELECT COUNT(*) FROM retail_sales

-- DATA CLEANING
SELECT * FROM retail_sales
WHERE
     customer_id IS NULL 
	 OR
	 transactions_id IS NULL
	  OR 
	  sale_date	IS NULL
	  OR
	  sale_time IS NULL
	  OR
	  customer_id  IS NULL
	   OR
	   gender	IS NULL 
	   OR
	   age IS NULL 
	   OR
	   category	IS NULL 
	   OR 
	   quantity  IS NULL
	   OR 
	   price_per_unit IS NULL 
	   OR
	   cogs  IS NULL 
	   OR
	   total_sale  IS NULL


DELETE  FROM retail_sales
WHERE
     customer_id IS NULL 
	 OR
	 transactions_id IS NULL
	  OR 
	  sale_date	IS NULL
	  OR
	  sale_time IS NULL
	  OR
	  customer_id  IS NULL
	   OR
	   gender	IS NULL 
	   OR
	   age IS NULL 
	   OR
	   category	IS NULL 
	   OR 
	   quantity  IS NULL
	   OR 
	   price_per_unit IS NULL 
	   OR
	   cogs  IS NULL 
	   OR
	   total_sale  IS NULL

--- DATA EXPLORE
SELECT COUNT(*) AS total_sale from retail_sales

--unique customers 
SELECT COUNT(DISTINCT(customer_id)) as total_sale FROM retail_sales

SELECT DISTINCT category   FROM retail_sales
--Business problem 
--query to retrive the sale made on 22/11/6
SELECT * FROM retail_sales WHERE sale_date = '2022-11-6'
 
---Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

    -- category,
    -- SUM(quantity)
SELECT *
FROM retail_sales
WHERE category ='Clothing'
  AND 
 TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
 AND 
 quantity >=4
-- GROUP BY 1

3.-- query for the total sale for each catagory 
 
SELECT category , SUM(total_sale) as net_sale, COUNT(*) as total_order FROM retail_sales GROUP BY 1

--4 find the avg age who buy from beauty catagory

SELECT ROUND(AVG(age)) as avg_age FROM retail_sales WHERE category ='Beauty'

-- quesry for the otal sales> 1000


SELECT * FROM retail_sales  WHERE total_sale > 1000
-- query for find the total num of transiction (trsid) made by each gender

SELECT 
    category,
	gender,
	COUNT(*) as total_trans
	FROM retail_sales
	GROUP BY
	category,
	gender
ORDER BY 1

-- Query for the cal avg sale for each month .best selling month


SELECT 
 year, 
 month,
 totalsale
  FROM 
(
 SELECT 
     EXTRACT(YEAR FROM sale_date)as  year,
	 EXTRACT(MONTH FROM sale_date) as  month,
	 AVG(total_sale) as totalsale,
	 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
 GROUP BY 1,2
) as t1
WHERE rank=1

--query to find the top 5 customers based on the highset sale

SELECT 
 customer_id ,
 SUM(total_sale) as totalsale
 FROM retail_sales
 GROUP BY 1
 ORDER BY 2 DESC
 LIMIT  5
	  
-- query for cust purched from each item 

SELECT 
category, 
 count( DISTINCT customer_id) AS unique_cust
FROM retail_sales
GROUP BY category
-- ORDER BY 2 DESC

--q10 each shift and coloums

WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
            ELSE 'EVENING'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;

--END OF PROJECT

-- SELECT EXTRACT(HOUR FROM CURRENT_TIME)

