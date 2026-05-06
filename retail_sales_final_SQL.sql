create table retail_analysis (
transactions_id	int primary key,
sale_date date,	
sale_time time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
)

select * from retail_analysis;

delete from retail_analysis
where 
transactions_id	is NULL
or
sale_date is NULL
or
sale_time is NULL
or
customer_id	is NULL
or
gender is NULL
or
age is NULL
or
category is NULL
or
quantiy is NULL
or
price_per_unit is NULL
or
cogs is NULL
or
total_sale is NULL;

select * from retail_analysis;


--how many sales we have
select count(*) total_sale
from retail_analysis;

--no of customers 
select distinct count(customer_id)
from retail_analysis;

--types of categories 
select distinct category
from retail_analysis;


---Data Analysis questions & answrs
--write a query to retreive all the columns for sales made on 2022-11-05
select * 
from retail_analysis
where sale_date = '2022-11-05';

--Write a SQL query to reterive all the transactions made in clothing and 
--the quantity sold more than 10 in the month of Nov 22

select *
from retail_analysis 
where category = 'Clothing'
		and 
		To_Char(sale_date,'YYYY-MM')='2022-11'
		and 
		quantiy >=4

--Write a SQL query to calculate the total sales for each category 
select category,sum(total_sale) as total_sale,count(*) as total_orders
from retail_analysis
group by category;

--Write a SQL query to find the average age of cusotmers who purchased items from beauty category 
select round(avg(age),2) as avg_age
from retail_analysis
where category='Beauty';

--Write a SQL query to find all the transactions where the total sales is greater than 1000
select *
from retail_analysis
where total_sale >= 1000;


--Write a SQL query to find the total number of transactions made by each gender in each category 
select category,count(transactions_id) as total_transactions,gender
from retail_analysis
group by category,gender
order by category;

--Write a SQL query to calculate the average sale for each month 
--Find out the best selling month in each year  


select 
sales_year,
sales_month,
avg_sales
from
(
select 
to_char(sale_date,'YYYY') as sales_year,
to_char(sale_date,'MM') as sales_month,
avg(total_sale) as avg_sales,
rank() over(partition by to_char(sale_date,'YYYY') order by avg(total_sale) desc) as rank_qw
from retail_analysis
group by 1,2
) as t 
where rank_qw=1


--Write a SQL query to find the top 5 customers based on highest total sales
select customer_id,sum(total_sale) as total_sales
from retail_analysis
group by customer_id
order by total_sales desc
limit 5;


--Write a SQL query to find the number of unique customers who purchased items from each category 
select category,count(distinct(customer_id)) as unique_customers
from retail_analysis
group by category;


--Write a SQL query to create each shift and number of orders (Example morning <=12,Afternoon between 12 & 17 ,Evening >17)


with hourly_sale as
(
select *,
	Case 
		when extract(Hour from sale_time)< 12 then 'Morning'
		when extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	End as shift
from retail_analysis
)
select shift,
		count(*) as total_orders
from hourly_sale
group by shift


















