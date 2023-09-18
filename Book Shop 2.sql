-- For this section, we'll use the same bookstore database that we used in section 7.
USE book_shop;

-- To show some useful behaviours, we'll add a few more data entries.
INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
           
/* Using DISTICT will allow us to refine the output data by only pulling distinct values. 
We can see from the following that by adding the DISTINCT tag after the SELECT, the output only 
included distinct outputs, as compared to the aternative, which  will include duplicates if 
they're present in the database.*/
SELECT author_lname FROM books;
SELECT DISTINCT author_lname FROM books;

/* When you want to pull full names from the database, we can see that without 
the DISTINCT tag, the output includes duplicates, as the database includes multiple 
books from the same author. To output only distinct full names, we have two different 
ways to do this. We can either ask for distinct concatentations of the first and last 
name, which will remove any duplicates. Alternatively, we can simply ask for distinct 
first and last names by listing them both after the DISTINCT tag. */
SELECT author_fname, author_lname FROM books;
SELECT DISTINCT CONCAT(author_fname,' ', author_lname) FROM books;
SELECT DISTINCT author_fname, author_lname FROM books;

/* Another really useful thing we'll want to do with our outputs is to sort them in different ways. By default, the outputs
are sorted by the order in which they've been added. We can use custom orders using the ORDER BY tag. */
SELECT book_id, author_fname, author_lname FROM books; -- Original ordering
SELECT book_id, author_fname, author_lname FROM books ORDER BY author_lname; -- Alphabetical by last name (NULL comes first)

/* The ORDER BY tag defaults to ordering in ascending order. That is A-Z alphabetically, or increasing numerically. To order the results 
in descending order (Z-A, or decreasing) we can add DESC after the variable we're ordering by. Note that DESC is also used to describe 
the contents of a table, depending on it's location in the query*/
SELECT book_id, author_fname, author_lname FROM books ORDER BY author_lname DESC; -- Inverse alphabetical by last name

-- Here we'll sort the books by number of pages.
SELECT title, pages FROM books; -- Original ordering
SELECT title, pages FROM books ORDER BY pages; -- Numerical ordering by page number

/* You can also add secondary (or tertiary etc.) orderings to the ORDER BY tag. The output will then primarily be ordered 
by the first given column, but will then use the second ordering when the first is insufficient. */
SELECT title, author_lname, released_year FROM books ORDER BY author_lname; -- Alphabetical by last name, then default
SELECT title, author_lname, released_year FROM books ORDER BY author_lname, title; -- Alphabetical by last name, then title
SELECT title, author_lname, released_year FROM books ORDER BY author_lname, released_year; -- Alphabetical by last name, then numerically by release year

/* If you set an alias using AS, you can continue using that alias in the rest of the command. Here' we'll order by the 
full name, which we define in the query */
SELECT CONCAT(author_fname, ' ', author_lname) AS author FROM books ORDER BY author;

/* Using the LIMIT command, you can limit the number of elements that you want to be outputted. Simply add 
the number of rows that you want after the LIMIT tag. You can also add a range after the LIMIT tag instead of a single value. 
If you set a limit that is higher than the number that would be outputted anyways, SQL will simply output everything it can. */
SELECT book_id, title, released_year FROM books LIMIT 5; -- First 5 using default ordering
SELECT book_id, title, released_year FROM books ORDER BY released_year LIMIT 5; -- First 5 after ordering by release year
SELECT book_id, title, released_year FROM books ORDER BY released_year LIMIT 5, 10; -- 5th through 10th after ordering by release year

/* The LIKE command can be used to pull only certain elements, but with fuzzier logic. For example, say we want to find a book, but all 
we know is that the author's name starts with 'Da'. We can use the LIKE command to find items that satisfy this constraint. For example, 
searching for strings LIKE '%da%' will find anything with 'da' in the string. Each % is a stand-in for an arbitrary number of characters.
Similary, each _ is a stand-in for exactly one character. If you're searching for a entry with a '%' or '_' in the title, you'll
need to add a forward-slash (\) in front of it. */
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE '%da%'; -- Pulls all items where 'da' is anywhere in the first name.
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE 'da%'; -- Pulls all items where 'da' is first in the first name.
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE 'da_'; -- Pulls all items with 'da' starting the first name, and only 1 other character
SELECT title, author_fname, author_lname FROM books WHERE author_fname LIKE '____'; -- Pulls all items the author's first name is 4 characters long.
SELECT title, author_fname, author_lname FROM books WHERE title LIKE '%\%%'; -- Pulls all items where '%' is anywhere in the title.

/* Now I'll complete the final exercise in the section. This included a few complicated queries using the 
functions that I've just learned. I'll make the following queries:
	1. Output a table of all books that contains 'stories' in the title.
    2. Find the longest book. Output the title and page count.
    3. Output a summary table containing the three most recent books in the form "Lincoln in the Bardo - 2017"
    4. Find all books where the author's last name contains a space character.
    5. Find the three books with the lowest stock.
    6. Output a table of book titles and author last names sorted first by last name, then by title.
    7. Output a table called 'yell', with entries like 'MY FAVORITE AUTHOR IS _____!' for each author. Remove duplicates. */
    
-- Problem 1 Query
SELECT title FROM books WHERE title LIKE '%stories%';

-- Problem 2 Query
SELECT title, CONCAT(author_fname, ' ', author_lname) AS 'name', pages FROM books ORDER BY pages DESC LIMIT 1;
/* Note: I understand that there is a more elegant way to get this output, but we have not 
learned it yet at this point in the course. */

-- Problem 3 Query
SELECT CONCAT(title,' - ', released_year) AS 'summary' FROM books ORDER BY released_year DESC LIMIT 3;

-- Problem 4 Query
SELECT author_lname FROM books WHERE author_lname LIKE '% %';

-- Problem 5 Query
SELECT title, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;

-- Problem 6 Query
SELECT title, author_lname FROM books ORDER BY author_lname, title;

-- Problem 7 Query
SELECT DISTINCT UPPER(CONCAT('my favorite author is ', author_fname, ' ', author_lname, '!!')) AS 'YELL!!' FROM books;