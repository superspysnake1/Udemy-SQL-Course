-- Create the database shirts.db
CREATE DATABASE shirts_db;
USE shirts_db;

/* This will create the shirts table within shirts.db. The table will include a primary key ID, 
the article type, the color, the size, and the last worn date. */
CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(50),
    color VARCHAR(50),
    shirt_size VARCHAR(5),
    last_worn INT
);

-- To confirm that the shirts table is created correctly.
DESC shirts;
 
-- Here we populate the shirts table with the provided data.
INSERT INTO shirts (article, color, shirt_size, last_worn)  
VALUES 
	('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 0),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);

-- Now we'll add the medium purple polo shirt last worn 50 days ago
INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('polo shirt','purple', 'M', 50);

-- Here we'll select all of the shirts, but only print out the article and color
SELECT article, color FROM shirts;

-- Here we'll select all medium shirts, and print out all info except the primary key
SELECT article, color, size, last_worn FROM shirts WHERE size='M';

/* Here we'll update the table as requested. All polo shirts are changed to large, 
the shirt last worn 15 days ago is changed to 0 days ago, and all white shirts are made XS and off-white. */ 
UPDATE shirts SET size='L' WHERE article='polo shirt';
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
UPDATE shirts SET size='XS', color='off-white' WHERE color='white';

/* Here are the given deletion requests. We delete all shirts last worn 200 days ago, delete all tank tops, 
and then delete the entire shirts table. Finally, we delete the entire shirts.db database */
DELETE FROM shirts WHERE last_worn=200;
DELETE FROM shirts WHERE article='tank-top';
DELETE FROM shirts;
DROP DATABASE shirts_db;