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
