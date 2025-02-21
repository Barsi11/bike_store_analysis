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

#Aggregation Functions (GROUP BY)
#🔸 Count Total Orders Per Customer
select customer_id, count(order_id) as Total_order
from orders
group by customer_id;

#Get Total Revenue from Orders.
select sum(list_price) as total_revenue
from products;

#Find Average Order Value
select avg(order_id) as average_value
from orders;

#Get Total Revenue Per City
select customer.city,sum(products.list_price) as total_revenue_city
from customer
join products 
on customer.customer_id=products.product_id
group by customer.city;

#Advanced SQL Joins & Aggregations
#Today, we will focus on:
#✅ Self JOIN – Joining a table with itself.
#✅ Cross JOIN – Cartesian product of two tables.
#✅ Aggregate Functions – SUM(), AVG(), COUNT(), MAX(), MIN().
#✅ GROUP BY & HAVING – Grouping data and filtering aggregated results.
#1️⃣ Self JOIN (Joining a Table with Itself)
# 1️⃣ Find Total Orders Per Product
select products.product_name,count(orders.order_id)as total_order
from orders
join products on orders.order_id=products.product_id
group by products.product_name
order by total_order desc;

#2️⃣ Identify Customers Who Placed less Than 3 Orders.
select customer.customer_id,customer.first_name,customer.last_name, count(orders.order_id)as total_order
from customer
join orders on customer.customer_id=orders.customer_id
group by customer.customer_id,customer.first_name,customer.last_name
having count(orders.order_id)<3
order by total_order desc;

#3️⃣ Find the customer with the Highest Sales (Revenue).
select customer.customer_id,customer.first_name,customer.last_name,sum(order_items.list_price) AS total_Sales
From customer
join order_items on Customer.customer_id=order_items.order_id
group by customer.customer_id,customer.first_name,customer.last_name
order by total_Sales desc
limit 1;

#4️⃣ Get All customer & order Combinations (CROSS JOIN)
select customer.customer_id as customer_name, orders.order_id
from customer
cross join orders;

# Advanced SQL Queries & Subqueries
#1️⃣ Subqueries – Writing queries inside queries
#2️⃣ Common Table Expressions (CTEs) – Making complex queries easier
#3️⃣ Window Functions – Analyzing data trends

#1️⃣ Subquery Example
#Find customers who have placed orders worth more than the average order amount.
select customer.customer_id,customer.first_name,customer.last_name,sum(order_items.list_price) as average_total
from customer
join order_items on customer.customer_id=order_items.order_id
group by customer.customer_id,customer.first_name,customer.last_name
having sum(order_items.list_price)>(select avg(order_items.list_price)
from order_items)
order by average_total desc;

#2️⃣ Common Table Expression (CTE) Example
#Find the top 5 customers based on total spending.
with customertotal as (
select customer.customer_id,customer.first_name,customer.last_name,sum(order_items.list_price) as Total_spent
from customer
join order_items on customer.customer_id=order_items.list_price
group by customer.customer_id,customer.first_name,customer.last_name)
select * 
from customertotal
order by Total_spent desc
limit 5;

#3️⃣ Window Function Example
#Instead of grouping data, window functions calculate rankings across rows.
#Rank customers by their total spending.
select customer.customer_id,customer.first_name,customer.last_name,sum(order_items.list_price) as total_spending,
rank()over(order by sum(order_items.list_price)desc)as rank_no
from customer
join order_items on customer.customer_id=order_items.list_price
group by customer.customer_id,customer.first_name,customer.last_name;

#Indexing, Performance Optimization & Stored Procedures
#1️⃣ Indexes – Speeding up query execution
#2️⃣ Performance Optimization – Best practices for large datasets
#3️⃣ Stored Procedures – Automating repetitive queries

#1️⃣ Indexing for Faster Queries
#🔹 Creating an Index
create index idx_customer_id on orders(customer_id);
#✅ Now, queries that filter or join on customer_id will run much faster.

#🔹 Checking Index Usage
explain select* 
from orders
where customer_id=101;
#✅ If the query uses an index, you’ll see Using index in the result.

#2️⃣ Performance Optimization Techniques
#🔹 Avoiding SELECT*(❌ Bad Query) use  at the place of optimized query.Only fetch the necessary columns to reduce memory usage.
select order_id,customer_id,order_status
from orders;

#🔹 Using LIMIT for Large Datasets
select *
from orders limit 100;

#3️⃣ Stored Procedures: Automating Queries.
#🔹 Creating a Stored Procedure.
DELIMITER $$  
CREATE PROCEDURE GetCustomerOrders(IN cust_id INT)  
BEGIN  
SELECT * FROM orders WHERE customer_id = cust_id;  
END $$  
DELIMITER ;

#🔹 Running the Stored Procedure
CALL GetCustomerOrders(101);



