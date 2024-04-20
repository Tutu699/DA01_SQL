--EX1:
SELECT 
sum(case when device_type ='laptop' then 1 else 0 end) as laptop_views,
sum(case when device_type in ('tablet','phone') then 1 else 0 end) as mobile_views
FROM viewership;
--EX2:
select x,y,z,
case 
when x+y>z and y+z>x and x+z>y then 'Yes' else 'No'
end as triangle
from Triangle
--EX3:
select round(sum(case when call_category is NULL or call_category = 'n/a' then 1 else 0 end)/count(*),1) 
as call_percentage
from callers; 
--EX4:
SELECT name FROM Customer 
WHERE referee_id <>2 OR referee_id IS NULL;
--EX5:
select survived,
sum(case when pclass=1 then 1 else 0 end) as first_class,
sum(case when pclass=2 then 1 else 0 end) as second_classs,
sum(case when pclass=3 then 1 else 0 end) as third_class
from titanic
group by survived
