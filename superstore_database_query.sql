create database superstores;
use superstores;

# Task 1:- Understanding the Data
# 1. Describe the data in hand in your own words. 

-- I am working on database "superstores".--
-- It contains 5 tables cust_dimen,market_fact,orders_dimen,prod_dimen,shipping_dimen Respectively.-- 
-- **In cust_dimen we have 5 columns.**
-- 1. Customer_Name : It includes name of customer.
-- 2. Province :  specifies the specific province or state where each customer resides.
-- 3. Region : The 'Region' column categorizes provinces or states into larger geographical areas.
-- 4. Customer_Segment : It cantains market segments of each customer.
-- 5. Cust_id :  unique identifier for each customer.

-- **In market_fact we have 10 columns.**
-- 1. Ord_id: Unique identifier for each order.
-- 2. Prod_id: Unique identifier for each product.
-- 3. Ship_id: Unique identifier for each shipment.
-- 4. Cust_id: Unique identifier for each customer.
-- 5. Sales: Total sales amount for the order.
-- 6. Discount: Discount applied to the order.
-- 7. Order_Quantity: Quantity of products ordered.
-- 8. Profit: Profit generated from the order.
-- 9. Shipping_Cost: Cost incurred for shipping the order.
-- 10. Product_Base_Margin: Profit margin for the product.

-- **In orders_dimen we have 4 columns.**
-- 1. Order_ID: Unique identifier for each order.
-- 2. Order_Date: Date when the order was placed.
-- 3. Order_Priority: Priority level assigned to the order.
-- 4. Ord_id: Unique identifier for each order, likely related to the primary key or foreign key in another table.

-- **In prod_dimen we have 3 columns.**
-- 1. Product_Category: The broad category to which a product belongs.
-- 2. Product_Sub_Category: A more specific sub-category within the broader product category.
-- 3. Prod_id: Unique identifier for each product.

-- **In shipping_dimen we have 4 columns.**
-- 1. Order_ID: Unique identifier for each order.
-- 2. Ship_Mode: Method or mode of shipment for the order.
-- 3. Ship_Date: Date when the order was shipped.
-- 4. Ship_id: Unique identifier for each shipment, likely related to the primary key or foreign key in another table.

/*2. Identify and list the Primary Keys and Foreign Keys for this dataset provided to
    you(In case you don’t find either primary or foreign key, then specially mention
    this in your answer)*/
    
   /* --1. *cust_dimen*:
   - Primary Key: Cust_id
   - Foreign Keys: None mentioned.

      -- 2. *market_fact*:
   - Primary Key: Ord_id
   - Foreign Keys:
     - Cust_id (references cust_dimen.Cust_id)
     - Prod_id (references prod_dimen.Prod_id)
     - Ship_id (references shipping_dimen.Ship_id)

      -- 3. *orders_dimen*:
   - Primary Key: Order_ID
   - Foreign Keys: None mentioned.

	-- 4. *prod_dimen*:
   - Primary Key: Prod_id
   - Foreign Keys: None mentioned.

	-- 5. *shipping_dimen*:
   - Primary Key: Ship_id
   - Foreign Keys: None mentioned.*/
   
   # Task 1:- Basic & Advanced Analysis
   
    /* 1. Write a query to display the Customer_Name and Customer Segment using alias
      name “Customer Name", "Customer Segment" from table Cust_dimen.*/

select Customer_Name as "Customer Name",Customer_Segment as "Customer Segment"
from Cust_dimen;

/* 2. Write a query to find all the details of the customer from the table cust_dimen
	order by desc.*/
    
select * 
from cust_dimen 
order by customer_Name desc;  

 /* 3. Write a query to get the Order ID, Order date from table orders_dimen where
‘Order Priority’ is high.*/

select Order_ID,Order_Date
from orders_dimen
where Order_Priority = 'HIGH' ;

/* 4. Find the total and the average sales (display total_sales and avg_sales) */

select sum(sales) as "total_sales",avg(sales) as "avg_sales"
from market_fact;

