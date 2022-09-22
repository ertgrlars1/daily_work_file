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

--LOWER and UPPER
SELECT LOWER ('CLARUSWAY'), UPPER ('clarusway')

--STRING_SPLIT(string, separator)
SELECT	value
FROM	STRING_SPLIT('Ezgi/Senem/Mustafa', '/')

--clarusway kelimesinin sadece ilk harfini b�y�lt�n.

select UPPER(LEFT('clarusway', 1)) + RIGHT('clarusway', LEN('clarusway')-1)

select replace('clarusway', LEFT('clarusway', 1), UPPER(LEFT('clarusway', 1)))

SELECT UPPER(LEFT('clarusway',1)) + LOWER (SUBSTRING('clarusway', 2, LEN('clarusway')))

--email sutununun ilk harfini buyuk yap�n
SELECT	*, UPPER(LEFT(email,1)) + LOWER (SUBSTRING(email, 2, LEN(email))) 
FROM	sale.store

--TRIM([characters FROM] string)

SELECT TRIM ('   CLARUSWAY   ')
--i�ine  tek bir stirng girilirse sag�nda ve solunda bulunan bo�luklar� kald�r�r.

SELECT TRIM ('?' FROM '?   CLARUSWAY   ?')
--sag�nda ve solundaki ? ifadesini kald�rd�

SELECT TRIM('?, *, ' FROM '?*    CLARUSWAY    *')
--ba�tan ve sondan soru i�aretini,  y�ld�z� ve bo�luklar� kald�r�r

--LTRIM(string) and RTRIM(string)
SELECT LTRIM ('  CLARUSWAY   ')
--solundaki bo�luklar� kald�rd�
SELECT RTRIM ('  CLARUSWAY   ')
--sag�ndaki bosluklar� kald�rd�

--REPLACE(string expression, string pattern, string replacement)
SELECT REPLACE('CLARUSWAY', 'C', 'A')
--C'yi A yapt�

SELECT REPLACE('CLAR USWAY', ' ', '')
--bo�lugu kald�rd�k

--STR(float expression [, length [, decimal]])
SELECT STR(1234.25, 7, 2)
--float bir ifadeyi 7 uzunlukta virg�lden sonraki k�sm� 2 b�r�m olacak �ekilde string olarak yazar

SELECT STR(1234.25, 7, 1)

--CAST ( expression AS data_type [ ( length ) ] )  
select cast(123.56 as varchar(6))
--varchara �evirdi
select cast(123.56 as int)
--int'e cevirdi
select cast(123.56 as numeric(4,1))
--4 karakter olsun, virg�lden sonra 1 karakter �eklinde yazs�n

--CONVERT ( data_type [ ( length ) ] , expression [ , style ] )
select convert(numeric(4,1), 123.56)
--4 karakter olsun, virg�lden sonra 1 karakter �eklinde yazs�n
select CONVERT(varchar, getdate(), 6)
--varchar olarak getdate'i 6 numaral� stil ile de�i�tir
select CONVERT(date,'19 Sep 22', 6)
-- 6 numaral� stil olan string'i(19 Sep 22) date fonksiyonuna donustur

--CAST VE CONVERT �rnekler
SELECT CONVERT(varchar, '2017-08-25', 101);
SELECT CAST('2017-08-25' AS varchar);
-- date format�ndaki bir veriyi char'a �evirdi.
SELECT CONVERT(datetime, '2017-08-25');
SELECT CAST('2017-08-25' AS datetime);
-- char format�ndaki bir veriyi datetime'a �evirdi.
SELECT CONVERT(int, 25.65);
SELECT CAST(25.65 AS int);
-- decimal bir veriyi, integer'a (tam say�ya) �evirdi.
SELECT CONVERT(DECIMAL(5,2), 12) AS decimal_value;
SELECT CAST(12 AS DECIMAL(5,2) ) AS decimal_value;
-- integer bir veriyi 5 rakamdan olu�an ve bunun virg�lden sonras� 2 rakam olan decimal'e �evirdi.
SELECT CONVERT(DECIMAL(7,2), ' 5800.79 ') AS decimal_value;
SELECT CAST(' 5800.79 ' AS DECIMAL (7,2)) AS decimal_value;
-- char (string) olan ama rakamdan olu�an veriyi decimal'e �evirdi.

