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
``sql
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



