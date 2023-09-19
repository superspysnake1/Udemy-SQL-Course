# Udemy SQL Course
To start learning SQL, I'm working through an introductory SQL course. The course is titled "The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert", and can be found [here](https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert/).

## CRUD Basics
**Relevant Commands:** CREATE, DESC, INSERT, SELECT, FROM, UPDATE, SET, DELETE, DROP.

The first 7 sections in this course cover what they call "CRUD operations", which is Creating, Reading, Updating, and Deleting elements in the database. In the 7th course, labeled "CRUD Challenge", I've been assigned the following:
 - Create a database, shirts.db, and populate it with a shirts table including the provided data.
 - Add to the shirts table a medium purple polo shirt last worn 50 days ago.
 - Select all of the shirts, but only print out the article and color.
 - Select all medium shirts, and print out all info except the primary key.
 - Update all polo shirts to be size L.
 - Update the shirt last work 15 days ago to be worn 0 days ago.
 - Update all white shirts to be size XS with off-white color.
 - Delete all shirts last worn 200 days ago.
 - Delete all tank tops.
 - Delete all shirts.
 - Delete the entire shirts table.

**Code:** [CRUD_Basics.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/CRUD_Basics.sql).

## String Functions
**Relevant Commands:** CONCAT, CONCAT_WS, SUBSTR, REPLACE, REVERSE, LENGTH, CHAR_LENGTH, UPPER, LOWER.

The next section covers some important string functions that are used to modify the outputs. For the whole section, we use example data from a bookstore, and provided relevent explanations for why each function might be useful in context. At the top of this file, I have included the introductory practice and explanations of each function. Following that, I have included the final exercises and my solutions, which are summarized below:
 - Output a table of titles with all spaces replaced with '->'
 - Output a table with the last name of each author, printed both forwards and backwards.
 - Output a table with the full name of each author in ALL CAPS.
 - Output a blurb table. The blurb should be of the form "The Namesake was released in 2003 by Jhumpa Lahiri."
 - Output a table with the title of each book and the character count of each title.
 - Output a table with a shortened title (with ellipses), the author name given in last, first form, and the quantity in stock.

**Code:** [String_functions.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/String_Functions.sql)

## Selection Refinement
**Relevant Commands:** DISTINCT, ORDER BY, DESC, ASC, LIMIT, WHERE, LIKE.

This section covers different functions that we can use to refine the sections that we're making. This includes limiting the number of outputs, ordering them a certain way, only calling for unique elements, and more. At the top of the code file, I've included explanations and example with each command. Following that, I have included the final exercises and my solutions, which are summarized below:
 - Output a table of all books that contains 'stories' in the title.
 - Find the longest book. Output the title and page count.
 - Output a summary table containing the three most recent books in the form "Lincoln in the Bardo - 2017"
 - Find all books where the author's last name contains a space character.
 - Find the three books with the lowest stock.
 - Output a table of book titles and author last names sorted first by last name, then by title.
 - Output a table called 'yell', with entries like 'MY FAVORITE AUTHOR IS _____!' for each author. Remove duplicates.

**Code:** [Selection_Refinement.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/Selection_Refinement.sql)

## Aggregate Functions
**Relevant Commands:** COUNT, GROUP BY, MIN, MAX, SUM, AVG.

This section covers aggregate functions, which are used to get useful data about your selections. We can do numerical tasks, like counting, summing, or averaging a bunch of values. We can group the outputs by different unique elements in each column, and make more refined questions based on these groupings. I also learned here how to make subqueries, which can be really useful to find more info about max/min values and more. At the top of the code file, I've included explanations and example with each command. Following that, I have included the final exercises and my solutions, which are summarized below:
 - Print the total number of books in the database.
 - Print out how many books were release in each year.
 - Print out the total number of books in stock.
 - Print out the average release year for each author.
 - Find the full name of the author who wrote the longest book.
 - Output a table grouped by release year giving the number of books released during each year and the average page count of books released each year.

**Code:** [Aggregate_Functions.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/Aggregate_Functions.sql)
