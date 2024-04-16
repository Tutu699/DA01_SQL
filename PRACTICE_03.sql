--EX1:
select name from STUDENTS
where marks >75
order by right(name,3),ID;
--EX 2:
select user_id,
concat(upper(left(name,1)),'',lower(right(name,length(name)-1))) as name
from Users
order by user_id
--EX3:
SELECT manufacturer,
'$'||round(sum(total_sales)/1000000,0)||' million' as sale
FROM pharmacy_sales
GROUP BY manufacturer
order by sum(total_sales) desc, manufacturer asc
--EX4:
SELECT 
extract(month from submit_date) as mth,
product_id,
round(avg(stars),2) as avg_stars
FROM reviews
group by extract(month from submit_date), product_id
order by mth, product_id
--EX5:
SELECT sender_id,
count(sender_id) as message_count
FROM messages
where extract(month from sent_date)=8 and extract(year from sent_date)=2022
group by sender_id
order by message_count desc
limit 2
--EX6:
select tweet_id from Tweets
where length(content)>15
-- EX 7:
select 
activity_date as day, 
count(distinct user_id) as active_users
from activity
where activity_date > '2019-06-27' and activity_date <= '2019-07-27' 
group by activity_date;
--EX 8:
select
count(id) as number_of_employee
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date)=2022
--EX9:
select 
position('a' in first_name)
from worker
where first_name ='Amitah';
--EX10:
select 
substring(title, length(winery)+2,4)
from winemag_p2
where country='Macedonia'
