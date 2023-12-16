-- For this assignment, the code begins at line 319.

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`cities` ;

CREATE TABLE IF NOT EXISTS `university`.`cities` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`colleges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`colleges` ;

CREATE TABLE IF NOT EXISTS `university`.`colleges` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`departments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`departments` ;

CREATE TABLE IF NOT EXISTS `university`.`departments` (
  `dept_code` VARCHAR(4) NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dept_code`),
  INDEX `fk_departments_colleges1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_departments_colleges1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`colleges` (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`courses` ;

CREATE TABLE IF NOT EXISTS `university`.`courses` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `dept_code` VARCHAR(4) NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_courses_departments1_idx` (`dept_code` ASC) VISIBLE,
  CONSTRAINT `fk_courses_departments1`
    FOREIGN KEY (`dept_code`)
    REFERENCES `university`.`departments` (`dept_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`teachers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`teachers` ;

CREATE TABLE IF NOT EXISTS `university`.`teachers` (
  `teachers_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`teachers_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`terms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`terms` ;

CREATE TABLE IF NOT EXISTS `university`.`terms` (
  `terms_id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR NOT NULL,
  `term` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`terms_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `section_number` INT NOT NULL,
  `capacity` INT NOT NULL,
  `terms_id` INT NOT NULL,
  `teachers_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_terms1_idx` (`terms_id` ASC) VISIBLE,
  INDEX `fk_section_teachers1_idx` (`teachers_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_teachers1`
    FOREIGN KEY (`teachers_id`)
    REFERENCES `university`.`teachers` (`teachers_id`),
  CONSTRAINT `fk_section_terms1`
    FOREIGN KEY (`terms_id`)
    REFERENCES `university`.`terms` (`terms_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`students` ;

CREATE TABLE IF NOT EXISTS `university`.`students` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('f', 'm') NOT NULL,
  `birthdate` DATE NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_students_cities` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_students_cities`
    FOREIGN KEY (`city_id`)
    REFERENCES `university`.`cities` (`city_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`section_has_students`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `section_id` INT NOT NULL,
  `student_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `student_id`),
  INDEX `fk_enrollment_students1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_enrollment_section1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_enrollment_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`),
  CONSTRAINT `fk_enrollment_students1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`students` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university`.`section_has_courses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section_has_courses` ;

CREATE TABLE IF NOT EXISTS `university`.`section_has_courses` (
  `section_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`section_id`, `course_id`),
  INDEX `fk_section_has_courses_courses1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_has_courses_section1_idx` (`section_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_courses_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_has_courses_courses1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`courses` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -------------------------------------------------------------------------------------------------------

INSERT INTO cities VALUES
	(1, "Dallas", "TX"),
	(2, "Provo", "UT"),
    (3, "Mesa", "AZ"),
    (4, "Topeka", "KS"),
    (5, "Rigby", "ID"),
    (6, "Bozeman", "MT"),
    (7, "Decatur", "TN"),
    (8, "Rexburg", "ID");
    
INSERT INTO colleges VALUES
	(1, "College of Physical Science and Engineering"),
    (2, "College of Business and Communication"),
    (3, "College of Language and Letters");
    
INSERT INTO departments VALUES
	("CIT", "Computer Information Technology", 1),
    ("ECON", "Economics", 2),
    ("HUM", "Humanities and Philosophy", 3);

INSERT INTO teachers VALUES
	(1, "Marty", "Morring"),
    (2, "Nate", "Nathan"),
    (3, "Ben", "Barrus"),
    (4, "John", "Jensen"),
    (5, "Bill", "Barney");
    
INSERT INTO terms VALUES
	(1, 2019, "Fall"),
    (2, 2018, "Winter");
    
INSERT INTO students VALUES
	(1, "Paul", "Miller", 'm', '1996-02-22', 1),
    (2, "Katie", "Smith", 'f', '1995-07-22', 2),
    (3, "Kelly", "Jones", 'f', '1998-06-22', 2),
    (4, "Devon", "Merrill", 'm', '2000-07-22', 3),
    (5, "Mandy", "Murdock", 'f', '1996-11-22', 4),
    (6, "Alece", "Adams", 'f', '1997-05-22', 5),
    (7, "Bryce", "Carlson", 'm', '1997-11-22', 6),
    (8, "Preston", "Larsen", 'm', '1996-09-22', 7),
    (9, "Julia", "Madsen", 'f', '1998-09-22', 8),
    (10, "Susan", "Sorensen", 'f', '1998-08-09', 3);
    
INSERT INTO section VALUES
	(1, 1, 30, 1, 1),
    (2, 1, 50, 1, 2),
    (3, 2, 50, 1, 2),
    (4, 1, 35, 1, 3),
    (5, 1, 30, 1, 4),
    (6, 2, 30, 2, 1),
    (7, 3, 35, 2, 5),
    (8, 1, 50, 2, 2),
    (9, 2, 50, 2, 2),
    (10, 1, 30, 2, 4);
    
INSERT INTO courses VALUES
	(1, 111, "Intro to Databases", 3, "CIT"),
    (2, 388, "Econometrics", 4, "ECON"),
    (3, 150, "Micro Economics", 3, "ECON"),
    (4, 376, "Classical Heritage", 2, "HUM");
    
INSERT INTO section_has_courses VALUES
	(1, 1),
    (2, 3),
    (3, 3),
    (4, 2),
    (5, 4),
    (6, 1),
    (7, 1),
    (8, 3),
    (9, 3),
    (10, 4);
    
INSERT INTO enrollment VALUES
	(7, 6),
    (6, 7),
    (8, 7),
    (10, 7),
    (5, 4),
    (9, 9),
    (4, 2),
    (4, 3),
    (4, 5),
    (5, 5),
    (1, 1),
    (3, 1),
    (9, 8),
    (6, 10);
    
    -- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Query 1: Students, and their birthdays, of students born in September. Format the date to look like it is shown in the result set. Sort by the student's last name.

USE university;

SELECT first_name AS fname, last_name AS lname, DATE_FORMAT(birthdate, '%M %e, %Y') AS "Sept Birthdays"
FROM students
WHERE MONTH(birthdate) = 9
ORDER BY lname;

-- Query 2: Student's age in years and days as of Jan. 5, 2017.  Sorted from oldest to youngest.
-- (You can assume a 365 day year and ignore leap day.) Hint: Use modulus for days left over after years.
-- The 5th column is just the 3rd and 4th column combined with labels.

USE university;

SELECT last_name AS fname, last_name AS lname, TIMESTAMPDIFF(YEAR, birthdate, "2017-01-05") AS Years, TIMESTAMPDIFF(DAY, birthdate, "2017-01-05") % 365 AS Days, 
CONCAT(TIMESTAMPDIFF(YEAR, birthdate, "2017-01-05"), " - Yrs ", TIMESTAMPDIFF(DAY, birthdate, "2017-01-05") % 365, " - Days") AS "Years and Days"
FROM students
ORDER BY Years DESC, Days DESC;

-- Query 3: Students taught by John Jensen. Sorted by student's last name

USE university;

SELECT first_name AS fname, last_name AS lname
FROM students s
	JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN teachers t
		ON se.teachers_id = t.teachers_id
WHERE faculty_fname = "John"AND faculty_lname = "Jensen"
ORDER BY last_name;

-- Query 4:   Instructors Bryce will have in Winter 2018. Sort by the faculty's last name.

USE university;

SELECT faculty_fname AS fname, faculty_lname AS lname
FROM teachers t
	JOIN section se
		ON t.teachers_id = se.teachers_id
	JOIN enrollment e
		ON se.section_id = e.section_id
	JOIN students s
		ON e.student_id = e.student_id
	JOIN terms te
		ON se.terms_id = te.terms_id
WHERE e.student_id = 7 AND te.terms_id = 2
GROUP BY se.section_id
ORDER BY faculty_lname;

-- Query 5: Students that take Econometrics in Fall 2019. Sort by student last name.

USE university;

SELECT first_name AS fname, last_name AS lname
FROM students s
	JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN section_has_courses shc
		ON se.section_id = shc.section_id
	JOIN courses c
		ON shc.course_id = c.course_id
WHERE c.course_id = 2
ORDER BY last_name;

-- Query 6: Report showing all of Bryce Carlson's courses for Winter 2018. Sort by the name of the course.

USE university;

SELECT d.dept_code, course_num, course_title AS name
FROM departments d
	JOIN courses c
		ON d.dept_code = c.dept_code
	JOIN section_has_courses shc
		ON c.course_id = shc.course_id
	JOIN section s
		ON shc.section_id = s.section_id
	JOIN terms t
		ON s.terms_id = t.terms_id
	JOIN enrollment e
		ON s.section_id = e.section_id
WHERE e.student_id = 7 AND t.terms_id = 2
ORDER BY name;

-- Query 7: The number of students enrolled for Fall 2019

USE university;

SELECT term, year, COUNT(student_id) AS Enrollment
FROM terms t
	JOIN section s
		ON t.terms_id = s.terms_id
	JOIN enrollment e
		ON s.section_id = e.section_id
WHERE t.terms_id = 1
GROUP BY t.terms_id;

-- Query 8: The number of courses in each college. Sort by college name.

USE university;

SELECT college_name AS Colleges, COUNT(course_id) AS Courses
FROM colleges co
	JOIN departments d
		ON co.college_id = d.college_id
	JOIN courses c
		ON d.dept_code = c.dept_code
GROUP BY co.college_id
ORDER BY college_name;

-- Query 9: The total number of students each professor can teach in Winter 2018. Sort by that total number of students (teaching capacity).

USE university;

SELECT faculty_fname AS fname, faculty_lname AS lname, SUM(capacity) AS TeachingCapacity
FROM teachers t
	JOIN section s
		ON t.teachers_id = s.teachers_id
	JOIN terms ter
		ON s.terms_id = ter.terms_id
WHERE ter.terms_id = 2
GROUP BY t.teachers_id
ORDER BY TeachingCapacity;

-- Query 10: Each student's total credit load for Fall 2019, but only students with a credit load greater than three.  Sort by credit load in descending order. 

USE university;

SELECT first_name AS fname, last_name AS lname, SUM(credits) AS Credits
FROM students s
	JOIN enrollment e
		ON s.student_id = e.student_id
	JOIN section se
		ON e.section_id = se.section_id
	JOIN section_has_courses shc
		ON se.section_id = shc.section_id
	JOIN courses c
		ON c.course_id = shc.course_id
	JOIN terms t
		ON se.terms_id = t.terms_id
WHERE t.terms_id = 1
GROUP BY s.student_id
HAVING credits > 3
ORDER BY Credits;