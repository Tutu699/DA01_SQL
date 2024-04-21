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
