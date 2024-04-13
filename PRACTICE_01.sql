--EX1:
select NAME from CITY where COUNTRYCODE = 'USA' and POPULATION >120000;

--EX2:
select * from city where COUNTRYCODE = 'JPN';

--EX3:
select city, state from station where lat_n <>0 and long_w <>0;

--EX4:
SELECT CITY FROM STATION WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%') AND LAT_N <>0 and LONG_W <>0;

--EX 5:
SELECT DISTINCT(CITY) FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';

--EX6:
SELECT CITY FROM STATION WHERE NOT (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%');

--EX7:
SELECT NAME FROM EMPLOYEE ORDER BY NAME ASC;

--EX8:
SELECT NAME FROM EMPLOYEE WHERE SALARY >2000 AND MONTHS <10 ORDER BY EMPLOYEE_ID ASC;

--EX9:
SELECT product_id FROM Products WHERE low_fats ='Y' AND recyclable ='Y';

--EX10:
SELECT name FROM Customer WHERE referee_id <>2 OR referee_id IS NULL;

--EX11:
SELECT name, population, area FROM World WHERE  area >=3000000 OR population >=25000000;

--EX12:
SELECT DISTINCT author_id AS id FROM Views WHERE author_id = viewer_id ORDER BY author_id ASC;

--EX13:
SELECT part, assembly_step FROM parts_assembly WHERE finish_date IS NULL;

--EX14:
select * from lyft_drivers WHERE yearly_salary <=30000 OR yearly_salary >=70000;

--EX15:
select advertising_channel from uber_advertising WHERE year=2019 AND money_spent >100000;
