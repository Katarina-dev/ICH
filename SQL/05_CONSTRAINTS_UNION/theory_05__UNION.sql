SELECT job_id, salary FROM hr.employees WHERE salary = '9000'
UNION
SELECT job_id, salary FROM hr.employees WHERE salary = '8000';


SELECT job_id, salary FROM hr.employees WHERE salary = '9000'
UNION ALL
SELECT job_id, salary FROM hr.employees WHERE salary = '8000';


