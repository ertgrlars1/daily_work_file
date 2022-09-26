--------------having
--query, write a querry that checs if anny product id is duplicated in product table
--�r�n tablosunda herhangi bir �r�n kimli�inin kopyalan�p kopyalanmad���n� kontrol eden bir sorgu yaz�n

select product_id, count(product_id)
from product.product
group by product_id
having  count(product_id) > 1

--Write a query that returns category ids with conditions max list price above 4000 or a min list price below 500.
--Maksimum liste fiyat�n�n 4000'in �zerinde veya minimum liste fiyat�n�n 500'�n alt�nda oldu�u 
--ko�ullarda kategori kimliklerini d�nd�ren bir sorgu yaz�n

select category_id, max(list_price), min(list_price)
from product.product
group by category_id
having max(list_price) > 4000 or min(list_price) < 500
order by category_id

--markalar�n ortalama urun fiyat�


select brand_name, avg(list_price)
from product.brand b, product.product p
where p.brand_id = b.brand_id
group by brand_name
order by 2 DESC

--ortalamalar�n 1000'den buyuk olanlar

select brand_name, avg(list_price)
from product.brand b, product.product p
where p.brand_id = b.brand_id
group by brand_name
having avg(list_price) > 1000
order by 2 DESC

--querry, her bir order_id yani sipari�in toplam net amount'u

select order_id, sum(list_price * quantity * (1-discount)) as net_price
from sale.order_item
group by order_id

--querry, m��terilerin state'ler verilen ayl�k s�pari� say�s�

select state, year(order_date) as years, month(order_date) as months, count(*) as num_of_orders
from sale.customer s, sale.orders o
where s.customer_id = o.customer_id
group by state, month(order_date), year(order_date)
order by state, years, months


-------------grouping sets
--SUMMARY TABLE

SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year,
		ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO	sale.sales_summary
FROM	sale.order_item A, product.product B, product.brand C, product.category D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year

--grouping sets example
-- ayn� sorguda hem markalara ait net amount bilgisini
-- kategorilere ait net amount bilgisini
-- marka ve kategori k�r�l�m�ndaki net amount bilgisini getiririnz
-- t�m veriye ait net amount bilgisini getiriniz

select brand, Category, sum(total_sales_price) net_amount
from sale.sales_summary
group by grouping sets( (brand), (Category), (), (Brand,Category))
order by 1
--() gruplama yapmad�g� yani total amount

--------rollup
--farkl� gruplama varyanslar� yapmak �c�n kullan�l�r
/*
d1 d2 d3 d4
d1 d2 d3 null
d1 d2 null null
d1 null null null
null null null null 
*/

select brand, Category, sum(total_sales_price) net_amount
from sale.sales_summary
group by rollup (brand, Category)
order by 1

-------cube
--yapab�ld�g� tum gruplamalar� yapab�l�r. max varyasyon
/*
d1 d2 d3
d1 d2 null
d1 d3 null
d2 d3 null
d1 null null
d2 null null
d3 null null
null null null
*/
select brand, Category, sum(total_sales_price) net_amount
from sale.sales_summary
group by cube (brand, Category)
order by 1

-------pivot
-- bir sat�rdaki farkl� kategorileri sutun haline getirir
-- gruplama �slem� p�votun �c�nde yap�l�r
-- agg �slem� de select'de deg�l p�vot'un �c�nde yap�l�r


--Write a query using summary table that returns the total turnover from each category by model year. (in pivot table)
select Category, Model_Year, sum(total_sales_price) total_amount
from sale.sales_summary
group by Category, Model_Year
order by 1,2

select *
from
(
select Category, Model_Year, total_sales_price
from sale.sales_summary
) ss
pivot
( sum(total_sales_price) for Model_Year in ([2018], [2019], [2021])
) as pvt_tbl

--2 gunden gec kargolanan sipari�lerin g�nlere g�re dag�l�m�

select *
from
(
select order_id, datename(DW, order_date) order_weekday
from sale.orders
where DATEDIFF(DAY, order_date, shipped_date) > 2
) od
pivot
( count(order_id) for order_weekday IN ( [Monday], [Tuesday],  [Wednesday], [Thursday], [Friday], [Saturday], [Sunday])
) as pvt_tbl