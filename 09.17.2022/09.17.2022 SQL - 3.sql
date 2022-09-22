

---SQL Server Built-in Functions


--Date formats



CREATE TABLE t_date_time (
	A_time time, --saat:dakika:saniye:microsniye(6 basamak)
	A_date date, --y�l-ay-gun
	A_smalldatetime smalldatetime, --y�l-ay-gun saat:dakika:saniye
	A_datetime datetime,--y�l-ay-gun saat:dakika:saniye:microsniye(3 basamak)
	A_datetime2 datetime2,--y�l-ay-gun saat:dakika:saniye:microsniye(6 basamak)
	A_datetimeoffset datetimeoffset--y�l-ay-gun saat:dakika:saniye:microsniye(3 basamak) saat dilimi
	)

--listeyi olu�turduk i�leri bo�


SELECT GETDATE() AS TIME

--su an�n zaman�n� al�r

INSERT t_date_time 
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())


select * from t_date_time


INSERT t_date_time 
VALUES ('12:20:00', '2022-09-17','2022-09-17', '2022-09-17', '2022-09-17', '2022-09-17')


-------------////////////////


---

SELECT DATENAME (DW, GETDATE())
--su anki zaman�n(GETDATE) g�n ismi(DW ile)

SELECT DATEPART (SECOND, GETDATE())
--su anki zaman�n(GETDATE) saniyesi(SECOND ile)

SELECT DATEPART (MONTH, GETDATE())
--su anki zaman�n(GETDATE) ay� int �eklinde(MONTH ile)

SELECT DAY (GETDATE())
--su anki zaman�n(GETDATE) g�n �NT(DAY ile)

SELECT MONTH (GETDATE())
--su anki zaman�n(GETDATE) AY �NT(MONTH ile)

SELECT YEAR (GETDATE())
--su anki zaman�n(GETDATE) YIL �NT(YEAR ile)


---

SELECT DATEDIFF(SECOND, '2021-12-21', GETDATE())
--DATEDIFF �k� zamansal fark� �sted�g�m�z formatta return eder
--2021-12-21 ile su anki zaman aras�ndaki saniye cinsinden g�sterir

SELECT DATEDIFF(DAY, '2021-12-21', GETDATE())
--2021-12-21 ile su anki zamanla ka� g�n ge�mi�

--SampleReatil'deki ORDER TABLOSUNDAK� ORDER DATE �LE SHIP DATE ARASINDAK� G�N FARKINI BULUNUZ.


SELECT	*, DATEDIFF(DAY , order_date, shipped_date) AS shipped_day
FROM	sale.orders

--DATEADD(datepart,number,date)
--EOMONTH(start_date [,month_to_add])

SELECT DATEADD(DAY, 3 , '2022-09-17')
--DATEADD istedi�imiz tarihin istedi�imiz k�sm�na ekleme ve c�karma yapmak �c�n kullan�l�r
--2022-09-17'nin g�n k�sm�na 3 ekled�k

SELECT DATEADD(DAY, -3 , '2022-09-17')
--2022-09-17'nin g�n k�sm�na 3 c�kard�k

SELECT DATEADD(YEAR, -3 , '2022-09-17')



SELECT EOMONTH('2023-02-10')
--EOMONTH i�inde bulunan ay�n son gununu y�ll-ay-gun �eklinde verir

SELECT EOMONTH('2023-02-10', 2)
--2023-02-10 tarihinin ay k�sm�na 2 ekleyip on gununu y�ll-ay-gun �eklinde verir

SELECT ISDATE('2022-09-17')
--girilen de�erin sistem taraf�ndan ayarlanm�s date format�na uygun olup olmad�g�n� verir
-- Dogru ise 1 degilse 0 dondurur


SELECT ISDATE('20220917')

SELECT ISDATE('17-09-2022')


---sipari� tarihinden iki g�n sonra kargolanan sipari�leri d�nd�ren bir sorgu yaz�n


SELECT *, DATEDIFF(DAY , order_date, shipped_date) AS day_diff
FROM		sale.orders
WHERE		DATEDIFF(DAY , order_date, shipped_date) > 2
--where de day_diff kullnamay�z o tabloda sadece goruntu olarak vard�r





--LEN(input_string)
	--karakter uzunlugunu gosterir.sondaki Bo�luklar� dahil etmez. �lk bosluklar� dahil eder.
	--asl�nda bize son karakterin indexini d�nd�r�r

SELECT LEN('Clarusway')

SELECT LEN('Clarusway  ')

SELECT LEN('  Clarusway')

SELECT LEN('  Clarusway  ')


--CHARINDEX(substring, string [, start location])
	-- girilem harfin veya kelimenin as�l string'te kac�nc� indexte basl�yor onu gosterir
	--start location ile kactan baslamas� gerekt�g�n� soyleyeb�l�r�z

SELECT CHARINDEX('C', 'Clarusway')

SELECT CHARINDEX('c', 'Clarusway')
--buyuk kucuk harf farketmez

SELECT CHARINDEX('a', 'Clarusway')

SELECT CHARINDEX('a', 'Clarusway', 4)

--PATINDEX(%pattern%, input string)
	--pattern aramak �c�n

SELECT PATINDEX('sw', 'Clarusway')
--% kullanmad�g�m�z �c�n 0 dondurur

SELECT PATINDEX('%sw%', 'Clarusway')
SELECT CHARINDEX('sw', 'Clarusway')
--ikiside ayn� sonucu dondurur

SELECT PATINDEX('%sw', 'Clarusway')
--0 dondurur

SELECT PATINDEX('%r_sw%', 'Clarusway')


SELECT PATINDEX('___r_sw%', 'Clarusway')


--LEFT(string, number of characters)
	--string i�erisinden belirli karakterleri soldan almak i�in(int)
SELECT LEFT('Clarusway',3)

--RIGHT(string, number of characters)
	--string i�erisinden belirli karakterleri sagdan almak i�in(int)
SELECT RIGHT('Clarusway',3)


--SUBSTRING(string, start_postion, [length])
SELECT SUBSTRING ('Clarusway', 3,2)
--3.karakterden ba�la 2 karakter al(3 ve 4)

SELECT SUBSTRING ('Clarusway', 0,2)
--0.karakterden basla 2 karakter al(0 ve 1'i alacak ama 0 yok)

SELECT SUBSTRING ('Clarusway', -1,2)
-- -1'inci karakterden basla 2 tane al (-1 ve 0)
-- -1 son karakter de�ildir

SELECT SUBSTRING ('Clarusway', -1,3)
-- -1'inci karakterden basla 3 tane al (-1, 0 ve 1.karakterler)
