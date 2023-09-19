CREATE DATABASE book_shop;
USE book_shop;
CREATE TABLE books (
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    author_fname VARCHAR(100),
    author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT,
    PRIMARY KEY (book_id)
);
DESC books; -- Confirm that books looks right.

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

/* Consider if the book shop wanted to know the full name of each author. 
Since the first and last name are seperated, we'll need to use the CONCAT() function 
to do this. */
SELECT 
    CONCAT(author_fname, ' ', author_lname)
FROM
    books;
/* While this gives out the correct output, the column name in the output is quite messy, 
as it just displays the entire CONCAT() function. To get around this, we can use the 
AS operator, which can give the CONCAT() function an alias. */
SELECT 
    CONCAT(author_fname, ' ', author_lname) AS author_full_name
FROM
    books;
/* Note that if you're concatenating more than just two columns, adding the space 
between each column can be annoying. To get around this, use the CONCAT_WS() function, 
which puts the first argument in between all the following arguments */
SELECT 
    CONCAT_WS(' ', author_fname, author_lname, title) AS author_name_book
FROM
    books;

/* Some of the titles on these books are quite long, the longest being 51 characters. 
The bookstore may only need to know the first few characters to confirm that the system is 
pulling up the correct book. To select only part of the title, we can use the SUBSTRING() or
SUBSTR() (they're identical) function. */
SELECT SUBSTR(title, 1, 10) FROM books;-- This pulls the first 10 characters of the title string
SELECT SUBSTR(title, 1, 20) FROM books;-- This pulls the first 20 characters of the title string
SELECT SUBSTR(title, 5, 15) FROM books;-- This pulls strings of length 15 starting from the 5th character
SELECT SUBSTR(title, 5) FROM books;-- This pulls from the string, starting at the 5th character to the end
SELECT SUBSTR(title, - 5) FROM books;-- This pulls the last 5 characters from the string

SELECT CONCAT(SUBSTR(title, 1, 15), '...') AS shortened_title
FROM
    books;-- This takes the first 15 characters of each title, and adds ellipses after.

/* Another application would be to shorten the year that the book was released. Let's remove
the first two characters, and only display the last two, but with an apostraphe to signify the removal. */ 
SELECT 
    CONCAT('''', SUBSTR(released_year, - 2)) AS shortened_year
FROM
    books;
/* Our last application here will be to output just the author's initials, which can be done as follows */
SELECT 
    CONCAT(SUBSTR(author_fname, 1, 1),
            '. ',
            SUBSTR(author_lname, 1, 1),
            '.') AS author_initials
FROM
    books;
    
/* The REPLACE() function is used to replace parts of strings with other text. The input is always 
(string, part_to_replace, replace_with_this). Although this wouldn't be very helpful, we can replace all the spaces 
in the titles with hyphens using the following command: */
SELECT REPLACE(title,' ','-') FROM books;

-- The REVERSE() function takes a string, and outputs the reverse. 
SELECT REVERSE(author_fname) FROM books;

/* The CHAR_LENGTH() function outputs the character length of the inputted string. The LENGTH() function is similar, 
but outputs the length of the given string in bytes. For most english characters, they're the same, but for chinese characters,
they may not be the same. */ 
SELECT CHAR_LENGTH(title) FROM books; 
SELECT LENGTH(title) FROM books;
SELECT CHAR_LENGTH('木廿弓田');
SELECT LENGTH('木廿弓田');

/* The UPPER() and LOWER() functions take in a given string, and output the result as entirely uppercase or 
lowercase respectively. The UCASE() and LCASE() functions are used identically. */
SELECT UPPER(author_fname) FROM books;
SELECT LOWER(author_fname) FROM books;

/* Now I'll complete the final exercise in the section. This included a few complicated queries using the string 
functions that we've just learned. We'll make the following queries:
	1. Output a table of titles with all spaces replaced with '->'
    2. Output a table with the last name of each author, printed both forwards and backwards.
    3. Output a table with the full name of each author in ALL CAPS.
    4. Output a blurb table. The blurb should be of the form "The Namesake was released in 2003 by Jhumpa Lahiri."
    5. Output a table with the title of each book and the character count of each title.
    6. Output a table with a shortened title (with ellipses), the author name given in last,first form, and the quantity in stock. */

-- Problem 1 Query
SELECT REPLACE(title,' ','->') AS arrow_title FROM books;

-- Problem 2 Query
SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards FROM books;

-- Problem 3 Query
SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps' FROM books;

-- Problem 4 Query
SELECT CONCAT(title,' was released in ', released_year, ' by ', author_fname, ' ', author_lname) AS blurb FROM books;

-- Problem 5 Query
SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;

-- Problem 6 Query
SELECT 
	CONCAT(SUBSTR(title,1,15),'...') AS 'shortened title',
    CONCAT(author_lname, ' ', author_fname) AS 'author',
    CONCAT(stock_quantity,' in stock') AS 'quantity'
FROM books;