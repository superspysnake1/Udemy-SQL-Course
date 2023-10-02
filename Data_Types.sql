/* In this section, we'll get a bit more detailed about the similarities and differences between a bunch of data types.
We'll start by making a new database to house these tests. Then we'll make a few different tables for each example. */
CREATE DATABASE Data_Types_db;
USE Data_Types_db;

/* We'll start with the following data types: CHAR, VARCHAR 
	The CHAR datatype takes in strings of a specified length. The data is stored in a fixed size, so it is best used 
    when you know how many characters will be used. When calling the type, you give the length of the string stored
    (e.g. CHAR(length)). Shorter strings will be padded with spaces that are removed when called back. For our example, 
    since state abbreviations are all a fixed 2 characters, it will be most efficient to store it in CHAR(2). 
    
    The VARCHAR datatype takes in strings of a variable length. The data is stored with variable lengths, so for each given 
    length, the CHAR type will be more efficient, but for variable data, it is vasty more efficient overall. When calling 
    the type, you give the maximum length of each value (e.g. VARCHAR(max_length)). For our example, the state names kave
    large variaety in lengths, so we'll use VARCHAR(50) to provide a generous maximum. 
*/
CREATE TABLE States (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    State_Name VARCHAR(50),
    State_Abbrev CHAR(2)
);

/* Next up are the following data types: TINYINT, SMALLINT, MEDIUMINT, INT, BIGINT 
These are the integer data types. They use 1, 2, 3, 4, and 8 bytes respectively. See the reference manual for exact max/mins.
https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert/learn/lecture/34511736#overview

For the state table, we'll use INT to store state population, TINYINT to store number of state representatives, and MEDIUMINT to 
store the area of each state in square miles.
*/

ALTER TABLE States
ADD COLUMN Population_Size INT,
ADD COLUMN Federal_Representatives_Count TINYINT,
ADD COLUMN State_Area MEDIUMINT;

/* Next up are the following data types: DECIMAL, FLOAT, DOUBLE
The DECIMAL data type is used to store entries with known precision. When calling the type, you give the length of the number stored,
and the number of decimal places (e.g. DECIMAL(size, decimal_length)).

The Float and double are used for variable number storage. Floats use 4 bytes, and doubles use 8 bytes. For the states example, we
can use FLOAT for all of our purposes. We'll store the median salary, 
*/

ALTER TABLE States
ADD COLUMN Median_Salary FLOAT;

/* Next up are the following data types: DATE, TIME, DATETIME, CURDATE, CURTIME, NOW
The DATE data type stores dates in YYYY-MM-DD format. The time stores time in a HH:MM:SS format. It can be used to either store 
time of day, or just time amounts, which can go up to HHH:MM:SS. The DATETIME type combines the two. CURDATE, CURTIME, and NOW
are called when you want to take the current date, time, or date and time respectively when a new row is added.

For the states example, we can use the DATE type to store the state ratification date. 
*/

ALTER TABLE States
ADD COLUMN Ratification_Date DATE;