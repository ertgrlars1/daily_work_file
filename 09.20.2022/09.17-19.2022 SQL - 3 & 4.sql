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

--LOWER and UPPER
SELECT LOWER ('CLARUSWAY'), UPPER ('clarusway')

--STRING_SPLIT(string, separator)
SELECT	value
FROM	STRING_SPLIT('Ezgi/Senem/Mustafa', '/')

--clarusway kelimesinin sadece ilk harfini büyültün.

select UPPER(LEFT('clarusway', 1)) + RIGHT('clarusway', LEN('clarusway')-1)

select replace('clarusway', LEFT('clarusway', 1), UPPER(LEFT('clarusway', 1)))

SELECT UPPER(LEFT('clarusway',1)) + LOWER (SUBSTRING('clarusway', 2, LEN('clarusway')))

--email sutununun ilk harfini buyuk yapýn
SELECT	*, UPPER(LEFT(email,1)) + LOWER (SUBSTRING(email, 2, LEN(email))) 
FROM	sale.store

--TRIM([characters FROM] string)

SELECT TRIM ('   CLARUSWAY   ')
--içine  tek bir stirng girilirse sagýnda ve solunda bulunan boþluklarý kaldýrýr.

SELECT TRIM ('?' FROM '?   CLARUSWAY   ?')
--sagýnda ve solundaki ? ifadesini kaldýrdý

SELECT TRIM('?, *, ' FROM '?*    CLARUSWAY    *')
--baþtan ve sondan soru iþaretini,  yýldýzý ve boþluklarý kaldýrýr

--LTRIM(string) and RTRIM(string)
SELECT LTRIM ('  CLARUSWAY   ')
--solundaki boþluklarý kaldýrdý
SELECT RTRIM ('  CLARUSWAY   ')
--sagýndaki bosluklarý kaldýrdý

--REPLACE(string expression, string pattern, string replacement)
SELECT REPLACE('CLARUSWAY', 'C', 'A')
--C'yi A yaptý

SELECT REPLACE('CLAR USWAY', ' ', '')
--boþlugu kaldýrdýk

--STR(float expression [, length [, decimal]])
SELECT STR(1234.25, 7, 2)
--float bir ifadeyi 7 uzunlukta virgülden sonraki kýsmý 2 býrým olacak þekilde string olarak yazar

SELECT STR(1234.25, 7, 1)

--CAST ( expression AS data_type [ ( length ) ] )  
select cast(123.56 as varchar(6))
--varchara çevirdi
select cast(123.56 as int)
--int'e cevirdi
select cast(123.56 as numeric(4,1))
--4 karakter olsun, virgülden sonra 1 karakter þeklinde yazsýn

--CONVERT ( data_type [ ( length ) ] , expression [ , style ] )
select convert(numeric(4,1), 123.56)
--4 karakter olsun, virgülden sonra 1 karakter þeklinde yazsýn
select CONVERT(varchar, getdate(), 6)
--varchar olarak getdate'i 6 numaralý stil ile deðiþtir
select CONVERT(date,'19 Sep 22', 6)
-- 6 numaralý stil olan string'i(19 Sep 22) date fonksiyonuna donustur

--CAST VE CONVERT Örnekler
SELECT CONVERT(varchar, '2017-08-25', 101);
SELECT CAST('2017-08-25' AS varchar);
-- date formatýndaki bir veriyi char'a çevirdi.
SELECT CONVERT(datetime, '2017-08-25');
SELECT CAST('2017-08-25' AS datetime);
-- char formatýndaki bir veriyi datetime'a çevirdi.
SELECT CONVERT(int, 25.65);
SELECT CAST(25.65 AS int);
-- decimal bir veriyi, integer'a (tam sayýya) çevirdi.
SELECT CONVERT(DECIMAL(5,2), 12) AS decimal_value;
SELECT CAST(12 AS DECIMAL(5,2) ) AS decimal_value;
-- integer bir veriyi 5 rakamdan oluþan ve bunun virgülden sonrasý 2 rakam olan decimal'e çevirdi.
SELECT CONVERT(DECIMAL(7,2), ' 5800.79 ') AS decimal_value;
SELECT CAST(' 5800.79 ' AS DECIMAL (7,2)) AS decimal_value;
-- char (string) olan ama rakamdan oluþan veriyi decimal'e çevirdi.

--ROUND(numeric_expression , length [ ,function ])
select ROUND(123.56, 1)
--virgülden sonraki ilk basamagý yukarý yuvarla
select ROUND(123.54, 1)

select ROUND(123.56, 1, 0)
--ikinci int default 0'dýr. anlamý virgülden sonraki ikinci deðere göre yuvarla

select ROUND(123.54, 1, 1)
--ikinci 1, virgülden sonraki ilk haneyi al diðerlerini yuvarlama anlamýndadýr

--ROUND CEÝLÝNG Örnekler
--ROUND = sayýyý istenilen haneye göre yuvarlama.
--FLOOR = sayýyý aþaðýya yuvarlama.
--CEILING = sayýyý yukarýya yuvarlama.

SELECT ROUND(12.4512,2)		 --sayýyý virgülden sonra 2 haneye yuvarlar.
SELECT FLOOR(12.4512) AS deger -- sayýnýn virgülden sonraki deðerini atarak 12 olarak yuvarlar.
SELECT CEILING(12.4512) AS deger -- sayýnýn virgülden sonraki hanesini yukarý yuvarlar ve 13 elde edilir.

