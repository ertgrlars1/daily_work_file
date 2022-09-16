SELECT GETDATE() AS now;

SELECT DATENAME(WEEKDAY, '2021-11-11') AS sample;

SELECT DATEPART(MINUTE, GETDATE()) AS sample;

SELECT DAY('2021-11-19') AS sample;

SELECT MONTH('2021-11-19') AS sample;

SELECT YEAR('2021-11-19') AS sample;

SELECT DATEDIFF(week, '2021-01-01', '2021-02-12') AS DateDifference

SELECT DATEADD (SECOND, 1, '2021-12-31 23:59:59') AS NewDate

SELECT EOMONTH('2021-02-10') AS EndofFeb


SET DATEFORMAT DMY


SELECT ISDATE('2021-02-10') AS isdate_

SELECT ISDATE('32/2020/04') AS isdate_

SELECT LEN('this is an example') AS sample

SELECT LEN(NULL) AS col1, LEN(10) AS col2, LEN(10.5) AS col3

SELECT CHARINDEX('yourself', 'Reinvent yourself') AS start_position;

SELECT CHARINDEX('r', 'Reinvent yourself') AS motto;

SELECT CHARINDEX('self', 'Reinvent yourself and ourself') AS motto;

SELECT CHARINDEX('self', 'Reinvent yourself and ourself', 15) AS motto;

SELECT PATINDEX('%ern%', 'this is not a pattern') AS sample

SELECT PATINDEX('%ern', 'this is not a pattern') AS sample

SELECT UPPER('clarusway') AS col;

SELECT LOWER('CLARUSWAY') AS col;

SELECT value from string_split('John,is,a,very,tall,boy.', ',')

SELECT SUBSTRING('Clarusway', 1, 3) AS substr

SELECT SUBSTRING('Clarusway', -7, 9) AS substr

SELECT SUBSTRING('Clarusway', -6, 2) AS substr

SELECT LEFT('Clarusway', 2) AS leftchars

SELECT RIGHT('Clarusway', 2) AS rightchars

SELECT TRIM('  Reinvent Yourself  ') AS new_string;

SELECT TRIM('@' FROM '@@@clarusway@@@@') AS new_string;

SELECT TRIM('ca' FROM 'cadillac') AS new_string;

SELECT LTRIM('   cadillac') AS new_string;

SELECT RTRIM('   cadillac   ') AS new_string;

SELECT REPLACE('REIMVEMT','M','N');

SELECT REPLACE('I do it my way.','do','did') AS song_name;

SELECT STR(123.45, 6, 1) AS num_to_str;

SELECT STR(123.45, 2, 2) AS num_to_str;

SELECT FLOOR (123.45)

SELECT STR(FLOOR (123.45), 8, 3) AS num_to_str;

SELECT 'Reinvent' + ' yourself' AS concat_string;

SELECT CONCAT('Reinvent' , ' yourself') AS concat_string;

SELECT 'Way' + ' to ' + 'Reinvent ' + 'Yourself' AS motto;

SELECT CONCAT ('Robert' , ' ', 'Gilmore') AS full_name 

SELECT 'customer' + '_' + CAST(1 AS VARCHAR(1)) AS col

SELECT CAST(4599.999999 AS numeric(5,1)) AS col

SELECT ROUND(565.49, -1) AS col;

SELECT ROUND(565.49, -2) AS col;

SELECT ROUND(123.9994, 3) AS col1, ROUND(123.9995, 3) AS col2;

SELECT ROUND(150.75, 0) AS col1, ROUND(150.75, 0, 1) AS col2;

SELECT ISNULL(NULL, 'Not null yet.') AS col;

SELECT ISNULL(1, 2) AS col;

SELECT COALESCE(NULL, NULL, 'third_value', 'fourth_value');

SELECT COALESCE(Null, Null, 1, 3) AS col

SELECT COALESCE(Null, Null, 'William', Null) AS col

SELECT NULLIF(4,4) AS Same, NULLIF(5,7) AS Different;

SELECT NULLIF(1, 3) AS col

SELECT NULLIF('2021-01-01', '2021-01-01') AS col

SELECT ISNUMERIC ('William') AS col

SELECT ISNUMERIC (123.455) AS col



