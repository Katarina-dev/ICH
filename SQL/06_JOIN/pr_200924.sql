-- 1. Выведите список студентов с курсом, на который каждый записан (результат содержит имя студента - name и course_id).
-- Подсказка: сделать join таблицы students и students2courses
select * from Students2Courses;

select s.first_name, c.course_id
from Students s
join Students2Courses c 
on c.student_id = s.id

-- 2. Изменить предыдущий запрос так, чтобы вместо course_id выводилось название курса. Подсказка: нужен дополнительный join в запросе с таблицей courses

select s.first_name, c.title
from Students s
join Students2Courses st 
on st.student_id = s.id
join Courses c
on c.id = st.course_id;
