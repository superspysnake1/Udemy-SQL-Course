-- We'll be using the same book shop data as in the previous two sections.
USE book_shop;

/* If we want to count the number of elements a given column has, we can use the COUNT function. This does not 
count the number of unique elements, but just how many rows a given coumn has data within. If we wanted to count
distinct elements, we would need to add the DISTINCT tag. */
SELECT COUNT(author_fname) FROM books; -- Total number of rows with name data
SELECT COUNT(DISTINCT author_fname) FROM books; -- Total number of unique author's

/* For another example, say we want to find how many book titles contain the word 'the'. We've already learned
previously how to output all elements satisfying this constraint using the LIKE command, so we can add in the 
COUNT command to simply output a number */
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

/* In this book shop dataset, we have a bunch of duplicate author names, since we have multiple books for certain authors.
Using the GROUP BY command, SQL will make a bunch of sub-tables, each corresponding to a distinct element of the given
column. If all we do is then select the same column, we'll just get a single entry for each unique value. */
SElECT author_lname FROM books GROUP BY author_lname;
/* However, since the GROUP BY command stores the groups as sub-tables, we can ask questions about those sub-tables.
For example, we can find out how many books each author published. */ 
SELECT author_lname, COUNT(*) FROM books GROUP BY author_lname;
-- We can even get fancier and order by number of books published
SELECT author_lname, COUNT(*) AS 'Books Published' FROM books GROUP BY author_lname ORDER BY 'Books Published' DESC;
/* Now we have to be careful when we only use the author's last name, as distinct author's may have the same last name. 
In this case, we have two distinct authors with the last name 'harris'. One option to fix this is to concatentate the 
names together using an alias. */
SELECT 
	CONCAT(author_fname, ' ', author_lname) AS author_name, 
	COUNT(*) AS books_published 
FROM books GROUP BY author_name ORDER BY books_published DESC;
/* Alternatively, we can group by both the last and first name, which will have a similar result. */
SELECT author_fname, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;

/* Another set of useful commands are the MIN and MAX commands. They are fairly self explanatory, and output the minimum or 
maximum value respectively of a given column. The MIN and MAX commands also work on strings, and output the earliest and latest 
elements alphabetically. */
SELECT MIN(released_year) FROM books; -- Output the earliest release year.
SELECT MAX(released_year) FROM books; -- Output the latest release year.
SELECT MIN(author_lname) FROM books; -- Output alphabetically earliest author last name
SELECT MAX(author_lname) FROM books; -- Output alphabetically latest author last name
/* What if we want to know more information about the maximum or minimum value? To do this, we'll use sub-queries. 
A sub-query is a query that is nested inside another query that will be run first, whos output can be used later. Sub-queries must 
be surrounded by parenteses for them to work. For example, we can now find the title of the book with the most pages. */
SELECT title, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);
-- Similarly, we can find the title of the book that released earliest.
SELECT title, released_year FROM books WHERE released_year = (SELECT MIN(released_year) FROM books);

/* Similarly to how we were able to count the number of titles in each group of author names, we can also use 
the MIN and MAX commands. For example, let's find the earliest and latest book release years for each author. */
SELECT 
	author_lname AS 'First Name', 
	author_fname AS 'Last Name', 
    MIN(released_year) AS 'Earliest Release', 
    MAX(released_year) AS 'Latest Release' 
FROM books GROUP BY author_lname, author_fname;

/* Next up we can use the SUM command to add together a bunch of numbers. The simplest example will be to find
the total number of pages written in the database. */
SELECT SUM(pages) FROM books;
-- We can refine out query by grouping by each author to find the total number of pages written by each author.
SELECT author_fname, author_lname, SUM(pages) FROM books GROUP BY author_lname, author_fname;
-- Note that when strings are sent through the SUM command, they're treated as 0.
SELECT SUM(author_lname) FROM books;

/* Similarly, the AVG command can be used to find the average value of a given set of numbers. Let's use it to find the average
page number for each author. */
SELECT 
	author_fname AS 'First Name', 
    author_lname AS 'Last Name',
    MIN(pages) AS 'Minimum Pages',
    AVG(pages) AS 'Average Pages',
    MAX(pages) AS 'Maximum Pages'
FROM books
GROUP BY author_lname, author_fname;


/* Now I'll complete the final exercise in the section. This included a few complicated queries using the 
functions that I've just learned. I'll make the following queries:
	1. Print the total number of books in the database.
    2. Print out how many books were release in each year.
    3. Print out the total number of books in stock.
    4. Print out the average release year for each author.
    5. Find the full name of the author who wrote the longest book.
    6. Output a table grouped by release year giving the number of books released during 
    each year and the average page count of books released each year. */
    
-- Problem 1 Query
SELECT COUNT(*) AS 'Total Books' FROM books;

-- Problem 2 Query
SELECT released_year AS 'Release Year', COUNT(*) AS 'Total Books' FROM books GROUP BY released_year;

-- Problem 3 Query
SELECT SUM(stock_quantity) AS 'Total Books in Stock' FROM books;

-- Problem 4 Query
SELECT 
	author_fname AS 'First Name', 
    author_lname AS 'Last Name', 
    ROUND(AVG(released_year)) AS 'Average Release Year'
FROM books GROUP BY author_lname, author_fname; -- Note: I added the ROUND command because I didn't like the decimal places.

-- Problem 5 Query
SELECT 
	CONCAT(author_fname, ' ', author_lname) AS 'Author Name', 
    pages AS 'Largest Page Count'
FROM books WHERE pages = (SELECT max(pages) FROM books);

-- Problem 6 Query
SELECT 
	released_year AS 'Release Year', 
    COUNT(*) AS 'Total Titles Released', 
    ROUND(AVG(pages)) AS 'Average Page Count' 
FROM books GROUP BY released_year; -- Note: I added the ROUND command because I didn't like the decimal places.
