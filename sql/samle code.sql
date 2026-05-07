-- ==============================================================
-- Company Demo Database for SQL Practice (MySQL 8+)
-- ==============================================================

DROP DATABASE IF EXISTS learning_mysql;
CREATE DATABASE learning_mysql;
USE learning_mysql;

-- ==============================================================
-- TABLES
-- ==============================================================

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL,
    manager_id INT NULL
) ENGINE=InnoDB;

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    hire_date DATE NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    manager_id INT NULL,
    status ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
    INDEX idx_emp_dept (department_id),
    INDEX idx_emp_mgr (manager_id),
    CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB;

ALTER TABLE departments
ADD CONSTRAINT fk_dept_mgr FOREIGN KEY (manager_id) REFERENCES employees(id);

CREATE TABLE salaries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    salary_month DATE NOT NULL,
    base_salary DECIMAL(12,2) NOT NULL,
    bonus DECIMAL(12,2) DEFAULT 0.00,
    INDEX idx_sal_emp_month (employee_id, salary_month),
    CONSTRAINT fk_sal_emp FOREIGN KEY (employee_id) REFERENCES employees(id)
) ENGINE=InnoDB;

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    department_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    status ENUM('PLANNED','ACTIVE','ON_HOLD','COMPLETED') DEFAULT 'PLANNED',
    CONSTRAINT fk_proj_dept FOREIGN KEY (department_id) REFERENCES departments(id)
) ENGINE=InnoDB;

CREATE TABLE employee_projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(80) NOT NULL,
    allocation_pct INT NOT NULL CHECK (allocation_pct BETWEEN 0 AND 100),
    assigned_date DATE NOT NULL,
    CONSTRAINT fk_ep_emp FOREIGN KEY (employee_id) REFERENCES employees(id),
    CONSTRAINT fk_ep_proj FOREIGN KEY (project_id) REFERENCES projects(id),
    UNIQUE KEY uk_emp_proj (employee_id, project_id)
) ENGINE=InnoDB;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ==============================================================
-- TRIGGER
-- ==============================================================

DELIMITER //
CREATE TRIGGER trg_users_email_domain
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.email NOT LIKE '%@demo.com' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email must be under @demo.com domain';
    END IF;
END//
DELIMITER ;

-- ==============================================================
-- TRANSACTION FIX (IMPORTANT PART)
-- ==============================================================

START TRANSACTION;

UPDATE employee_projects
SET allocation_pct = allocation_pct - 10
WHERE employee_id = (SELECT id FROM employees WHERE email='karthik.iyer@demo.com')
AND project_id = (SELECT id FROM projects WHERE name='Payments Service Rewrite');

UPDATE employee_projects
SET allocation_pct = allocation_pct + 10
WHERE employee_id = (SELECT id FROM employees WHERE email='sanjay.patel@demo.com')
AND project_id = (SELECT id FROM projects WHERE name='Payments Service Rewrite');

-- Check invalid allocations
SET @out_of_bounds := (
    SELECT COUNT(*)
    FROM employee_projects
    WHERE allocation_pct < 0 OR allocation_pct > 100
);

-- ✅ MySQL-compatible conditional handling
SELECT 
CASE 
    WHEN @out_of_bounds > 0 THEN 'ROLLBACK NEEDED'
    ELSE 'COMMIT SAFE'
END AS status;

-- 👉 YOU manually decide based on result:
-- If result = 'ROLLBACK NEEDED'
-- ROLLBACK;

-- If result = 'COMMIT SAFE'
COMMIT;
d
-- ==============================================================
-- DONE
-- ==============================================================