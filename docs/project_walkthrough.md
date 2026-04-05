# Project Walkthrough

## 1. Problem Statement

The goal of this project is to analyze a movie dataset using SQL and transform raw relational data into meaningful business insights. In a real-world media or entertainment setting, stakeholders often need answers to questions such as:

- Which movies are performing best in terms of ratings and revenue?
- Which genres are most common and most successful?
- Which directors consistently create high-performing films?
- Which actors appear most frequently across successful movies?
- How do movie trends change over time?

This project was built to demonstrate how a Data Analyst can use SQL for database design, data preparation, analysis, optimization, and dashboard-ready reporting.

## 2. Dataset Preparation

The project uses a structured movie dataset organized into five related CSV files:

- `movies.csv`
- `genres.csv`
- `directors.csv`
- `cast.csv`
- `movie_cast.csv`

### Data preparation steps

1. A realistic synthetic dataset was created for portfolio use.
2. The data was separated into lookup tables and relationship tables to support normalization.
3. Unique IDs were assigned to movies, genres, directors, and actors.
4. Foreign key relationships were maintained between:
   - `movies.genre_id` and `genres.genre_id`
   - `movies.director_id` and `directors.director_id`
   - `movie_cast.movie_id` and `movies.movie_id`
   - `movie_cast.cast_id` and `cast.cast_id`
5. The final dataset was saved in CSV format so it could be loaded into a relational database.

### Dataset scale

- 1,000 movies
- 5,000 actors
- 200 directors
- 15 genres
- 8,516 movie-cast relationship records

This dataset size is large enough to support meaningful SQL analysis while still being easy to manage in a portfolio project.

## 3. Database Design

The database was designed using normalization principles, specifically Third Normal Form (3NF), to reduce redundancy and improve data integrity.

### Tables created

#### `genres`

Stores unique genre names.

#### `directors`

Stores unique director records.

#### ``cast``

Stores unique actor names.

#### `movies`

Stores core movie attributes such as:

- title
- release year
- genre
- director
- budget
- revenue
- rating

#### `movie_cast`

Acts as a bridge table to handle the many-to-many relationship between movies and actors.

### Design decisions

- Primary keys were added to uniquely identify each record.
- Foreign keys were used to enforce referential integrity.
- Constraints were added to improve data quality.
- Data types were selected based on business meaning, such as `YEAR` for release year and `DECIMAL` for financial values.

This design makes the database efficient, scalable, and suitable for analytical querying.

## 4. SQL Analysis Process

After building the schema and loading the data, the next step was to perform analysis using SQL queries. The analysis process focused on converting raw data into insights that could support decision-making.

### Types of analysis performed

- Top-rated movies
- Revenue-based performance analysis
- Genre-wise movie counts
- Average rating by genre
- Director performance analysis
- Actor frequency analysis
- Year-wise movie release trends
- Genre popularity over time
- High-rated movie participation by actors

### SQL concepts applied

- `INNER JOIN` to combine related tables
- `LEFT JOIN` to include records even when matching entries are missing
- `GROUP BY` for summarization
- `HAVING` to filter aggregated results
- Subqueries for benchmark comparisons
- Common Table Expressions (CTEs) for readability
- Window functions for ranking and trend analysis
- `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()` for advanced reporting

### Example business questions answered

- Which 10 movies have the highest ratings?
- Which genres have the highest average ratings?
- Which directors have directed the most movies?
- Which actors appear across multiple high-rated films?
- How do ratings and releases change across years?

This stage highlights practical SQL skills that are directly relevant to a Data Analyst role.

## 5. Query Optimization

Once the analytical queries were written, the next step was to improve performance using indexing and query optimization techniques.

### Indexes added

- Index on `movies.release_year`
- Index on `movies.genre_id`
- Index on `movies.director_id`
- Indexes on `movie_cast` relationship columns

### Why optimization matters

Without indexes, SQL queries may scan entire tables to find matching rows. This becomes inefficient as data volume grows. With indexes, the database can locate relevant records more quickly, improving query speed for filtering, joining, sorting, and grouping.

### Optimization approach

- Reviewed query patterns used most often in analysis
- Added indexes to high-usage join and filter columns
- Used `EXPLAIN` to understand query execution plans
- Compared the concept of full table scans before indexing versus targeted index lookups after indexing

This step demonstrates performance awareness, which is an important skill when working with production-scale datasets.

## 6. Dashboard Creation

The SQL outputs from this project are designed to support dashboard creation in Excel and Power BI.

### Dashboard objectives

- Present insights in a visual and easy-to-understand format
- Support trend analysis over time
- Compare movie performance across genres and directors
- Highlight top-performing movies and actors

### Recommended dashboard visuals

- Bar chart for top-rated movies
- Column chart for movies by genre
- Line chart for year-wise releases
- KPI cards for total movies, average rating, and total revenue
- Director ranking table
- Actor appearance leaderboard

### Tools used

- SQL for data extraction and transformation
- Excel for basic reporting and quick analysis
- Power BI for interactive dashboard design

This part of the project shows how technical analysis can be translated into business-friendly visuals.

## 7. Key Insights

Although the dataset is synthetic, the project is structured to surface realistic analytical insights such as:

- Some genres can have a higher average rating than others, suggesting stronger audience reception
- A small number of directors may contribute a large share of highly rated movies
- Frequently appearing actors may be associated with multiple successful films
- Revenue and ratings do not always move together, showing the difference between commercial success and critical success
- Release trends across years can reveal growth or decline in production volume
- Genre popularity can shift over time, helping identify changing audience interests

## Why This Project Matters for Recruiters

This project is more than a collection of SQL files. It reflects the full workflow a Data Analyst might follow in a real business setting:

- structuring raw data
- designing a relational database
- writing analytical SQL queries
- optimizing performance
- preparing data for dashboards
- communicating insights clearly

For recruiters and hiring managers, this project demonstrates both technical capability and business thinking. It shows proficiency in SQL, data modeling, analysis, and reporting, all of which are core skills for data-focused roles.
