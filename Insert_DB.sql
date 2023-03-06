--
-- main table data
--

INSERT INTO person(person_fullname)
VALUES
('Фрэнк Дарабонт'),
('Дэвид Тэттерсолл'),
('Томас Ньюман'),
('Теренс Марш'),
('Ричард Фрэнсис-Брюс');

INSERT INTO actor(actor_fullname)
VALUES
('Том Хэнкс'),
('Дэвид Морс'),
('Бонни Хант'),
('Майкл Кларк Дункан'),
('Джеймс Кромуэлл'),
('Майкл Джитер'),
('Грэм Грин'),
('Даг Хатчисон'),
('Сэм Рокуэлл'),
('Барри Пеппер');

INSERT INTO dubbing(dubbing_fullname)
VALUES
('Всеволод Кузнецов'),
('Владимир Антоник'),
('Любовь Германова'),
('Валентин Голубенко'),
('Александр Белявский'),
('Александр Коврижных'),
('Борис Шувалов'),
('Андрей Градов'),
('Олег Вирозуб'),
('Лариса Некипелова');

INSERT INTO genre(genre_name)
VALUES
('драма'),
('криминал'),
('фэнтези'),
('боевик'),
('вестерн'),
('детектив'),
('комедия');

INSERT INTO finance(budget, marketing, box_office_USA, box_office_world)
VALUES
(60000000, 30000000, 136801374, 150000000);

INSERT INTO rating(rating_name)
VALUES
('G'),
('PG'),
('PG-13'),
('R'),
('NC-17');

INSERT INTO nomination(nomination_name)
VALUES
('Лучший фильм'),
('Лучшая мужская роль второго плана'),
('Лучший адаптированный сценарий'),
('Лучший звук'),
('Прорыв года'),
('Лучшая музыка'),
('Лучший режисер');

INSERT INTO award(award_name)
VALUES
('Оскар, 2000 год'),
('Золотой глобус, 2000 год'),
('Премия канала "MTV", 2000 год'),
('Сатурн, 2000 год'),
('Премия Гильдии актеров, 2000 год');

INSERT INTO film
(film_name, original_name, release_year, country_prod, tagline,
director_id, screenwriter_id, producer_id, operator_id,
composer_id, artist_id, editor_id, finance_id,
min_age, rating_id, duration)
VALUES
('Зеленая миля', 'The Green Mile', 1999, 'США', 'Пол Эджкомб не верил в чудеса. Пока не столкнулся с одним из них',
1, 1, 1, 2,
3, 4, 5, 1,
16, 4, 189);

INSERT INTO rental(country, view_number, release_date, release_comment, rental_company, film_id)
VALUES
('США', NULL, '1999-12-06', 'Вествуд, Калифорния', NULL, 1),
('США', 26000000, '1999-12-10', NULL, NULL, 1),
('Германия', 2107877, '2000-02-10', NULL, NULL, 1),
('Греция', 182000, '2000-02-11', NULL, NULL, 1),
('Швейцария', NULL, '2000-02-17', 'Немецкоговорящие регионы', NULL, 1),
('Испания', 692551, '2000-02-18', NULL, NULL, 1),
('Румыния', 340, '2001-04-27', NULL, NULL, 1),
('Аргентина', NULL, '2000-03-02', NULL, NULL, 1),
('Россия', NULL, '2000-04-18', NULL, 'West', 1);

--
-- linked table data
--

INSERT INTO film_actor
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10);

INSERT INTO film_dubbing
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10);

INSERT INTO film_genre
VALUES
(1, 1),
(1, 2),
(1, 3);

INSERT INTO award_nomination_film
VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(1, 4, 1),
(2, 2, 1),
(3, 5, 1),
(4, 5, 1),
(4, 6, 1),
(5, 2, 1);