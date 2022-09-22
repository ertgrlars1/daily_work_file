

---SQL Server Built-in Functions


--Date formats



CREATE TABLE t_date_time (
	A_time time, --saat:dakika:saniye:microsniye(6 basamak)
	A_date date, --yýl-ay-gun
	A_smalldatetime smalldatetime, --yýl-ay-gun saat:dakika:saniye
	A_datetime datetime,--yýl-ay-gun saat:dakika:saniye:microsniye(3 basamak)
	A_datetime2 datetime2,--yýl-ay-gun saat:dakika:saniye:microsniye(6 basamak)
	A_datetimeoffset datetimeoffset--yýl-ay-gun saat:dakika:saniye:microsniye(3 basamak) saat dilimi
	)

--listeyi oluþturduk içleri boþ


SELECT GETDATE() AS TIME

--su anýn zamanýný alýr

INSERT t_date_time 
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())


select * from t_date_time


INSERT t_date_time 
VALUES ('12:20:00', '2022-09-17','2022-09-17', '2022-09-17', '2022-09-17', '2022-09-17')


-------------////////////////


---

SELECT DATENAME (DW, GETDATE())
--su anki zamanýn(GETDATE) gün ismi(DW ile)

SELECT DATEPART (SECOND, GETDATE())
--su anki zamanýn(GETDATE) saniyesi(SECOND ile)

SELECT DATEPART (MONTH, GETDATE())
--su anki zamanýn(GETDATE) ayý int þeklinde(MONTH ile)

SELECT DAY (GETDATE())
--su anki zamanýn(GETDATE) gün ÝNT(DAY ile)

SELECT MONTH (GETDATE())
--su anki zamanýn(GETDATE) AY ÝNT(MONTH ile)

SELECT YEAR (GETDATE())
--su anki zamanýn(GETDATE) YIL ÝNT(YEAR ile)


---

SELECT DATEDIFF(SECOND, '2021-12-21', GETDATE())
--DATEDIFF ýký zamansal farký ýstedýgýmýz formatta return eder
--2021-12-21 ile su anki zaman arasýndaki saniye cinsinden gösterir

SELECT DATEDIFF(DAY, '2021-12-21', GETDATE())
--2021-12-21 ile su anki zamanla kaç gün geçmiþ

--SampleReatil'deki ORDER TABLOSUNDAKÝ ORDER DATE ÝLE SHIP DATE ARASINDAKÝ GÜN FARKINI BULUNUZ.


SELECT	*, DATEDIFF(DAY , order_date, shipped_date) AS shipped_day
FROM	sale.orders

--DATEADD(datepart,number,date)
--EOMONTH(start_date [,month_to_add])

SELECT DATEADD(DAY, 3 , '2022-09-17')
--DATEADD istediðimiz tarihin istediðimiz kýsmýna ekleme ve cýkarma yapmak ýcýn kullanýlýr
--2022-09-17'nin gün kýsmýna 3 ekledýk

SELECT DATEADD(DAY, -3 , '2022-09-17')
--2022-09-17'nin gün kýsmýna 3 cýkardýk

SELECT DATEADD(YEAR, -3 , '2022-09-17')



SELECT EOMONTH('2023-02-10')
--EOMONTH içinde bulunan ayýn son gununu yýll-ay-gun þeklinde verir

SELECT EOMONTH('2023-02-10', 2)
--2023-02-10 tarihinin ay kýsmýna 2 ekleyip on gununu yýll-ay-gun þeklinde verir

SELECT ISDATE('2022-09-17')
--girilen deðerin sistem tarafýndan ayarlanmýs date formatýna uygun olup olmadýgýný verir
-- Dogru ise 1 degilse 0 dondurur


SELECT ISDATE('20220917')

SELECT ISDATE('17-09-2022')


---sipariþ tarihinden iki gün sonra kargolanan sipariþleri döndüren bir sorgu yazýn


SELECT *, DATEDIFF(DAY , order_date, shipped_date) AS day_diff
FROM		sale.orders
WHERE		DATEDIFF(DAY , order_date, shipped_date) > 2
--where de day_diff kullnamayýz o tabloda sadece goruntu olarak vardýr





--LEN(input_string)
	--karakter uzunlugunu gosterir.sondaki Boþluklarý dahil etmez. Ýlk bosluklarý dahil eder.
	--aslýnda bize son karakterin indexini döndürür

SELECT LEN('Clarusway')

SELECT LEN('Clarusway  ')

SELECT LEN('  Clarusway')

SELECT LEN('  Clarusway  ')


--CHARINDEX(substring, string [, start location])
	-- girilem harfin veya kelimenin asýl string'te kacýncý indexte baslýyor onu gosterir
	--start location ile kactan baslamasý gerektýgýný soyleyebýlýrýz

SELECT CHARINDEX('C', 'Clarusway')

SELECT CHARINDEX('c', 'Clarusway')
--buyuk kucuk harf farketmez

SELECT CHARINDEX('a', 'Clarusway')

SELECT CHARINDEX('a', 'Clarusway', 4)

--PATINDEX(%pattern%, input string)
	--pattern aramak ýcýn

SELECT PATINDEX('sw', 'Clarusway')
--% kullanmadýgýmýz ýcýn 0 dondurur

SELECT PATINDEX('%sw%', 'Clarusway')
SELECT CHARINDEX('sw', 'Clarusway')
--ikiside ayný sonucu dondurur

SELECT PATINDEX('%sw', 'Clarusway')
--0 dondurur

SELECT PATINDEX('%r_sw%', 'Clarusway')


SELECT PATINDEX('___r_sw%', 'Clarusway')


--LEFT(string, number of characters)
	--string içerisinden belirli karakterleri soldan almak için(int)
SELECT LEFT('Clarusway',3)

--RIGHT(string, number of characters)
	--string içerisinden belirli karakterleri sagdan almak için(int)
SELECT RIGHT('Clarusway',3)


--SUBSTRING(string, start_postion, [length])
SELECT SUBSTRING ('Clarusway', 3,2)
--3.karakterden baþla 2 karakter al(3 ve 4)

SELECT SUBSTRING ('Clarusway', 0,2)
--0.karakterden basla 2 karakter al(0 ve 1'i alacak ama 0 yok)

SELECT SUBSTRING ('Clarusway', -1,2)
-- -1'inci karakterden basla 2 tane al (-1 ve 0)
-- -1 son karakter deðildir

SELECT SUBSTRING ('Clarusway', -1,3)
-- -1'inci karakterden basla 3 tane al (-1, 0 ve 1.karakterler)
