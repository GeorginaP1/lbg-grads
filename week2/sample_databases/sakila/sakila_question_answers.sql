-- List all actors
SELECT
CONCAT(first_name, " ", last_name) as actor_name
FROM actor_info;

-- 1. Find surname of "John" actor
SELECT
CONCAT(first_name, " ", last_name) as actor_name
FROM actor_info
WHERE first_name = "John";

-- 2. Find actors with surname "Neeson"
SELECT
CONCAT(first_name, " ", last_name) as actor_name
FROM actor_info
WHERE last_name = "Neeson";

-- 3. Find actors with ID number divisible by 10
SELECT
	actor_id,
	CONCAT(first_name, " ", last_name) as actor_name
FROM actor_info
WHERE mod(actor_id, 10) = 0;

-- 5. Find description of movie ID 100
SELECT 
	description
FROM film
WHERE film_id = 100;

-- 6. Find every R-rated movie
SELECT *
FROM film
WHERE rating = "R";

-- 7. Find every non R-rated movie
SELECT *
FROM film
WHERE rating != "R";

-- 8. Find the 10 shortest movies
SELECT *
FROM film
ORDER BY length ASC
LIMIT 10;

-- 9. Find the movies with the longest runtime
SELECT *
FROM film
WHERE length = (SELECT MAX(length) FROM film);

-- 10. Find all movies with deleted scenes
SELECT *
FROM film
WHERE special_features LIKE "Deleted Scenes%";

-- 11. Reverse alphabetically list unique names using HAVING
SELECT
    last_name,
    COUNT(last_name)
FROM actor_info
GROUP BY last_name
HAVING COUNT(last_name) = 1
ORDER BY last_name DESC;

-- 12. Find names that appear more than once using HAVING, from highest -> lowest frequency
SELECT
    last_name,
    COUNT(last_name)
FROM actor_info
GROUP BY last_name
HAVING COUNT(last_name) > 1
ORDER BY last_name DESC;

-- 13. Find which actor has appeared in the most films
CREATE VIEW v_acting_counts AS
SELECT 
	actor_id,
    COUNT(actor_id) as count
FROM film_actor
GROUP BY actor_id
ORDER BY count DESC;

SELECT
	CONCAT(first_name, " ", last_name) as actor_name,
    count
FROM actor_info
INNER JOIN v_acting_counts
	ON v_acting_counts.actor_id = actor_info.actor_id
WHERE count = (SELECT MAX(count) FROM v_acting_counts);

-- 14. When is "Academy Dinosaur" due?
SELECT 
	rental_id,
    rental_date,
    rental_duration,
    ADDDATE(rental_date, rental_duration) AS due_date
FROM rental
LEFT OUTER JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
LEFT OUTER JOIN film
	ON inventory.film_id = film.film_id
WHERE return_date IS NULL
AND title = "ACADEMY DINOSAUR";

-- 15. Find the average runtime of all films
SELECT
	AVG(length) AS average_length
FROM film;

-- 16. What's the average runtime for each film category?
SELECT
	COUNT(film_category),
    AVG(length)
FROM film
GROUP BY film_category

