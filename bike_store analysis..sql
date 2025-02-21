#To she a data sets avilable. 
Show databases;
#use a data sets .on which do you you want work. 
use bike_store;
#Import a data in table. 
create table brands(
brands_id int primary key not null,
brand_name varchar(50));

#it is used to know the no.of data avilable in it. 
select count(*)
from customer;
select count(*)
from order_items;
#tList all tables in your database.  
show tables;
#Check a table structure.
desc order_items;

#BASIC SQL QUERY#
#Fetch All Data from a Table or a perticular no.
select *
from customer limit 20;

#Selecting Specific Columns.
select first_name 
from customer;

#Selecting Specific Columns with limit.
select first_name,last_name,email
from customer limit 20;

#3️⃣ Filtering Data Using WHERE Clause.
#Find Customers from a Specific City.
select *
from customer
where city='new york';
#with limit
select *
from customer
where city='new york' limit 5;

#Get Orders with Amount Greater than 500.
select *
from products
where list_price> 500;

#limit
select *
from products
where list_price>500 limit 10;

#4️⃣ Sorting Data Using ORDER BY.
#Get the Top 5 Highest Orders.
select *
from products
order by list_price desc limit 5;

#Get Customers in Alphabetical Order.
select*
from customer
order by last_name asc;

#5️⃣ Using DISTINCT to Remove Duplicates
#List All Unique Cities Where Customers Are From.
select distinct city 
from customer;

select distinct *
from customer
where city="new york";

#Joins & Aggregations
#1️⃣ Understanding Joins
#JOIN Type	Description
#INNER JOIN	Returns matching records from both tables
#LEFT JOIN	Returns all records from the left table and matching records from the right table
#RIGHT JOIN	Returns all records from the right table and matching records from the left table
#FULL JOIN	Returns all records from both tables
#2️⃣ INNER JOIN (Most Common)
#Get Orders with Customer Details
select orders.order_id,orders.order_status,orders.order_date,orders.required_date,orders.shipped_date,orders.staff_id,
customer.first_name,customer.last_name,customer.phone,customer.email,customer.street,customer.state,customer.city,customer.zip_code
from orders
inner join customer on orders.customer_id = customer.customer_id;

# 4️⃣ RIGHT JOIN (Include All Orders, Even If No Customer Info)
select orders.order_id,orders.order_status,orders.order_date,orders.required_date,orders.shipped_date,orders.staff_id,
customer.first_name,customer.last_name,customer.phone,customer.email,customer.street,customer.state,customer.city,customer.zip_code
from orders
right join customer on orders.customer_id = customer.customer_id;

#3️⃣ LEFT JOIN (Include All Customers, Even Those Without Orders)
select orders.order_id,orders.order_status,orders.order_date,orders.required_date,orders.shipped_date,orders.staff_id,
customer.first_name,customer.last_name,customer.phone,customer.email,customer.street,customer.state,customer.city,customer.zip_code
from orders
left join customer on orders.customer_id = customer.customer_id;

#full join
select orders.order_id,orders.order_status,orders.order_date,orders.required_date,orders.shipped_date,orders.staff_id,
customer.first_name,customer.last_name,customer.phone,customer.email,customer.street,customer.state,customer.city,customer.zip_code
from orders
join customer on orders.customer_id = customer.customer_id;

