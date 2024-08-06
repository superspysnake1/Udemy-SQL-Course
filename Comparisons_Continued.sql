/* Using the UNIQUE operator, you can require that a column only hold 
unique values. If you attempt to add a duplicate value, you will get 
an error and it will fail to be added. */

CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);
 
INSERT INTO contacts (name, phone)
VALUES ('john', '8781213455');
 
-- This insert would result in an error, due to the duplicate phone number. 
INSERT INTO contacts (name, phone)
VALUES ('diana', '8781213455');

/* The CHECK operator allows you to make more broad constraints on what 
valid inputs to a column can be. The following is a simple example where 
the age must be larger than 18.  */
CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 18)
);
 
 -- This example works just fine.
INSERT INTO users (username, age)
VALUES ('username1', '19');

-- This example cannot be added since the age is less than 18.
INSERT INTO users (username, age)
VALUES ('username1', '17');

/* This example does a better job showing the flexibility of the CHECK oporator. 
Here the palindromes table will only accept an input if the REVERSE of the word is
equivalent to the word itself.  */
CREATE TABLE palindromes (
  word VARCHAR(100) CHECK(REVERSE(word) = word)
);

-- This input will work.
INSERT INTO palindromes (word)
VALUES ('racecar');

-- This input will not work.
INSERT INTO palindromes (word)
VALUES ('palindrome');

/* You may have noticed that when you try to enter an invalid value into a column, 
you get an error message like the following:

"Error Code: 3819. Check constraint 'users_chk_1' is violated."

It would be nicer if this message could at least give us a bit more information on 
what exactly went wrong. We can do this by changing the name of the CONSTRAINT. */

CREATE TABLE users2 (
	username VARCHAR(20) NOT NULL,
    age INT, 
    CONSTRAINT age_not_negative CHECK (age > 0)
);

-- Now if we add an invalid value, the error message displays the name of the error.
INSERT INTO users2 (username, age)
VALUES ('chickenlady', -9);

/* These CONSTRAINTs can also be used to compare multiple columns. In this example, 
we have a houses sales database, which can only accept sales where the purchase price
is less than the sale price. */
CREATE TABLE houses (
	purchase_price INT NOT NULL,
    sale_price INT NOT NULL,
    CONSTRAINT sale_price_gt_purchase_price CHECK (sale_price >= purchase_price)
);

-- This works
INSERT INTO houses (purchase_price, sale_price)
VALUES (100000, 120000);

-- This doesn't work
INSERT INTO houses (purchase_price, sale_price)
VALUES (120000, 100000);

/* The last major piece we'll do in this chapter is to learn about ALTER TABLE. 
This command will allow us to change any part of an existing table. We'll start with 
a small database named 'companies'. */
CREATE TABLE companies (
	name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL
);

INSERT INTO companies (name, address) VALUES 
('blackbird auto', '123 spruce'), 
('luigis pies', '567 main');

/* First we'll add a new column into the table. */
ALTER TABLE companies
ADD COLUMN phone VARCHAR(15);
INSERT INTO companies 
VALUES ('mud bay', '23 holly', '1234567890');

/* Notice that when you add a new column, all the rows that originally did 
not have entries for that column will be entered by default as NULL. Alternatively
you can require it be NOT NULL, which will give them each the smallest value of its 
type (0 for INT, '' for VARCHAR). Similarly, you can set a default value using the
DEFAULT operator. */ 
ALTER TABLE companies
ADD COLUMN ceo_name VARCHAR(50) NOT NULL,
ADD COLUMN employee_count INT DEFAULT 1;

/* The ALTER TABLE command can also be used to drop a column. All data held in those
columns will be permanently deleted, so be careful! */
ALTER TABLE companies
DROP COLUMN employee_count;

/* Another function of the ALTER TABLE command is to rename tables and columns. An entire
table can be renamed as follows. Note that this shows two different command options that
have equivaluent outputs, the second is just shortened. */
ALTER TABLE companies
RENAME TO suppliers;

RENAME TABLE suppliers TO companies;

-- Column names can be altered using the RENAME COLUMN command.
ALTER TABLE companies
RENAME COLUMN name TO company_name;

/* Similarly, column definitions can be modified using the MODIFY COLUMN command. This 
changes the company_name column so that it has a larger input and has a new default. */
ALTER TABLE companies
MODIFY COLUMN company_name VARCHAR(255) DEFAULT 'unknown';

-- Now when we add something without a name, it will be added as 'unknown'.
INSERT INTO companies (address, ceo_name)
VALUES ('255 Rose Ln', 'John Doe');

SELECT * FROM companies;

/* The last piece that I show here (but not the full functionality of ALTER TABLE) is 
going to be how to add/alter constriants on a table. This example will show adding
a constraint that the phone number nust be 10 characters long. */ 
ALTER TABLE companies 
ADD CONSTRAINT phone_number_length CHECK (LENGTH(phone) >= 0);

-- Constraint can be dropped just as easily as they were added!
ALTER TABLE companies DROP CONSTRAINT phone_number_length;
