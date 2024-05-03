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
