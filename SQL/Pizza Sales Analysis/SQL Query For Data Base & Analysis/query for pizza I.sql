-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category, sum(order_details.quantity) as total_quantity_ordered
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.category
order by total_quantity_ordered desc;

select pt.category, SUM(od.quantity) AS total_quantity_ordered
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity_ordered DESC;



-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hour, count(order_id) as order_count
from orders
group by hour(order_time) 
order by order_count;

SELECT HOUR(order_time) AS order_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY order_hour ;



-- Join relevant tables to find the category-wise distribution of pizzas-types.

SELECT category, COUNT(*) AS number_of_pizza_types
FROM pizza_types
GROUP BY category
ORDER BY number_of_pizza_types DESC;



-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT round(AVG(daily_pizzas),0) AS avg_pizzas_per_day
FROM (
    SELECT o.order_date, SUM(od.quantity) AS daily_pizzas
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_date
) AS daily_totals;



-- Determine the top 3 most ordered pizza types based on revenue.

SELECT pt.name AS pizza_type, 
       ROUND(SUM(p.price * od.quantity), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


