-- ZOMATO DATA ANALYSIS PROJECT
-- SQL Queries for Portfolio

-- SECTION 1: BASIC QUERIES (Easy)

-- Q1: Customer Registration Analysis
-- List all customers who registered after 1st January 2022.
SELECT 
	customer_id,
	customer_name,
	reg_date
FROM customers
WHERE reg_date > '2022-01-01';

-- Q2: Total Platform Activity
-- Find the total number of orders placed on the platform.
SELECT * FROM orders;
SELECT 
	COUNT(order_id) AS total_number_of_orders
FROM orders;

-- Q3: City-Level Operations
--  Get a list of all restaurants in Mumbai.
SELECT * FROM restaurants;
SELECT 
	restaurant_id,
	restaurant_name
FROM restaurants
WHERE city = 'Mumbai';

-- Q4: Cancellation Tracking
-- Find all orders where the order status is 'Cancelled'.
SELECT 
	order_id,
	customer_id,
	restaurant_id,
	order_item,
	order_date,
	order_time,
	order_status,
	total_amount
FROM orders
WHERE LOWER(order_status) = 'cancelled';

-- Q5: Revenue Reporting
-- Get the total revenue generated from all successful payments.
SELECT * FROM payments;
SELECT 
	ROUND(SUM(amount),2) AS total_revenue_inr
FROM payments
WHERE payment_status = 'Success';

-- SECTION 2: INTERMEDIATE QUERIES (Medium)

-- Q6: Customer Activity Analysis
--  Find the number of orders placed by each customer. Return customer name and order count, sorted by order count descending.
SELECT * FROM orders;
SELECT 
	c.customer_name,
	COUNT(o.order_id) AS total_orders
FROM orders o
LEFT JOIN customers c ON c.customer_id = o.customer_id -- get all the customers and the number of thier orders.
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- Q7: Rider Performance Tracking
-- Find the average delivery time for each rider. Return rider name and average delivery time, only for delivered orders.

SELECT
	r.rider_name,
	ROUND(AVG(d.delivery_time),2) AS avg_delivery_time_mins
FROM deliveries d
JOIN riders r ON r.rider_id = d.rider_id
WHERE d.delivery_status = 'Delivered'
GROUP BY r.rider_name
ORDER BY avg_delivery_time_mins ASC;

-- Q8: Payment Infrastructure Planning
-- Find the most popular payment method used on the platform.

SELECT * FROM payments;
SELECT 
	DISTINCT(payment_method) AS payment_methods,
	COUNT(payment_id) AS times_ordered
FROM payments
GROUP BY payment_methods
ORDER BY times_ordered DESC;

-- Q9: Partner Restaurant Performance
-- Get the top 5 restaurants by total revenue generated.

SELECT 
	r.restaurant_name,
	SUM(p.amount) AS total_revenue
FROM orders o
JOIN  payments p ON p.order_id = o.order_id
JOIN restaurants r ON r.restaurant_id = o.restaurant_id
WHERE p.payment_status = 'Success'
GROUP BY r.restaurant_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Q10: Monthly Trend Analysis
-- Find the number of orders placed each month in the year 2023. Return month and order count.
SELECT
	TO_CHAR(order_date, 'Month') AS order_month,
	COUNT(order_id) AS total_orders
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2023
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY MIN(order_date);


-- Q11: New Rider Productivity
-- Find all riders who signed up in the last 1 year and have completed more than 10 deliveries.

SELECT 
	r.rider_name,
	count(d.delivery_id) AS total_completed_deliveries
FROM deliveries d
JOIN riders r ON r.rider_id = d.rider_id
WHERE 
    d.delivery_status = 'Delivered'
    AND r.sign_up_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY r.rider_name
HAVING COUNT(d.delivery_id) > 10
ORDER BY total_completed_deliveries DESC;

-- Q12: Restaurant Quality Monitoring		
/* Calculate the average food rating and average delivery rating for each restaurant.
Return restaurant name, avg food rating, avg delivery rating.	*/

SELECT 
	r.restaurant_name,
	ROUND(AVG(rt.food_rating),2) AS avg_food_rating,
	ROUND(AVG(rt.delivery_rating),2) AS avg_delivery_rating
FROM ratings rt
JOIN restaurants r ON r.restaurant_id = rt.restaurant_id
GROUP BY r.restaurant_name;

-- SECTION 3: ADVANCED QUERIES (Hard)
-- Find customers who have never placed an order.

SELECT 
	c.customer_id,
	c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q14: City-Level Menu Insights
-- Find the most ordered food item in each city.

