USE hr;

select * from employees;
select * from departments;
select * from manager;
select * from locations;

-- Используя базу hr_data.sql, вывести имя и фамилию сотрудника и название его департамента.
SELECT 
    a.first_name, a.last_name, b.department_name
FROM
    employees a
        JOIN
    departments b ON a.department_id = b.department_id;
    
    -- Вывести имя и фамилию и название департамента только тех сотрудников, которые работают в IT, Treasury или IT Support.
    SELECT 
    a.first_name, a.last_name, b.department_name
FROM
    employees a
        JOIN
    departments b ON a.department_id = b.department_id
WHERE
    b.department_name IN ('IT' , 'Treasury', 'IT Support');
    
    -- Вывести имя и фамилию сотрудника и имя и фамилию его менеджера.
    select e.first_name as Employee_name, e.last_name as Employee_last, m.first_name as Manager_name, m.last_name as Manager_last
    from employees as e
    left join employees as m
    on e.manager_id = m.employee_id
    where m.last_name ='King';
    
     select e.first_name as Employee_name, e.last_name as Employee_last, m.first_name as Manager_name, m.last_name as Manager_last
    from employees as e
    inner join employees as m
    on e.manager_id = m.employee_id
    order by m.last_name;
    
      select e.first_name as Employee_name, e.last_name as Employee_last, m.first_name as Manager_name, m.last_name as Manager_last
    from employees as e
    right join employees as m
    on e.manager_id = m.employee_id
    order by m.last_name;
    
    -- Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера.
    
  select e.job_id, e.first_name as Employee_name, e.last_name as Employee_last, m.first_name as Manager_name, m.last_name as Manager_last, e.salary as empl_salary, m.salary as man_salary
  from employees e
  join employees m
  on m.manager_id = e.employee_id
  where e.salary > m.salary;
  
  -- Вывести имя, фамилию и город сотрудников, которые работают в Seattle или Toronto.
  
  select e.last_name, e.first_name, l.city 
  from employees e
  join departments d 
  on e.department_id = d.department_id 
  join locations l
  on d.location_id = l.location_id
  where l.city in ('Seattle', 'Toronto');
  
  -- Вывести названия департаментов, в которых никто не работает.
SELECT * FROM hr.departments;
 SELECT * FROM hr.employees;
 
 SELECT DISTINCT d.department_name,d.department_id,e.department_id 
 From hr.departments AS d
 LEFT JOIN
  hr.employees AS e ON  d.department_id =e.department_id
 WHERE e.department_id IS NULL;