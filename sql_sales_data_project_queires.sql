

-- ---------------------------------------------------------------------------
-- 1. Create the database and use it
-- ---------------------------------------------------------------------------
CREATE DATABASE sql_project_1;
USE sql_project_1;

-- ---------------------------------------------------------------------------
-- 2. Create the retail_sale table
-- ---------------------------------------------------------------------------
CREATE TABLE retail_sale (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT 
);

-- ---------------------------------------------------------------------------
-- 3. Data Cleaning: Remove NULL records
-- ---------------------------------------------------------------------------
SELECT * 
FROM retail_sale;

SELECT * 
FROM retail_sale
WHERE sale_date IS NULL 
   OR transactions_id IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

DELETE FROM retail_sale
WHERE sale_date IS NULL 
   OR transactions_id IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

SET SQL_SAFE_UPDATES = 0;
SELECT COUNT(*) FROM retail_sale;

-- ---------------------------------------------------------------------------
-- 4. Business Questions and Analysis
-- ---------------------------------------------------------------------------

/* Q1. Find the total number of transactions made on 2022-11-05 */
SELECT COUNT(*) AS total_transactions
FROM retail_sale
WHERE sale_date = '2022-11-05';

/* Q2. List sales where category is 'Clothing' and quantity sold ≥ 4 in November 2022 */
SELECT *
FROM retail_sale
WHERE category = 'Clothing'
  AND sale_date LIKE '2022-11-%'
  AND quantiy >= 4;

/* Q3. Calculate total sales and number of orders for each category */
SELECT category, 
       SUM(total_sale) AS total_sales,
       COUNT(*) AS total_orders
FROM retail_sale
GROUP BY category;

/* Q4. Find the average age of customers who purchased from the 'Beauty' category */
SELECT category, 
       AVG(age) AS avg_age
FROM retail_sale
WHERE category = 'Beauty'
GROUP BY category;

/* Q5. Retrieve all transactions where total_sale > 1000 */
SELECT *
FROM retail_sale
WHERE total_sale > 1000;

/* Q6. Find total number of transactions by gender within each category */
SELECT category, gender, COUNT(*) AS total_transactions
FROM retail_sale
GROUP BY category, gender
ORDER BY category;

/* Q7. Identify the best-selling month (highest average sales) in each year */
SELECT years, months, avgsales
FROM (
    SELECT YEAR(sale_date) AS years,
           MONTH(sale_date) AS months,
           ROUND(AVG(total_sale),2) AS avgsales,
           RANK() OVER (PARTITION BY YEAR(sale_date) 
                        ORDER BY ROUND(AVG(total_sale),2) DESC) AS rn
    FROM retail_sale
    GROUP BY years, months
) AS t
WHERE rn = 1;

/* Q8. Find the Top 5 customers based on total sales */
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sale
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

/* Q9. Count unique customers who purchased from each category */
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sale
GROUP BY category;

/* Q10. Find customers who purchased from ALL three categories (Clothing, Electronics, Grocery) */
SELECT customer_id
FROM retail_sale
GROUP BY customer_id
HAVING COUNT(DISTINCT category) = 3;

/* Q11. Count how many customers purchased from ALL three categories */
SELECT COUNT(*) AS total_customers
FROM (
    SELECT customer_id
    FROM retail_sale
    GROUP BY customer_id
    HAVING COUNT(DISTINCT category) = 3
) AS t;

/* Q12. Create shifts (Morning, Afternoon, Evening) based on sale_time */
SELECT *,
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sale;

/* Q13. Count number of orders by shift */
SELECT 
    SUM(CASE WHEN HOUR(sale_time) < 12 THEN 1 ELSE 0 END) AS morning_shift,
    SUM(CASE WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 1 ELSE 0 END) AS afternoon_shift,
    SUM(CASE WHEN HOUR(sale_time) > 17 THEN 1 ELSE 0 END) AS evening_shift
FROM retail_sale;

SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sale
GROUP BY shift;

/* Q14. Find total revenue per day */
SELECT sale_date, SUM(total_sale) AS total_revenue
FROM retail_sale
GROUP BY sale_date
ORDER BY total_revenue DESC;

/* Q15. Which category generated the highest revenue? */
SELECT category, SUM(total_sale) AS revenue
FROM retail_sale
GROUP BY category
ORDER BY revenue DESC
LIMIT 1;

/* Q16. Find total unique customers in November 2022 */
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sale
WHERE sale_date LIKE '2022-11-%';

/* Q17. Top 5 customers by spending */
SELECT customer_id, SUM(total_sale) AS total_spent
FROM retail_sale
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

/* Q18. Divide customers into age groups: 18-25, 26-30, 31+ */
SELECT 
    COUNT(CASE WHEN age BETWEEN 18 AND 25 THEN 1 END) AS `18-25`,
    COUNT(CASE WHEN age BETWEEN 26 AND 30 THEN 1 END) AS `26-30`,
    COUNT(CASE WHEN age >= 31 THEN 1 END) AS `31+`
FROM retail_sale;

/* Q19. Find which age group generates the highest revenue */
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 30 THEN '26-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS age_group,
    SUM(total_sale) AS total_revenue
FROM retail_sale
GROUP BY age_group
ORDER BY total_revenue DESC
LIMIT 1;

/* Q20. Which shift (Morning, Afternoon, Evening) generates the most sales? */
SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    SUM(total_sale) AS sales
FROM retail_sale
GROUP BY shift
ORDER BY sales DESC
LIMIT 1;
