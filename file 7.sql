-- determine the distribution of orders by hour of the day
SELECT 
    HOUR(time), COUNT(order_id) AS oder_count
FROM
    orders
GROUP BY HOUR(time);