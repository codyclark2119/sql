-- Original DB: student
-- Original Table: tekcamp01
-- Creation of my database
CREATE DATABASE `tc1-Cody-Clark`;

-- Specify usage of db
USE `tc1-Cody-Clark`;

-- Create table for data
CREATE TABLE tekcampers
(
    id INT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    gender VARCHAR(1),
    education VARCHAR(20),
    PRIMARY KEY(id),
    FOREIGN KEY (hobby_id) REFERENCES hobbies(id)
);

-- Get data from original database
INSERT INTO tekcampers (id, first_name, last_name, gender, education) SELECT * FROM students.tekcamp01;

-- Inserting missing students but following original format for data for ease of movement
INSERT INTO tekcampers (id, first_name, last_name, gender, education) VALUES
    (28, "Aaron", "White", null, "M"),
    (29, "Cody", "Clark", null, "M"),
    (30, "Devon", "Brewster", null, "M"),
    (31, "Gotham", "Katta", null, "M"),
    (32, "John", "Bozarov", null, "M"),
    (33, "John", "Kol", null, "M"),
    (34, "Justin", "Cheng", null, "M"),
    (35, "Kevin", "Keesee", null, "M"),
    (36, "Monica", "Howard", null, "F"),
    (37, "Tyler", "Clements", null, "M"),
    (38, "Vimala", "Murthy", null, "F");

-- Deleting the any non-current students
DELETE FROM tekcampers WHERE first_name="Desaree";
DELETE FROM tekcampers WHERE first_name="Jake";
DELETE FROM tekcampers WHERE first_name="Rosa";

-- Moving null gender column to education and moving the gender values to the correct column
UPDATE tekcampers SET gender = education, education = null;

-- Fixing missing genders
UPDATE tekcampers SET gender="M" WHERE first_name="Gabe";
UPDATE tekcampers SET gender="F" WHERE first_name="Jessica";
UPDATE tekcampers SET gender="M" WHERE first_name="George";
UPDATE tekcampers SET gender="M" WHERE first_name="Michael";
UPDATE tekcampers SET gender="M" WHERE first_name="Christian";

-- Updating missing education for all names that dont repeat
UPDATE tekcampers SET education="High School" WHERE first_name in ("Kevin", "Zachary");
UPDATE tekcampers SET education="Some College" WHERE first_name in ("Devon", "Justin", "George", "Cody", "Marcelo", "Julian", "Christian", "Victor");
UPDATE tekcampers SET education="Associates" WHERE first_name in ("Phoenix", "Caleb");
UPDATE tekcampers SET education="Bachelors" WHERE first_name in ("Tyler", "John", "Katherine", "Sabitha", "Gotham", "Jessica", "Jose", "Adam", "Abigail");
UPDATE tekcampers SET education="Masters" WHERE first_name in ("Nancy", "Vimala");
UPDATE tekcampers SET education="Doctorate" WHERE first_name in ("Norita");

-- Set individual education for people with matching first names
UPDATE tekcampers SET education="Masters" WHERE first_name="Mathew" AND last_name="Choat";
UPDATE tekcampers SET education="Bachelors" WHERE first_name="Mathew" AND last_name="Castiglione";

-- Fixing incorrect data
UPDATE tekcampers SET first_name="Matthew" WHERE first_name="Mathew" AND last_name="Choat";
UPDATE tekcampers SET first_name="Matthew" WHERE first_name="Mathew" AND last_name="Castiglione";

-- Queries for
-- 1. Students whose last names are longer than 7 characters
SELECT * FROM tekcampers WHERE CHAR_LENGTH(last_name) > 7;
-- 2. Alphabatized by student's first name
SELECT * FROM tekcampers ORDER BY first_name asc;
-- 3. Alphabatized by student's last name
SELECT * FROM tekcampers ORDER BY last_name asc;
-- 4. Students that are male
SELECT * FROM tekcampers WHERE gender="M";
-- 5. Students that are female
SELECT * FROM tekcampers WHERE gender="F";
-- 6. Students that have a Masters degree
SELECT * FROM tekcampers WHERE education="Masters";
-- 7. Students that have a Bachelors degree
SELECT * FROM tekcampers WHERE education="Bachelors";
-- 8. Students that have an Associate degree
SELECT * FROM tekcampers WHERE education="Associates";
-- 9. Students that don't currently have a Higher Education Degree
SELECT * FROM tekcampers WHERE education IN ("High School", "Some College");

