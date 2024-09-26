SELECT job_id, salary FROM hr.employees WHERE salary = '9000'
UNION
SELECT job_id, salary FROM hr.employees WHERE salary = '8000';


SELECT job_id, salary FROM hr.employees WHERE salary = '9000'
UNION ALL
SELECT job_id, salary FROM hr.employees WHERE salary = '8000';


USE world;

select Name, Population from world.city
union all
select Name, Population from world.country order by Name asc;

select * from country;
show create table country;