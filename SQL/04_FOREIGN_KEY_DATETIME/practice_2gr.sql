USE 050824_ekmi;

create table if not exists Students (
student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name_st varchar(128) NOT NULL,
age integer);

create table if not exists Teachers (
teacher_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
name_te varchar(128) NOT NULL,
age integer);

create table if not exists Competencies (
compet_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
title varchar(128) NOT NULL
);

create table if not exists TeachersToCompetencies (
te_co_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
t_id integer,
c_id integer,
FOREIGN KEY (t_id) REFERENCES Teachers(teacher_id),
FOREIGN KEY (c_id) REFERENCES Competencies(compet_id)
);

create table if not exists Courses (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
t_id integer,
title varchar(128),
headman_id integer,
FOREIGN KEY (t_id) REFERENCES Teachers(teacher_id),
FOREIGN KEY (headman_id) REFERENCES Students(student_id)
);

create table if not exists StudentsToCourses (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
s_id integer,
c_id integer,
FOREIGN KEY (s_id) REFERENCES Students(student_id),
FOREIGN KEY (c_id) REFERENCES Competencies(compet_id)
);

