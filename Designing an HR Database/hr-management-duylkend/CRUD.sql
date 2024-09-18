Question 1: Return a list of employees with Job Titles and Department Names

SELECT 
    e.emp_id,
    e.emp_nm,
    e.email,
    j.job_title,
    d.department_name
FROM 
    employee e
JOIN 
    job j ON e.job_id = j.job_id
JOIN 
    department d ON e.department_id = d.department_id;


Question 2: Insert Web Programmer as a new job title

INSERT INTO job (job_title)
VALUES ('Web Programmer');

Question 3: Correct the job title from web programmer to web developer

UPDATE job
SET job_title = 'Web Developer'
WHERE job_title = 'Web Programmer';


Question 4: Delete the job title Web Developer from the database

DELETE FROM job
WHERE job_title = 'Web Developer';

Question 5: How many employees are in each department?

SELECT
    d.department_name,
    COUNT(e.emp_id) AS employee_count
FROM
    department d
LEFT JOIN
    employee e ON d.department_id = e.department_id
GROUP BY
    d.department_id;

Question 6: Write a query that returns current and past jobs (include employee name, job title, department, manager name, start and end date for position) for employee Toni Lembeck.

SELECT
    e.emp_nm AS employee_name,
    j.job_title,
    d.department_name,
    m.emp_nm AS manager_name,
    eh.start_dt,
    eh.end_dt
FROM
    employee e
JOIN
    employee_history eh ON e.emp_id = eh.emp_id
JOIN
    job j ON eh.job_id = j.job_id
JOIN
    department d ON eh.department_id = d.department_id
LEFT JOIN
    employee m ON e.manager_id = m.emp_id
WHERE
    e.emp_nm = 'Toni Lembeck';

Question 7: Describe how you would apply table security to restrict access to employee salaries using an SQL server.
