--Initial Setup to remove previously created tables 
DROP TABLE IF EXISTS YT_VIdeos;
DROP TABLE IF EXISTS YT_Reviews;
DROP TYPE IF EXISTS Rating; 

--Table Creation
CREATE TABLE YT_Videos
(
VidNum int PRIMARY KEY,
Title varchar(100) NOT NULL,
Length time NOT NULL,
URL varchar(100) NOT NULL
);

CREATE TYPE Rating AS ENUM  ('0','1','2','3','4','5');

CREATE TABLE YT_Reviews
(
RevNum int PRIMARY KEY,
UserName varchar(50) NOT NULL,
Review TEXT,
VidRating Rating,
VidNum int
);

--Inserting Values into Tables
INSERT INTO YT_Videos VALUES('1','Getting the Data from the HTML File','00:09:57','https://www.youtube.com/watch?v=FMV1eMapiSY');
INSERT INTO YT_Videos VALUES('2','C# HTML Data Collecting','00:15:14','https://www.youtube.com/watch?v=rru3G7PLVjw');
INSERT INTO YT_Videos VALUES('3','Getting WebPage Data into Excel using VBA','00:14:46','https://www.youtube.com/watch?v=cSoRVZKRkvY');

INSERT INTO YT_Reviews VALUES('1001','Mijanur Rahman','Very nice tutorial. Neat and clean description. Thanks.','5','2');
INSERT INTO YT_Reviews VALUES('1002','Darkyin','Are you eating a Toffy? Holy Moses thats annoying as ****!','0','2');
INSERT INTO YT_Reviews VALUES('1003','Irakli Khakhviashvili','i dont understand why we using ArrayList? isnt that HashMap holding all the information it needs? titles and urls?','2','1');
INSERT INTO YT_Reviews VALUES('1004','Rahul','why pre increment not post increment in while','4','1');

--Necessary to set the ENUM value to a integer
ALTER TABLE YT_Reviews ALTER COLUMN VidRating TYPE int USING VidRating::text::int; 

--Join Tables I did Two Queries, only the last will be displayed 
SELECT v.VidNum, v.title, r.UserName, r.VidRating, r.Review
FROM YT_Videos v
JOIN YT_Reviews r
ON v.VidNum = r.VidNum
;

--Aggregate the Query to find Average Rating

SELECT v.title, AVG(r.VidRating) 
FROM YT_Videos v
JOIN YT_Reviews r
ON v.VidNum = r.VidNum 
GROUP BY v.Title
ORDER BY v.Title
;
