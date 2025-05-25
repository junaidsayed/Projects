-- Retrieve the total number of orders placed.
select * from orders;
select count(order_id) from orders;

SELECT COUNT(order_id) AS total_orders
FROM orders;



-- Calculate the total revenue generated from pizza sales. 

SELECT SUM(p.price * od.quantity) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;



-- Identify the highest-priced pizza.

SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;



-- Identify the most common pizza size ordered

SELECT p.size, SUM(od.quantity) AS total_ordered
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_ordered DESC
LIMIT 1;



-- List the top 5 most ordered pizza types along with their quantities.

SELECT pt.name AS pizza_type, SUM(od.quantity) AS total_ordered
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_ordered DESC
LIMIT 5;


