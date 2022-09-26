SELECT emp_id, first_name, last_name, job_title
  FROM employees_A
UNION
SELECT emp_id, first_name, last_name, job_title
  FROM employees_B;

SELECT 'Employees A' AS Type, emp_id, first_name, last_name, job_title
  FROM employees_A
UNION ALL
SELECT 'Employees B' AS Type, emp_id, first_name, last_name, job_title
  FROM employees_B;

SELECT emp_id, first_name, last_name, job_title
  FROM employees_A
INTERSECT
SELECT emp_id, first_name, last_name, job_title
  FROM employees_B
  ORDER BY emp_id;

SELECT emp_id, first_name, last_name, job_title
  FROM employees_A
EXCEPT
SELECT emp_id, first_name, last_name, job_title
  FROM employees_B;

SELECT dept_name,
    CASE dept_name
        WHEN 'Computer Science' THEN 'IT'
        ELSE 'others'
    END AS category
FROM department;



