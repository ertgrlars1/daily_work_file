--Davis thomas�n cal��t�g� magazadaki tum cal�sanlar� getirin subquerry

select *
from sale.staff
where store_id = ( select store_id from sale.staff where  first_name = 'Davis' and last_name = 'Thomas')

-- Charles Cussona'n�n birinci dereceden y�netici oldu�u �al��anlar� g�steren bir sorgu yaz�n.
--(Charles Cussona hangi �al��anlar i�in birinci derece y�neticidir?)


select *
from sale.staff
where manager_id = (select staff_id from sale.staff where first_name = 'Charles' and last_name = 'Cussona')

--bflo store nerde �se o seh�rde bulunan musteriler

SELECT	city
FROM	sale.store
WHERE	 store_name = 'The BFLO Store'
SELECT *
FROM	SALE.customer
WHERE	city = (SELECT	city
				FROM	sale.store
				WHERE	 store_name = 'The BFLO Store')

----Write a query that returns the list of products that are more expensive 
--than the product named 'Pro-Series 49-Class Full HD Outdoor LED TV (Silver)'

select product_id, product_name, model_year, list_price
from product.product
where list_price > (select list_price from product.product where product_name like 'Pro-Series%')

-- M��teri adlar�n�, soyadlar�n� ve sipari� tarihlerini d�nd�ren bir sorgu yaz�n.
-- Laurel Goldammer ile ayn� tarihlerde sipari� veren m��teriler.
select first_name, last_name
from sale.orders o, sale.customer c
where o.customer_id = c.customer_id and
order_date in (select order_date
from sale.orders o, sale.customer c
where o.customer_id = c.customer_id and c.first_name = 'Laurel' and c.last_name = 'Goldammer')

--in yerine order_date = ANY �eklinde diyebilirdik

--Buffalo �ehrinde son 10 sipari�te sipari� edilen �r�nleri listeleyin.

select *
from sale.order_item o, product.product p
where order_id in
(select top 10 order_id
from sale.customer c, sale.orders o
where c.customer_id = o.customer_id and city = 'buffalo'
order by order_id DESC)
and p.product_id = o.product_id

--receivers Amplifiers'dak en pahal� urunden daha pahal� ve 2020 olan urunler� s�ralay�n

select *
from product.product
where model_year = '2020' and list_price >
(
select max(list_price)
from product.category c, product.product p
where c.category_id = p.category_id and category_name = 'Receivers Amplifiers'
)

-- or
select *
from product.product
where model_year = '2020' and list_price > ALL
(
select list_price
from product.category c, product.product p
where c.category_id = p.category_id and category_name = 'Receivers Amplifiers'
)

--yukar�da sonunun min'umum
--max yerine min
-- veya all yerine  any kullan�acak

-----------Coreelated Subquaries, exist, not exist
--subquerry ile d�s sorgunun bir tak�ma join edilmesi anlam�na gelir
--kontrol amacl� kullan�l�r, querry'nin �al���p �al�smad�g�n� kontrol eder
--eger queery'i �al���yorsa sunu yap tarz� amaclarda kullan�l�r