--ROUND(numeric_expression , length [ ,function ])
select ROUND(123.56, 1)
--virg�lden sonraki ilk basamag� yukar� yuvarla
select ROUND(123.54, 1)

select ROUND(123.56, 1, 0)
--ikinci int default 0'd�r. anlam� virg�lden sonraki ikinci de�ere g�re yuvarla

select ROUND(123.54, 1, 1)
--ikinci 1, virg�lden sonraki ilk haneyi al di�erlerini yuvarlama anlam�ndad�r

--ROUND CE�L�NG �rnekler
--ROUND = say�y� istenilen haneye g�re yuvarlama.
--FLOOR = say�y� a�a��ya yuvarlama.
--CEILING = say�y� yukar�ya yuvarlama.

SELECT ROUND(12.4512,2)		 --say�y� virg�lden sonra 2 haneye yuvarlar.
SELECT FLOOR(12.4512) AS deger -- say�n�n virg�lden sonraki de�erini atarak 12 olarak yuvarlar.
SELECT CEILING(12.4512) AS deger -- say�n�n virg�lden sonraki hanesini yukar� yuvarlar ve 13 elde edilir.

--Desimal (Ondal�k) veri t�r� ve �e�itli uzunluk parametreleriyle yuvarlama:
DECLARE @value decimal(10,2)  -- de�i�ken deklare ettik.
SET @value = 11.05 -- de�i�kene de�er atad�k.
SELECT ROUND(@value, 1)  -- 11.10
SELECT ROUND(@value, -1) -- 10.00 
SELECT ROUND(@value, 2)  -- 11.05 
SELECT ROUND(@value, -2) -- 0.00 
SELECT ROUND(@value, 3)  -- 11.05
SELECT ROUND(@value, -3) -- 0.00
SELECT CEILING(@value)   -- 12 
SELECT FLOOR(@value)     -- 11 

--Numeric (say�sal) veri t�r� ile yuvarlama :
DECLARE @value numeric(10,10)
SET @value = .5432167890
SELECT ROUND(@value, 1)  -- 0.5000000000 
SELECT ROUND(@value, 2)  -- 0.5400000000
SELECT ROUND(@value, 3)  -- 0.5430000000
SELECT ROUND(@value, 4)  -- 0.5432000000
SELECT ROUND(@value, 5)  -- 0.5432200000
SELECT ROUND(@value, 6)  -- 0.5432170000
SELECT ROUND(@value, 7)  -- 0.5432168000
SELECT ROUND(@value, 8)  -- 0.5432167900
SELECT ROUND(@value, 9)  -- 0.5432167890
SELECT ROUND(@value, 10) -- 0.5432167890
SELECT CEILING(@value)   -- 1
SELECT FLOOR(@value)     -- 0

--Float veri t�r� ile yuvarlama fonksiyonlar�.
DECLARE @value float(10)
SET @value = .1234567890
SELECT ROUND(@value, 1)  -- 0.1
SELECT ROUND(@value, 2)  -- 0.12
SELECT ROUND(@value, 3)  -- 0.123
SELECT ROUND(@value, 4)  -- 0.1235
SELECT ROUND(@value, 5)  -- 0.12346
SELECT ROUND(@value, 6)  -- 0.123457
SELECT ROUND(@value, 7)  -- 0.1234568
SELECT ROUND(@value, 8)  -- 0.12345679
SELECT ROUND(@value, 9)  -- 0.123456791
SELECT ROUND(@value, 10) -- 0.123456791
SELECT CEILING(@value)   -- 1
SELECT FLOOR(@value)     -- 0

--Pozitif bir tamsay� yuvarlama (1 keskinlik de�eri i�in):
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, 1)  -- 6 - No rounding with no digits right of the decimal point
SELECT CEILING(@value)   -- 6 - Smallest integer value
SELECT FLOOR(@value)     -- 6 - Largest integer value 

