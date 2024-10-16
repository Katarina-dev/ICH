-- Используя базу данных hr, выведите номера отделов и количество сотрудников в каждом отделе, где сотрудников больше 10
-- c использованием HAVING


-- без использования HAVING

SELECT * FROM employees; 

SELECT department_id, COUNT(*) as count_emp
FROM employees group by department_id 
HAVING COUNT(*) > 10;

SELECT department_id, count_emp
from
(SELECT department_id, COUNT(*) as count_emp
FROM employees group by department_id) as t
WHERE 
count_emp > 10;

-- Выведите название отделов с кол-вом сотрудников больше 10. Пример выше нужно изменить, добавив join, чтобы получить название отдела, так как таблица employees содержит только номера отделов.

SELECT * FROM departments;

SELECT d.department_name, COUNT(*) as count_emp
FROM employees e
JOIN departments d
on e.department_id = d.department_id 
group by department_name 
HAVING COUNT(*) > 10;

SELECT department_name, count_emp
from
(SELECT department_id, COUNT(*) as count_emp
FROM employees group by department_id) as t
JOIN departments d
on t.department_id = d.department_id 
WHERE 
count_emp > 10;

-- Используя базу hr, найти максимальную зарплату в каждом департаменте. Вывести department_id и max_salary.

SELECT department_id, MAX(salary) as max_salary
FROM employees  
GROUP BY department_id 

-- 2. Найти сотрудников, у которых наибольшая зарплата в их департаменте.

SELECT department_id, last_name, first_name, MAX(salary) as max_salary
FROM employees  
GROUP BY department_id;


SELECT department_id, last_name, first_name, salary from employees e1 
WHERE salary = (SELECT MAX(salary) from employees e2 WHERE e1.department_id = e2.department_id);


-- с JOIN корректно
SELECT 
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS emp_name,
    FORMAT(e.salary,0)
FROM
    departments AS d
        JOIN
    employees AS e ON d.department_id = e.department_id
        JOIN
    (SELECT 
        department_id, MAX(salary) AS max_salary
    FROM
        employees
    GROUP BY department_id) d_ms ON e.department_id = d_ms.department_id
        AND e.salary = d_ms.max_salary;

       
       -- 3. Найти департамент с наибольшим кол-вом сотрудников. 
       
       SELECT department_id, COUNT(*) as count_emp from employees 
       group by department_id 
       HAVING count_emp = (SELECT MAX(count_emp1) from (SELECT COUNT(*) as count_emp1 from employees GROUP BY department_id) as t);

 		SELECT department_id, COUNT(*) as count_emp from employees 
       group by department_id 
       order by count_emp DESC LIMIT 1;
      
      -- 5. Выведите название отделов с кол-вом сотрудников больше среднего.
      
      SELECT d.department_name, employee_count
FROM departments d
JOIN (
    SELECT department_id, COUNT(employee_id) AS employee_count
    FROM employees
    GROUP BY department_id
) AS dept_counts ON d.department_id = dept_counts.department_id,
(
    SELECT AVG(employee_count) AS avg_employee_count
    FROM (
        SELECT COUNT(employee_id) AS employee_count
        FROM employees
        GROUP BY department_id
    ) AS avg_counts
) AS avg_emp
WHERE dept_counts.employee_count > avg_emp.avg_employee_count; 
      


SELECT 
    department_id, emp_cnt
FROM
    (SELECT 
        department_id, COUNT(*) AS emp_cnt
    FROM
        employees
    GROUP BY department_id) AS t
WHERE
    emp_cnt > (SELECT 
            AVG(emp_cnt1)
        FROM
            (SELECT 
                COUNT(*) AS emp_cnt1
            FROM
                employees AS e
            GROUP BY e.department_id) AS sub);
      
      
      
      
      
      
