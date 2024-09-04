/*============== IF ================*/

SELECT IF(1 = 2, "YES", "NO");

SELECT IF(10 < 20, IF(10 < 30, '+', '-'), "NO");

SELECT 
    last_name,
    salary,
    IF(salary > 10000, 'Good', 'Bad') AS Estimate
FROM
    hr.employees;
    
  /*============= CASE ================*/
  
  SELECT last_name, salary,
			CASE
				WHEN salary < 5000 THEN 'Low'
                WHEN salary < 10000 THEN 'Middle'
                ELSE 'High'
                END AS Level
  FROM hr.employees;
    
    /*============= SUM ================*/
    
SELECT SUM(salary) FROM hr.employees WHERE salary > 10000; -- 175 000
    
SELECT 
    SUM(IF(salary > 10000, salary, 0))
FROM
    hr.employees;
  
SELECT 
    SUM(
		CASE
        WHEN salary > 10000 THEN salary
        WHEN salary <= 10000 THEN 0
        END
        ) AS type3
	FROM hr.employees;
  
  /*============= AVG ================*/
  
  SELECT AVG(salary) FROM hr.employees WHERE salary > 10000;  -- 13 461
  
  SELECT 
    AVG(IF(salary > 10000, salary, NULL))
FROM
    hr.employees;
    
    SELECT 
    AVG(
		CASE
        WHEN salary > 10000 THEN salary
        WHEN salary <= 10000 THEN NULL
        END
        ) AS type3
	FROM hr.employees;
    
    /*============= DISTINCT ================*/
    
   SELECT DISTINCT salary FROM hr.employees; 
   
    /*============= ORDER BY ================*/
    
    SELECT 
    last_name, salary
FROM
    hr.employees
ORDER BY salary ASC;
    