select * from project_customers;

select * from project_orders;

select * from project_products;


create table combined_table_indah as
	select c.customer_id ,p.product_id ,o.order_id,
		   c.customer_name, c.segment ,c.country, c.state ,c.postal_code, c.region, c.city, 
		   o.order_date ,o.ship_date,o.ship_mode ,o.sales ,o.quantity ,o.profit,o.discount,
		   p.category,p.product_name ,p.sub_category 
		FROM project_customers c
			INNER JOIN project_orders o ON c.customer_id = o.customer_id 
			INNER JOIN project_products	p ON o.product_id = p.product_id;

select * from combined_table_indah;
	
select sum(sales) as total_sales from combined_table_indah;

select sum(quantity) as total_product_sold from combined_table_indah;

select sum(profit) as total_profit from combined_table_indah;

select count(distinct order_id) as total_order from combined_table_indah;

select count(distinct product_name) as total_jenis_produk from combined_table_indah;

select count(distinct country) as total_order from combined_table_indah;

select count(distinct customer_id) as total_customer from combined_table_indah;

--daily trend

select extract(ISODOW from order_date) as order_day , count(distinct order_id)as total_orders
from combined_table_indah
group by extract(ISODOW from order_date)
order by total_orders desc;

--monthly trend

select extract(month from order_date) as order_month , count(distinct order_id)as total_orders
from combined_table_indah
group by extract(month from order_date)
order by total_orders desc;

--total shipping 
select extract(ISODOw from ship_date) as shipping_day , count(distinct order_id)as total_orders
from combined_table_indah
group by extract(ISODOW from ship_date)
order by total_orders desc;


--sales by category
select category , cast(sum(sales)as decimal(10,2)) as total_revenue ,
		cast(sum(sales)*100/(select sum(sales) from combined_table_indah) as decimal(10,2))as pct
	from combined_table_indah 
	group by category;
	
--total order by category
select category, count(distinct order_id)as total_orders ,
	cast(count(distinct order_id)*100/(select count(distinct order_id) from combined_table_indah) as decimal(10,2))as pct
	from combined_table_indah 
	group by category;
	
--top 5 best seller sub_category

select sub_category, sum(quantity) as total_product_sold
from combined_table_indah 
group by sub_category
order by total_product_sold desc
limit 5


select segment, sum(quantity) as total_product_sold_by_segment
from combined_table_indah 
group by segment
order by total_product_sold_by_segment desc

select segment,count(distinct order_id)as total_order, 
		sum(quantity) as total_product_sold,cast(sum(sales)as decimal(10,2)) as total_revenue,
		cast(sum(profit)as decimal(10,2)) as total_profit
from combined_table_indah 
group by segment

select ship_mode,count(distinct order_id)as total_order, 
		sum(quantity) as total_product_sold,cast(sum(sales)as decimal(10,2)) as total_revenue,
		cast(sum(profit)as decimal(10,2)) as total_profit
from combined_table_indah 
group by ship_mode

select category,count(distinct order_id)as total_order, 
		sum(quantity) as total_product_sold,cast(sum(sales)as decimal(10,2)) as total_revenue,
		cast(sum(profit)as decimal(10,2)) as total_profit
from combined_table_indah 
group by category

select sub_category,count(distinct order_id)as total_order, 
		sum(quantity) as total_product_sold,cast(sum(sales)as decimal(10,2)) as total_revenue,
		cast(sum(profit)as decimal(10,2)) as total_profit
from combined_table_indah 
group by sub_category

select order_date, quantity,sales, profit
	from combined_table_indah 


