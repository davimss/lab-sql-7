-- In the table actor, which are the actors whose last names are not repeated? 
-- For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. 
-- These three actors have the same last name. So we do not want to include this last name in our output. 
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.

SELECT FIRST_NAME, LAST_NAME, COUNT(*) OVER(PARTITION BY LAST_NAME)
FROM SAKILA.ACTOR
HAVING COUNT(*) OVER(PARTITION BY LAST_NAME) = 1
ORDER BY LAST_NAME
;

USE SAKILA;
SELECT FIRST_NAME, LAST_NAME
FROM SAKILA.ACTOR
WHERE LAST_NAME IN (
    SELECT LAST_NAME
    FROM SAKILA.ACTOR 
    GROUP BY LAST_NAME
    HAVING COUNT(LAST_NAME) = 1
);

-- Which last names appear more than once? 
-- We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once
SELECT FIRST_NAME, LAST_NAME
FROM SAKILA.ACTOR
WHERE LAST_NAME IN (
    SELECT LAST_NAME
    FROM SAKILA.ACTOR
    GROUP BY LAST_NAME
    HAVING COUNT(LAST_NAME) > 1
);

-- Using the rental table, find out how many rentals were processed by each employee.
SELECT STAFF_ID, COUNT(RENTAL_ID)
FROM SAKILA.RENTAL
GROUP BY STAFF_ID;

-- Using the film table, find out how many films were released each year.
SELECT COUNT(FILM_ID), RELEASE_YEAR
FROM SAKILA.FILM
GROUP BY RELEASE_YEAR;

-- Using the film table, find out for each rating how many films were there.
SELECT COUNT(FILM_ID), RATING
FROM SAKILA.FILM
GROUP BY RATING;

-- What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT RATING, ROUND(AVG(LENGTH), 2)
FROM SAKILA.FILM
GROUP BY RATING;

-- Which kind of movies (rating) have a mean duration of more than two hours?
SELECT RATING, ROUND(AVG(LENGTH), 2)
FROM SAKILA.FILM
GROUP BY RATING
HAVING AVG(LENGTH) > 120
;