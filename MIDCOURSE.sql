--C1:
select distinct film_id, replacement_cost desc
from film
order by replacement_cost asc
--C2:
select 
case
 when replacement_cost between 9.99 and 19.99 then 'Low'
 when replacement_cost between 20.00 and 24.99 then 'Medium'
 when replacement_cost between 25.00 and 29.99 then 'High'
end as category,
COUNT(*) AS SO_LUONG
from film
group by case
 when replacement_cost between 9.99 and 19.99 then 'Low'
 when replacement_cost between 20.00 and 24.99 then 'Medium'
 when replacement_cost between 25.00 and 29.99 then 'High'
end
--C3:
SELECT a.title , c.name as category_name,
max(a.length)
FROM public.film AS a
JOIN public.film_category AS b ON a.film_id=b.film_id
JOIN public.category AS c ON b.category_id=c.category_id
where c.name in ('Drama' ,'Sports')
group by a.title, c.name
order by max(a.length) desc;
--C4:
SELECT b.category_id,c.name as category_name,
count(a.title)
FROM public.film AS a
JOIN public.film_category AS b ON a.film_id=b.film_id
JOIN public.category AS c ON b.category_id=c.category_id
group by b.category_id,c.name
order by count(a.title) desc
--C5:
SELECT 
CONCAT(c.first_name,' ',c.last_name) AS ho_ten,
COUNT(a.film_id) 
FROM public.film AS a
JOIN public.film_actor AS b ON a.film_id=b.film_id
JOIN public.actor AS c ON b.actor_id=c.actor_id
GROUP BY ho_ten
ORDER BY COUNT(a.film_id)  desc
--C6:

--C7:
SELECT a.city,
sum(d.amount)
FROM city AS a
JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
group by a.city
order by sum(d.amount) desc
--C8:
SELECT 
concat(a.city,', ',e.country),
sum(d.amount)
FROM city AS a
JOIN address AS b ON a.city_id=b.city_id
JOIN customer AS c ON b.address_id=c.address_id
JOIN payment AS d ON c.customer_id=d.customer_id
JOIN country AS e ON a.country_id=e.country_id
group by concat(a.city,', ',e.country)
order by sum(d.amount) 
