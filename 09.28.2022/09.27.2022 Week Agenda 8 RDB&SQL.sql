---- RDB&SQL Exercise-2 Student

----1. View kullanarak, AVG() toplama i�levini kullanarak staff ve y�llara g�re ortalama sat��lar� al�n.
create view v_sample as
select first_name, last_name, year(order_date) as year_, avg(list_price * quantity * (1-discount)) as avg_
from sale.staff s, sale.orders o, sale.order_item oi
where s.staff_id = o.staff_id and o.order_id = oi.order_id
group by year(order_date), first_name, last_name

select *
from v_sample
order by 1,2, 3 DESC

----2. Brand g�re �retilen y�ll�k �r�n miktar�n� se�in
select brand_name, model_year, sum(quantity) as sum_
from product.brand b, product.product p, product.stock s
where b.brand_id = p.brand_id and p.product_id = s.product_id
group by brand_name, model_year
order by 1,2

----3. Storea g�re stokta bulunan en az 3 �r�n� se�in.
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

----4. 2020'de g�nl�k ortalama sipari� say�s�n� d�nd�ren bir sorgu yaz�n.

select day_, avg(count_) as avg_
from (
select DATENAME(dw,order_date) day_, DATENAME(week,order_date) week_ ,count(o.order_id) as count_
from sale.orders o, sale.order_item oi
where o.order_id = oi.order_id 
and year(order_date) = 2020
group by DATENAME(dw,order_date), DATENAME(week,order_date)) T
group by day_

----5. Her bir markadaki liste fiyat�na g�re her bir �r�ne bir derece atay�n ve ��e e�it veya daha az olan �r�nleri al�n.

select *
from product.brand b, product.product p, product.stock s
where b.brand_id = p.brand_id and p.product_id = s.product_id