create database pizzahut;
show databases;
SELECT * FROM pizzahut.pizzas;
SELECT * FROM pizzahut.pizza_types;
create table Orders( 
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id)
);
SELECT * FROM pizzahut.orders;
create table Order_details ( 
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key (order_details_id));
SELECT * FROM pizzahut.order_details;
