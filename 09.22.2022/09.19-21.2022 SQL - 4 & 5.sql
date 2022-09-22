-- inner join

select  product.product.product_name,
		product.product.category_id,
		product.category.category_id,
		product.category.category_name
from product.product inner join product.category 
					  on product.product.category_id = product.category.category_id
order by product.product.category_id DESC

--k�saltal�m
select  pp.product_name,
		pp.category_id,
		pc.category_id,
		pc.category_name
from product.product as pp join product.category as pc
	 on pp.category_id = pc.category_id
order by pc.category_id DESC
--column �s�mler�ne as vererek k�saltab�l�r�z
--inner join yerine ya join yazab�l�r.
--�imdi daha da k�saltal�m

select  pp.product_name,
		pp.category_id,
		pc.category_id,
		pc.category_name
from product.product pp , product.category pc
where pp.category_id = pc.category_id
order by 2 DESC
--inner join yerine , kullan�lab�l�r�z bu sefer de where kullanmam�z gerek�r
--as kullanmadan yazab�l�r
--order by de column'�n s�ras�n� verebiliriz

--query, list employees of stores with their store information. select employee name, surname, store names
select ssta.*, ssto.store_name
from sale.staff ssta, sale.store ssto
where ssta.store_id = ssto.store_id


--left join
--ilk(soldaki) tablonun hepsi, ikinci(sagdak�) tablonun sadece kes�sen k�s�mlar�

--query, write a query, that returns products that hane never been ordered
--hi� sipari� edilmeyen �r�nleri d�nd�ren bir sorgu yaz�n
--select product ID, product name, order ID

select distinct p.product_id, product_name, oi.order_id, oi.product_id
from product.product p left join sale.order_item oi
on p.product_id = oi.product_id
where order_id IS NULL
order by p.product_id

--query, Report the stock status of the products that product id greater than 310 in the stores.
--Ma�azalarda 310'dan b�y�k �r�n kimli�ine sahip �r�nlerin stok durumunu bildirin.
-- Expected columns: product_id, product_name, store_id, product_id, quantity

select p.product_id, product_name, store_id, quantity
from product.product p left join product.stock s
on p.product_id = s.product_id
where p.product_id > 310

--right join
--ikinci(sagdaki) tablonun hepsi, ilk(soldaki) tablonun sadece kes�sen k�s�mlar�

--querry, Report (AGAIN WITH RIGHT JOIN) the stock status of the products that product id greater than 310 in the stores.
--Ma�azalarda 310'dan b�y�k �r�n kimli�ine sahip �r�nlerin stok durumunu raporlay�n (Y�NE SA� B�RLE��MLE).
--Expected columns: product_id, product_name, store_id, quantity

select p.product_id, product_name, store_id, quantity
from product.stock s  right join product.product p
on p.product_id = s.product_id
where p.product_id > 310

--querry Report the order information made by all staffs.
--T�m personel taraf�ndan yap�lan sipari� bilgilerini bildirin.
--Expected columns: staff_id, first_name, last_name, all the information about orders

select s.staff_id, first_name, last_name ,o.*
from sale.orders o right join  sale.staff s
on s.staff_id = o.staff_id

--full outer join
--ne var ne yok getirir

--Write a query that returns stock and order information together for all products . Return only top 100 rows.
--T�m �r�nler i�in stok ve sipari� bilgilerini birlikte d�nd�ren bir sorgu yaz�n. Yaln�zca en �stteki 100 sat�r� d�nd�r�r.
--Expected columns: Product_id, store_id, quantity, order_id, list_price

select distinct p.product_id, product_name, s.product_id, o.product_id
from product.product p full outer join product.stock s 
on p.product_id = s.product_id
full outer join sale.order_item o on p.product_id = o.product_id
order by s.product_id, o.product_id

--crosjoin
--bir tablodaki t�m kay�tlar� di�er tablodaki t�m kay�tlarla e�le�tirir. Kartezyen e�leme

/*quary, In the stocks table, there are not all products store on the product table and you want to insert these products into the stock table.
Stoklar tablosunda, �r�n tablosunda t�m �r�nler ma�azas� bulunmuyor ve bu �r�nleri stok tablosuna eklemek istiyorsunuz.
You have to insert all these products for every three stores with "One (zero)" quantity.
T�m bu �r�nleri her �� ma�aza i�in "Bir (s�f�r)" adet ile girmelisiniz.
Write a query to prepare this data.
Bu verileri haz�rlamak i�in bir sorgu yaz�n.*/

select distinct s.store_id, p.product_id, 0 as quantity
from product.stock s cross join product.product p
where p.product_id not in (select product_id from product.stock)


--self join
--tablonun kend�ne kat�lmas�

--Write a query that returns the staff names with their manager names.
--Personel adlar�n� y�netici adlar�yla d�nd�ren bir sorgu yaz�n.
--Expected columns: staff first name, staff last name, manager name

select s1.staff_id, s1.first_name, s1.last_name, s2.first_name manager_first_name, s2.last_name manager_last_name
from sale.staff s1 left join sale.staff s2
on s1.manager_id = s2.staff_id

--view

create view v_sample_summary AS
select c.customer_id, count(o.order_id) cnt_order
from sale.customer c, sale.orders o
where c.customer_id = o.customer_id and city = 'Charleston'
group by c.customer_id
--su an view olu�tu

select *
from v_sample_summary

select *
into #v_sample_sum2
from v_sample_summary
-- bas�na # koyarsak sadece gec�c olarak kullanacag�m�z� gosterir