--Desimal (Ondalýk) veri türü ve çeþitli uzunluk parametreleriyle yuvarlama:
DECLARE @value decimal(10,2)  -- deðiþken deklare ettik.
SET @value = 11.05 -- deðiþkene deðer atadýk.
SELECT ROUND(@value, 1)  -- 11.10
SELECT ROUND(@value, -1) -- 10.00 
SELECT ROUND(@value, 2)  -- 11.05 
SELECT ROUND(@value, -2) -- 0.00 
SELECT ROUND(@value, 3)  -- 11.05
SELECT ROUND(@value, -3) -- 0.00
SELECT CEILING(@value)   -- 12 
SELECT FLOOR(@value)     -- 11 

--Numeric (sayýsal) veri türü ile yuvarlama :
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

--Float veri türü ile yuvarlama fonksiyonlarý.
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

--Pozitif bir tamsayý yuvarlama (1 keskinlik deðeri için):
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, 1)  -- 6 - No rounding with no digits right of the decimal point
SELECT CEILING(@value)   -- 6 - Smallest integer value
SELECT FLOOR(@value)     -- 6 - Largest integer value 

--Kesinlik deðeri olarak bir negatif sayýnýn etkilerini de görelim:
DECLARE @value int
SET @value = 6
SELECT ROUND(@value, -1) -- 10 - Rounding up with digits on the left of the decimal point
SELECT ROUND(@value, 2)  -- 6  - No rounding with no digits right of the decimal point 
SELECT ROUND(@value, -2) -- 0  - Insufficient number of digits
SELECT ROUND(@value, 3)  -- 6  - No rounding with no digits right of the decimal point
SELECT ROUND(@value, -3) -- 0  - Insufficient number of digits

--Bu örnekteki rakamlarý geniþletelim ve ROUND fonksiyonu kullanarak etkilerini görelim:
SELECT ROUND(444,  1) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -1) -- 440  - Rounding down
SELECT ROUND(444,  2) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -2) -- 400  - Rounding down
SELECT ROUND(444,  3) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -3) -- 0    - Insufficient number of digits
SELECT ROUND(444,  4) -- 444  - No rounding with no digits right of the decimal point
SELECT ROUND(444, -4) -- 0    - Insufficient number of digits

--Negatif bir tamsayý yuvarlayalým ve etkilerini görelim:
SELECT ROUND(-444, -1) -- -440  - Rounding down
SELECT ROUND(-444, -2) -- -400  - Rounding down
SELECT ROUND(-555, -1) -- -560  - Rounding up
SELECT ROUND(-555, -2) -- -600  - Rounding up
SELECT ROUND(-666, -1) -- -670  - Rounding up
SELECT ROUND(-666, -2) -- -700  - Rounding up

--ISNULL(check expression, replacement value)
--NULL'u belirtilen deðiþtirme deðeriyle deðiþtirir.

SELECT ISNULL(NULL, 0)
--null yerine yanýndaki ifadeyi koy
SELECT ISNULL(1, 0)

select phone, ISNULL(phone, 0)
from sale.customer
--null yerine 0 degerini koyar

--COALESCE(expression [, ...n])
select coalesce(null, null, 2, null)
--null olmayan ilk degeri alýr

--NULLIF(expression, expression)
select nullif (0,0)
--ilk deger ikincisine eþit ise null yazar
select nullif(5,1)
--eþit deðil ise ilk karakteri yazdýrýr

select phone, isnull(phone, 0), nullif (ISNULL(phone, 0), '0')
from sale.customer
--eþit olanlarý null'e dönüþtürdük

--ISNUMERIC(expression)
--Bir ifadenin geçerli bir sayýsal tür olup olmadýðýný belirler.
select ISNUMERIC(1)
--numeric ise 1 yazar
select ISNUMERIC('1')
--numeric olarak kabul eder
select ISNUMERIC('1,4')
--numeric olarak kabul eder
select ISNUMERIC('alþ11')
--numeric olmadýgý ýcýn 0 yazar

--query, how many customers have yahoo mail ?
select count(email)
from sale.customer
where email like '%yahoo%'

select count(PATINDEX('%yahoo%', email))
from sale.customer
where PATINDEX('%yahoo%', email) > 0
--olmayanlara 0 getirir. where ile 0'dan buyuk olanlarý alýp count ile saydýrdýk

--e-posta sütununda '@' karakterinden önceki karakterleri döndüren bir sorgu yazýn
SELECT LEFT(email, PATINDEX('%@%',email)-1)
FROM sale.customer

SELECT LEFT(email, CHARINDEX('@',email)-1)
FROM sale.customer

select SUBSTRING(email, 1, CHARINDEX('@',email)-1)
from sale.customer

--Müþterilerin iletiþim bilgilerini içeren müþteriler tablosuna yeni bir sütun ekleyin.
--Telefon null deðilse telefon bilgileri yazdýrýlýr, deðilse e-posta bilgileri yazdýrýlýr.
SELECT phone, email, COALESCE(phone, email, 'no contact') contact 
FROM	sale.customer
ORDER BY 3

--street sütununda soldan üçüncü karakterin rakam olduðu kayýtlarý getiriniz.
select street, SUBSTRING(street, 3,1) AS third_char
from sale.customer
where ISNUMERIC(SUBSTRING(street, 3,1)) = 1