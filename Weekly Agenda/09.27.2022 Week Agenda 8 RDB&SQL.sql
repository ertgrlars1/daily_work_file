---- RDB&SQL Exercise-2 Student

----1. View kullanarak, AVG() toplama iþlevini kullanarak staff ve yýllara göre ortalama satýþlarý alýn.
create view v_sample as
select first_name, last_name, year(order_date) as year_, avg(list_price * quantity * (1-discount)) as avg_
from sale.staff s, sale.orders o, sale.order_item oi
where s.staff_id = o.staff_id and o.order_id = oi.order_id
group by year(order_date), first_name, last_name

select *
from v_sample
order by 1,2, 3 DESC

----2. Brand göre üretilen yýllýk ürün miktarýný seçin
select brand_name, model_year, sum(quantity) as sum_
from product.brand b, product.product p, product.stock s
where b.brand_id = p.brand_id and p.product_id = s.product_id
group by brand_name, model_year
order by 1,2

----3. Storea göre stokta bulunan en az 3 ürünü seçin.
select store_name, product_name, quantity
from sale.store st, product.stock s, product.product p
where st.store_id = s.store_id and s.product_id = p.product_id
and p.product_id in (
select top 3 product_id
from product.stock
where store_id = s.store_id
order by quantity
)
order by 1

----4. 2020'de günlük ortalama sipariþ sayýsýný döndüren bir sorgu yazýn.

select day_, avg(count_) as avg_
from (
select DATENAME(dw,order_date) day_, DATENAME(week,order_date) week_ ,count(o.order_id) as count_
from sale.orders o, sale.order_item oi
where o.order_id = oi.order_id 
and year(order_date) = 2020
group by DATENAME(dw,order_date), DATENAME(week,order_date)) T
group by day_

----5. Her bir markadaki liste fiyatýna göre her bir ürüne bir derece atayýn ve üçe eþit veya daha az olan ürünleri alýn.

select *
from product.brand b, product.product p, product.stock s
where b.brand_id = p.brand_id and p.product_id = s.product_id