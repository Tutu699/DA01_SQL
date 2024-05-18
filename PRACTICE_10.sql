-01:
with order_cohort as
(select order_id, user_id, delivered_at 
from bigquery-public-data.thelook_ecommerce.order_items
where status='Complete'
and (delivered_at  between '2019-01-01 00:00:00' and '2022-05-01 00:00:00'))
select 
extract(year from delivered_at) ||'-'|| extract(month from delivered_at) as month_year,
count(order_id) as total_order,
count(distinct(user_id)) as total_user
from order_cohort
group by 1
order by 1 
--02:
Select 
extract(year from created_at) ||'-'|| extract(month from created_at) as month_year,
count(distinct(user_id)) as distinct_users,
round(sum(sale_price)/count(distinct order_id),2) as average_order_value
from bigquery-public-data.thelook_ecommerce.order_items
Where created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by month_year
ORDER BY month_year
--03:
With female_age as 
(select 
min(age) as min_age, 
max(age) as max_age
from bigquery-public-data.thelook_ecommerce.users
Where gender='F' and created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'),
male_age as 
(select 
min(age) as min_age, 
max(age) as max_age
from bigquery-public-data.thelook_ecommerce.users
Where gender='M' and created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'),
young_old_group as 
(Select t1.first_name, t1.last_name, t1.gender, t1.age
from bigquery-public-data.thelook_ecommerce.users as t1
Join female_age as t2 on t1.age=t2.min_age or t1.age=t2.max_age
Where t1.gender='F'
and created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
UNION ALL
Select t3.first_name, t3.last_name, t3.gender, t3.age
from bigquery-public-data.thelook_ecommerce.users as t3
Join female_age as t4 on t3.age=t4.min_age or t3.age=t4.max_age
Where t3.gender='M' and created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'),
age_tag as
(Select *, 
Case 
  when age in (select min(age) as min_age from bigquery-public-data.thelook_ecommerce.users
Where gender='F' and created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00') then 'Youngest'
  when age in (select min(age) as min_age from bigquery-public-data.thelook_ecommerce.users
Where gender='M'and created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00') then 'Youngest'
  Else 'Oldest'
END as tag
from young_old_group)
Select gender, tag, 
count(*) as user_count
from age_tag
group by gender, tag
--04:
Select * from 
(With product_profit as
(Select 
extract(year from created_at) ||'-'|| extract(month from created_at) as month_year,
t1.product_id as product_id,
t2.name as product_name,
round(sum(t1.sale_price),2) as sales,
round(sum(t2.cost),2) as cost,
round(sum(t1.sale_price)-sum(t2.cost),2)  as profit
from bigquery-public-data.thelook_ecommerce.order_items as t1
Join bigquery-public-data.thelook_ecommerce.products as t2 on t1.product_id=t2.id
Where t1.status='Complete'
Group by month_year, t1.product_id, t2.name)
Select * ,
dense_rank() OVER ( PARTITION BY month_year ORDER BY month_year,profit) as rank
from product_profit) as rank_table
Where rank_table.rank<=5
order by rank_table.month_year
--05:
Select 
extract(year from created_at) ||'-'|| extract(month from created_at)||'-'|| extract(day from created_at) as dates,
t2.category as product_categories,
round(sum(t1.sale_price),2) as revenue,
from bigquery-public-data.thelook_ecommerce.order_items as t1
Join bigquery-public-data.thelook_ecommerce.products as t2 on t1.product_id=t2.id
Where t1.status='Complete' and t1.delivered_at BETWEEN '2022-01-15 00:00:00' AND '2022-04-16 00:00:00'
Group by dates, product_categories
Order by dates
