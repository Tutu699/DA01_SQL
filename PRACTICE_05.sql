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
