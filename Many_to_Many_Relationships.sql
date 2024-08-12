/* After understanding One-to-One and one-to-Many relationships and how to implement them
in SQL, we'll now work on the Many-to-Many relationship. First, here are a few examples of
where this might be needed.
	1. Books and Authors: A single author may have written multiple books, and each
	   book can be written by multiple authors. 
	2. Files and Tags: A user may want to give a file multiple tags, and each tag may be 
       added to multiple files. 
	3. Students and Classes: Each student will take many classes, and each class will have 
       any students enrolled. This could also be added with a professors table as well. 
For this course, we're going to be using a different application. We'll be making a tv show
review database. This database will include three tables; reviewers, series, and reviews.
The reviews table is what is called a 'join table', because the reviewers and series are
totally independant tables, but they are both connected to the reviews table.  */

CREATE DATABASE tv_database;
USE tv_database;

CREATE TABLE reviewers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE series (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    released_year YEAR,
    genre VARCHAR(100)
);

CREATE TABLE reviews (
	id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2,1),
    series_id INT, 
    reviewers_id INT,
    FOREIGN KEY (series_id) REFERENCES series(id),
    FOREIGN KEY (reviewers_id) REFERENCES reviewers(id)
);

-- Now let's add some sample data.
INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(series_id, reviewers_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),(8,4,8.5),(8,2,7.8),(8,6,8.8),
    (8,5,9.3),(9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),
    (9,5,4.5),(10,5,9.9),(13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

/* The rest of this section consists of completing 7 challenge exercises. I will include
my solutions to them. */
-- Challenge 1. Select a table that includes every different review rating for each series.
SELECT title, rating FROM series
JOIN reviews ON series.id = reviews.series_id;

/* Challenge 2. Select a table that includes each series in the database along with the 
average rating of each series. */
SELECT title, ROUND(AVG(rating), 2) AS 'avg_rating' FROM series
JOIN reviews ON series.id=reviews.series_id
GROUP BY title
ORDER BY avg_rating;

/* Challenge 3. Select a table that includes gives the first name and last name of each 
reviewer attached to any rating they've given a show. */
SELECT first_name, last_name, rating FROM reviewers
JOIN reviews ON reviewers.id=reviews.reviewers_id;

/* Challenge 4. Select a table that includes all series that have no reviews published. */
SELECT title AS 'unreviewed series' FROM series
LEFT JOIN reviews ON series.id = reviews.series_id
WHERE rating IS NULL;

/* Challenge 5. Select a table of genres and the average rating for each genre. */
SELECT genre, ROUND(AVG(rating), 2) AS avg_rating FROM series
JOIN reviews ON series.id=reviews.series_id
GROUP BY genre;

/* Challenge 6. Select a table which includes every reviewer by first and last name,
The number of times they've published, their minimum, maximum, and average 
rating, and a status column, which will be ACTIVE if they've left a review, and 
INACTIVE otherwise. */
SELECT 
	first_name, 
    last_name, 
    COUNT(rating) AS 'count', 
    IFNULL(MIN(rating),0) AS 'min',
    IFNULL(MAX(rating),0) AS 'max',
    IFNULL(ROUND(AVG(rating),2),0) AS 'average',
    IF(COUNT(rating)>0, 'active', 'inactive') AS 'status'
FROM reviewers
LEFT JOIN reviews ON reviewers.id = reviews.reviewers_id
GROUP BY first_name, last_name;

/* Challenge 7. Select a table that includes every review, along with the tile and 
reviewer that it is associated with. */
SELECT title, rating, CONCAT(first_name, ' ', last_name) as 'reviewer' FROM reviews
JOIN reviewers ON reviewers.id=reviews.reviewers_id
JOIN series ON series.id=reviews.series_id
ORDER BY title;