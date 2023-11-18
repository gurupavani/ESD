USE companydb;

SELECT * FROM department;
SELECT * FROM dependent;
SELECT * FROM dept_locations;
SELECT * FROM employee;
SELECT * FROM project;
SELECT * FROM works_on;

SELECT fname,lname FROM employee;

SELECT * from employee WHERE sex = 'M' AND salary >= 30000;

SELECT * FROM dependent WHERE essn = '333445555';

SELECT * FROM project WHERE plocation in ('Houston','Stafford');

SELECT * FROM project WHERE plocation = 'Houston' OR dnum = 4; 

SELECT dname,YEAR(mgr_start_date) FROM department;

SELECT ssn FROM employee WHERE address LIKE '%Houston%';
SELECT * FROM employee WHERE fname LIKE 'J%';

SELECT * FROM employee WHERE (sex = 'M' AND salary > 30000) OR ( sex = 'F' AND salary < 30000); 

WITH emp_sum AS (SELECT essn,SUM(hours) as total_hrs FROM works_on GROUP BY essn) SELECT es.essn from emp_sum es WHERE es.total_hrs >= 25 AND es.total_hrs <= 50 ;
WITH emp_sum AS (SELECT essn,SUM(hours) as total_hrs FROM works_on GROUP BY essn) SELECT es.essn from emp_sum es WHERE es.total_hrs BETWEEN 25 AND 50 ;

SELECT essn FROM works_on WHERE hours >=25 AND hours <= 50;
SELECT essn FROM works_on WHERE hours BETWEEN 25 AND 50;

SELECT pname FROM project WHERE plocation = 'Houston' OR plocation = 'Stafford';
SELECT pname FROM project WHERE plocation IN ('Houston' , 'Stafford');

SELECT pname FROM project WHERE plocation != 'Houston' AND plocation != 'Stafford';
SELECT pname FROM project WHERE plocation NOT IN ('Houston','Stafford');

SELECT ssn,CONCAT(fname,' ',lname) AS fullname FROM employee;

SELECT * FROM employee WHERE super_ssn IS NULL ;

SELECT ssn FROM employee ORDER BY salary;

SELECT * FROM works_on ORDER BY pno,hours;

SELECT AVG(hours) AS average_time,MIN(hours) as min_time,MAX(hours) AS max_time,SUM(hours) AS total_time FROM works_on;

SELECT COUNT(*) as employee_count FROM employee WHERE super_ssn IS NULL ;

SELECT AVG(salary) as average_salary FROM employee WHERE super_ssn IS NULL ;

SELECT MAX(salary) FROM employee WHERE sex = 'F';

SELECT MIN(salary) FROM employee WHERE sex = 'M';

SELECT d.dname AS department,count(*) AS employee_count FROM employee e INNER JOIN department d ON e.dno = d.dnumber GROUP BY d.dname;
SELECT dno,COUNT(*) AS employee_count FROM employee GROUP BY dno;

SELECT dno,sex,AVG(salary) AS avg_salary FROM employee GROUP BY dno,sex;

SELECT dno,COUNT(*) AS employee_count FROM employee WHERE sex ='M' GROUP BY dno ;

SELECT pno,AVG(hours) AS avg_hours,MIN(hours) AS min_hours,MAX(hours) AS max_hours FROM works_on GROUP BY pno;

SELECT birth_year,COUNT(*) AS employee_count FROM employee e INNER JOIN (SELECT DISTINCT YEAR(bdate) AS birth_year FROM employee) be ON YEAR(e.bdate) = be.birth_year GROUP BY birth_year;

SELECT essn,COUNT(*) AS no_of_projects FROM works_on GROUP BY essn;

SELECT dno FROM employee GROUP BY dno HAVING COUNT(*) >= 3;

SELECT dno,AVG(salary) AS avg_salary FROM employee WHERE salary >=30000 GROUP BY dno;

/* Select all employees whose compensation is
greater than that of Pataballa.*/
SELECT dno,AVG(salary) as avg_salary FROM employee GROUP BY dno HAVING COUNT(*) >= 3;
SELECT dname,AVG(salary) as avg_salary FROM employee e INNER JOIN department d ON e.dno = d.dnumber GROUP BY dno HAVING COUNT(*) >= 3;

SELECT fname FROM employee INNER JOIN department ON dno=dnumber WHERE dname = 'Research';

SELECT fname,salary FROM employee WHERE salary > (SELECT AVG(salary) FROM employee);

SELECT pno FROM works_on GROUP BY pno HAVING COUNT(*) = (SELECT MIN(emp_ct.count_emp) FROM (SELECT pno,COUNT(*) AS count_emp FROM works_on GROUP BY pno) AS emp_ct);
WITH emp_min_ct AS (SELECT MIN(emp_ct.count_emp) FROM (SELECT pno,COUNT(*) AS count_emp FROM works_on GROUP BY pno)AS emp_ct) SELECT pno FROM works_on GROUP BY pno HAVING COUNT(*)=(SELECT * FROM emp_min_ct);

SELECT fname,total_hrs FROM employee INNER JOIN (SELECT essn,SUM(hours) AS total_hrs FROM works_on GROUP BY essn) AS emp_time ON ssn = essn WHERE total_hrs >= 20;
WITH emp_time AS ((SELECT essn,SUM(hours) AS total_hrs FROM works_on GROUP BY essn)) SELECT fname,total_hrs FROM employee INNER JOIN emp_time ON ssn=essn WHERE total_hrs>=20;
-- 34 start
-- 40 to 45
SELECT e.fname AS emp_fname , m.fname AS manager_fname FROM employee e INNER JOIN employee m ON e.super_ssn=m.ssn;

WITH pd AS(SELECT w.essn,w.pno,p.pname,d.dname AS proj_dept_name FROM works_on w INNER JOIN project p INNER JOIN department d ON w.pno=p.pnumber AND p.dnum=d.dnumber)SELECT e.ssn,p.pname,d.dname AS emp_dept_name,p.proj_dept_name FROM employee e INNER JOIN department d INNER JOIN pd p ON e.dno=d.dnumber AND e.ssn=p.essn WHERE d.dname != p.proj_dept_name;

SELECT * FROM employee e INNER JOIN dependent d ON e.ssn=d.essn;

SELECT e.ssn,e.fname,d.dependent_name FROM employee e LEFT OUTER JOIN dependent d ON e.ssn=d.essn;

SELECT d.dependent_name,e.fname AS gaurdian_name FROM dependent d LEFT OUTER JOIN employee e ON d.essn=e.ssn; 

SELECT fname,salary FROM employee ORDER BY salary DESC LIMIT 3;