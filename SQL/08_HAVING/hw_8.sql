-- Подключитесь к базе данных Students (которая находится на удаленном сервере). 

-- Найдите самого старшего студента

SELECT name, max(age) from Students;


-- Найдите самого старшего преподавателя

SELECT * from Teachers;
SELECT name, max(age) from Teachers;


-- Выведите список преподавателей с количеством компетенций у каждого
SELECT * from Competencies;

SELECT t.name, COUNT(c.title) as 'Count of competencies' 
from Teachers t 
join Teachers2Competencies tc
on t.id = tc.teacher_id
join Competencies c 
on tc.competencies_id = c.id
GROUP BY t.name;


-- Выведите список курсов с количеством студентов в каждом
SELECT * from Students;
SELECT * from Students2Courses;

SELECT c.title, COUNT(s.id) as 'Count of students' 
from Students s 
join Students2Courses sc
on s.id = sc.student_id 
join Courses c 
on sc.course_id = c.id
group by c.title ;


-- Выведите список студентов, с количеством курсов, посещаемых каждым студентом. 

SELECT s.name, COUNT(c.id) as 'Count of courses'
from Students s 
join Students2Courses sc 
on s.id = sc.student_id 
join Courses c 
on c.id = sc.course_id 
GROUP BY s.name;

