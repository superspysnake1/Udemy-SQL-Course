/* This will be the last section where we use the book-shop data which was introduced in the String Functions section */

USE book_shop;

/* We'll start with the "not equal" operator (!=). In the same way we can select all books who were released in 2017,
we can select all books release in a year that wasn't 2017. This works the same with strings, where we can select every 
book released by a single author, and every book released by anyone else. */

SELECT title, released_year FROM books WHERE released_year = 2017;
SELECT title, released_year FROM books WHERE released_year != 2017;

SELECT title, author_fname, author_lname, released_year FROM books WHERE author_lname = 'Gaiman';
SELECT title, author_fname, author_lname, released_year FROM books WHERE author_lname != 'Gaiman';

/* Similar to "not equal", we can use NOT LIKE. This will invert the selection that LIKE makes. */
SELECT title, author_fname, author_lname FROM books WHERE title LIKE '%e%'; -- Find every book with an 'e' in the title.
SELECT title, author_fname, author_lname FROM books WHERE title NOT LIKE '%e%'; -- Find every book without an 'e' in the title.

/* Next up we have "greater than" (>), "less than" (<), "greater than or equal to" (>=), or "less than or equal to" (<=).
Using this, we can select all books released before or after a given year. */

SELECT title, released_year FROM books WHERE released_year >= 2000; -- All books released on or after 2000
SELECT title, released_year FROM books WHERE released_year < 2000; -- All book released before 2000

/* The previous examples are all comparisons operators. We can add in some logical operators to make even finer distinctions.
These follow the truth tables that we know from discrete mathematics. SQL recognises AND, OR, XOR, and NOT. */

-- We can find all books that were released during or after the year 2000, by an author with last name 'Eggers', with 'novel' in the title.
SELECT title, author_fname, author_lname, released_year FROM books 
WHERE author_lname='Eggers'
AND released_year >= 2000
AND title LIKE '%novel%';

-- We can also select all books released between the years 2000 and 2010.
SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year <= 2010;
-- This can also be done more simply by using the BETWEEN command. 
SELECT title, released_year FROM books WHERE released_year BETWEEN 2000 AND 2010;

-- We can select all books written by a collection of author's. 
SELECT title, author_fname, author_lname FROM books
WHERE author_lname = 'Lahiri'
OR author_lname = 'Harris'
OR author_lname = 'Gaiman';
/* This can also be done with a more advanced command. The IN command will evaluate as true for any row
element that is found within the set given. */
SELECT title, author_fname, author_lname FROM books WHERE author_lname IN ('Lahiri', 'Harris', 'Gaiman');

/* The CASE command can be used to generate a new column depending on values/entries in other columns. It essentially creates an
If-Then statement for the column. For example, we can make a genre column, labeling books as either 'modern lit' or 
'20th century lit' depending on release year. */
SELECT title, released_year,
CASE
	WHEN released_year >= 2000 THEN 'Modern Lit'
    ELSE '20th Century Lit'
END AS 'Genre' FROM books;

-- Similarly, we can make a stock quantity indicator.
SELECT title, stock_quantity,
CASE
	WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
    WHEN stock_quantity BETWEEN 50 AND 100 THEN '**'
    WHEN stock_quantity BETWEEN 100 AND 150 THEN '***'
    WHEN stock_quantity BETWEEN 150 AND 200 THEN '****'
    ELSE '*****'
END AS 'Quantity' FROM books;
/* Like with If-Then statements, SQL will take the value whenever the first statement is satisfied in the order, 
even if it satisfies another one later. This means we can rewrite the command above to utilize that behaviour. */
SELECT title, stock_quantity,
CASE
	WHEN stock_quantity <= 50 THEN '*'
    WHEN stock_quantity <= 100 THEN '**'
    WHEN stock_quantity <= 150 THEN '***'
    WHEN stock_quantity <= 200 THEN '****'
    ELSE '*****'
END AS 'Quantity' FROM books;

/* Lastly, we can use the IS NULL command to select values that are null. This is most useful for data cleaning where we can 
see what elements have null vaues, and possibly delete them. */
SELECT * FROM books WHERE author_fname IS NULL;

DELETE FROM books WHERE author_fname IS NULL; -- This deletes values where author first name is null.

/* Now I'll complete the final exercise in the section. This included a few complicated queries using the 
functions that I've just learned. I'll make the following queries:
	1. Select all books written before 1980 (non inclusive)
    2. Select all books written by Eggers or Chabon
    3. Select all books written by Lahiri published after 2000.
    4. Select all books with page counts between 100 and 200.
    5. Select all books whos author's last name starts with a 'C' or an 'S'.
    6. Make a selection including the title, author-s last name, and a 'Type' column, which contains 'Short Stories'
	   if the entry contains 'stories' in the title, 'Memoir' if the title is ''Just Kids' of 'A Heartbreaking Work of Staggering
       Genius', and 'Novel' for everything else.
	7. Make a selection including each unique author full name, and a 'Count' column which has the total number of 
       books they have each published.
*/
-- Problem 1 Query
SELECT title, released_year FROM books WHERE released_year < 1980;

-- Problem 2 Query
SELECT title, author_fname, author_lname FROM books WHERE author_lname IN ('Eggers', 'Chabon');

-- Problem 3 Query
SELECT title, author_fname, author_lname, released_year FROM books 
WHERE author_lname = 'Lahiri'
OR released_year >= 2000; 

-- Problem 4 Query
SELECT title, pages FROM books WHERE pages BETWEEN 100 AND 200;

-- Problem 5 Query
SELECT title, author_lname FROM books WHERE author_lname LIKE 'C%' OR 'S%';

-- Problem 6 Query
SELECT title, CONCAT(author_fname, ' ', author_lname) AS 'Author', 
CASE
	WHEN title LIKE '%stories%' THEN 'Short Stories'
    WHEN title IN ('Just Kids', 'A Heartbreaking Work of Staggering Genius') THEN 'Memoir'
    ELSE 'Novel'
END AS 'Type' FROM books;

-- Problem 7 Query
SELECT CONCAT(author_fname, ' ', author_lname) AS 'Author', COUNT(*)  AS 'Count' FROM books GROUP BY Author;
