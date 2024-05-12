-01:
with order_cohort as
(select order_id, user_id, created_at
from bigquery-public-data.thelook_ecommerce.order_items
where status='Complete'
and created_at between '2019-01-01' and '2022-05-01'
group by 1,2,3)
select 
extract(year from created_at) ||'-'|| extract(month from created_at) as month_year,
sum(order_id) as total_order,
sum((user_id)) as total_user
from order_cohort
group by 1
order by 1 asc
--02:
