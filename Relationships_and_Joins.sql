/* Since data as a whole can be incredibly diverse, and can be organised in
many different ways, it's important to understand the different ways that we
can implement these connections in SQL. These connections can be organised into 
3 types.
	1. One to One Relationship
Although this is the simplest data relationship, it doesn't need to be used very 
often. A simple example using this relationship is a website that wants to seperate 
the user login information and the user details. They would want to make sure that each
row in the login information table has an equialent row in the user details table.
    2. Many to One Relationship
Consider a bookstore storing both books and reviews. They will need a table storing 
every book in their inventory, and another table storing the reviews. Each review 
is associated with a single book, but each book could have thousands of reviews. 
    3. Many to Many Relationship
Consider a bookstore storing both author details and book details. They will need a table
storing every book in their inventory and another for every author they store. Each book
can be associated with many different authors (though they don't have to) and each author 
can be associated with many books. */

/* In order to implement a one-to-one or one-to-many relationship, it's important to
understand both primary keys and foreign keys. Primary keys were covered previously
in the course, which when added to a data column turns it into a unique incrementing 
identifier for each addition. Foreign keys can then be used to ensure that a column in 
one table must match an element from a column in another table. */

/* We'll start by defining the tables. Note how the customer_id column in the orders 
table is associated with the id column in the custuers table through the FOREIGN KEY.
This means that only values that have a corresponding value in the custumers table can
be entered into the orders table. */
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT, 
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
 
 /* Now let's populate it with some data. Note that the custumers table has 5 rows, 
 so the id column will incrememnt up to 5. For the addition to the orders table, only 
 the values 1-5 can be entered. */ 
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);
       
-- This results in an an error because 256 is not a valid custumer id.
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2015-03-22', 33.67, 256);

/* Now that we've split our data up, we've introduced a small problem for ouselves. 
Although our data is stored very effeciently, accessing all the data together will be 
a bit more difficult. Say we want to know about all the orders from a certain custumer 
along with their information. */

-- This option allows us to isolate a given users orders, but no info is givien with it.
SELECT * FROM orders 
WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George');
 
/* What we will ultimately want to do to combine this information together is called 
a join. There are three main join types which will be covered in this course, which 
can be visualized nicely with venn-diagrams (Let A be table 1, and B be table 2.) 
	1. Inner Joins
An inner join will include all data from both A and B as long as a given condition is met.
Think the intersection of the venn-diagram.
    2. Left Joins
A left join will include all data from A along with matching data from B.
    3. Right Joins
A right join will include all data from B alont with matching data from A. */

/* We'll first work with the inner join. Here, we want to join the customers and orders tables 
together. The first line says what table we want to start with, and the second says the table
we want to join along with the condition for how they'll get joined together. Here we're only 
connecting orders where the customer_id entry in the orders table matches the id entry in the 
customers table. */
SELECT * FROM customers
JOIN orders ON orders.customer_id = customers.id;
 
 /* We can make that table more compact by only choosing the specific columns we want. Notice how
 the columns chosen after SELECT are from either the custoers or orders table. If there are duplicate
 column names across tables, you can specify using the format table_name.column_name. */
SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders ON orders.customer_id = customers.id;
 
/* Note how changing the order or the customers and orders tables in the command will
not change what data is returned, but it will change the order in which it is displayed.
The first table will get priority. */
SELECT * FROM orders
JOIN customers ON customers.id = orders.customer_id;

-- Here's a more complicated example that is grouped by name and sorted by total order amounts.
SELECT first_name, last_name, SUM(amount) AS total FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY first_name, last_name
ORDER BY total;

/* Now well look at the left join. Thinking of a venn-diagram with A being on the left and B being on 
the right, a left join takes all the data in table A and all the corresponding data from table B
appended based on a given correspondence rule. Notice how in the first command, we're starting with 
the customers table, and adding on all corresponding order information. With the second, we start with
every order, and add on the corresponding custumer information.  */
SELECT first_name, last_name, order_date, amount FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id;

SELECT order_date, amount, first_name, last_name FROM orders 
LEFT JOIN customers ON orders.customer_id = customers.id;

/* Here is a more complicated example using the left join. We can start with the customers table, 
calculate the total amount spent for each customer, and join the corresponding order data. */ 
SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS money_spent FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name;

/* Finally we'll look at the right join. Thinking of a venn-diagram with A being on the left and B being on 
the right, a right join takes all the data in table B and all the corresponding data from table A
appended based on a given correspondence rule. For the bookstore example, doing a right join on the orders
table will actually not result in anything different than a regular join. This is because every order is
required to have a custumer_id associated with it, so there can't be an order without custumer info.  */
SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

/* Although we wouldn't want to do this in a real order table, we can add in an element with a NULL
customer_id value. This will better allow us to see the differences between the two joins. */
INSERT INTO orders (amount, order_date) VALUES (100, CURDATE());

SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

/* Before we get to the exercises, we'll cover what happens when data gets deleted with foreign keys. Notice how in the following command, when we
try to delete the user 'George', we get the following error:
'Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails' */
DELETE FROM customers WHERE last_name = 'George';

/* There are lots of different ways to deal with this that are all useful in their own way. The simplest is to simply delete the data that would then 
become invalid. This can be done by adding the ON DELETE CASCADE command to the FOREIGN KEY in the orders table. This will then allow you to delete any
customer you want, and their information will then be removed from the orders table as well! */
DROP TABLE orders;
DROP TABLE customers;

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);
 
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8 , 2 ),
    customer_id INT,
    FOREIGN KEY (customer_id)
        REFERENCES customers (id)
        ON DELETE CASCADE
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

-- Now when george is deleted, his order data is also deleted. 
DELETE FROM customers WHERE last_name = 'George';
SELECT * FROM customers;
SELECT * FROM orders;

/* To finish this section, complete the following exercises:
	1. Make the following table schema. There should be a students table with an id and 
    first_name columns. There should also be a papers table with title, grade, and student_id 
    columns. Here the student_id should be an id that is found in the students table.
	2. Write the command to generate the first output provided in the video.
	3. Write the command to generate the second output provided in the video.
	4. Repeat the second output but with missing titles replaces with 'MISSING' and missing grades 
    replaced with '0'.
	5. Select an output table that included the first name of every student, and the average grade 
    they've recieved on their papers. Relace missing grades with '0'.
	6. From the same table in problem 5, add a column where you state whether or not they passed the 
    course, with 75% being the cutoff grade.  */

-- Here I create the student and papers table. 
CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50)
);
	
CREATE TABLE papers (
	title VARCHAR(250),
    grade DECIMAL(8,2),
    student_id INT, 
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Now we'll populate our tables with sample data
INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT * FROM students;
SELECT * FROM papers;

-- Problem 2 selection
SELECT first_name, title, grade FROM papers
JOIN students ON papers.student_id = students.id
ORDER BY grade DESC;

-- Problem 3 selection
SELECT first_name, title, grade FROM students
LEFT JOIN papers ON papers.student_id = students.id;

-- Problem 4 selection
SELECT first_name, IFNULL(title, 'MISSING') AS 'title', IFNULL(grade, 0)AS 'grade' FROM students
LEFT JOIN papers ON papers.student_id = students.id;

-- Problem 5 selection
SELECT first_name, IFNULL(AVG(grade),0) AS 'average_grade' FROM students
LEFT JOIN papers ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average_grade DESC;

-- Problem 6 selection
SELECT 
	first_name, 
	IFNULL(AVG(grade),0) AS 'average_grade', 
    CASE
		WHEN IFNULL(AVG(grade), 0) >= 75 THEN 'passing'
        ELSE 'failing' 
        END AS passing_status
FROM students
LEFT JOIN papers ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average_grade DESC;