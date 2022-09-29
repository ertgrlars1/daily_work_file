/*
1. Product Sales
You need to create a report on whether customers who purchased the product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' 
buy the product below or not.
1. 'Polk Audio - 50 W Woofer - Black' -- (other_product)
*/

select distinct c.customer_id, first_name, last_name,
case
	when product_name = 'Polk Audio - 50 W Woofer - Black' then 'Yes'
	else 'No'
	end as other_product
from sale.customer c, sale.orders o, sale.order_item oi, product.product p
where c.customer_id = o.customer_id and o.order_id = oi.order_id and oi.product_id = p.product_id
and c.customer_id in
(
select o.customer_id
from  sale.orders o, sale.order_item oi, product.product p
where o.order_id = oi.order_id and oi.product_id = p.product_id
and product_name like '2TB Red%'
)

/*
2. Conversion Rate
Below you see a table of the actions of customers visiting the website by clicking on 
two different types of advertisements given by an E-Commerce company. 
Write a query to return the conversion rate for each Advertisement type.
*/

Create database ECommerce
use ECommerce

create table Actions (
Visitor_ID int identity(1,1) primary key,
Adv_Type varchar(1),
Action varchar(6)
)

insert Actions values ('A', 'Left')
insert Actions values ('A', 'Order')
insert Actions values ('B', 'Left')
insert Actions values ('A', 'Order')
insert Actions values ('A', 'Review')
insert Actions values ('A', 'Left')
insert Actions values ('B', 'Left')
insert Actions values ('B', 'Order')
insert Actions values ('B', 'Review')
insert Actions values ('A', 'Review')

select adv_type, cast(count(*) * 1.0 /
(select count(*) from Actions where a.Adv_Type = Adv_Type) as numeric (3,2)) Conversion_Rate
from Actions a
where action = 'order'
group by adv_type

--ikinci yöntem

select t.Adv_Type, cast(count(a.Adv_Type) * 1.0 / t.count_  as numeric(3,2)) Conversion_Rate
from(select adv_type, count(*) as count_
from Actions
group by adv_type
) T, Actions a
where t.Adv_Type = a.Adv_Type and action = 'order'
group by a.adv_type, t.Adv_Type, t.count_
