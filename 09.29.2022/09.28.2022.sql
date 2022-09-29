-------------------------------------window Functionlar

/*
Soru: Stok tablosundaki her bir ürünün toplam stok miktarýný gösteren bir sorgu yazýnýz.
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
--partititon by gruplamasý saglar
-- tabloyla herhangi bir iþlem yapmadýgý ýcýn tum sutunlar cagýrýlabýlýr
select distinct product_id, sum(quantity) over(partition by product_id) total_
from product.stock
order by 1
--group by yontemýne benzedi

--brandlara gore ortalama urun fýyatý  (Use both of Group by and WF)
select brand_id, avg(list_price) over (partition by brand_id) avg_
from product.product
-- tüm sutunlarý getýrýr

