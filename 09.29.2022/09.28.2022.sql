-------------------------------------window Functionlar

/*
Soru: Stok tablosundaki her bir �r�n�n toplam stok miktar�n� g�steren bir sorgu yaz�n�z.
(Use both of Group by and WF)
*/

--group by
select product_id, sum(quantity) total_
from product.stock
group by product_id
order by 1

--windows function
select *, sum(quantity) over(partition by product_id) total_
from product.stock
order by 2
--partititon by gruplamas� saglar
-- tabloyla herhangi bir i�lem yapmad�g� �c�n tum sutunlar cag�r�lab�l�r
select distinct product_id, sum(quantity) over(partition by product_id) total_
from product.stock
order by 1
--group by yontem�ne benzedi

--brandlara gore ortalama urun f�yat�  (Use both of Group by and WF)
select brand_id, avg(list_price) over (partition by brand_id) avg_
from product.product
-- t�m sutunlar� get�r�r

