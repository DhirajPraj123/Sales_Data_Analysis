
-- Write to create a database name
use store;


-- write a query to fetch data from datasource;
select * from str_hariom;

-- 1. Get total sales amount.
select count(distinct product_name) as Total_Product_name from str_hariom;

-- write a query to particular date from date_columns;
select * from str_hariom 
where sales_date='19-12-2024';

-- write a query to find specific name from particular table and certain date and aslo quantity;
select * from str_hariom 
where product_name='Apple'
and (sales_date='2024')
and 
quantity >= 100;

-- 4. Find sales per region.
select product_name,
round(sum(total_price)) as Net_Total,
count(*) as total_orders
from str_hariom
group by product_name;

select round(avg(quantity),2) as avg_gender
from str_hariom
where product_name='Nokia';

select * from str_hariom
where total_price >=6000;

-- 5. Find the product with the highest sales amount.
select product_name,
		gender,
        count(*) as Total_count_of_products
        from str_hariom
        group by product_name,
				gender
                order by 1;
                
-- 7. Find monthly sales trend for 2024.      
select extract(year from sales_date),
	  extract(month from sales_date),
round(avg(total_price),2)
from str_hariom
group by 1,2
order by 1,2 desc;


-- 8. Find salespersons who crossed ₹1,00,000 in sales.
select year sales_date,
	  month sales_date,
round(avg(total_price),2)
from str_hariom
group by 1,2
order by 1,2 desc;

-- 9. Find repeat customers (more than 1 order).
select  sd,pn,avgsale
from(
select sales_date as sd, product_name as pn,
avg(total_price) as avgsale,
rank() over(partition by sales_date order by avg(total_price) desc) as rank1
from str_hariom
group by 1,2)as tlt
where rank1 =1;


-- 10. Find highest-selling category.
select  custome_name, sum(total_price) as tlt
from str_hariom
group by 1
order by 2 desc
limit 5;


select * from str_hariom;

-- 11. Find the day with the maximum sales.
select product_name, count(distinct transaction_id) from str_hariom
group by 1;

-- 12. Find customers who never placed an order.
with hourly_sale 
as (
select *,
case 
	when extract(hour from sales_time) < 12 then 'morning'
    when extract(hour from sales_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift 
from str_hariom)
select shift,
count(*) as total_orders
from hourly_sale
group by shift;










