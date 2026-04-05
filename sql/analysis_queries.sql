-- Movie Database Analysis using SQL
-- Analytical Queries
-- Dialect: MySQL 8.0+

-- 1. Top 10 highest rated movies
-- Purpose: Identify the best-rated movies in the dataset.
-- Insight: Useful for spotting critically successful movies regardless of revenue.
SELECT
    m.movie_id,
    m.title,
    m.release_year,
    g.genre_name,
    d.director_name,
    m.rating
FROM movies AS m
INNER JOIN genres AS g
    ON m.genre_id = g.genre_id
INNER JOIN directors AS d
    ON m.director_id = d.director_id
ORDER BY m.rating DESC, m.revenue DESC
LIMIT 10;

-- 2. Movies grouped by genre
-- Purpose: Count how many movies belong to each genre.
-- Insight: Shows which genres dominate the dataset.
SELECT
    g.genre_id,
    g.genre_name,
    COUNT(m.movie_id) AS total_movies
FROM genres AS g
LEFT JOIN movies AS m
    ON g.genre_id = m.genre_id
GROUP BY g.genre_id, g.genre_name
ORDER BY total_movies DESC, g.genre_name;

-- 3. Average rating by genre
-- Purpose: Measure genre quality using average movie ratings.
-- Insight: Helps compare audience or critic reception across genres.
SELECT
    g.genre_name,
    ROUND(AVG(m.rating), 2) AS avg_genre_rating,
    COUNT(m.movie_id) AS movie_count
FROM genres AS g
INNER JOIN movies AS m
    ON g.genre_id = m.genre_id
GROUP BY g.genre_id, g.genre_name
HAVING COUNT(m.movie_id) >= 5
ORDER BY avg_genre_rating DESC, movie_count DESC;

-- 4. Top directors by average rating
-- Purpose: Find directors with the strongest average ratings.
-- Insight: Highlights consistently high-performing directors.
SELECT
    d.director_id,
    d.director_name,
    COUNT(m.movie_id) AS total_movies,
    ROUND(AVG(m.rating), 2) AS avg_director_rating
FROM directors AS d
INNER JOIN movies AS m
    ON d.director_id = m.director_id
GROUP BY d.director_id, d.director_name
HAVING COUNT(m.movie_id) >= 3
ORDER BY avg_director_rating DESC, total_movies DESC
LIMIT 10;

-- 5. Most frequent actors
-- Purpose: Show which actors appear in the highest number of movies.
-- Insight: Useful for understanding casting frequency and actor productivity.
SELECT
    c.cast_id,
    c.actor_name,
    COUNT(mc.movie_id) AS movie_appearances
FROM `cast` AS c
INNER JOIN movie_cast AS mc
    ON c.cast_id = mc.cast_id
GROUP BY c.cast_id, c.actor_name
HAVING COUNT(mc.movie_id) > 1
ORDER BY movie_appearances DESC, c.actor_name
LIMIT 15;

-- 6. Movies with highest revenue
-- Purpose: Rank movies by box office revenue.
-- Insight: Reveals the most commercially successful titles.
SELECT
    m.movie_id,
    m.title,
    m.release_year,
    m.budget,
    m.revenue,
    ROUND(m.revenue - m.budget, 2) AS profit
FROM movies AS m
ORDER BY m.revenue DESC, profit DESC
LIMIT 10;

-- 7. Year-wise movie releases
-- Purpose: Count how many movies were released each year.
-- Insight: Shows release volume trends over time.
SELECT
    m.release_year,
    COUNT(*) AS total_releases
FROM movies AS m
GROUP BY m.release_year
ORDER BY m.release_year;

-- 8. Ranking movies using window functions
-- Purpose: Rank movies within each genre by rating.
-- Insight: Makes it easy to compare top performers inside every genre segment.
SELECT
    g.genre_name,
    m.title,
    m.release_year,
    m.rating,
    RANK() OVER (
        PARTITION BY g.genre_name
        ORDER BY m.rating DESC, m.revenue DESC
    ) AS genre_rank,
    DENSE_RANK() OVER (
        PARTITION BY g.genre_name
        ORDER BY m.rating DESC
    ) AS genre_dense_rank,
    ROW_NUMBER() OVER (
        PARTITION BY g.genre_name
        ORDER BY m.rating DESC, m.movie_id
    ) AS genre_row_number
