Use employees;

-- Task 1: Find all the employees which name starts with 'M' and are female.alter
Select * from employees
Where first_name like 'M%' and gender like 'F'
Order by first_name;
    
-- Task 2: Find how many employees was hired before 1.1.1990.
Select 
	count(*)
From employees 
Where hire_date < '1990-01-01'
Order by emp_no;
    
-- Task 3: Find avarage salary from every department
Select 
	d.dept_name, 
    avg(s.salary) as avg_salary_by_department
From
	departments d
		join
	dept_manager dm on d.dept_no = dm.dept_no
		join
	employees e on dm.emp_no = e.emp_no
		join
	salaries s on e.emp_no = s.emp_no
Group by d.dept_name
Order by avg_salary_by_department desc;

-- Task 4: Find what is a difference between salary of the current Finance department manager and HR department manager
Select * from dept_manager;
-- We analyzed dept_manager table to see the structure
Select * from salaries;
-- By analyzing salaries table we can see that salary is inserted annually
-- Therefore, we need to take into the consideration years that current manager is on that position
-- Also, we need to be sure that we only take values connected to the current manager, since it was more of them durin the time
Select 
	e.first_name,
    e.last_name,
    t.title,
    d.dept_name,
    dm.from_date,
    dm.to_date,
	round(avg(s.salary),2) as avg_salary
From
	departments d
		join
	dept_manager dm on d.dept_no = dm.dept_no
		join
	employees e on dm.emp_no = e.emp_no
		join
	salaries s on e.emp_no = s.emp_no
		join
	titles t on s.emp_no = t.emp_no
Where
	d.dept_name = 'Human Resources' and
    t.title = 'Manager'  and
    dm.to_date = '9999-01-01'
Order by e.first_name;
-- Result -> avarage_salary: 53581,89, hired since: 1992

Select 
	e.first_name,
    e.last_name,
    t.title,
    d.dept_name,
    dm.from_date,
    dm.to_date,
	round(avg(s.salary),2) as avg_salary
From
	departments d
		join
	dept_manager dm on d.dept_no = dm.dept_no
		join
	employees e on dm.emp_no = e.emp_no
		join
	salaries s on e.emp_no = s.emp_no
		join
	titles t on s.emp_no = t.emp_no
Where
	d.dept_name = 'Finance' and
    t.title = 'Manager' and
    dm.to_date = '9999-01-01'
Order by e.first_name;
-- Resuls -> avarage_salary: 68809,00, hired since: 1989
-- Final answer: Difference between avarage salaries is 15,228, and also Finance manager is hired three years before Human Resources manager.alter

-- Task 5: How many workers was employed from 01.01.1990. to 01.01.2000. and in which department are they working?
Select 
	d.dept_name,
	count(de.emp_no) as number_of_employees
From 
	departments d
		join
	dept_emp de on d.dept_no = de.dept_no
Where
	from_date > '1990-01-01' and to_date > '2000-01-01'
Group by d.dept_name
Order by number_of_employees desc;
-- With this code we get a table with departments and number of employees in each one

-- With count function we get total amount of wokers in all departments in mentioned time frame:
Select 
	count(de.emp_no) as number_of_employees
From 
	departments d
		join
	dept_emp de on d.dept_no = de.dept_no
Where
	from_date > '1990-01-01' and to_date > '2000-01-01';
	
