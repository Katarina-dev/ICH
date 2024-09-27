/* Для декомпозиции сложных запросов, помимо VIEW,
можно также создавать временные таблицы.

Они хранятся в оперативной памяти ТОЛЬКО на время сессии и не видны другим пользователям.

Для создания временной таблицы также нужно иметь право на запись.*/


CREATE TEMPORARY TABLE tmp_salary_by_department AS
	(SELECT
		department_id, GROUP_CONCAT(concat(first_name, "_", last_name)SEPARATOR '\n')
	FROM
		hr.employees
	GROUP BY department_id);


SELECT * FROM tmp_salary_by_department;