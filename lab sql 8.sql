-- SQL Queries 8
-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, and the rank.
select title, length, rank() over(order by length asc) as 'RANK' from film; -- there are no nulls or zeroes..

select title, length, rank() over(order by length asc) as 'RANK' from film
where length <> 0 and length is not null;

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). In your output, only select the columns title, length, rating and the rank.
select title, length, rating, rank() over (partition by rating order by length) as 'RANK' from film
where (length <> 0 and length is not null and rating <> 0 and rating is not null);

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
select a.name, a.category_id, b.film_id 
from category a
join film_category b on a.category_id = b.category_id
group by category_id;

-- 4. Which actor has appeared in the most films?
select a.actor_id, count(a.film_id), b.first_name, b.last_name
from film_actor a
join actor b on a.actor_id = b.actor_id
group by actor_id
order by count(a.film_id) desc
limit 1;

-- 5. Most active customer (the customer that has rented the most number of films)
select a.customer_id, count(a.rental_id), b.first_name, b.last_name
from rental a
join customer b on a.customer_id = b.customer_id
group by customer_id
order by count(a.rental_id) desc
limit 1;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

select film_table.title, count(rental_table.rental_id)
from film as film_table
join inventory as inventory on film_table.film_id = inventory.film_id
join rental as rental_table on inventory.inventory_id = rental_table.inventory_id
group by title
order by count(rental_table.rental_id) desc
limit 1;