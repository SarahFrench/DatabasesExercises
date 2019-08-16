-- Build queries to do the following:
-- 1) Populate the database with some sample data. Make sure you use INSERTs rather than doing it via the graphical interface!

SELECT CONCAT(first_name,' ', last_name) AS name, age FROM employees WHERE age >= 30;

-- 2) Return the names of everyone older than a certain age. You want to return a single column that has their full name in it (e.g. "Fred Bloggs", not "Fred" and "Bloggs" separately which is how it should be stored in your database)

SELECT t1.first_name, t1.last_name, t2.monthly_contribution FROM employees AS t1 JOIN pensions AS t2 ON t1.pension_fund=t2.id;

-- 3) Each month, the employer contributes 5% of an employee's salary into their pension fund. Write a query that increases the value of everyone's pension fund by one month's worth of contributions.  For this query, you will need to have read the material in the advanced "Update with Select" section.

UPDATE pensions SET total_contributions = total_contributions+monthly_contribution;
