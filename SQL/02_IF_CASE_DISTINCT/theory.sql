/* ================ IF ====================== */

SELECT IF(1 = 2, 'Yes', 'No');

SELECT IF(10 < 20, IF(10 = 30, '+', '-'), 'No');

SELECT 
    last_name, salary, IF(salary > 10000, '+', '-') AS type1
FROM
    hr.employees;
    
/* ================ CASE  
						WHEN     THEN  
                        WHEN     THEN
                        . . .
                        ELSE
					END ====================== */
                    
SELECT 
    last_name,
    salary,
    CASE
        WHEN salary < 5000 THEN 'Low'
        WHEN salary < 10000 THEN 'Middle'
        ELSE 'High'
    END AS type2
FROM
    hr.employees;

/* ================ SUM() ================== */
SELECT 
    SUM(salary)
FROM
    hr.employees
WHERE
    salary > 10000; -- 175 000
    
    
SELECT 
    SUM(IF(salary > 10000, salary, 0))
FROM
    hr.employees;  -- 175 000
    
SELECT 
    SUM(
		CASE
			WHEN salary > 10000 THEN salary
			ELSE 0
		END 
    ) AS type3
FROM
    hr.employees;  -- 175 000    
    
SELECT 
    SUM(CASE
        WHEN salary > 10000 THEN salary
        WHEN salary <= 10000 THEN 0
    END) AS type3
FROM
    hr.employees;  -- 175 000    
    
/* ================ AVG() ================== */
SELECT 
    AVG(salary)
FROM
    hr.employees
WHERE
    salary > 10000; -- 13 461   

SELECT 
    AVG(IF(salary > 10000, salary, NULL))
FROM
    hr.employees;  -- 13 461
    
/* ================ DISTINCT ================== */

SELECT salary FROM hr.employees; -- 78 rows

SELECT DISTINCT salary FROM hr.employees; -- 48 rows

/* ================ ORDER BY ======================= */

SELECT 
    last_name, salary
FROM
    hr.employees
ORDER BY salary DESC;

/* ================= GROUP BY ====================== */
SELECT 
    department_id, AVG(salary) AS AVG_salary
FROM
    hr.employees
WHERE
    department_id IN (60 , 90, 100)
GROUP BY department_id
ORDER BY department_id ASC;