--EX01:
SELECT extract(year from transaction_date) as year,
product_id, 
spend as curr_year_spend,
lag(spend) OVER(PARTITION BY product_id order by transaction_date)
as prev_year_spend, 
round((spend
-lag(spend) OVER(PARTITION BY product_id order by transaction_date))*100/
lag(spend) OVER(PARTITION BY product_id order by transaction_date),2)
as yoy_rate
FROM user_transactions;
--EX02:
SELECT distinct card_name,
first_value (issued_amount) over (partition by card_name 
order by issue_year,issue_month)
FROM monthly_cards_issued
order by first_value (issued_amount) over (partition by card_name 
order by issue_year,issue_month) desc;
--EX03:
with a as 
(SELECT user_id,spend,transaction_date, 
row_number() over(partition by user_id order by transaction_date)
FROM transactions
group by user_id,spend,transaction_date)
select user_id,spend,transaction_date
from a where row_number = 3;
--EX04:
WITH transaction_date_CTE AS
(SELECT transaction_date,user_id,product_id,
RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS STT
FROM user_transactions) 
SELECT 
transaction_date, user_id,
COUNT(product_id) AS purchase_count
FROM transaction_date_CTE
WHERE STT =1
GROUP BY transaction_date, user_id
ORDER BY transaction_date 
--EX05:
WITH A AS
(SELECT user_id, tweet_date,tweet_count,
lag(tweet_count) over(partition by user_id order by tweet_date) as pre1,
lag(tweet_count,2) over(partition by user_id order by tweet_date) as pre2
from tweets)
SELECT user_id, tweet_date,
CASE 
WHEN pre1 IS NULL AND pre2 IS NULL THEN ROUND(tweet_count,2)
WHEN pre1 IS NULL THEN ROUND((pre2 + tweet_count)/2.0,2)
WHEN pre2 IS NULL THEN ROUND((pre1 + tweet_count) /2.0,2)
ELSE ROUND((pre1 + pre2 + tweet_count)/3.0,2)
END AS rolling_avg_3d
FROM A
ORDER BY user_id;
--EX06:
WITH cte AS
(SELECT 
transaction_id, merchant_id, credit_card_id, amount, 
transaction_timestamp-lag(transaction_timestamp) 
over( PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp ) as time
FROM transactions)
select count(*) as payment_count
from cte
where time <= '00:10:00'
--EX07:
WITH CTE AS
(SELECT category,product,
SUM(spend) AS total_spend,
RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
WHERE EXTRACT(YEAR FROM transaction_date) = 2022
GROUP BY category, product)
SELECT category, product, total_spend
FROM CTE
WHERE ranking <= 2
--EX08:
with cte as 
(select d.artist_name,
DENSE_RANK() over (order by COUNT(d.count) desc ) as artist_rank
from 
(select a.artist_name,a.artist_id,b.song_id,b.name,c.rank,
COUNT(c.rank) over(PARTITION BY a.artist_name)as count
from artists as a
join songs as b on a.artist_id=b.artist_id
join global_song_rank as c on b.song_id=c.song_id
where c.rank<=10
order by c.rank) d
group by artist_name)
select artist_name, artist_rank
from cte as e where e.artist_rank<=5;
