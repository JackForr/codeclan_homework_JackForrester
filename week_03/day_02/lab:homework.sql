--Q1a
SELECT
E.first_name,
E.last_name,
T.name 
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = T.id;

--1b
SELECT
E.first_name,
E.last_name,
T.name,
E.pension_enrol 
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = T.id
WHERE pension_enrol = TRUE;

--1c
SELECT
E.first_name,
E.last_name,
T.name,
T.charge_cost
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = T.id
WHERE (Cast(T.charge_cost AS integer)) > 80;

--2a
SELECT 
E.*,
local_account_no,
local_sort_code
FROM employees AS E
LEFT JOIN pay_details AS PD ON E.pay_detail_id = PD.id;

--2b
SELECT 
E.*,
local_account_no,
local_sort_code,
T."name" 
FROM employees AS E
LEFT JOIN pay_details AS PD ON E.pay_detail_id = PD.id
INNER JOIN teams AS T ON E.team_id = T.id ;

--Q3a
SELECT
E.id,
T.name
FROM employees AS E
LEFT JOIN teams AS T ON E.team_id  = T.id;

--3b & c
SELECT
count(E.id) AS employee_num,
T."name"  
FROM employees AS E
LEFT JOIN teams AS T ON E.team_id  = T.id
GROUP BY T."name" 
ORDER BY employee_num;

--Q4a
SELECT
count(E.id) AS employee_num,
T."name",
T.id
FROM employees AS E
INNER JOIN teams AS T ON E.team_id  = T.id
GROUP BY T."name", T.id
ORDER BY employee_num;

--4b
SELECT
Cast(T.charge_cost AS integer)*count(E.id) AS total_day_charge,
T."name",
T.id
FROM employees AS E
INNER JOIN teams AS T ON E.team_id  = T.id
GROUP BY T."name", T.id ;

--4c
SELECT
Cast(T.charge_cost AS integer)*count(E.id) AS total_day_charge,
T."name",
T.id
FROM employees AS E
INNER JOIN teams AS T ON E.team_id  = T.id
GROUP BY T."name", T.id 
HAVING (Cast(T.charge_cost AS integer)*count(E.id)) > 5000;


















