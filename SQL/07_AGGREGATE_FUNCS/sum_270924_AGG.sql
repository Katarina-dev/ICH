select count(*) from departments;

SELECT 
    COUNT(*) AS TotalDepartments,
    COUNT(DISTINCT CASE WHEN e.department_id IS NOT NULL THEN d.department_id END) AS DepartmentsWithEmployees,
    COUNT(DISTINCT CASE WHEN e.department_id IS NULL THEN d.department_id END) AS DepartmentsWithoutEmployees
FROM 
    departments d
LEFT JOIN 
    employees e ON d.department_id = e.department_id;
   
   -- 2. Выведите одним запросом общее количество департаментов (отделов) в базе, 
-- кол департаментов где есть сотрудники и кол департаментов где нет сотрудников (на выходе три столбца и одна строчка)
select * from departments;
select * from employees;
select count(*) from employees;

select department_name, (select count(*) from employees) from departments;


SELECT 
    COUNT(*) AS TotalDepartments,
    COUNT(DISTINCT CASE WHEN e.department_id IS NOT NULL THEN d.department_id END) AS Departments_With_Employees,
    COUNT(DISTINCT CASE WHEN e.department_id IS NULL THEN d.department_id END) AS Departments_Without_Employees
FROM 
    departments d
LEFT JOIN 
    employees e ON d.department_id = e.department_id;
    
   select * from country;
   -- Выведите одним запросом среднюю продолжительность жизни, минимальную и максимальную по континентам. Если измерение равно NULL, то выведите "нет данных"
  
  select Continent, 
  if (avg(LifeExpectancy) is not null, avg(LifeExpectancy), "нет данных") as avg_LifeExpectancy, 
  if (min(LifeExpectancy) is not null, min(LifeExpectancy), "нет данных") as min_LifeExpectancy,
  if (max(LifeExpectancy) is not null, max(LifeExpectancy), "нет данных") as max_LifeExpectancy
  from country 
  group by Continent;
  
 -- Выведите самую большую площадь территории среди стран, которые приняли независимость до 1950 года.
 
 select * from country;
-- 4. Выведите одним запросом среднюю продолжительность жизни, минимальную и 
-- максимальную по континентам. Если измерение равно NULL, то выведите "нет данных"

select * from country;

SELECT 
    Continent,
	if (AVG(LifeExpectancy) is not null, AVG(LifeExpectancy),  "нет данных" ) as avg_LifeExpectancy,
    if (MIN(LifeExpectancy) is not null, MIN(LifeExpectancy),  "нет данных" ) as  min_LifeExpectancy,
    if (Max(LifeExpectancy) is not null, Max(LifeExpectancy),  "нет данных" ) as max_LifeExpectancy
FROM
    country
GROUP BY Continent;

-- 5. Выведите самую большую площадь территории среди стран, которые приняли 
-- независимость до 1950 года.

SELECT 
    Name, MAX(SurfaceArea), IndepYear
FROM
    country
Where IndepYear < 1950;
 