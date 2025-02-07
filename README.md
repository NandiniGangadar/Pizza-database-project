# Pizza Sales Analysis Using SQL 
## Project Objective
### The Pizza Sales Analysis project aims to analyze sales trends, customer preferences, and operational efficiency using SQL queries. The goal is to help a pizza restaurant optimize sales, improve inventory management, and enhance customer satisfaction.

## Key Areas of Analysis:
### 1.Sales Performance – Analyzing total revenue, order trends, and peak sales periods.
### 2.Customer Behavior – Identifying popular pizza types, purchase frequency, and spending patterns.
### 3.Inventory & Operations – Evaluating ingredient demand and optimizing stock levels.
### 4.Performance Metrics – Using SQL functions to generate insights and reports.

## Technologies Used:
### SQL (for data extraction, cleaning, and analysis)

### Impact:
### >Helps increase revenue by identifying high-demand pizzas.
### >Improves inventory management by forecasting ingredient needs.
### >Enhances marketing strategies through customer purchase analysis.

# Business problems and solutions
## 1. Retrieve the total number of orders places
```sql
     select count(order_id) as total_orders
     from orders;
```
## 2
```sql
select  round(sum(order_details.quantity * pizzas.price),2) as total_sales
from order_details join pizzas on
pizzas.pizza_id= order_details.pizza_id
```
## 3.Identify the highest-prices pizza
```sql
     select pizza_types.name, pizzas.price
     from pizza_types join pizzas
     on pizza_types.pizza_type_id= pizzas.pizza_type_id
     order by pizzas.price desc limit 1;
```
## 4.list the top 5 most ordered pizza types alomg with their quantities
```sql
   SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
    FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.name
    ORDER BY quantity DESC
    LIMIT 5;
```
## 5.join the necessary table to find the total quantity of each pizza category
```sql
     SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_Details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;
```
## 6.identify the most common pizzas  size ordered
```sql
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc;
```
## 7.determine the distribution of orders by hour of the day
```sql
SELECT 
    HOUR(time), COUNT(order_id) AS oder_count
FROM
    orders
GROUP BY HOUR(time);
```
## 8.join relevant tables to find the category wise distribution of pizzas.
```sql
select category,count(name) from pizza_types
group by category;
```
## 9.group the orders by date and calculate the average number of pizzas ordered per day
```sql
SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_ordered_per_day
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS order_quantity;
```

## 10.determine the top 3 most ordered pizza types based on revenue
```sql
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;
```
## 11.calculate the percentage contribution of each pizza type to total revenue.
```sql
SELECT 
    pizza_types.category,
    round(SUM(order_details.quantity * pizzas.price) / (SELECT 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_sales
        FROM
            order_details
                JOIN
            pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,2) as revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;
```
## 12.calculate the percentage contribution of each pizza type to total revenue
```sql
select pizza_types.category,
round(sum(order_details.quantity*pizzas.price)/ (select 
            ROUND(SUM(order_details.quantity * pizzas.price),
                        2) AS total_sales
from
order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id)* 100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category order by revenue desc;
```
## 13.analyze  the cummulative revenue generated over time.
```sql
select date,
sum(revenue) over (order by date) as cum_revenue
from
(select orders.date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas 
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.date) as sales;
```
## 14.determine the top 3 most ordered pizza types based on revenue for each pizza category.
```sql
select name,revenue from

(select category,name,revenue,
rank() over (partition by category order by revenue desc) as rn
from
(select pizza_types.category,pizza_types.name,
sum((order_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where rn<=3;
```





