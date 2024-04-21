--EX1:
SELECT t2.Continent,
floor(avg(t1.Population))
FROM CITY AS t1 INNER JOIN COUNTRY AS t2
ON t1.CountryCode=t2.Code
group by t2.Continent
--EX2:
SELECT 
ROUND(CAST(COUNT(texts.email_id) AS DECIMAL)
/COUNT(DISTINCT emails.email_id),2) AS activation_rate
FROM emails
LEFT JOIN texts
ON emails.email_id = texts.email_id
AND texts.signup_action = 'Confirmed';
--EX3:
SELECT t2.age_bucket,
round(100*(sum(case when t1.activity_type = 'send' then t1.time_spent else 0 end)/ sum(t1.time_spent)), 2) as send_perc,
round(100*(sum(case when t1.activity_type = 'open' then t1.time_spent else 0 end) / sum(t1.time_spent)), 2) as open_perc
FROM activities AS t1 JOIN age_breakdown AS t2
ON t1.user_id=t2.user_id
WHERE t1.activity_type IN ('send', 'open') 
GROUP BY t2.age_bucket
--EX4:
SELECT customer_id
FROM customer_contracts AS t1
LEFT JOIN products AS t2
ON t1.product_id = t2.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category) = (SELECT COUNT(DISTINCT product_category) FROM products)
ORDER BY customer_id;
--EX5:
select 
t1.reports_to as employee_id,
t2.name,
count(t1.reports_to) as reports_count,
round(avg(t1.age),0) as average_age
from employees as t1
join employees as t2
on t1.reports_to=t2.employee_id
group by t1.reports_to
order by t1.reports_to
--EX6:
select
t1.product_name,
sum(t2.unit) as unit
from Products as t1
join Orders as t2
on t1.product_id=t2.product_id
where t2.order_date between '2020-02-01' and '2020-02-29'
group by t1.product_name
having sum(t2.unit)>=100 
--EX7:
SELECT t1.page_id 
FROM pages AS t1
left join page_likes AS t2
on t1.page_id = t2.page_id 
where t2.liked_date is null
order by t1.page_id;
