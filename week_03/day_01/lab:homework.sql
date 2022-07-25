--Q1
SELECT *
FROM employees 
WHERE (department = 'Human Resources');

--Q2
SELECT 
first_name,
last_name,
country
FROM employees 
WHERE department = 'Legal';

--Q3
SELECT *
FROM employees 
WHERE country = 'Portugal';

--Q4
SELECT *
FROM employees 
WHERE country = 'Portugal' 
OR  country = 'Spain';

--Q5
SELECT *
FROM pay_details 
WHERE local_account_no IS NULL ;

--Q6
SELECT *
FROM pay_details 
WHERE local_account_no IS NULL 
AND iban IS NULL;

--Q7
SELECT 
first_name,
last_name
FROM employees 
ORDER BY last_name ASC NULLS LAST;

--Q8
SELECT 
first_name,
last_name,
country 
FROM employees 
ORDER BY country ASC NULLS LAST,
last_name ASC NULLS LAST;

--Q9
SELECT *
FROM employees 
ORDER BY salary DESC NULLS LAST
LIMIT 10;

--Q10
SELECT 
first_name,
last_name,
salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary ;

--Q11
SELECT *
FROM employees
WHERE first_name LIKE 'F%';

--Q12
SELECT *
FROM employees 
WHERE email LIKE '%@yahoo%'

--Q13
SELECT *
FROM employees 
WHERE country NOT IN ('France', 'Germany') AND 
pension_enrol = TRUE;

--Q14
SELECT 
salary
FROM employees 
WHERE department = 'Engineering'
AND fte_hours = 1.0
ORDER BY salary DESC 
LIMIT 1;

--Q15
SELECT 
first_name,
last_name,
fte_hours,
salary,
salary * fte_hours AS effective_yearly_salary
FROM employees 

--Q16
SELECT
first_name,
last_name,
department,
concat(first_name, ' ', last_name, ' - ', department,'.') 
FROM employees ;

--Q17
SELECT
first_name,
last_name,
department,
EXTRACT (YEAR FROM "start_date")
concat(first_name, ' ', last_name, ' - ', department, ' ', year) 
FROM employees
WHERE start_date NOT NULL; 


--Q18



















