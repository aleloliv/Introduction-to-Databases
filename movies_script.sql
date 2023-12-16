CREATE DATABASE mdb;

USE mdb;

CREATE TABLE actors (actor_id INT NOT NULL AUTO_INCREMENT, 
	last_name VARCHAR(30) NOT NULL,
	first_name VARCHAR(25) NOT NULL,
    PRIMARY KEY(actor_id));
    
SELECT * FROM actors;

INSERT INTO actors VALUES
	(NULL, "Hanks", "Tom"),
    (NULL, "Allen", "Tim");
    
INSERT INTO actors VALUES
	(DEFAULT, "Potts", "Annie");
    
INSERT INTO actors (last_name, first_name) VALUES 
	("Fisher", "Carrie");
    
CREATE TABLE movies (movie_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(45) NOT NULL,
    rating ENUM("G", "PG", "PG 13"),
    r_year YEAR NOT NULL,
    studio VARCHAR(45),
    PRIMARY KEY(movie_id));
    
SELECT * FROM movies;

INSERT INTO movies VALUES
	(DEFAULT, "Star Wars: Episode V The Empire Strikes Back", "PG", 1980, "Lucasfilm Ltd.");
    
INSERT INTO movies VALUES
	(DEFAULT, "Toy Story", "G", 1995, "Pixar");
    
UPDATE actors
SET first_name = "Tommy"
WHERE actor_id = 1;

DELETE FROM actors
WHERE actor_id = 1;

DROP TABLE actors;

DROP DATABASE mdb;

INSERT INTO actors VALUES
	(1, "Hanks", "Tom"),
    (2, "Allen", "Tim"),
    (3, "Potts", "Annie"),
    (4, "Fisher", "Carrie"),
    (5, "Hamill", "Mark"),
    (6, "Ford", "Harrison");
    
INSERT INTO movies VALUES
	(1, "Toy Story", "G", 1995, "Pixar"),
    (2, "Toy Story 3", "PG", 2010, "Pixar"),
    (3, "Star Wars", "PG", 1977, "Lucasfilm Ltd");
    
INSERT INTO cast VALUES
	(1, 1), -- Tom Hanks in Toy Story
    (2, 1), -- Tom Hanks in Toy Story 3
    (1, 2), -- Tim Allen in Toy Story
    (2, 2), -- Tim Allen in Toy Story 3
    (1, 3), -- Annie Potts in Toy Story
    (3, 4), -- Carrie Fisher in Star Wars
    (3, 5), -- Mark Hamill in Star Wars
    (3, 6); -- Harrison Ford in Star Wars
    
SELECT * FROM cast;