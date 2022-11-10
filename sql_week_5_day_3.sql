-- 1. List all customers who live in Texas (use JOINs)
SELECT *
FROM customer
LEFT JOIN address
ON address.address_id = customer.address_id 
WHERE district = 'Texas'
ORDER BY last_name, first_name ASC;


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.customer_id, first_name, last_name, amount
FROM customer
LEFT JOIN payment
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99
ORDER BY amount DESC, last_name, first_name ASC;


-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
)
GROUP BY customer_id, first_name, last_name
ORDER BY last_name, first_name ASC;


-- 4. List all customers that live in Nepal (use the city table)
SELECT * 
FROM customer
LEFT JOIN address
ON address.address_id = customer.address_id
LEFT JOIN city
ON city.city_id = address.city_id
LEFT JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal'
ORDER BY last_name, first_name ASC;


-- 5. Which staff member had the most transactions?
SELECT staff.staff_id, first_name, last_name, COUNT(payment_id) AS transaction_count
FROM staff
LEFT JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY staff.staff_id, first_name, last_name
ORDER BY transaction_count DESC;
-- answer: first row in result


-- 6. How many movies of each rating are there?
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY rating ASC;


-- 7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer.customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
)
GROUP BY customer_id, first_name, last_name
ORDER BY last_name, first_name ASC


-- 8. How many free rentals did our store give away?
SELECT COUNT(rental_id) AS free_rental_count
FROM payment
WHERE amount = 0.00;
