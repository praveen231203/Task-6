📊 Monthly Revenue Analysis – SQL Project

📌 Objective
The goal of this task was to analyze monthly revenue using two related datasets:

Orders table → contains order_id and order_date
Details table → contains order_id, revenue, and profit

We needed to join these tables, extract year/month, and calculate:
Total Revenue
Total Orders (volume)
Sorted results by year and month
Optional filtering for specific time periods

🛠 Hurdles & Solutions
1️⃣ Extracting Month & Year from Date
Hurdle: Initially, extracting the month or year resulted in NULL values because the date column was not recognized as a proper DATE format.

Solution:
Ensured order_date column was in DATE type format in the database.

Used:
sql
Copy
Edit
EXTRACT(YEAR FROM order_date) AS order_year
EXTRACT(MONTH FROM order_date) AS order_month

2️⃣ Joining Orders & Details Tables
Hurdle: Needed to combine revenue and profit (from details) with order date (from orders) while avoiding duplicate records.

Solution:
Used INNER JOIN on order_id since it is the primary key in orders and foreign key in details.
sql
Copy
Edit
FROM orders o
JOIN details d
    ON o.order_id = d.order_id

3️⃣ Calculating Monthly Revenue
Hurdle: Revenue was spread across multiple rows for the same month, requiring aggregation.

Solution:
Applied SUM(d.revenue) and grouped by year/month.
sql
Copy
Edit
GROUP BY EXTRACT(YEAR FROM o.order_date),
         EXTRACT(MONTH FROM o.order_date)

4️⃣ Counting Distinct Orders
Hurdle: Simple COUNT(*) overcounted orders if multiple items existed in the same order.

Solution:
Used COUNT(DISTINCT o.order_id) to avoid duplicates.
sql
Copy
Edit
COUNT(DISTINCT o.order_id) AS total_orders

5️⃣ Sorting the Results
Hurdle: Sorting purely by month number mixed different years together.

Solution:
Ordered results first by order_year, then order_month:
sql
Copy
Edit
ORDER BY order_year, order_month

6️⃣ Filtering for a Specific Period
Hurdle: Needed to analyze only part of the year without affecting grouping logic.

Solution:
Applied a WHERE filter before grouping:
sql
Copy
Edit
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-06-30'

📜 Final SQL Script
sql
Copy
Edit
SELECT
    EXTRACT(YEAR FROM o.order_date) AS order_year,
    EXTRACT(MONTH FROM o.order_date) AS order_month,
    SUM(d.revenue) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN details d
    ON o.order_id = d.order_id
WHERE o.order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date)
ORDER BY
    order_year,
    order_month;

✅ Outcome
Successfully extracted year and month from order dates.
Calculated monthly revenue and order volume accurately.
Produced a sorted, readable report ready for visualization or further BI analysis.