-- Drop and create the MusicDataBase
DROP DATABASE IF EXISTS MusicDataBase;
CREATE DATABASE MusicDataBase;
USE MusicDataBase;

-- 1. Create Listener table
DROP TABLE IF EXISTS Listener;
CREATE TABLE Listener (
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    userID INT(10) NOT NULL,
    userName VARCHAR(50) NOT NULL UNIQUE,
    userPassword VARCHAR(50) NOT NULL,
    PRIMARY KEY (userID)
);

-- 2. Create contentCreator table
DROP TABLE IF EXISTS contentCreator;
CREATE TABLE contentCreator (
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    userID INT(10) NOT NULL UNIQUE,
    numberFollowers INT(10),
    stageName VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (stageName)
);

-- 3. Create Song table
DROP TABLE IF EXISTS Song;
CREATE TABLE Song (
    songTitle VARCHAR(50) NOT NULL,
    musicType VARCHAR(50),
    length INT(10) NOT NULL,
    language VARCHAR(30),
    stageName VARCHAR(50) NOT NULL,
    songID INT(10) NOT NULL UNIQUE,
    ReleaseDate DATE NOT NULL,
    FOREIGN KEY (stageName) REFERENCES contentCreator(stageName),
    PRIMARY KEY (songID)
);

-- 4. Create Reviewer table
DROP TABLE IF EXISTS Reviewer;
CREATE TABLE Reviewer (
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    userID INT(10) NOT NULL UNIQUE,
    userName VARCHAR(50) NOT NULL UNIQUE,
    userPassword VARCHAR(50),
    PRIMARY KEY (userID)
);

-- 5. Create Review table
DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
    reviewID INT(5) NOT NULL,
    reviewContent VARCHAR(1000) NOT NULL,
    reviewScore INT(3),
    songID INT(10),
    userID INT(10),
    FOREIGN KEY (songID) REFERENCES Song(songID),
    FOREIGN KEY (userID) REFERENCES Reviewer(userID),
    PRIMARY KEY (reviewID)
);

-- Insert data into Listener
INSERT INTO Listener (FirstName, LastName, userID, userName, userPassword)
VALUES 
    ('Jon', 'Doe', 1, 'jdoe123', 'password123'),
    ('Jane', 'Doe', 2, 'janedoe456', 'password1234'),
    ('John', 'Smith', 3, 'jsmith123', 'password12345');

-- Insert data into contentCreator
INSERT INTO contentCreator (firstName, lastName, userID, numberFollowers, stageName)
VALUES 
    ('John', 'Rabbit', 1, 1980, 'One Direction'),
    ('Jane', 'Doesong', 2, 104500, 'Billie Eilish'),
    ('Alice', 'Wonderland', 46, 10530, 'Shaun');

-- Insert data into Song
INSERT INTO Song (songTitle, songID, length, musicType, stageName, ReleaseDate)
VALUES 
    ('What Makes You Beautiful', 57864, 350, 'pop', 'One Direction', '2011-08-12'),
    ('Lovely', 25759, 400, 'pop', 'Billie Eilish', '2018-06-10'),
    ('Way Back Home', 24753, 375, 'Electronic', 'Shaun', '2018-04-08');

-- Insert data into Reviewer
INSERT INTO Reviewer (FirstName, LastName, userID, userName)
VALUES 
    ('Niuikn', 'Tgftyvi', 9750, 'ytcdetghb'),
    ('Niuikn', 'Tgftyvi', 2546, 'ytcdetghb'),
    ('Niuikn', 'Tgftyvi', 1865, 'ytcdetghb');

-- Insert data into Review
INSERT INTO Review (reviewID, reviewContent, reviewScore, songID, userID)
VALUES 
    (57864, 'Worst song ever, lol', 100, 57864, 9750),
    (2, 'Made me cry tears of joy', 100, 25759, 2546),
    (3, 'Wowie', 90, 24753, 1865);

-- Create views
DROP VIEW IF EXISTS listenerView;
CREATE VIEW listenerView AS
SELECT userName, FirstName, LastName
FROM Listener;

DROP VIEW IF EXISTS contentCreatorView;
CREATE VIEW contentCreatorView AS
SELECT FirstName, LastName, stageName
FROM contentCreator;

DROP VIEW IF EXISTS reviewAndReviewer;
CREATE VIEW reviewAndReviewer AS
SELECT 
    r.userName, 
    rev.reviewScore, 
    s.songTitle
FROM 
    Review rev
JOIN 
    Reviewer r ON rev.userID = r.userID
JOIN 
    Song s ON rev.songID = s.songID;

-- Create stored procedures
DROP PROCEDURE IF EXISTS findArtist;
DELIMITER $$
CREATE PROCEDURE findArtist(IN artistName VARCHAR(15))
BEGIN
    SELECT stageName
    FROM contentCreator
    WHERE artistName = stageName;
END$$
DELIMITER ;

CALL findArtist('One Direction');

DROP PROCEDURE IF EXISTS findPositiveReviewsToMakeMeFeelBetter;
DELIMITER $$
CREATE PROCEDURE findPositiveReviewsToMakeMeFeelBetter(IN tuneName VARCHAR(150))
BEGIN
    SELECT 
        r.reviewScore, 
        s.songTitle, 
        r.reviewContent
    FROM 
        Review r
    JOIN 
        Song s ON r.songID = s.songID
    WHERE 
        r.reviewScore > 75 
        AND s.songTitle = tuneName;
END$$
DELIMITER ;

CALL findPositiveReviewsToMakeMeFeelBetter('What Makes You Beautiful');
