-- Exercises
-- Take the employment database you created in the previous topic. Build queries to do the following:


-- 1) Find the average salary for each job position
-- this query gets the average salaries as an aggregate
SELECT avg(annual_salary), job_position FROM employees GROUP BY job_position;

-- this is an improvement of the above, using a JOIN to make a table that's more readable
SELECT t1.name AS job_title, t2.average_salary
FROM job_positions AS t1
JOIN (
  SELECT job_position, avg(annual_salary) as average_salary
  FROM employees
  GROUP BY job_position
) AS t2
ON t1.id=t2.job_position;


-- 2) Work out how many people have their funds with each of the pension providers

SELECT t1.name AS pension_provider, t2.number_of_people
FROM pension_providers AS t1
JOIN (
  SELECT count(*)
  AS number_of_people, provider
  FROM pensions
  GROUP BY provider
) AS t2
ON t1.id=t2.provider;

-- 3) Find all the employees without pension funds

--this table shows only details of employees who don't have pensions
SELECT employee_number, first_name, last_name
FROM (
  SELECT *
  FROM employees
  LEFT JOIN pensions
  ON pensions.employee_id = employees.employee_number
) AS t1
WHERE t1.id IS NULL;

--this table shows details of employees and includes a has_pension column (boolean)
SELECT employee_number, first_name, last_name,
       CASE WHEN t1.id IS NULL THEN false ELSE true END AS has_pension
FROM (
  SELECT *
  FROM employees
  LEFT JOIN pensions
  ON pensions.employee_id = employees.employee_number
) AS t1;

-- Modify the previous query to create pension funds for all those employees, with the default pension fund provider (default provider should be a column on your pension provider table)
INSERT INTO pensions (employee_id)  SELECT employee_number FROM (   SELECT *  FROM employees   LEFT JOIN pensions   ON pensions.employee_id = employees.employee_number ) AS t1 WHERE t1.id IS NULL;
