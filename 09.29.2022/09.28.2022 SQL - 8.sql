------------------------------------set operations

------union/ union all
--union da dupl�cate olanlar al�nmaz. union all'da al�n�r
--order by en altak�n�n alt�nda yap�lmal�. Ortada deg�l
--Soru: Charlotte ve Aurora �ehirlerinde sat�lan �r�nleri listeleyin

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

--ismi veya soy ismi thomas olan m��terileri getirin
select first_name, last_name
from sale.customer
where first_name = 'thomas'
union all
select first_name, last_name
from sale.customer
where last_name = 'thomas'

------------intersect
--kes�s�m al�r

-- Soru: Hem 2018 hem de 2020 model y�l� i�in �r�nleri olan t�m markalar� d�nd�ren bir sorgu yaz�n.

select distinct b.brand_id, brand_name
from product.product p, product.brand b
where model_year = 2018 and p.brand_id = b.brand_id
intersect
select distinct b.brand_id, brand_name
from product.product p, product.brand b
where model_year = 2020 and p.brand_id = b.brand_id

--Soru:2018, 2019 ve 2020'nin tamam�nda sipari� veren m��terilerin ad ve soyadlar�n� d�nd�ren bir sorgu yaz�n.

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

--soruda first_name ve last_name'den g�demey�z cunku ayn� �s�ml� olup da farkl� y�llarda s�par�s veren musteriler olab�l�r

--------except
--k�melerdeki fark i�lemi

--Soru: 2018 model �r�n� olan ancak 2019 model �r�n� olmayan markalar� d�nd�ren bir sorgu yaz�n�z.
select b.brand_id, brand_name
from product.product p, product.brand b
where p.brand_id = b.brand_id and model_year = 2018
except
select b.brand_id, brand_name
from product.product p, product.brand b
where p.brand_id = b.brand_id and model_year = 2019

--Soru: Yaln�zca 2019 y�l�nda sipari� edilen �r�nleri i�eren bir sorgu yaz�n (Sonu� di�er y�llarda sipari� edilen �r�nleri i�ermez)

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
--simple case expression da sadece e�itse anlam� kullan�l�r

/*
Soru: Order_Status s�tunundaki de�erlerin anlam� ile yeni bir s�tun olu�turun.
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
Soru: store_ids s�tunundaki de�erlerle tutarl� olmas� i�in ma�azalar�n adlar�yla yeni bir s�tun olu�turun
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
--case'in yan�na yazd�g�m�z column �sm� yok b�rden fazla column'da cal�sab�l�r


/*
Soru: Order_Status s�tunundaki de�erlerin anlam� ile yeni bir s�tun olu�turun.
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
Soru: Hangi e-posta servis sa�lay�c�s�n� ("Gmail", "Hotmail", "Yahoo" veya "Other") g�steren yeni bir s�tun olu�turun.
*/

select first_name, last_name, email,
case 
	when email like '%Gmail.com' then 'Gmail'
	when email like '%Hotmail.com' then 'Hotmail'
	when email like '%Yahoo.com' then 'Yahoo'
	else 'Other'
end as email_service_provider
from sale.customer
--simple ile yap�lmaz orda like operatorunu kullanamay�z

--Soru: �ki g�n sonra sevk edilen sipari�lerin say�s�n� g�nl�k olarak pivot tablo bi�iminde d�nd�ren bir sorgu yaz�n.

select
sum(case when DATENAME(dw, order_date) = 'sunday' then 1 else 0 end) as sunday,
sum(case when DATENAME(dw, order_date) = 'Monday' then 1 else 0 end) as Monday,
sum(case when DATENAME(dw, order_date) = 'tuesday' then 1 else 0 end) as tuesday,
sum(case when DATENAME(dw, order_date) = 'wednesday' then 1 else 0 end) as wednesday,
sum(case when DATENAME(dw, order_date) = 'friday' then 1 else 0 end) as friday,
sum(case when DATENAME(dw, order_date) = 'saturday' then 1 else 0 end) as saturday
from sale.orders
where DATEDIFF(day, order_date, shipped_date) > 2