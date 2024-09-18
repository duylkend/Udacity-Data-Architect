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
