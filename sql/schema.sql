-- Movie Database Analysis using SQL
-- Dialect: MySQL 8.0+
-- Note: `cast` is a reserved keyword, so it is escaped with backticks.

DROP TABLE IF EXISTS movie_cast;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS `cast`;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT chk_genre_name_not_empty CHECK (CHAR_LENGTH(TRIM(genre_name)) > 0)
);

CREATE TABLE directors (
    director_id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(150) NOT NULL,
    CONSTRAINT uq_director_name UNIQUE (director_name),
    CONSTRAINT chk_director_name_not_empty CHECK (CHAR_LENGTH(TRIM(director_name)) > 0)
);

CREATE TABLE `cast` (
    cast_id INT PRIMARY KEY AUTO_INCREMENT,
    actor_name VARCHAR(150) NOT NULL,
    CONSTRAINT uq_actor_name UNIQUE (actor_name),
    CONSTRAINT chk_actor_name_not_empty CHECK (CHAR_LENGTH(TRIM(actor_name)) > 0)
);

CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_year YEAR NOT NULL,
    genre_id INT NOT NULL,
    director_id INT NOT NULL,
    budget DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    revenue DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    rating DECIMAL(3,1) NOT NULL,
    CONSTRAINT fk_movies_genre
        FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_movies_director
        FOREIGN KEY (director_id) REFERENCES directors(director_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_title_not_empty CHECK (CHAR_LENGTH(TRIM(title)) > 0),
    CONSTRAINT chk_budget_non_negative CHECK (budget >= 0),
    CONSTRAINT chk_revenue_non_negative CHECK (revenue >= 0),
    CONSTRAINT chk_rating_range CHECK (rating BETWEEN 0.0 AND 10.0)
);

CREATE TABLE movie_cast (
    movie_id INT NOT NULL,
    cast_id INT NOT NULL,
    PRIMARY KEY (movie_id, cast_id),
    CONSTRAINT fk_movie_cast_movie
        FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_movie_cast_cast
        FOREIGN KEY (cast_id) REFERENCES `cast`(cast_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