WITH item_counts AS (
	SELECT 
		r.city,
		o.order_item,
		COUNT(o.order_id) AS order_count,
		RANK() OVER(PARTITION BY r.city ORDER BY COUNT(o.order_id) DESC) AS rank
	FROM restaurants r
	JOIN orders o ON r.restaurant_id = o.order_id
	GROUP BY r.city,o.order_item
)
SELECT 
	city,
	order_item,
	order_count
FROM item_counts
WHERE rank =1;

-- Q15: Rider Quality Management
-- Find the top 3 riders with the highest cancellation rate. Return rider name and cancellation rate percentage.

WITH cancellation_data AS (
	SELECT 
        r.rider_name,
        ROUND(100 *SUM(CASE WHEN d.delivery_status = 'Cancelled' THEN 1 ELSE 0 END):: numeric / COUNT(d.order_id) :: numeric,
			2) AS cancellation_percentage
    FROM deliveries d
    JOIN riders r ON r.rider_id = d.rider_id
    GROUP BY r.rider_name
),
ranked_data AS (
	SELECT 
		rider_name,
		cancellation_percentage,
		RANK() OVER(ORDER BY cancellation_percentage DESC) AS rank
	FROM cancellation_data
	)
SELECT rider_name, cancellation_percentage
FROM ranked_data
WHERE rank <= 3;

-- Q16: Customer Retention Analysis
--  Find customers who placed orders in both 2023 and 2024 (retained customers).
SELECT * FROM orders;
SELECT * FROM customers;

SELECT 
    c.customer_id,
    c.customer_name
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM o.order_date) = 2023 THEN 1 END) > 0
    AND
    COUNT(DISTINCT CASE WHEN EXTRACT(YEAR FROM o.order_date) = 2024 THEN 1 END) > 0
ORDER BY c.customer_name;

-- Q17: Executive Revenue Reporting
-- Find each month's total revenue and calculate the month-over-month revenue growth percentage.

WITH monthly_revenue AS (
    SELECT 
        EXTRACT(YEAR FROM payment_date) AS payment_year,
        EXTRACT(MONTH FROM payment_date) AS payment_month,
        SUM(amount) AS total_revenue
    FROM payments
    WHERE payment_status = 'Success'
    GROUP BY payment_year, payment_month
),
month_over_month_revenue AS (
    SELECT 
        payment_year,
        payment_month,
        total_revenue,
        LAG(total_revenue) OVER (ORDER BY payment_year, payment_month) AS prev_month_revenue
    FROM monthly_revenue
)
SELECT 
    payment_year,
    payment_month,
    total_revenue,
    prev_month_revenue,
    ROUND(
        100.0 * (total_revenue - prev_month_revenue) / NULLIF(prev_month_revenue, 0),
        2
    ) AS growth_percentage
FROM month_over_month_revenue
ORDER BY payment_year, payment_month;

-- Q18: City-Level Restaurant Rankings
-- Rank restaurants by their average food rating within each city using a window function.SELECT * FROM ratings;
WITH restaurant_ratings AS (
    SELECT
        r.city,
        r.restaurant_name,
        AVG(rt.food_rating) AS avg_food_rating
    FROM restaurants r
    JOIN ratings rt ON r.restaurant_id = rt.restaurant_id
    GROUP BY r.city, r.restaurant_name
)
SELECT 
    city,
    restaurant_name,
    ROUND(avg_food_rating, 2),
    RANK() OVER(PARTITION BY city ORDER BY avg_food_rating DESC) AS city_rank
FROM restaurant_ratings
ORDER BY city, city_rank;

-- Q19: Churn Detection for Marketing
-- Find customers who placed their most recent order more than 6 months ago
SELECT 
    c.customer_id,
    c.customer_name,
    MAX(o.order_date) AS last_order_date,
    CURRENT_DATE - MAX(o.order_date) AS days_since_last_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING MAX(o.order_date) < CURRENT_DATE - INTERVAL '6 months'
ORDER BY last_order_date DESC;

-- Q20: Restaurant Operational Health
-- For each restaurant, find the percentage of orders that were cancelled out of total orders placed.

WITH delivery_count AS (
	SELECT 
		r.restaurant_id,
		r.restaurant_name,
		COUNT(o.order_id) AS total_count
	FROM restaurants r
	JOIN orders o ON r.restaurant_id = o.restaurant_id
	GROUP BY 1,2
),
cancelled_count AS (
	SELECT 
		restaurant_id,
		COUNT(order_id) AS cancelled_count
	FROM orders
	WHERE order_status ='Cancelled'
	GROUP BY 1
)
SELECT 
	d.restaurant_name,
	ROUND(
	100 * c.cancelled_count / d.total_count,
	2) AS cancelled_percentage
FROM delivery_count d
JOIN cancelled_count c ON d.restaurant_id = c.restaurant_id
ORDER BY 2 DESC;

-- END OF QUERIES