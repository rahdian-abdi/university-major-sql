# DATA DEFINITION LANGUAGE
CREATE TABLE major (
	major_id CHAR(8) PRIMARY KEY,
	major_name VARCHAR(32) NOT NULL
);

ALTER TABLE major
MODIFY COLUMN major_id char(3);
DESC major;

CREATE TABLE student (
	student_id CHAR(16) PRIMARY KEY,
	student_name VARCHAR(32) NOT NULL,
	major_id CHAR(3),
	join_year INT NOT NULL,
	grad_year INT,
	FOREIGN KEY (major_id) REFERENCES major(major_id)
);

CREATE TABLE lecturer (
	lecturer_id CHAR(16) PRIMARY KEY,
	lecturer_name VARCHAR(32) NOT NULL,
	major_id CHAR(3),
	FOREIGN KEY (major_id) REFERENCES major(major_id)
);

CREATE TABLE subject (
	subject_id CHAR(16) PRIMARY KEY,
	subject_name VARCHAR(32) NOT NULL,
	semester INT NOT NULL,
	year INT NOT NULL,
	lecturer_id CHAR(16),
	FOREIGN KEY (lecturer_id) REFERENCES lecturer(lecturer_id)
);

CREATE TABLE study (
	study_id CHAR(16) PRIMARY KEY,
	student_id CHAR(16),
	subject_id CHAR(16),
	score DECIMAL(3, 2) CHECK (score >=0 AND score <= 4),
	FOREIGN KEY (student_id) REFERENCES student(student_id),
	FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);

# DATA MANIPULATION LANGUAGE
# INSERT
INSERT INTO major (major_id, major_name) VALUES ('TEE', 'Electro Engineering');
INSERT INTO major (major_name ,major_id) VALUES ('Informatics Engineering', 'TIF'); # It will follow the previous sort (major)
INSERT INTO major VALUES ('TME', 'Mechanical Engineering');

INSERT INTO student (student_id, student_name, major_id, join_year) VALUES 
	('101', 'Riko', 'TIF', '2023'),
	('102', 'Rizal', 'TIF', '2024'),
	('103', 'Daffa', 'TIF', '2025');

INSERT INTO lecturer (lecturer_id, lecturer_name, major_id) VALUES
	('201','Bambang', 'TIF'),
	('202', 'Dewa', 'TME'),
	('203', 'Ridwan', 'TEE');

INSERT INTO subject(subject_id, subject_name, semester, year, lecturer_id) VALUES 
	('515', 'Computer 101', '1', '2009'),
	('516', 'Computer Design', '2', '2010'),
	('517', 'Computer Alghoritmic', '3', '2011');

INSERT INTO study (study_id, student_id, subject_id, score) VALUES 
	('301', '101', '515', 3.52 ),
	('302', '102', '516', 3.64 ),
	('303', '103', '517', 3.76 );
	
# INSERT

# SELECT
SELECT * FROM major;
SELECT major_id FROM major;
SELECT * FROM major WHERE major_id = 'TEE'; # Act as filter

SELECT * FROM student;
# PAGINATION
# GET /student?search=daniel&order=asc(join_year),desc(student_name)&limit=5&page=1
# OFFSET = (PAGE - 1) x LIMIT
SELECT s.student_name, m.major_name, s.join_year # You want major_name in student so use JOIN
FROM student s JOIN major m ON s.major_id = m.major_id 
# WHERE student_name LIKE 'r%'
ORDER BY join_year DESC, student_name ASC
# LIMIT 3 OFFSET 3
;

SELECT * FROM lecturer;
SELECT l.lecturer_name, m.major_name  
FROM lecturer l JOIN major m ON l.major_id = m.major_id
WHERE l.lecturer_name = 'Ridwan';

SELECT * FROM subject s ;
SELECT s.subject_name, l.lecturer_name  
FROM subject s JOIN lecturer l ON s.lecturer_id = l.lecturer_id ; 

SELECT * FROM study s ;
SELECT s.study_id, s2.student_name, s2.major_id, s3.subject_name, s.score 
FROM study s JOIN student s2 ON s.student_id = s2.student_id JOIN subject s3 ON s.subject_id = s3.subject_id ;

# SELECT

# UPDATE

UPDATE subject SET lecturer_id = '201' WHERE subject_id = '515';
UPDATE subject SET lecturer_id = '202' WHERE subject_id = '516';
UPDATE subject SET lecturer_id = '203' WHERE subject_id = '517';
#UPDATE

#DELETE
DELETE FROM major WHERE major_id = 'TME'
#DELETE

