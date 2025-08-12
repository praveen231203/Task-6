create database task_6 ;

use task_6 ;

select * from orders ;

SELECT `Order date`, STR_TO_DATE(`Order date`, '%d/%m/%Y') AS converted
FROM orders
LIMIT 20;

ALTER TABLE orders ADD COLUMN order_date_upd DATE;

UPDATE orders
SET order_date_upd = STR_TO_DATE(`Order date`, '%d-%m-%Y');

select * from orders ;

SELECT 
    YEAR(order_date_upd) AS year,
    MONTH(order_date_upd) AS month
FROM orders;

SELECT 
    order_date_upd,
    MONTH(order_date_upd) AS month_number,
    MONTHNAME(order_date_upd) AS month_name
FROM orders;

select * from orders ;

ALTER TABLE orders
ADD COLUMN month_number INT,
ADD COLUMN month_name VARCHAR(20);

UPDATE orders
SET 
    month_number = MONTH(STR_TO_DATE(`Order date`, '%d-%m-%Y')),
    month_name = MONTHNAME(STR_TO_DATE(`Order date`, '%d-%m-%Y'));
    
    ALTER TABLE orders
DROP COLUMN order_date_new;

select * from orders ;

select * from details ;

SELECT 
    DATE_FORMAT(o.order_date_upd, '%M %Y') AS month_name,  
    SUM(d.Amount) AS total_revenue,                   
    SUM(d.Profit) AS total_profit,                     
    COUNT(DISTINCT o.`Order id`) AS total_orders         
FROM orders o
JOIN details d 
    ON o.`Order id` = d.`Order id`
GROUP BY DATE_FORMAT(o.order_date_upd, '%M %Y')
ORDER BY MIN(o.order_date_upd);

SELECT 
    SUM(Amount) AS total_revenue
FROM details;

SELECT 
    COUNT(DISTINCT `Order id`) AS total_orders
FROM orders;





    
    





