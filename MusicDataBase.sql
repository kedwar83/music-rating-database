DROP DATABASE IF EXISTS MusicDataBase;
CREATE DATABASE MusicDataBase;
USE MusicDataBase;

DROP TABLE IF EXISTS Listener;
CREATE TABLE Listener (
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
userID INT(10) NOT NULL,
userName VARCHAR(50) NOT NULL,
userPassword VARCHAR(50) NOT NULL,
PRIMARY KEY (userID)
);
CREATE UNIQUE INDEX Listener_name
ON Listener (userName);

DROP TABLE IF EXISTS contentCreator;
CREATE TABLE contentCreator (
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    userID INT(10) NOT NULL UNIQUE,
    numberFollowers INT(10),
    stageName VARCHAR(50) NOT NULL,
    PRIMARY KEY (stageName)
);
CREATE UNIQUE INDEX contentCreator_name
ON contentCreator (stageName);
SELECT * FROM contentCreator;

DROP TABLE IF EXISTS Song;
CREATE TABLE Song (
songTitle VARCHAR(50) NOT NULL,
musicType VARCHAR(50),
length int(10) NOT NULL,
language VARCHAR(30),
stageName VARCHAR(50) NOT NULL,
FOREIGN KEY (stageName) REFERENCES contentCreator(stageName),
songID INT(10) NOT NULL UNIQUE,
PRIMARY KEY (SongID),
ReleaseDate DATE NOT NULL
);

CREATE UNIQUE INDEX Song_name
ON Song (songTitle, ReleaseDate);
SELECT * FROM Song;

DROP TABLE IF EXISTS Reviewer;
CREATE TABLE Reviewer (
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
userID INT(10) NOT NULL UNIQUE,
userName VARCHAR(50) NOT NULL,
userPassword VARCHAR(50),
PRIMARY KEY (userID)
);
CREATE UNIQUE INDEX Reviewer
ON Reviewer (userID);
SELECT * FROM Reviewer;

DROP TABLE IF EXISTS Review;
CREATE TABLE Review (
reviewID INT (5) NOT NULL,
reviewContent VARCHAR(1000) NOT NULL,
reviewScore INT(3),
songID int (10),
userID int(10),
FOREIGN KEY (songID) REFERENCES Song(songID),
FOREIGN KEY (userID) REFERENCES Reviewer(userID)
);
CREATE UNIQUE INDEX Review
ON Review (userID);
SELECT * FROM Review;

INSERT INTO Listener(FirstName, LastName, userID, userName, userPassword)
VALUES('Jon', 'Doe', 0000000001, 'jdoe123' , 'password123' ),
('Jane', 'Doe', 0000000002,'janedoe456', 'password1234' ),
('John','Smith',0000000003, 'jsmith123', 'password12345');

INSERT INTO contentCreator(firstName, lastName, userID, numberFollowers, stageName)
VALUES('John', 'Rabbit', 000000001, 1980, 'One Direction'),
      ('Jane', 'Doesong', 000000002, 104500, 'Billie Eilish'),
      ('alice', 'Wonderland', 0000046, 10530, 'Shaun');

INSERT INTO Song(songTitle, songID, Length, musicType, stageName, ReleaseDate)
VALUES ('What makes you beautiful', '57864', '350', 'pop', 'One Direction', '08-12-2011'),
       ('Lovely', '25759', '400', 'pop', 'Billie Eilish', '06-10-2018'),
       ('Way back home', '24753', '375', 'Electronic', 'Shaun', '04-08-2018');

INSERT INTO Reviewer(FirstName, LastName, userID, userName)
VALUES ('niuikn', 'tgftyvi', 9750, 'ytcdetghb'),
       ('niuikn', 'tgftyvi', 2546, 'ytcdetghb'),
       ('niuikn', 'tgftyvi', 1865, 'ytcdetghb');

INSERT INTO Review(userID, songID, reviewID, reviewContent, reviewScore)
VALUES(9750, 57864, 57864, 'worst  song ever, lol', 100),
       (2546, 25759,  00002, 'made me cry tears of tears', 100),
       (1865, 24753, 00003, 'wowie', 90);
       
drop view if exists listenerView;
CREATE VIEW listenerView AS
SELECT userName, FirstName, LastName
FROM Listener;

SELECT * FROM listenerView;

drop view if exists contentCreatorView;
CREATE VIEW contentCreatorView AS
SELECT FirstName, LastName, stageName
FROM contentCreator;

select * from contentCreatorView;

drop view if exists reviewAndReviewer;
CREATE VIEW reviewAndReviewer AS
SELECT Reviewer.userName, reviewScore, Song.songTitle
FROM Review
    inner join Reviewer on  Reviewer.userID = Review.userID
    inner join Song on  Song.songID= Review.songID;

select * from reviewAndReviewer;

drop procedure if exists findArtist;
delimiter $$
CREATE PROCEDURE findArtist (
    IN artistName varChar (15)
)
begin
    select
        stageName
    from
        contentCreator
    where
        artistName = stageName;
end$$
delimiter ;
call findArtist('One Direction');
    
    
drop procedure if exists findPositiveReviewsToMakeMeFeelBetter;
delimiter $$
CREATE PROCEDURE findPositiveReviewsToMakeMeFeelBetter (
    IN tuneName varChar (150)
)
begin
    select
        Review.reviewScore, Song.songTitle, Review.reviewContent
    from
        Review , Song
    where
        reviewScore > 75 and tuneName = songTitle;
end$$
delimiter ;

call findPositiveReviewsToMakeMeFeelBetter('What makes you beautiful');
