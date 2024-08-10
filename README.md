# Udemy SQL Course

To start learning SQL, I'm working through an introductory SQL course. The course is titled "The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert".

**Useful Links**

[MySQL Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/char.html)

[Course Landing Page](https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert/)

[Course Videos](https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert/learn/lecture/34511736#overview)

## CRUD Basics

**Relevant Commands:** CREATE, DESC, INSERT, SELECT, FROM, UPDATE, SET, DELETE, DROP.

The first 7 sections in this course cover what they call "CRUD operations", which is Creating, Reading, Updating, and Deleting elements in the database. In the 7th course, labeled "CRUD Challenge", I've been assigned the following:
 1. Create a database, shirts.db, and populate it with a shirts table including the provided data.
 2. Add to the shirts table a medium purple polo shirt last worn 50 days ago.
 3. Select all of the shirts, but only print out the article and color.
 4. Select all medium shirts, and print out all info except the primary key.
 5. Update all polo shirts to be size L.
 6. Update the shirt last work 15 days ago to be worn 0 days ago.
 7. Update all white shirts to be size XS with off-white color.
 8. Delete all shirts last worn 200 days ago.
 9. Delete all tank tops.
 - Delete all shirts.
 - Delete the entire shirts table.

**Code:** [CRUD_Basics.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/CRUD_Basics.sql).

## String Functions

**Relevant Commands:** CONCAT, CONCAT_WS, SUBSTR, REPLACE, REVERSE, LENGTH, CHAR_LENGTH, UPPER, LOWER.

The next section covers some important string functions that are used to modify the outputs. For the whole section, we use example data from a bookstore, and provided relevent explanations for why each function might be useful in context. At the top of this file, I have included the introductory practice and explanations of each function. Following that, I have included the final exercises and my solutions, which are summarized below:
 1. Output a table of titles with all spaces replaced with '->'
 2. Output a table with the last name of each author, printed both forwards and backwards.
 3. Output a table with the full name of each author in ALL CAPS.
 4. Output a blurb table. The blurb should be of the form "The Namesake was released in 2003 by Jhumpa Lahiri."
 5. Output a table with the title of each book and the character count of each title.
 6. Output a table with a shortened title (with ellipses), the author name given in last, first form, and the quantity in stock.

**Code:** [String_functions.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/String_Functions.sql)

## Selection Refinement

**Relevant Commands:** DISTINCT, ORDER BY, DESC, ASC, LIMIT, WHERE, LIKE.

This section covers different functions that we can use to refine the sections that we're making. This includes limiting the number of outputs, ordering them a certain way, only calling for unique elements, and more. At the top of the code file, I've included explanations and example with each command. Following that, I have included the final exercises and my solutions, which are summarized below:
 1. Output a table of all books that contains 'stories' in the title.
 2. Find the longest book. Output the title and page count.
 3. Output a summary table containing the three most recent books in the form "Lincoln in the Bardo - 2017"
 4. Find all books where the author's last name contains a space character.
 5. Find the three books with the lowest stock.
 6. Output a table of book titles and author last names sorted first by last name, then by title.
 7. Output a table called 'yell', with entries like 'MY FAVORITE AUTHOR IS _____!' for each author. Remove duplicates.

**Code:** [Selection_Refinement.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/Selection_Refinement.sql)

## Aggregate Functions

**Relevant Commands:** COUNT, GROUP BY, MIN, MAX, SUM, AVG.

This section covers aggregate functions, which are used to get useful data about your selections. We can do numerical tasks, like counting, summing, or averaging a bunch of values. We can group the outputs by different unique elements in each column, and make more refined questions based on these groupings. I also learned here how to make subqueries, which can be really useful to find more info about max/min values and more. At the top of the code file, I've included explanations and example with each command. Following that, I have included the final exercises and my solutions, which are summarized below:
 1. Print the total number of books in the database.
 2. Print out how many books were release in each year.
 3. Print out the total number of books in stock.
 4. Print out the average release year for each author.
 5. Find the full name of the author who wrote the longest book.
 6. Output a table grouped by release year giving the number of books released during each year and the average page count of books released each year.

**Code:** [Aggregate_Functions.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c81bf36181fcaae221b4093f1d586118763f418d/Aggregate_Functions.sql)

## Data Types

**Relevant Types:** CHAR, VARCHAR, INT, TINYINT, BIGINT, DECIMAL, FLOAT, DOUBLE, DATE, TIME, CURDATE, CURTIME, NOW.

In this section, we covered the most important data types. I wrote quick explanations of what makes each type useful, and how they're most effeciently implemented. 

**Code:** [Data_Types.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/6adbacbf9f299f420f33b60b07f3cdc0cfbcfb8a/Data_Types.sql)

## Comparison and Logical Operators

**Relevant Commands:** AND, OR, XOR, NOT, BETWEEN, IN, CASE, IS NULL.

This section covers logical operators and comparison, which allows us to get more specific about our data selection. We cover logical operators, which act the same as discrete mathematics. At the top of the code file, I've included explanations and example with each command. Following that, I have included the final exercises and my solutions, which are summarized below:
 1. Select all books written before 1980 (non inclusive)
 2. Select all books written by Eggers or Chabon
 3. Select all books written by Lahiri published after 2000.
 4. Select all books with page counts between 100 and 200.
 5. Select all books whos author's last name starts with a 'C' or an 'S'.
 6. Make a selection including the title, author-s last name, and a 'Type' column, which contains 'Short Stories' if the entry contains 'stories' in the title, 'Memoir' if the title is ''Just Kids' of 'A Heartbreaking Work of Staggering Genius', and 'Novel' for everything else.
 7. Make a selection including each unique author full name, and a 'Count' column which has the total number of books they have each published.

**Code:** [Comparison_and_Logic.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/0be541846260149c907cf256b0321fa9680102db/Comparison_and_Logic.sql)

## Comparisons Continued and Table Changes

**Relevant Commands:** UNIQUE, CHECK, CONSTRAINT, ALTER TABLE (ADD, DROP, RENAME TO, MODIFY)

This section covers additional comparison tools, along with how to change the details of table definitions. I've included explanations and examples with each command.

**CODE:** [Comparisons_Continued.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/85ef34b7dfb27b6d03fcfafc90ae9f0925035dc2/Comparisons_Continued.sql)

## Relationships and Joins

**Relevant Commands:** FOREIGN KEY, REFERENCES, JOIN, LEFT JOIN, RIGHT JOIN

This section covers different kinds of data relationships like one-to-one, one-to-many, and many-to-many. These can be implemented into tables using foreign keys. It also coverers the inner join, left join, and right join.

At the end of this course, I completed the following exercises:
1. Make the following table schema. There should be a students table with an id and first_name columns. There should also be a papers table with title, grade, and student_id columns. Here the student_id should be an id that is found in the students table.
2. Write the command to generate the first output provided in the video.
3. Write the command to generate the second output provided in the video.
4. Repeat the second output but with missing titles replaces with 'MISSING' and missing grades replaced with '0'.
5. Select an output table that included the first name of every student, and the average grade they've recieved on their papers. Relace missing grades with '0'.
6. From the same table in problem 5, add a column where you state whether or not they passed the course, with 75% being the cutoff grade. 

**CODE:** [Relationships_and_Joins.sql](https://github.com/superspysnake1/Udemy-SQL-Course/blob/c14149d6d58b33727b77df3bb256dcc139eb3381/Relationships_and_Joins.sql)