-- Create table for ta-mark with foreign key for student data relation
CREATE TABLE `ta-mark` (
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES tekcampers(id)
);
-- Migrating specific students to ta-mark table
INSERT INTO `ta-mark`
(student_id) VALUES
(8),(21),(23),(25),(27),(28),(29),(31),(32),(34),(35),(37);

-- Showing the students in ta-mark with full information
SELECT tekcampers.*
FROM tekcampers
    INNER JOIN `ta-mark`
ON tekcampers.id = `ta-mark`.student_id;

-- Create hobbies table
CREATE TABLE `hobbies` (
    id INT,
    name VARCHAR (100),
    PRIMARY KEY (id)
)
-- Creating a refrence list
INSERT INTO `hobbies`(id, name) VALUES
(1, "Reading"),
(2, "Motorcycle Riding"),
(3, "Video Games"),
(4, "Golfing"),
(5, "Cattle rustling"),
(6, "Gardening"),
(7, "Aerial yoga"),
(8, "Running"),
(9, "Working out"),
(10, "Pickle ball"),
(11, "Jiu Jitsu"),
(12, "Cooking"),
(13, "Eating"),
(14, "Listening to Music"),
(15, "Hockey"),
(16, "Soccer"),
(17, "Growing Hot Peppers"),
(18, "Longboarding");

-- Adding hobby id to tekcampers table with a null default
ALTER TABLE tekcampers 
ADD hobby_id Int null 
DEFAULT null;
-- Setting video game hobbies 
UPDATE tekcampers SET hobby_id=3 WHERE last_name IN ("Castiglione", "Keesee", "Torres");
-- Setting reading hobby 
UPDATE tekcampers SET hobby_id=1 WHERE last_name IN ("Swigert", "Betts");
-- Setting eating hobby
UPDATE tekcampers SET hobby_id=13 WHERE last_name IN ("Waters", "Cheng");
-- Setting soccer hobby
UPDATE tekcampers SET hobby_id=16 WHERE last_name IN ("Bozarov", "Moreno");
-- Setting individual hobbies 
UPDATE tekcampers SET hobby_id=2 WHERE last_name="Sieffert";
UPDATE tekcampers SET hobby_id=4 WHERE last_name="Rice";
UPDATE tekcampers SET hobby_id=5 WHERE last_name="Chavez";
UPDATE tekcampers SET hobby_id=6 WHERE last_name="Murthy";
UPDATE tekcampers SET hobby_id=7 WHERE last_name="Shane";
UPDATE tekcampers SET hobby_id=8 WHERE last_name="Katta";
UPDATE tekcampers SET hobby_id=9 WHERE last_name="Ibanez";
UPDATE tekcampers SET hobby_id=10 WHERE last_name="Ladd";
UPDATE tekcampers SET hobby_id=11 WHERE last_name="Barbosa";
UPDATE tekcampers SET hobby_id=12 WHERE last_name="Clark";
UPDATE tekcampers SET hobby_id=14 WHERE last_name="Ulysse";
UPDATE tekcampers SET hobby_id=15 WHERE last_name="Johnson";
UPDATE tekcampers SET hobby_id=18 WHERE last_name="Choat";
UPDATE tekcampers SET hobby_id=17 WHERE last_name="Clements";
UPDATE tekcampers SET hobby_id=19 WHERE last_name="Kim";
UPDATE tekcampers SET hobby_id=20 WHERE last_name="Radhakrishnan";

-- Adding Bootcamp field to tekcampers table
ALTER TABLE tekcampers 
ADD bootcamp VARCHAR(100) null 
DEFAULT null;
-- Setting bootcamp values 
UPDATE tekcampers SET bootcamp="Coding Dojo" WHERE last_name IN ("Rice", "Ladd", "Barbosa");
UPDATE tekcampers SET bootcamp="DevMountain" WHERE last_name IN ("Shane", "Johnson");
UPDATE tekcampers SET bootcamp="Trilogy Education" WHERE last_name IN ("Clark");

-- Setting all nulls to default values
UPDATE tekcampers SET hobby_id=0 WHERE hobby_id IS NULL;
UPDATE tekcampers SET education="N/A" WHERE education IS NULL;
UPDATE tekcampers SET bootcamp="N/A" WHERE bootcamp IS NULL;

-- Showing the students in ta-marks full information with hobbies and bootcamp information
SELECT tekcampers.*, hobbies.name
FROM tekcampers
    INNER JOIN `ta-mark`
ON tekcampers.id = `ta-mark`.student_id
INNER JOIN hobbies ON tekcampers.hobby_id = hobbies.id;