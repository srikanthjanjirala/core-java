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


-----------
#Find the duplicate records in the table
select city,count(*) as total_city from user GROUP BY city HAVING total_city > 5 
------------------------------------------------------------------
2) Second Highest salary from the employee

SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

WITH hishest_salary_employee_order as ( SELECT *,DENSE_RANK() OVER(
	ORDER BY base_salary DESC
	) as salary_sn FROM learning_mysql.salaries
)

select * from learning_mysql.employees e JOIN hishest_salary_employee_order h ON e.id = h.employee_id WHERE h.salary_sn = 2;
----------------------------------------------------------------
3) Find the employees who do not have a department

SELECT * FROM learning_mysql.employees e LEFT JOIN learning_mysql.departments d ON e.department_id = d.id WHERE d.id IS NUll;

----------------------------------------------------------------
3) Find the employees who subscriber to more than 2 times
SELECT s.employee_id,count(*) as salary_count from learning_mysql.salaries s GROUP BY s.employee_id HAVING salary_count >= 2;

----------------------------------------------------------------
4) Calculate total revenue per product

----------------------------------------------------------------
5) Customer who made the purchase but never returned the product
SELECT 
    c.*
FROM
    learning_mysql.customers c
        INNER JOIN
    learning_mysql.orders o ON o.customer_id = c.customer_id
        LEFT JOIN
    learning_mysql.returns AS r ON r.order_id = o.order_id
WHERE
    r.return_id IS NULL
----------------------------------------------------------------
6) Retrieve all customers who registered in the year 2025
-
SELECT * from learning_mysql.customers WHERE YEAR(registration_date) = 2025

- Better Version (Uses Index Efficiently) index friendly
SELECT * from learning_mysql.customers WHERE registration_date >= '2025-01-01' AND registration_date < '2026-01-01'
----------------------------------------------------------------
7) Calculate the average order value for each customer
SELECT o.customer_id,AVG(o.total_amount) as avg_salary FROM learning_mysql.orders o GROUP BY o.customer_id

8) Find the product that never sold
SELECT p.* FROM learning_mysql.products p LEFT JOIN learning_mysql.orders o ON o.product_id = p.product_id WHERE o.order_id IS NULL
