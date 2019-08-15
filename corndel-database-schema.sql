DROP DATABASE IF EXISTS employment_db;
CREATE DATABASE IF NOT EXISTS employment_db;

USE employment_db;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS job_positions;
DROP TABLE IF EXISTS pensions;
DROP TABLE IF EXISTS pension_providers;

CREATE TABLE IF NOT EXISTS employees (
  employee_number INT NOT NULL AUTO_INCREMENT,
  first_name      VARCHAR(255) NOT NULL,
  last_name       VARCHAR(255) NOT NULL,
  birthday        TIMESTAMP,
  annual_salary   MEDIUMINT(255),
  monthly_salary  MEDIUMINT(255),
  job_position    INT NOT NULL,
  PRIMARY KEY (employee_number)
);


-- ON DELETE CASCADE used to delete pension if employee record deleted.
-- This works because employees are one-to-one with pensions. If there was a
-- delete cascade that affected job positions then people wouldn't be able to have
-- the same job title

CREATE TABLE IF NOT EXISTS job_positions (
  id          INT NOT NULL AUTO_INCREMENT,
  name        VARCHAR(255) NOT NULL,
  department  ENUM('Tech', 'Product', 'IT', 'Customer Service', 'Data', 'HR', 'Finance', 'Other'),
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS pensions (
  id INT NOT NULL AUTO_INCREMENT,
  employee_id INT NOT NULL,
  total_contributions MEDIUMINT(255) NOT NULL DEFAULT 0,
  monthly_contribution MEDIUMINT(255) NOT NULL DEFAULT 0,
  provider INT NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
);


CREATE TABLE IF NOT EXISTS pension_providers (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);


-- Set up foreign keys:

ALTER TABLE employees ADD CONSTRAINT fk_job_position FOREIGN KEY (job_position) REFERENCES job_positions(id);
ALTER TABLE employees ADD CONSTRAINT fk_pension_fund FOREIGN KEY (pension_fund) REFERENCES pensions(id);

ALTER TABLE pensions ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES employees(id);
ALTER TABLE pensions ADD CONSTRAINT fk_provider FOREIGN KEY (provider) REFERENCES pension_providers(id);


-- Add values into tables:

INSERT INTO pension_providers (name)
VALUES  ('London Pensions Co.'),
        ('Edgy Blockchain Pensions Ltd.');

INSERT INTO job_positions (name, department)
VALUES  ("Developer","Tech"),
        ("Designer","Product"),
        ("Support","IT"),
        ("Client Coordinator","Customer Service"),
        ("Analyst","Data"),
        ("Recruiter","HR"),
        ("Payroll Admin","Finance"),
        ("Intern","Other");

INSERT INTO pensions (employee_id, total_contributions, monthly_contribution, provider)
VALUES  (1, 500, 0, DEFAULT),
        (1, 500, 0, 2),
        (2,1500, 0, DEFAULT),
        (3, 100, 0, 2),
        (4, 1450, 0, DEFAULT);

INSERT INTO employees ( first_name, last_name, age, annual_salary, monthly_salary, job_position, pension_fund)
  VALUES  ("Joe", "Bloggs", 28, 30000, 2500, 1, 1),
          ("Joanna", "Bleggs", 25, 27000, 2250, 1, 2),
          ("John", "Bragg", 30, 37500, 3125, 5, 3),
          ("Johannes", "Blégs", 24, 30000, 2500, 2, 4),
          ("Jo", "Blages", 33, 40000, 3333.33, 7, 5)
