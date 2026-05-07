-- 1 Departments with more than 10 employ/ees (subquery)

SELECT deptName
FROM Department
WHERE depId IN (
    SELECT depId
    FROM Employee
    GROUP BY depId
    HAVING COUNT(empId) > 10
);

-- 2 List all active employees ordered by department then name
SELECT d.name AS department,
       e.first_name, e.last_name, e.job_title
FROM employees e
JOIN departments d ON d.id = e.department_id
WHERE e.status = 'ACTIVE'
ORDER BY d.name, e.last_name, e.first_name;

-- 3 Search active employees by name pattern (variable)
SET @search := 'a';

SELECT d.name AS department,
       e.first_name, e.last_name, e.job_title
FROM employees e
JOIN departments d ON d.id = e.department_id
WHERE e.status = 'ACTIVE'
  AND e.first_name LIKE CONCAT('%', @search, '%')
ORDER BY d.name, e.first_name, e.last_name;

--  4 Count employees per department
SELECT d.name AS department,
       COUNT(*) AS headcount
FROM employees e
JOIN departments d ON d.id = e.department_id
GROUP BY d.id, d.name
ORDER BY headcount DESC;

-- 5 — Second highest salary employee
SELECT e.id, e.first_name, s.base_salary
FROM employees e
JOIN salaries s ON s.employee_id = e.id
ORDER BY base_salary DESC
LIMIT 1 OFFSET 1;

-- 6 — Highest salary record per employee (CTE + window function)
WITH highest_salary_per_emp AS (
    SELECT
        s.employee_id,
        s.base_salary,
        s.salary_month,
        ROW_NUMBER() OVER (
            PARTITION BY s.employee_id
            ORDER BY s.base_salary DESC
        ) AS rn
    FROM salaries s
)
SELECT e.id, e.first_name,
       l.base_salary, l.salary_month
FROM highest_salary_per_emp l
JOIN employees e ON e.id = l.employee_id
WHERE l.rn = 1
  AND e.status = 'ACTIVE'
ORDER BY l.base_salary DESC, e.id ASC;

-- 7 — Employees earning more than their manager
SELECT
    e.id AS employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    m.id AS manager_id,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name,
    s.salary_month,
    (s.base_salary + COALESCE(s.bonus, 0))   AS employee_total,
    (ms.base_salary + COALESCE(ms.bonus, 0)) AS manager_total
FROM employees e
JOIN employees m  ON m.id = e.manager_id
JOIN salaries s   ON s.employee_id = e.id
JOIN salaries ms  ON ms.employee_id = m.id
                  AND ms.salary_month = s.salary_month
WHERE (s.base_salary  + COALESCE(s.bonus,  0))
    > (ms.base_salary + COALESCE(ms.bonus, 0))
ORDER BY s.salary_month DESC, e.id;

-- 8 — Department-wise highest paid employee (CTE + window function)
WITH ranked_dept_comp AS (
    SELECT
        d.id   AS department_id,
        d.name AS department_name,
        e.id   AS employee_id,
        e.first_name,
        e.email,
        s.salary_month,
        s.base_salary,
        s.bonus,
        ROW_NUMBER() OVER (
            PARTITION BY d.id
            ORDER BY (COALESCE(s.base_salary, 0)
                     + COALESCE(s.bonus, 0)) DESC
        ) AS rn
    FROM departments d
    JOIN employees e ON e.department_id = d.id
    JOIN salaries s  ON s.employee_id = e.id
)
SELECT
    department_id, department_name,
    employee_id, first_name, email,
    salary_month, base_salary,
    COALESCE(bonus, 0) AS bonus,
    COALESCE(base_salary, 0) + COALESCE(bonus, 0) AS total_compensation
FROM ranked_dept_comp
WHERE rn = 1
ORDER BY department_name;