/* 5. Write a query to get the maximum and minimum sales from maket_fact table. */

select max(sales) as "maximun sales",min(sales) as "minimum sales"
from market_fact;

/* 6. Display the number of customers in each region in decreasing order of
no_of_customers. The result should contain columns Region, no_of_customers.*/

select count(Cust_id) as "No_of_Customer",Region
from cust_dimen
group by Region 
order by No_of_Customer desc;

/* 7.Find the region having maximum customers (display the region name and
max(no_of_customers) */

select Region,count(Cust_id) as no_of_customer
from cust_dimen
group by Region
limit 1;

/* 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’
and the number of tables purchased (display the customer name, no_of_tables
purchased) */

select * from cust_dimen;
select * from market_fact;
select * from prod_dimen;

select a.Customer_Name,count(b.Product_Sub_Category) as no_of_tables
from cust_dimen as a
join market_fact as c
on a.cust_id=c.cust_id
join prod_dimen as b
on c.prod_id=b.prod_id
where a.Region='atlantic' and b.Product_Sub_Category='tables'
group by a.Customer_name;

/* 9. Find all the customers from Ontario province who own Small Business. (display
the customer name, no of small business owners)*/

select Customer_Name,count(Customer_Segment) as "no_of_small_business_owners"
from cust_dimen
where Province='Ontario' and Customer_Segment='Small Business'
group by Customer_name ;

/* 10. Find the number and id of products sold in decreasing order of products sold
(display product id, no_of_products sold) */

select Prod_id,count(Order_Quantity) as no_of_products
from market_fact
group by Prod_id
order by no_of_products desc;

/* 11. Display product Id and product sub category whose produt category belongs to
Furniture and Technlogy. The result should contain columns product id, product
sub category. */

select Prod_id,Product_Sub_Category
from prod_dimen
where Product_Category in ('FURNITURE','TECHNOLOGY');

/* 12. Display the product categories in descending order of profits (display the product
category wise profits i.e. product_category, profits)? */

select a.Product_Category,sum(b.Profit) as total_profit
from prod_dimen as a
join market_fact as b
on a.Prod_id=b.Prod_id
group by a.Product_Category
order by total_profit desc;

/* 13. Display the product category, product sub-category and the profit within each
subcategory in three columns. */

select a.Product_Category,a.Product_Sub_Category,sum(b.Profit) as total_profit
from prod_dimen as a
join market_fact as b
on a.Prod_id=b.Prod_id
group by a.Product_Sub_Category,a.Product_Category;

/* 14. Display the order date, order quantity and the sales for the order.*/

select a.Order_Date,b.Order_Quantity,b.Sales
from orders_dimen as a
join market_fact as b
on a.Ord_id=b.Ord_id;

/* 15. Display the names of the customers whose name contains the
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’ */
 
select Customer_Name 
 from cust_dimen
 where Customer_Name like '_R%' 
 and Customer_Name like '___D%';
 
 /* 16. Write a SQL query to make a list with Cust_Id, Sales, Customer Name and
their region where sales are between 1000 and 5000.*/

select a.Cust_id,b.Sales,a.Customer_Name,a.Region
from cust_dimen as a
join market_fact as b
on a.Cust_id=b.Cust_id
where b.sales between 1000 and 5000;

/* 17.Write a SQL query to find the 3rd highest sales.*/

select distinct Sales
from market_fact
order by sales desc
limit 1 offset 2;

/* 18. Where is the least profitable product subcategory shipped the most? For the least
profitable product sub-category, display the region-wise no_of_shipments and the
profit made in each region in decreasing order of profits (i.e. region,
no_of_shipments, profit_in_each_region)
 → Note: You can hardcode the name of the least profitable product subcategory */
 

select a.Region,count(b.Ship_id) as "no_of_shipments",sum(b.Profit) as "profit_in_each_region"
from cust_dimen as a
join market_fact as b
on a.Cust_id=b.Cust_id
group by region 
order by profit_in_each_region desc;