--Kesinlik de�eri olarak bir negatif say�n�n etkilerini de g�relim:
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, -1) -- 10 - Rounding up with digits on the left of the decimal point
SELECT ROUND(@value, 2)  -- 6  - No rounding with no digits right of the decimal point 
SELECT ROUND(@value, -2) -- 0  - Insufficient number of digits
SELECT ROUND(@value, 3)  -- 6  - No rounding with no digits right of the decimal point
SELECT ROUND(@value, -3) -- 0  - Insufficient number of digits

--Bu �rnekteki rakamlar� geni�letelim ve ROUND fonksiyonu kullanarak etkilerini g�relim:
SELECT ROUND(444,  1) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -1) -- 440  - Rounding down
SELECT ROUND(444,  2) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -2) -- 400  - Rounding down
SELECT ROUND(444,  3) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -3) -- 0    - Insufficient number of digits
SELECT ROUND(444,  4) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -4) -- 0    - Insufficient number of digits

--Negatif bir tamsay� yuvarlayal�m ve etkilerini g�relim:
SELECT ROUND(-444, -1) -- -440  - Rounding down
SELECT ROUND(-444, -2) -- -400  - Rounding down
SELECT ROUND(-555, -1) -- -560  - Rounding up
SELECT ROUND(-555, -2) -- -600  - Rounding up
SELECT ROUND(-666, -1) -- -670  - Rounding up
SELECT ROUND(-666, -2) -- -700  - Rounding up

--ISNULL(check expression, replacement value)
--NULL'u belirtilen de�i�tirme de�eriyle de�i�tirir.

SELECT ISNULL(NULL, 0)
--null yerine yan�ndaki ifadeyi koy
SELECT ISNULL(1, 0)

select phone, ISNULL(phone, 0)
from sale.customer
--null yerine 0 degerini koyar

--COALESCE(expression [, ...n])
select coalesce(null, null, 2, null)
--null olmayan ilk degeri al�r

--NULLIF(expression, expression)
select nullif (0,0)
--ilk deger ikincisine e�it ise null yazar
select nullif(5,1)
--e�it de�il ise ilk karakteri yazd�r�r

select phone, isnull(phone, 0), nullif (ISNULL(phone, 0), '0')
from sale.customer
--e�it olanlar� null'e d�n��t�rd�k

--ISNUMERIC(expression)
--Bir ifadenin ge�erli bir say�sal t�r olup olmad���n� belirler.
select ISNUMERIC(1)
--numeric ise 1 yazar
select ISNUMERIC('1')
--numeric olarak kabul eder
select ISNUMERIC('1,4')
--numeric olarak kabul eder
select ISNUMERIC('al�11')
--numeric olmad�g� �c�n 0 yazar

--query, how many customers have yahoo mail ?
select count(email)
from sale.customer
where email like '%yahoo%'

select count(PATINDEX('%yahoo%', email))
from sale.customer
where PATINDEX('%yahoo%', email) > 0
--olmayanlara 0 getirir. where ile 0'dan buyuk olanlar� al�p count ile sayd�rd�k

--e-posta s�tununda '@' karakterinden �nceki karakterleri d�nd�ren bir sorgu yaz�n
SELECT LEFT(email, PATINDEX('%@%',email)-1)
FROM sale.customer

SELECT LEFT(email, CHARINDEX('@',email)-1)
FROM sale.customer

select SUBSTRING(email, 1, CHARINDEX('@',email)-1)
from sale.customer

--M��terilerin ileti�im bilgilerini i�eren m��teriler tablosuna yeni bir s�tun ekleyin.
--Telefon null de�ilse telefon bilgileri yazd�r�l�r, de�ilse e-posta bilgileri yazd�r�l�r.
SELECT phone, email, COALESCE(phone, email, 'no contact') contact 
FROM	sale.customer
ORDER BY 3

--street s�tununda soldan ���nc� karakterin rakam oldu�u kay�tlar� getiriniz.
select street, SUBSTRING(street, 3,1) AS third_char
from sale.customer
where ISNUMERIC(SUBSTRING(street, 3,1)) = 1