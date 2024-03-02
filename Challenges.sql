--1
select distinct (replacement_cost)
from film
order by replacement_cost asc

--2
select
count(replacement_cost)
,
 case
 	when replacement_cost between 9.99 and 19.99 then 'low'
 	when replacement_cost between 20.00 and 24.99 then 'medium'
 else 'high'
	end as t1
from film
where replacement_cost between 9.99 and 19.99
group by t1


--3
select
title
, length
, t2.category_id
, name
from film t1
left join film_category t2 on t1.film_id = t2.film_id
left join category t3 on t2.category_id = t3.category_id
where name in ('Drama', 'Sports')
order by length desc

--4

select
count(title) as no_film
, name
from film t1
left join film_category t2 on t1.film_id = t2.film_id
left join category t3 on t2.category_id = t3.category_id
group by name
order by no_film desc

--5

select 
t1.first_name
, t1.last_name
, count(t3.film_id) as no_film
from actor t1
left join film_actor t2 on t1.actor_id = t2.actor_id
left join film t3 on t2.film_id = t3.film_id
group by t1.first_name
, t1.last_name
order by no_film desc

--6

select count (*)
from address t1
left join customer t2 on t1.address_id = t2.address_id
where t2.address_id is null

--7

select 
sum(amount) as tot_amt
, city
from payment t1
left join customer t2 on t1.customer_id = t2.customer_id
left join address t3 on t2.address_id = t3.address_id
left join city t4 on t3.city_id = t4.city_id
group by city
order by tot_amt desc

--8

select 
sum(amount) as tot_amt
, country
, city
from payment t1
left join customer t2 on t1.customer_id = t2.customer_id
left join address t3 on t2.address_id = t3.address_id
left join city t4 on t3.city_id = t4.city_id
left join country t5 on t4.country_id = t5.country_id
group by country
, city
order by tot_amt asc

--9

select
round(avg(tot_amt),2)
, staff_id
from (select
	sum(amount) as tot_amt
	, staff_id
	, customer_id
	from payment t1
	group by staff_id
	, customer_id
		 ) t3
group by staff_id

--10

select day_name
, round(avg(tot_amt),2)
from (
	select date(payment_date) as date
	, to_char(payment_date, 'Day') as day_name
	, sum(amount) as tot_amt
	from payment t2
	group by date
	, day_name
	order by date desc) t1
group by day_name



--11

select
title
, length
,replacement_cost
from film a
where length > (select avg(length)
			   from film b
				where a.replacement_cost = b.replacement_cost
			   group by replacement_cost)
order by length asc

--12

select district
, round(avg(total),2) as avg_total
from 
	(select district
	, sum(amount) as total
	from payment a
	left join customer b on a.customer_id = b.customer_id
	left join address c on b.address_id = c.address_id
	group by a.customer_id, district) t
group by district
order by avg_total desc

--13

select payment_id
, amount
, name
, 		(select sum(amount) from payment a1
		left join rental b1 on a1.rental_id = b1.rental_id
		left join inventory c1 on b1.inventory_id = c1.inventory_id
		left join film_category d1 on c1.film_id = d1.film_id
		left join category e1 on d1.category_id = e1.category_id
		where e.name = e1.name)
from payment a
left join rental b on a.rental_id = b.rental_id
left join inventory c on b.inventory_id = c.inventory_id
left join film_category d on c.film_id = d.film_id
left join category e on d.category_id = e.category_id
group by
 name
, amount
, payment_id
, e.name
order by name asc, payment_id desc

--14

select 
title
, sum(amount) as total
, name
from payment a
left join rental b on a.rental_id = b.rental_id
left join inventory c on b.inventory_id = c.inventory_id
left join film d on c.film_id = d.film_id
left join film_category e on d.film_id = e.film_id
left join category f on e.category_id = f.category_id
group by title
, name
order by name asc, total desc