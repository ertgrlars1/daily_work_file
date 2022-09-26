--Davis thomasýn calýþtýgý magazadaki tum calýsanlarý getirin subquerry

select *
from sale.staff
where store_id = ( select store_id from sale.staff where  first_name = 'Davis' and last_name = 'Thomas')

-- Charles Cussona'nýn birinci dereceden yönetici olduðu çalýþanlarý gösteren bir sorgu yazýn.
--(Charles Cussona hangi çalýþanlar için birinci derece yöneticidir?)


select *
from sale.staff
where manager_id = (select staff_id from sale.staff where first_name = 'Charles' and last_name = 'Cussona')

--bflo store nerde ýse o sehýrde bulunan musteriler

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

-- Müþteri adlarýný, soyadlarýný ve sipariþ tarihlerini döndüren bir sorgu yazýn.
-- Laurel Goldammer ile ayný tarihlerde sipariþ veren müþteriler.
select first_name, last_name
from sale.orders o, sale.customer c
where o.customer_id = c.customer_id and
order_date in (select order_date
from sale.orders o, sale.customer c
where o.customer_id = c.customer_id and c.first_name = 'Laurel' and c.last_name = 'Goldammer')

--in yerine order_date = ANY þeklinde diyebilirdik

--Buffalo þehrinde son 10 sipariþte sipariþ edilen ürünleri listeleyin.

select *
from sale.order_item o, product.product p
where order_id in
(select top 10 order_id
from sale.customer c, sale.orders o
where c.customer_id = o.customer_id and city = 'buffalo'
order by order_id DESC)
and p.product_id = o.product_id

--receivers Amplifiers'dak en pahalý urunden daha pahalý ve 2020 olan urunlerý sýralayýn

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

--yukarýda sonunun min'umum
--max yerine min
-- veya all yerine  any kullanýacak

-----------Coreelated Subquaries, exist, not exist
--subquerry ile dýs sorgunun bir takýma join edilmesi anlamýna gelir
--kontrol amaclý kullanýlýr, querry'nin çalýþýp çalýsmadýgýný kontrol eder
--eger queery'i çalýþýyorsa sunu yap tarzý amaclarda kullanýlýr