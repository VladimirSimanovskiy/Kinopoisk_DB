--
-- Зрители по странам фильма "Зеленая миля"
--
SELECT country, view_number, film_id
FROM rental
WHERE film_id = 1

--
-- Слоган фильма "Зеленая миля"
--
SELECT tagline
FROM film
WHERE film_id = 1

--
-- Дата премьеры фильма "Зеленая миля" в России и название компании-прокатчика
--
SELECT country, release_date, rental_company
FROM rental
WHERE film_id = 1 AND country = 'Россия'

--
-- Затраты на фильм "Зеленая миля"
--
SELECT film.film_name, SUM(budget + marketing) AS total_expenses
FROM film
JOIN finance ON finance.finance_id = film.finance_id
WHERE film.film_id = 1
GROUP BY film_id

--
-- Прибыль от фильма "Зеленая миля"
--
SELECT film.film_name, SUM((box_office_USA + box_office_world) - (budget + marketing)) AS total_expenses
FROM film
JOIN finance ON finance.finance_id = film.finance_id
WHERE film.film_id = 1
GROUP BY film_id

--
-- Все актеры дубляжа по фильмам
--
SELECT film.film_name, string_agg(dubbing.dubbing_fullname, ', ')
FROM film
JOIN film_dubbing ON film_dubbing.film_id = film.film_id
JOIN dubbing ON dubbing.dubbing_id = film_dubbing.dubbing_id
GROUP BY film_name

--
-- Жанры фильма
--
SELECT film.film_name, string_agg(genre.genre_name, ', ')
FROM film
JOIN film_genre ON film_genre.film_id = film.film_id
JOIN genre ON genre.genre_id = film_genre.genre_id
GROUP BY film_name

--
-- Все награды выбранного фильма
--
SELECT award.award_name, string_agg(nomination.nomination_name, ', ')
FROM award
JOIN award_nomination_film ON award_nomination_film.award_id = award.award_id
JOIN nomination ON nomination.nomination_id = award_nomination_film.nomination_id
WHERE award_nomination_film.film_id = 1
GROUP BY award_name