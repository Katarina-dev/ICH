USE ich;

create table if not exists Students (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name varchar(128) NOT NULL,
age integer);

create table if not exists Teachers (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name varchar(128) NOT NULL,
age integer);

create table if not exists Competencies (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
title varchar(128) NOT NULL
);

create table if not exists TeachersToCompetencies (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
teacher_id integer,
competencies_id integer,
FOREIGN KEY (teacher_id) REFERENCES Teachers(id),
FOREIGN KEY (competencies_id) REFERENCES Competencies(id)
);

create table if not exists Courses (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
teacher_id integer,
title varchar(128),
headman_id integer,
FOREIGN KEY (teacher_id) REFERENCES Teachers(id),
FOREIGN KEY (headman_id) REFERENCES Students(id)
);

create table if not exists StudentsToCourses (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
student_id integer,
competencies_id integer,
FOREIGN KEY (student_id) REFERENCES Students(id),
FOREIGN KEY (competencies_id) REFERENCES Competencies(id)
);


