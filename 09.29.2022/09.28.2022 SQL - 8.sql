------------------------------------set operations

------union/ union all
--union da duplýcate olanlar alýnmaz. union all'da alýnýr
--order by en altakýnýn altýnda yapýlmalý. Ortada degýl
--Soru: Charlotte ve Aurora þehirlerinde satýlan ürünleri listeleyin

select distinct product_name
from sale.customer c, sale.orders o, sale.order_item oi, product.product p
where city = 'Aurora' 
and c.customer_id = o.customer_id
and o.order_id = oi.order_id
and oi.product_id = p.product_id
union
select distinct product_name
from sale.customer c, sale.orders o, sale.order_item oi, product.product p
where city = 'Charlotte' 
and c.customer_id = o.customer_id
and o.order_id = oi.order_id
and oi.product_id = p.product_id

--ismi veya soy ismi thomas olan müþterileri getirin
select first_name, last_name
from sale.customer
where first_name = 'thomas'
union all
select first_name, last_name
from sale.customer
where last_name = 'thomas'

------------intersect
--kesýsým alýr

-- Soru: Hem 2018 hem de 2020 model yýlý için ürünleri olan tüm markalarý döndüren bir sorgu yazýn.

select distinct b.brand_id, brand_name
from product.product p, product.brand b
where model_year = 2018 and p.brand_id = b.brand_id
intersect
select distinct b.brand_id, brand_name
from product.product p, product.brand b
where model_year = 2020 and p.brand_id = b.brand_id

--Soru:2018, 2019 ve 2020'nin tamamýnda sipariþ veren müþterilerin ad ve soyadlarýný döndüren bir sorgu yazýn.

select first_name, last_name
from sale.customer
where customer_id in (
select distinct customer_id
from sale.orders o
where order_date between '2018-01-01' and '2018-12-31'
intersect
select distinct customer_id
from sale.orders o
where  year(order_date) = 2019
intersect
select distinct customer_id
from sale.orders o
where  year(order_date) = 2020)

--soruda first_name ve last_name'den gýdemeyýz cunku ayný ýsýmlý olup da farklý yýllarda sýparýs veren musteriler olabýlýr

--------except
--kümelerdeki fark iþlemi

--Soru: 2018 model ürünü olan ancak 2019 model ürünü olmayan markalarý döndüren bir sorgu yazýnýz.
select b.brand_id, brand_name
from product.product p, product.brand b
where p.brand_id = b.brand_id and model_year = 2018
except
select b.brand_id, brand_name
from product.product p, product.brand b
where p.brand_id = b.brand_id and model_year = 2019

--Soru: Yalnýzca 2019 yýlýnda sipariþ edilen ürünleri içeren bir sorgu yazýn (Sonuç diðer yýllarda sipariþ edilen ürünleri içermez)

with t1 as
(
select product_id
from sale.order_item oi, sale.orders o
where oi.order_id = o.order_id and year(order_date) = 2019
except
select product_id
from sale.order_item oi, sale.orders o
where oi.order_id = o.order_id and year(order_date) <> 2019
)
select p.product_id, product_name
from product.product p, t1
where p.product_id = t1.product_id

---------------------------case expression
--case when then else end
--simple case expression da sadece eþitse anlamý kullanýlýr

/*
Soru: Order_Status sütunundaki deðerlerin anlamý ile yeni bir sütun oluþturun.
1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
*/

select order_id, order_status,
case order_status
	when 1 then 'Pending'
	when 2 then 'Processing'
	when 3 then 'Rejected'
	else 'Completed'
end as order_status_desc
from sale.orders

/*
Soru: store_ids sütunundaki deðerlerle tutarlý olmasý için maðazalarýn adlarýyla yeni bir sütun oluþturun
1 = Davi techno Retail; 2 = The BFLO Store; 3 = Burkes Outlet
*/

select distinct first_name, last_name, store_id, 
case store_id
	when 1 then 'Davi techno Retail'
	when 2 then 'The BFLO Store'
	else 'Burkes Outlet'
end as store_name
from sale.customer c, sale.orders o
where c.customer_id = o.customer_id
order by 3


--searched case expression
--case'in yanýna yazdýgýmýz column ýsmý yok býrden fazla column'da calýsabýlýr


/*
Soru: Order_Status sütunundaki deðerlerin anlamý ile yeni bir sütun oluþturun.
1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
*/

select order_id, order_status,
case 
	when order_status =  1 then 'Pending'
	when order_status = 2 then 'Processing'
	when order_status = 3 then 'Rejected'
	else 'Completed'
end as order_status_desc
from sale.orders

/*
Soru: Hangi e-posta servis saðlayýcýsýný ("Gmail", "Hotmail", "Yahoo" veya "Other") gösteren yeni bir sütun oluþturun.
*/

select first_name, last_name, email,
case 
	when email like '%Gmail.com' then 'Gmail'
	when email like '%Hotmail.com' then 'Hotmail'
	when email like '%Yahoo.com' then 'Yahoo'
	else 'Other'
end as email_service_provider
from sale.customer
--simple ile yapýlmaz orda like operatorunu kullanamayýz

--Soru: Ýki gün sonra sevk edilen sipariþlerin sayýsýný günlük olarak pivot tablo biçiminde döndüren bir sorgu yazýn.

select
sum(case when DATENAME(dw, order_date) = 'sunday' then 1 else 0 end) as sunday,
sum(case when DATENAME(dw, order_date) = 'Monday' then 1 else 0 end) as Monday,
sum(case when DATENAME(dw, order_date) = 'tuesday' then 1 else 0 end) as tuesday,
sum(case when DATENAME(dw, order_date) = 'wednesday' then 1 else 0 end) as wednesday,
sum(case when DATENAME(dw, order_date) = 'friday' then 1 else 0 end) as friday,
sum(case when DATENAME(dw, order_date) = 'saturday' then 1 else 0 end) as saturday
from sale.orders
where DATEDIFF(day, order_date, shipped_date) > 2