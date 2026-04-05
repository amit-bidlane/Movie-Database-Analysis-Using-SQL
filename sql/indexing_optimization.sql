-- Movie Database Analysis using SQL
-- Indexing and Query Optimization
-- Dialect: MySQL 8.0+

-- Why indexes improve performance:
-- Indexes act like a lookup structure for table data, allowing MySQL to find
-- rows much faster than scanning the entire table for every filter, join, or sort.
-- They are especially helpful on columns used in WHERE, JOIN, GROUP BY, and ORDER BY clauses.

-- Before vs after optimization concept:
-- Before indexing, the database may perform full table scans, which become slower
-- as row counts grow. After indexing, the optimizer can use targeted lookups,
-- reducing I/O, improving join speed, and lowering query execution time.

-- Recommended indexes for the project:
-- 1. release_year supports year-wise trend analysis and filtering by year.
-- 2. genre_id supports joins between movies and genres plus grouped genre analysis.
-- 3. director_id supports joins between movies and directors and director-level reports.
-- 4. movie_cast indexes support fast many-to-many joins between movies and actors.

-- Index on movie release year
CREATE INDEX idx_movies_release_year
    ON movies (release_year);

-- Index on movie genre reference
CREATE INDEX idx_movies_genre_id
    ON movies (genre_id);

-- Index on movie director reference
CREATE INDEX idx_movies_director_id
    ON movies (director_id);

-- Composite index to support frequent filtering and sorting by genre and year
CREATE INDEX idx_movies_genre_year
    ON movies (genre_id, release_year);

-- Composite index to support director-based yearly analysis
CREATE INDEX idx_movies_director_year
    ON movies (director_id, release_year);

-- Index on the second side of the many-to-many relation
-- Note: movie_cast already has a PRIMARY KEY (movie_id, cast_id), which helps
-- queries starting from movie_id. This extra index helps queries starting from cast_id.
CREATE INDEX idx_movie_cast_cast_id
    ON movie_cast (cast_id);

-- Composite index for actor-to-movie traversal and join performance
CREATE INDEX idx_movie_cast_cast_movie
    ON movie_cast (cast_id, movie_id);

-- Optional performance check:
-- Use EXPLAIN before and after creating indexes to compare query plans.
-- Example 1: Year-wise movie releases
EXPLAIN
SELECT
    release_year,
    COUNT(*) AS total_releases
FROM movies
GROUP BY release_year
ORDER BY release_year;

-- Example 2: Average rating by genre
EXPLAIN
SELECT
    g.genre_name,
    ROUND(AVG(m.rating), 2) AS avg_genre_rating
FROM genres AS g
INNER JOIN movies AS m
    ON g.genre_id = m.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY avg_genre_rating DESC;

-- Example 3: Most frequent actors
EXPLAIN
SELECT
    c.actor_name,
    COUNT(mc.movie_id) AS appearances
FROM `cast` AS c
INNER JOIN movie_cast AS mc
    ON c.cast_id = mc.cast_id
GROUP BY c.cast_id, c.actor_name
ORDER BY appearances DESC;