FROM movies AS m
INNER JOIN genres AS g
    ON m.genre_id = g.genre_id
ORDER BY g.genre_name, genre_rank, m.title;

-- 9. Running average rating over years
-- Purpose: Calculate the cumulative average movie rating by release year.
-- Insight: Shows whether movie ratings trend upward or downward over time.
WITH yearly_ratings AS (
    SELECT
        release_year,
        ROUND(AVG(rating), 2) AS avg_year_rating
    FROM movies
    GROUP BY release_year
)
SELECT
    release_year,
    avg_year_rating,
    ROUND(
        AVG(avg_year_rating) OVER (
            ORDER BY release_year
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS running_avg_rating
FROM yearly_ratings
ORDER BY release_year;

-- 10. Genre popularity trends
-- Purpose: Track yearly movie counts by genre.
-- Insight: Highlights whether a genre is becoming more or less popular over time.
SELECT
    m.release_year,
    g.genre_name,
    COUNT(*) AS movies_released,
    RANK() OVER (
        PARTITION BY m.release_year
        ORDER BY COUNT(*) DESC
    ) AS popularity_rank_in_year
FROM movies AS m
INNER JOIN genres AS g
    ON m.genre_id = g.genre_id
GROUP BY m.release_year, g.genre_id, g.genre_name
ORDER BY m.release_year, popularity_rank_in_year, g.genre_name;

-- 11. Directors with most movies
-- Purpose: Identify the most prolific directors in the dataset.
-- Insight: Helps distinguish high-volume directors from selective ones.
SELECT
    d.director_id,
    d.director_name,
    COUNT(m.movie_id) AS total_movies_directed
FROM directors AS d
LEFT JOIN movies AS m
    ON d.director_id = m.director_id
GROUP BY d.director_id, d.director_name
ORDER BY total_movies_directed DESC, d.director_name
LIMIT 10;

-- 12. Actors appearing in multiple high-rated movies
-- Purpose: Find actors repeatedly associated with strong movie ratings.
-- Insight: Useful for detecting reliable performers in critically successful films.
SELECT
    c.cast_id,
    c.actor_name,
    COUNT(DISTINCT mc.movie_id) AS high_rated_movie_count,
    ROUND(AVG(m.rating), 2) AS avg_rating_in_high_rated_movies
FROM `cast` AS c
INNER JOIN movie_cast AS mc
    ON c.cast_id = mc.cast_id
INNER JOIN movies AS m
    ON mc.movie_id = m.movie_id
WHERE m.rating >= 8.0
GROUP BY c.cast_id, c.actor_name
HAVING COUNT(DISTINCT mc.movie_id) >= 2
ORDER BY high_rated_movie_count DESC, avg_rating_in_high_rated_movies DESC, c.actor_name
LIMIT 20;

-- 13. Movies performing above their genre average
-- Purpose: Compare each movie against the average rating of its genre.
-- Insight: Surfaces standout titles that beat their genre benchmark.
SELECT
    m.title,
    g.genre_name,
    m.rating,
    genre_stats.avg_genre_rating,
    ROUND(m.rating - genre_stats.avg_genre_rating, 2) AS rating_above_genre_avg
FROM movies AS m
INNER JOIN genres AS g
    ON m.genre_id = g.genre_id
INNER JOIN (
    SELECT
        genre_id,
        AVG(rating) AS avg_genre_rating
    FROM movies
    GROUP BY genre_id
) AS genre_stats
    ON m.genre_id = genre_stats.genre_id
WHERE m.rating > genre_stats.avg_genre_rating
ORDER BY rating_above_genre_avg DESC, m.rating DESC
LIMIT 15;

-- 14. Highest revenue movie for each director
-- Purpose: Find the top-grossing movie within every director's portfolio.
-- Insight: Useful for portfolio analysis and director-level performance reviews.
WITH director_movie_revenue AS (
    SELECT
        d.director_name,
        m.title,
        m.revenue,
        ROW_NUMBER() OVER (
            PARTITION BY d.director_id
            ORDER BY m.revenue DESC, m.rating DESC
        ) AS revenue_rank
    FROM directors AS d
    INNER JOIN movies AS m
        ON d.director_id = m.director_id
)
SELECT
    director_name,
    title,
    revenue
FROM director_movie_revenue
WHERE revenue_rank = 1
ORDER BY revenue DESC, director_name;
