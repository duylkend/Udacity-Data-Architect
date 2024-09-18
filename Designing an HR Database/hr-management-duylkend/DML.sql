-- Insert unique locations into the `location` table
INSERT INTO location (location_name, address, city, state)
SELECT DISTINCT
    location,
    address,
    city,
    state
FROM
    proj_stg
WHERE
    location IS NOT NULL;

-- Insert unique departments into the `department` table
INSERT INTO department (department_name)
SELECT DISTINCT
    department_nm
FROM
    proj_stg
WHERE
    department_nm IS NOT NULL;

-- Insert unique job titles into the `job` table
INSERT INTO job (job_title)
SELECT DISTINCT
    job_title
FROM
    proj_stg
WHERE
    job_title IS NOT NULL;
	
-- Insert unique job titles into the `job` table
INSERT INTO education (lelvel)
SELECT DISTINCT
    education_lvl
FROM
    proj_stg
WHERE
    education_lvl IS NOT NULL;

-- Insert employee data into the `employee` table
INSERT INTO employee (emp_id, emp_nm, email, hire_dt, job_id, department_id, manager_id, location_id)
SELECT
    Emp_ID,
    Emp_NM,
    Email,
    hire_dt,
    (SELECT job_id FROM job WHERE job_title = e1.job_title LIMIT 1), -- Get job_id
    (SELECT department_id FROM department WHERE department_name = e1.department_nm LIMIT 1), -- Get department_id
    (SELECT emp_id FROM employee WHERE emp_nm = e1.manager LIMIT 1), -- Get manager_id
    (SELECT location_id FROM location WHERE location_name = e1.location LIMIT 1), -- Get location_id
	(SELECT education_id FROM education WHERE education_lvl = e1.lelvel LIMIT 1) -- Get location_id
FROM
    proj_stg e1
WHERE e1.start_dt = (
        SELECT MAX(start_dt)
        FROM proj_stg AS e2
        WHERE e1.Emp_ID = e2.Emp_ID
);

-- Insert employee history data into the `employee_history` table
INSERT INTO employee_history (emp_id, job_id, department_id, start_dt, end_dt)
SELECT
    Emp_ID,
    (SELECT job_id FROM job WHERE job_title = proj_stg.job_title LIMIT 1), -- Get job_id
    (SELECT department_id FROM department WHERE department_name = proj_stg.department_nm LIMIT 1), -- Get department_id
    start_dt,
    end_dt
FROM
    proj_stg
WHERE
    start_dt IS NOT NULL;

-- Insert salary data into the `salary` table
INSERT INTO salary (employee_id, salary_amount)
SELECT
    Emp_ID,
    salary
FROM
    proj_stg
WHERE
    salary IS NOT NULL;
