--EX1:
WITH jobcount_cte AS (
SELECT company_id, title, description, 
COUNT(job_id) AS jobcount
FROM job_listings
GROUP BY company_id, title, description)
SELECT 
COUNT(company_id) AS duplicate_companies
FROM jobcount_cte
WHERE jobcount>1;
--EX2:
SELECT category, product, 
SUM(spend) AS total_spend 
FROM product_spend 
WHERE EXTRACT(year FROM transaction_date) = 2022
GROUP BY category, product
ORDER BY total_spend DESC
LIMIT 4;
--EX3:
SELECT COUNT(CALL) AS policy_holder_count
FROM
(SELECT policy_holder_id,
COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >=3) AS CALL; 
--EX4:
SELECT t1.page_id 
FROM pages AS t1
left join page_likes AS t2
on t1.page_id = t2.page_id 
where t2.liked_date is null
order by t1.page_id;
--EX5:
with users as 
(SELECT user_id, 
min(event_date) as min_date, 
max(event_date) as max_date
FROM user_actions 
where event_date BETWEEN '06/01/2022' and '07/31/2022'
group by user_id), 
active_users as 
(select 
EXTRACT(MONTH from max_date) as Month,
user_id
from users
where EXTRACT(MONTH from min_date)!= EXTRACT(MONTH from max_date)
GROUP BY user_id,max_date)
select month, COUNT(user_id) as monthly_active_users from active_users
GROUP BY month
--EX6:
SELECT 
DATE_FORMAT(trans_date, '%Y-%m') AS month, 
country,
COUNT(*) AS trans_count, 
SUM(IF(state = 'approved', 1, 0)) AS approved_count, 
SUM(amount) AS trans_total_amount, 
SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM Transactions
GROUP BY month, country
--EX7: 
SELECT product_id, 
year as first_year, 
quantity,
price
FROM Sales
WHERE (product_id,year) in 
(SELECT product_id,MIN(year)
FROM Sales
GROUP BY product_id)
--EX8:
select customer_id from customer 
group by customer_id
having count(distinct product_key ) = (select count(product_key) from product)
--EX9:
SELECT employee_id
FROM Employees as a
WHERE manager_id not in (SELECT employee_id FROM employees) and salary < 30000
ORDER BY employee_id ASC
--EX10:
WITH jobcount_cte AS (
SELECT company_id, title, description, 
COUNT(job_id) AS jobcount
FROM job_listings
GROUP BY company_id, title, description)
SELECT 
COUNT(company_id) AS duplicate_companies
FROM jobcount_cte
WHERE jobcount>1;
--EX11:
(select name as results 
  from movierating mr inner join users u 
  on mr.user_id=u.user_id
  group by u.user_id 
  order by count(*) desc, name asc 
  limit 1)
union all
(select results from
  (select title as results, avg(rating) as average_rating 
  from movierating mr 
  inner join movies m 
  on mr.movie_id=m.movie_id 
  where month(created_at) = 2 
  group by m.movie_id) rating_group
  order by average_rating desc, results asc limit 1);
--EX12:
select id, count(id) num from
(select requester_id as id
from RequestAccepted
union all
select accepter_id as id
from RequestAccepted) a
group by id
order by count(id) desc
limit 1

