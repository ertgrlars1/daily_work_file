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


--Soru: 2021'de yapýlan product_names döndüren bir sorgu yazýn. (Game, gps veya Home Theater ile eþleþen kategorileri hariç tutun)
select product_name, list_price
from product.product p, product.category c
where p.category_id = c.category_id and model_year = 2021
and category_name not in ('game', 'gps', 'Home Theater')


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

-----------Correlated Subquaries, exist, not exist
--subquerry ile dýs sorgunun bir takýma join edilmesi anlamýna gelir
--kontrol amaclý kullanýlýr, querry'nin çalýþýp çalýsmadýgýný kontrol eder
--eger queery'i çalýþýyorsa sunu yap tarzý amaclarda kullanýlýr

/*
Soru: 'Apple - Pre-Owned iPad 3 - 32GB - White' ürününün sipariþ edilmediði Durumlarýn listesini döndüren bir sorgu yazýn
*/

select distinct STATE
from sale.customer c2
where not exists (
select distinct state
from product.product p, sale.order_item oi, sale.orders o, sale.customer c1
where product_name = 'Apple - Pre-Owned iPad 3 - 32GB - White' 
and p.product_id = oi.product_id 
and o.order_id = oi.order_id 
and c1.customer_id = o.customer_id
and c2.state = c1.state
)
--1'in bir önemi yoktur. 

/*
Soru: Davi techno Retail maðazasýndaki ürünlerin stok bilgilerini döndüren bir sorgu yazýnýz.
BUFFALO Store'da bu ürünlerden stoklarý bitmiþ olsun.
*/
select store_name, s1.store_id, product_id, quantity
from sale.store s1, product.stock st1
where s1.store_id = st1.store_id and store_name = 'Davi techno Retail'
and exists (
select *
from sale.store s, product.stock st
where store_name = 'The BFLO Store' and s.store_id = st.store_id and quantity = 0 and st1.product_id = st.product_id
)

--or

select store_name, s1.store_id, product_id, quantity
from sale.store s1, product.stock st1
where s1.store_id = st1.store_id and store_name = 'Davi techno Retail'
and product_id in ( select product_id from product.stock s ,sale.store st where s.store_id = st.store_id and store_name = 'The BFLO Store')
and not exists (
select *
from sale.store s, product.stock st
where store_name = 'The BFLO Store' and s.store_id = st.store_id and quantity <> 0 and st1.product_id = st.product_id
)

/*
Soru: Davi techno Retail maðazasýndaki ürünlerin stok bilgilerini döndüren bir sorgu yazýnýz.
BUFFALO Store'da bu ürünlerden stoklarý bitmiþ veya hiç olmasýn.
*/

select store_name, s1.store_id, product_id, quantity
from sale.store s1, product.stock st1
where s1.store_id = st1.store_id and store_name = 'Davi techno Retail'
and not exists (
select *
from sale.store s, product.stock st
where store_name = 'The BFLO Store' and s.store_id = st.store_id and quantity <> 0 and st1.product_id = st.product_id
)



------cte's
--subquerry'i basa yasýyoruz


-- Soru: Jerald Berray adlý bir müþterinin son sipariþinden önce sipariþi olan ve Austin þehrinde ikamet eden müþterileri listeleyin.


with T1 AS
(select max(order_date) last_order_date
from sale.customer c, sale.orders o   
where c.customer_id = o.customer_id
and first_name = 'Jerald' and last_name = 'Berray')
select c.customer_id, first_name, last_name, order_date
from sale.customer c, sale.orders o, T1
where c.customer_id = o.customer_id and T1.last_order_date > order_date and city = 'Austin'

--Soru: Tüm müþterilerin sipariþlerinin ayný tarihlerde olduðunu Laurel Goldammer ile listeleyin
with T1 AS
(select order_date as laurel
from sale.customer c, sale.orders o
where c.customer_id = o.customer_id
and first_name = 'Laurel' and last_name = 'Goldammer')
select first_name, last_name, order_date
from sale.customer c, sale.orders o, T1
where c.customer_id = o.customer_id and order_date in (T1.laurel)

--Soru: Model yýlý 2021 olan ürünleri ve Oyun, gps veya Ev Sinemasý dýþýndaki kategorilerini listeleyin.
with t1 as
(
select *
from product.product p
where model_year = 2021)
select t1.product_name, t1.list_price
from product.category b, t1
where b.category_id = t1.category_id and category_name not in ('game', 'gps', 'Home Theater')

-----------------------recursive cte

--Question: Create a table with a number in each row in ascending order from o to 9.

with t1 as
(select 0 as number
union all
select number + 1
from t1
where number < 9)
select *
from t1

--Soru: Tüm personeli kendi bilgileriyle döndüren bir sorgu yazýn. manager_ids. (Recursive  CTE kullanýn)
WITH T1 AS (
    SELECT staff_id, first_name, manager_id
    FROM   sale.staff
    WHERE  staff_id=1
    UNION ALL
    SELECT B.staff_id, B.first_name, B.manager_id
    FROM   T1 A, sale.staff B
	WHERE  A.staff_id = B.manager_id
)
SELECT * FROM T1;
--Soru: 2018 yýlýnda cirolarý ortalama maðaza cirolarýnýn altýnda olan maðazalarý sýralayýnýz.

with t1 as
(
select store_name, sum(quantity * list_price * (1-discount)) turnover_of_stores
from sale.order_item oi, sale.orders o, sale.store s
where oi.order_id = o.order_id and s.store_id = o.store_id and year(order_date) = 2018
group by store_name),
t2 as
(
select  avg(turnover_of_stores) avg_turnover_2018
from t1
)
select *
from t1, t2
where t1.turnover_of_stores < avg_turnover_2018

--Soru: Her sipariþte ürünlerin toplam fiyatlarýný hesaplayan "total_price" adýnda yeni bir sütun oluþturan bir sorgu yazýn.

select order_id,
(
select sum(list_price) from sale.order_item oi where o.order_id = order_id) total_price
from sale.orders o

--Soru: 2019-10-01 tarihinden sonra ilk sipariþini veren müþteriler için ilk sipariþlerinin net tutarýný döndüren bir sorgu yazýn.
with t1 as(
select c.customer_id, first_name, last_name, min(order_id) as order_id
from sale.customer c , sale.orders o
where c.customer_id = o.customer_id
group by c.customer_id, first_name, last_name
having min(o.order_date) > '2019-10-01')
select customer_id,first_name, last_name, oi.order_id, sum((quantity * list_price * (1 - discount))) as net_price
from sale.order_item oi, t1
where oi.order_id = t1.order_id
group by customer_id, first_name, last_name, oi.order_id

