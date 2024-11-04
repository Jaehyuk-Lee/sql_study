-- Active: 1730251925164@@127.0.0.1@1521@free@HR

-- 1.
SELECT e.last_name 이름, j.job_title 직업, d.department_id 부서번호, d.department_name 부서이름
FROM employees e, departments d, jobs j
WHERE e.department_id = d.department_id
AND e.job_id = j.job_id;

SELECT e.last_name 이름, j.job_title 직업, d.department_id 부서번호, d.department_name 부서이름
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN jobs j
ON e.job_id = j.job_id;

-- 2.
SELECT e.last_name, e.job_id, d.department_id, d.department_name, l.city
FROM employees e, locations l, departments d
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND l.city = 'Toronto';

SELECT * FROM employees;

SELECT e.last_name, e.job_id, d.department_id, d.department_name, l.city
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'Toronto';