--
-- create database
--

CREATE DATABASE "Kinopoisk"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


DROP TABLE IF EXISTS film_genre;
DROP TABLE IF EXISTS film_person;
DROP TABLE IF EXISTS film_actor;
DROP TABLE IF EXISTS film_dubbing;
DROP TABLE IF EXISTS award_nomination_film;
DROP TABLE IF EXISTS rental;
DROP TABLE IF EXISTS film CASCADE;
DROP TABLE IF EXISTS nomination;
DROP TABLE IF EXISTS award;
DROP TABLE IF EXISTS actor;
DROP TABLE IF EXISTS dubbing;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS finance;
DROP TABLE IF EXISTS rating;

--
-- create tables
--

CREATE TABLE person (
  person_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  person_fullname text NOT NULL,

  CONSTRAINT pk_person_person_id PRIMARY KEY (person_id)
);

CREATE TABLE actor (
  actor_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  actor_fullname text NOT NULL,

  CONSTRAINT pk_actor_actor_id PRIMARY KEY (actor_id)
);

CREATE TABLE dubbing (
  dubbing_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  dubbing_fullname text NOT NULL,

  CONSTRAINT pk_dubbing_dubbing_id PRIMARY KEY (dubbing_id)
);

CREATE TABLE genre (
  genre_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  genre_name text NOT NULL,

  CONSTRAINT pk_genre_genre_id PRIMARY KEY (genre_id)
);

CREATE TABLE finance (
  finance_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  budget bigint NOT NULL,
  marketing bigint NOT NULL,
  box_office_USA bigint NOT NULL,
  box_office_world bigint NOT NULL,

  CONSTRAINT pk_finance_finance_id PRIMARY KEY (finance_id)
);

CREATE TABLE rating (
  rating_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  rating_name varchar(8) NOT NULL,

  CONSTRAINT pk_rating_rating_id PRIMARY KEY (rating_id)
);

CREATE TABLE award (
  award_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  award_name text NOT NULL,

  CONSTRAINT pk_award_award_id PRIMARY KEY (award_id)
);

CREATE TABLE nomination (
  nomination_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  nomination_name text NOT NULL,

  CONSTRAINT pk_nomination_nomination_id PRIMARY KEY (nomination_id)
);

CREATE TABLE film (
    film_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
    film_name text NOT NULL,
    original_name text NOT NULL,
    release_year int NOT NULL CONSTRAINT chk_film_release_year CHECK (release_year >= 1895 AND release_year <= 2050),
    country_prod text NOT NULL,
    tagline text,
    
    --to person
    director_id bigint NOT NULL,
    screenwriter_id bigint NOT NULL,
    producer_id bigint NOT NULL,
    operator_id bigint NOT NULL,
    composer_id bigint NOT NULL,
    artist_id bigint NOT NULL,
    editor_id bigint NOT NULL,

    finance_id bigint NOT NULL,
    min_age smallint DEFAULT 0,
    rating_id bigint NOT NULL,
    duration int NOT NULL,

    CONSTRAINT pk_film_film_id PRIMARY KEY (film_id),
    CONSTRAINT fk_person_director FOREIGN KEY (director_id) REFERENCES person(person_id),
    CONSTRAINT fk_person_screenwrite FOREIGN KEY (screenwriter_id) REFERENCES person(person_id),
    CONSTRAINT fk_person_producer FOREIGN KEY (producer_id) REFERENCES person(person_id),
    CONSTRAINT fk_person_operator FOREIGN KEY (operator_id) REFERENCES person(person_id),
    CONSTRAINT fk_person_composer FOREIGN KEY (composer_id) REFERENCES person(person_id),
    CONSTRAINT fk_person_artist FOREIGN KEY (artist_id) REFERENCES person(person_id),
    CONSTRAINT fk_person_editor FOREIGN KEY (editor_id) REFERENCES person(person_id),
    CONSTRAINT fk_finance_finance_id FOREIGN KEY (finance_id) REFERENCES finance(finance_id),
    CONSTRAINT fk_rating_rating_id FOREIGN KEY (rating_id) REFERENCES rating(rating_id)
);

CREATE TABLE rental (
  rental_id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  country text NOT NULL,
  view_number bigint,
  rental_company text,
  release_date date NOT NULL,
  release_comment text,
  film_id bigint NOT NULL,

  CONSTRAINT pk_rental_rental_id PRIMARY KEY (rental_id),
  CONSTRAINT fk_rental_film FOREIGN KEY (film_id) REFERENCES film(film_id)
);

--
-- many to many tables
--

CREATE TABLE film_actor (
  film_id bigint REFERENCES film(film_id),
  actor_id bigint REFERENCES actor(actor_id),

  CONSTRAINT pk_film_actor PRIMARY KEY (film_id, actor_id),
  CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES film(film_id),
  CONSTRAINT fk_actor_id FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

CREATE TABLE film_dubbing (
  film_id bigint REFERENCES film(film_id),
     bigint REFERENCES dubbing(dubbing_id),

  CONSTRAINT pk_film_dubbing PRIMARY KEY (film_id, dubbing_id),
  CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES film(film_id),
  CONSTRAINT fk_dubbing_id FOREIGN KEY (dubbing_id) REFERENCES dubbing(dubbing_id)
);

CREATE TABLE film_genre (
  film_id bigint REFERENCES film(film_id),
  genre_id bigint REFERENCES genre(genre_id),

  CONSTRAINT pk_film_genre PRIMARY KEY (film_id, genre_id),
  CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES film(film_id),
  CONSTRAINT fk_genre_id FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

CREATE TABLE award_nomination_film (
  award_id bigint REFERENCES award(award_id),
  nomination_id bigint REFERENCES nomination(nomination_id),
  film_id bigint REFERENCES film(film_id),

  CONSTRAINT pk_award_nomination_film PRIMARY KEY (award_id, nomination_id, film_id),
  CONSTRAINT fk_award_id FOREIGN KEY (award_id) REFERENCES award(award_id),
  CONSTRAINT fk_nomination_id FOREIGN KEY (nomination_id) REFERENCES nomination(nomination_id),
  CONSTRAINT fk_film_id FOREIGN KEY (film_id) REFERENCES film(film_id)
);