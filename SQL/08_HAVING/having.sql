/*  В MySQL, HAVING и WHERE используются для фильтрации данных, но
 - они работают на разных этапах обработки запроса
 - и применяются к разным типам данных.

1. WHERE: фильтрует строки таблицы

2. HAVING: фильтрует результат, возвращаемый агрегатными функциями


Пример использования WHERE:
    Вывести сотрудников, чья ЗП > 5000:*/
SELECT 
    first_name, last_name, salary
FROM
    hr.employees
WHERE
    salary > 5000;   
    
    
/*
Пример использования HAVING:
    Вывести департаменты, где средняя ЗП по департаменту > 5000:*/
    
SELECT 
    department_id, AVG(salary) AS avg_salary
FROM
    hr.employees
GROUP BY department_id
HAVING avg_salary > 5000; 
    
    