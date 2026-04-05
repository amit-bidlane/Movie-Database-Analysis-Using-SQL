# Movie Database Analysis using SQL

## Project Overview

This project showcases an end-to-end SQL data analysis workflow built around a movie database. It demonstrates how relational database design, structured querying, and performance optimization can be used to extract business insights from entertainment data.

The project was designed as a portfolio piece for a Data Analyst role, with a strong focus on clean schema design, analytical SQL queries, realistic sample data, and dashboard-ready outputs for reporting in Excel and Power BI.

## Dataset Description

The dataset represents a simplified movie industry database with normalized tables for movies, genres, directors, actors, and movie-actor relationships.

### Dataset size

- 1,000 movies
- 5,000 actors
- 200 directors
- 15 genres
- 8,516 movie-cast relationship records

### Included files

- `movies.csv`: movie-level information such as title, release year, genre, director, budget, revenue, and rating
- `genres.csv`: genre lookup table
- `directors.csv`: director lookup table
- `cast.csv`: actor lookup table
- `movie_cast.csv`: bridge table connecting movies and actors

## Database Schema

The database is designed in Third Normal Form (3NF) to reduce redundancy and maintain referential integrity.

### Main tables

- `genres`: stores unique movie genres
- `directors`: stores unique director records
- ``cast``: stores unique actor records
- `movies`: stores movie details and references genres and directors
- `movie_cast`: many-to-many bridge table linking movies and actors

### Key relationships

- Each movie belongs to one genre
- Each movie is assigned one director
- Each movie can have many actors
- Each actor can appear in many movies

## SQL Concepts Used

This project applies a wide range of SQL concepts commonly used in data analysis:

- `CREATE TABLE`, primary keys, foreign keys, and constraints
- Data normalization (3NF)
- `INSERT INTO` statements for dataset loading
- `INNER JOIN` and `LEFT JOIN`
- `GROUP BY` and `HAVING`
- Aggregate functions such as `COUNT()`, `AVG()`, and `SUM()`
- Subqueries and Common Table Expressions (CTEs)
- Window functions
- `RANK()`, `DENSE_RANK()`, and `ROW_NUMBER()`
- Indexing and query optimization with `EXPLAIN`

## Project Insights

The analytical SQL queries in this project answer practical business questions such as:

- Which movies have the highest ratings?
- Which genres have the best average audience performance?
- Which directors consistently produce highly rated movies?
- Which actors appear most frequently across the dataset?
- How do movie releases change over time?
- Which genres are becoming more popular year by year?
- Which actors are repeatedly associated with high-rated movies?

These insights demonstrate how SQL can be used not only for querying data, but also for storytelling and decision support.

## Dashboard Preview

The SQL outputs from this project can be used as inputs for dashboarding tools such as Excel and Power BI.

### Suggested dashboard views

- Top-rated movies leaderboard
- Revenue vs budget comparison
- Genre-wise movie count and average rating
- Director performance summary
- Year-wise release trend analysis
- Actor appearance frequency analysis

Dashboard planning notes are included here:

- `dashboards/powerbi_dashboard_description.md`
- `dashboards/excel_dashboard_description.md`

## Project Folder Structure

```text
Movie-Database-SQL-Analysis/
|
|-- README.md
|
|-- data/
|   |-- movies.csv
|   |-- genres.csv
|   |-- directors.csv
|   |-- cast.csv
|   `-- movie_cast.csv
|
|-- sql/
|   |-- schema.sql
|   |-- data_insertion.sql
|   |-- analysis_queries.sql
|   `-- indexing_optimization.sql
|
|-- dashboards/
|   |-- powerbi_dashboard_description.md
|   `-- excel_dashboard_description.md
|
`-- docs/
    `-- project_walkthrough.md
```

## How to Run the Project

1. Create a new database in MySQL 8.0+.
2. Run `sql/schema.sql` to create the database tables.
3. Run `sql/data_insertion.sql` to load the sample dataset.
4. Execute queries from `sql/analysis_queries.sql` to explore insights.
5. Apply `sql/indexing_optimization.sql` to improve performance and review query plans with `EXPLAIN`.
6. Export query outputs into Excel or Power BI for visualization and dashboard creation.

## Tools Used

- SQL
- Excel
- Power BI

## Future Improvements

- Add real-world movie data from public APIs or open datasets
- Build interactive Power BI and Excel dashboards with screenshots
- Include stored procedures and views for reusable analysis
- Add advanced KPI reporting such as ROI, genre profitability, and director success metrics
- Extend the schema with production companies, countries, languages, and award data
- Add PostgreSQL-compatible versions of the SQL scripts

## Portfolio Value

This project demonstrates core Data Analyst skills across database design, SQL querying, performance tuning, and insight generation. It is well suited for showcasing practical analytical thinking, technical SQL capability, and business-oriented storytelling in a professional portfolio.
