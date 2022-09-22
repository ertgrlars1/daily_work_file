---- C-12 WEEKLY AGENDA-7 RD&SQL STUDENT

---- 1. Teksas'taki tüm þehirleri ve her þehirdeki müþteri sayýsýný listeleyin
---- 1. List all the cities in the Texas and the numbers of customers in each city.
select city, COUNT(*) as count
from sale.customer
where state = 'TX'
GROUP BY city

---- 2. Kaliforniya'da 5'ten fazla müþterisi olan tüm þehirleri önce en fazla müþterisi olan þehirleri göstererek listeleyiniz.
---- 2. List all the cities in the California which has more than 5 customer, by showing the cities which have more customers first.
select city, COUNT(*) as count
from sale.customer
where state = 'CA'
GROUP BY city
having COUNT(*) > 5
ORDER BY count DESC

---- 3. En pahalý 10 ürünü listeleyin
---- 3. List the top 10 most expensive products
select TOP(10) product_name, list_price
from product.product
ORDER BY 2 DESC

---- 4.store_id, product name ve list price ve store_id = 2 de bulunan ve miktarlarý 25'den fazla olan ürünlerin miktarlarý
---- 4. List store_id, product name and list price and the quantity of the products which are located in the store id 2 and the quantity is greater than 25
select store_id, product_name, list_price, quantity
from product.product pp, product.stock ps
WHERE pp.product_id = ps.product_id and store_id = 2 and quantity > 25
ORDER BY quantity DESC

---- 5.Boulder'da yaþayan müþterilerin satýþ sipariþini order date'e göre bulun
---- 5. Find the sales order of the customers who lives in Boulder order by order date
select c.customer_id,city, first_name, last_name, order_date
from sale.customer c, sale.orders o
where c.customer_id = o.customer_id and c.city = 'Boulder'
Order by o.order_date DESC

---- 6. AVG () function'ý kullanarak sales'larý staff ve years göre alýn.
---- 6. Get the sales by staffs and years using the AVG() aggregate function.
select ss.first_name, ss.last_name, year(so.order_date) year, avg(soi.quantity * soi.list_price *(1-soi.discount)) sales
from sale.staff ss, sale.orders so, sale.order_item soi
where ss.staff_id = so.staff_id and so.order_id = soi.order_id
group by ss.first_name, ss.last_name, year(so.order_date)

---- 7. Markalara göre ürünün satýþ miktarý nedir ve bunlarý en yüksek-en düþük olarak sýralayýnýz.
---- 7. What is the sales quantity of product according to the brands and sort them highest-lowest
select pb.brand_name, product_name, SUM(so.quantity) as SUM
from product.brand pb, product.product pp, sale.order_item so
where pp.brand_id = pb.brand_id and pp.product_id = so.product_id
group by pb.brand_name, product_name
order by sum DESC

---- 8. Her markanýn sahip olduðu kategoriler nelerdir?
---- 8. What are the categories that each brand has?
select DISTINCT pb.brand_name, pc.category_name
from product.brand pb, product.product pp, product.category pc
where pp.brand_id = pb.brand_id and pp.category_id = pc.category_id

---- 9. Markalara ve kategorilere göre ortalama fiyatlarý seçin
---- 9. Select the avg prices according to brands and categories
select pb.brand_name,pc.category_name, AVG(pp.list_price) AS AVG
from product.brand pb, product.product pp, product.category pc
where pp.brand_id = pb.brand_id and pp.category_id = pc.category_id
group by pb.brand_name, pc.category_name

---- 10. Markalara göre yýllýk üretilen ürün miktarýný seçin
---- 10. Select the annual amount of product produced according to brands
select pb.brand_name, pp.model_year, sum(soi.quantity * soi.list_price *(1-soi.discount)) as sum
from product.brand pb, product.product pp, sale.order_item soi
where pp.brand_id = pb.brand_id and pp.product_id = soi.product_id
group by pp.model_year, pb.brand_name 

---- 11. 2018 yýlýnda en çok satýþ yapan maðazayý seçin
---- 11. Select the store which has the most sales quantity in 2018
select TOP(1) ss.store_name, sum(soi.quantity) as sum
from sale.store ss, sale.orders so, sale.order_item soi
where ss.store_id = so.store_id and so.order_id = soi.order_id and year(so.order_date) = 2018
group by ss.store_name
order by sum DESC
---- 12 2019'de en fazla satýþ tutarýna sahip maðazayý seçin.
---- 12 Select the store which has the most sales amount in 2019
select TOP(1) ss.store_name, sum(soi.quantity * soi.list_price *(1-soi.discount)) as sum
from sale.store ss, sale.orders so, sale.order_item soi, product.product pp
where ss.store_id = so.store_id and so.order_id = soi.order_id and pp.product_id = soi.product_id and year(so.order_date) = 2019
group by ss.store_name
order by sum DESC

---- 13. 2020 yýlýnda en çok satýþ yapan personeli seçin
---- 13. Select the personnel which has the most sales amount in 2020.
select top(1) ss.first_name, ss.last_name, sum(soi.quantity * soi.list_price *(1-soi.discount)) as sum
from sale.staff ss, sale.orders so, sale.order_item soi
where ss.staff_id = so.staff_id and so.order_id = soi.order_id and year(so.order_date) = 2020
group by ss.first_name, ss.last_name
order by sum DESC