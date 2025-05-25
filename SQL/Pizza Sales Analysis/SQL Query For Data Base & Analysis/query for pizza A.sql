-- Calculate the percentage contribution of each pizza type & pizza type category to total revenue.

SELECT 
    pt.name AS pizza_type,
    ROUND(SUM(p.price * od.quantity), 2) AS revenue,
    ROUND(SUM(p.price * od.quantity) * 100.0 / (
        SELECT SUM(p2.price * od2.quantity)
        FROM order_details od2
        JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id
    ), 2) AS percentage_contribution
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY percentage_contribution DESC;

SELECT 
    pt.category,
    ROUND(SUM(p.price * od.quantity), 2) AS category_revenue,
    ROUND(SUM(p.price * od.quantity) * 100.0 / (
        SELECT SUM(p2.price * od2.quantity)
        FROM order_details od2
        JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id
    ), 2) AS percentage_contribution
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY percentage_contribution DESC;

SELECT 
    pt.category,
    pt.name AS pizza_type,
    ROUND(SUM(p.price * od.quantity), 2) AS revenue,
    ROUND(SUM(p.price * od.quantity) * 100.0 / (
        SELECT SUM(p2.price * od2.quantity)
        FROM order_details od2
        JOIN pizzas p2 ON od2.pizza_id = p2.pizza_id
    ), 2) AS percentage_contribution
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, pt.name
ORDER BY pt.category, percentage_contribution DESC;



-- Analyze the cumulative revenue generated over time.

SELECT 
    o.order_date,
    ROUND(SUM(p.price * od.quantity), 2) AS daily_revenue,
    ROUND(SUM(SUM(p.price * od.quantity)) OVER (ORDER BY o.order_date), 2) AS cumulative_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;



-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT pizza_type, category, total_revenue
FROM (
    SELECT 
        pt.name AS pizza_type,
        pt.category,
        ROUND(SUM(p.price * od.quantity), 2) AS total_revenue,
        ROW_NUMBER() OVER (PARTITION BY pt.category ORDER BY SUM(p.price * od.quantity) DESC) AS rank_in_category
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
) ranked
WHERE rank_in_category <= 3
ORDER BY category, total_revenue DESC
limit 3;


