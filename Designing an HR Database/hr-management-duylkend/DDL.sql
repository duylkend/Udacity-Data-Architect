-- Create the `location` table
CREATE TABLE IF NOT EXISTS location (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(50) NOT NULL,
    address VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(2)
);

-- Create the `department` table
CREATE TABLE IF NOT EXISTS department (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Create the `job` table
CREATE TABLE IF NOT EXISTS job (
    job_id SERIAL PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL
);

-- Create the `Education` table
CREATE TABLE IF NOT EXISTS education (
    education_id SERIAL PRIMARY KEY,
    lelvel VARCHAR(50) NOT NULL
);


-- Create the `employee` table
CREATE TABLE IF NOT EXISTS employee (
    emp_id VARCHAR(8) PRIMARY KEY,
    emp_nm VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hire_dt DATE NOT NULL,
    job_id INT,
    department_id INT,
    manager_id VARCHAR(8),
    location_id INT,
	education_id INT,
    FOREIGN KEY (job_id) REFERENCES job(job_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (manager_id) REFERENCES employee(emp_id) ON DELETE SET NULL,
    FOREIGN KEY (location_id) REFERENCES location(location_id),
	FOREIGN KEY (education_id) REFERENCES education(education_id)
);

-- Create the `salary` table
CREATE TABLE IF NOT EXISTS salary (
    salary_id SERIAL PRIMARY KEY,
    employee_id VARCHAR(8) NOT NULL,
    salary_amount INT NOT NULL
    FOREIGN KEY (employee_id) REFERENCES employee(emp_id) ON DELETE CASCADE
);

-- Create the `employee_history` table
CREATE TABLE IF NOT EXISTS employee_history (
    history_id SERIAL PRIMARY KEY,
    emp_id VARCHAR(8),
    job_id INT,
    department_id INT,
    start_dt DATE,
    end_dt DATE,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (job_id) REFERENCES job(job_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);
