--Q1
SELECT
count(id)
FROM employees 
WHERE (grade IS NULL) 
AND (salary IS NULL) ;

--Q2
SELECT 
concat (first_name, ' ', last_name) AS full_name,
department 
FROM employees
ORDER BY department NULLS LAST , last_name NULLS LAST ;

--Q3
SELECT 
salary, 
first_name , 
last_name  
FROM employees 
WHERE last_name LIKE 'A%'
ORDER BY salary DESC NULLS LAST 
LIMIT 10;

--Q4
SELECT 
count(id) AS dep_count,
department 
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department 
ORDER BY count(id) ;

--Q5
SELECT 
count(id) AS fte__count,
department,
fte_hours 
FROM employees 
GROUP BY department, fte_hours  
ORDER BY department, count(id) ;

--Q6
SELECT 
count(id) AS pension_enrol_count,
pension_enrol 
FROM employees 
GROUP BY pension_enrol ;

--Q7
SELECT *
FROM employees 
WHERE pension_enrol = FALSE AND department = 'Accounting'
ORDER BY salary DESC NULLS LAST ;

--Q8
SELECT 
count(id) AS employees_in_country,
country,
avg(salary) AS avg_salary
FROM employees 
GROUP BY country 
HAVING count(id) > 30
ORDER BY avg_salary DESC NULLS LAST;

--Q9
SELECT 
first_name,
last_name,
fte_hours*salary AS effective_yearly_salary
FROM employees 
WHERE fte_hours*salary > 30000;

--Q10
SELECT
E.* ,
t.name 
FROM employees AS E INNER JOIN teams AS t
ON E.team_id = t.id 
WHERE (t.name = 'Data Team 1')
OR (t.name = 'Data Team 1');

--Q11
SELECT 
first_name,
last_name,
local_tax_code
FROM employees AS e INNER JOIN pay_details AS pd 
ON e.pay_detail_id = pd.id
WHERE local_tax_code IS NULL ;

--Q12
SELECT 
first_name,
last_name,
(48 * 35 * CAST(charge_cost AS int) - salary) * fte_hours AS expected_profit 
FROM employees AS e LEFT JOIN teams AS t
ON e.team_id = t.id;

--Q13
SELECT 
first_name,
last_name,
salary
FROM employees 
WHERE country = 'Japan' AND fte_hours = (SELECT
	fte_hours 
	FROM employees 
	GROUP BY fte_hours 
	ORDER BY count(*)
	LIMIT 1)
ORDER BY salary ASC 
LIMIT 1;

--Q14
SELECT
count(id) AS num_missing,
department 
FROM employees 
WHERE first_name IS NULL
GROUP BY department 
HAVING count(id) >= 2
ORDER BY num_missing DESC, department;

--Q15
SELECT 
count(id) AS name_count,
first_name
FROM employees 
WHERE first_name IS NOT NULL
GROUP BY first_name 
ORDER BY count(id) DESC, first_name ;

--Q16
SELECT 
department,
sum(CAST(grade = '1' AS int)) / cast(count(id) AS REAL)
AS proportion_g1s
FROM employees 
GROUP BY department;

































