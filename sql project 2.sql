create database Employee;

use Employee;

 create table emp (
 emp_id int PRIMARY KEY,
 name varchar(20),
 dob date,
 gender varchar(7),
 salary decimal(12,2),
 city varchar(20),
 department varchar(20)
 );
 
 desc emp;
 
 create table project(
 project_id int primary key ,
 project_name varchar(20),
 start_date date,
 end_date date,
 budget decimal(20,2)
 );
 
 desc project;
 
 create table emproject(
 emp_id int,
 project_id int ,
 primary key(emp_id, project_id ),
  foreign key (emp_id) references emp(emp_id),
  foreign key (project_id) references project(project_id)
  );
  
  insert into emp values 
  (001,'vishal','2003-07-2','male',70000,'pune','DS'),
  (002,'kaumudi','2002-05-04','female',40000,'pune','HR'),
  (003,'shamal','1999-02-04','female',50000,'mumbai','DS'),
  (004,'reena','1995-11-23','female',35000,'chennai','AC'),
  (005,'sahil','2006-12-04','male',20000,'mumbai','AC'),
  (006,'kajal','2005-04-24','female',75000,'pune','HR'),
  (007,'apurva','1998-04-18','female',45000,'chennai','DS'),
  (008,'arjun','1980-10-09','male',90000,'pune','HR');
  
   insert into emp values 
  (009,'anshika','2003-07-2','female',70000,'pune','DS');
  
  select * from emp;
  
  insert into project values
  (11,'classification','2025-05-25','2025-09-05',1000000),
  (12,'regression','2025-02-25','2025-12-14',5041000),
  (13,'classification','2023-04-2','2024-01-04',1045487),
  (14,'clustering','2024-07-12','2025-04-20',2500000),
  (15,'nlp_chatbot','2023-09-10','2024-08-15',3100000),
  (16,'image_classification','2024-11-05','2025-10-09',4050000),
  (17,'fraud_detection','2025-01-22','2025-09-30',5120000),
  (18,'sentiment_analysis','2024-02-15','2024-12-25',2999000),
  (19,'recommendation','2023-05-05','2024-03-10',4500000),
  (20,'object_detection','2024-04-18','2025-01-27',3850000),
  (21,'sales_forecasting','2024-08-09','2025-05-30',2750000);
  
select * from project;

insert into emproject values
(001,21),
(002,20),
(003,19),
(004,17),
(004,18),
(005,17),
(006,21),
(006,16),
(005,15),
(007,14),
(006,12),
(008,11),
(001,13),
(002,18);


select * from emproject;

-- Display each department and the number of employees in it,but only count employees whose salary is more than 25,000,
-- and show only departments having more than 3 employees.
select department,count(emp_id) from emp
where salary>35000
group by department
having count(name)>2;

-- 1.Find the second highest salary from the emp table.
select name,salary from emp
order by salary desc limit 1,1;

-- 2.Show department-wise total salary of employees.
select department ,sum(salary) from emp
group by department;

-- Display average salary for each department.
select department,avg(salary) from emp
group by department;

-- Find departments having more than 3 employees.
select department,count(emp_id) as cnt from emp
group by department
having count(emp_id)>2;


-- Show employees working on more than one project.
select emp.name,count(project.project_id) from emp
join emproject on emp.emp_id=emproject.emp_id
join project on project.project_id=emproject.project_id
group by emp.name
having count(project.project_id)>1;

-- Display employee name, project name, and department from all three tables.
select emp.name,project.project_name,emp.department from emp
join emproject on emp.emp_id=emproject.emp_id
join project on project.project_id=emproject.project_id;

-- List projects with no employees assigned.
select count(emp.emp_id) as cnt,project.project_name from emp
join emproject on emproject.emp_id=emp.emp_id
join project  on project.project_id=emproject.project_id
group by project.project_name
having cnt >1;


-- Show the highest salary in each department.
select max(salary),department from emp
group by department
having max(salary);

-- Display employees whose salary is above the average salary.
select name,salary from emp
where salary>(select avg(salary) from emp) ;

-- Find employee(s) with the minimum salary.
select name, min(salary) from emp
group by name;

-- Show employee count per department, sorted by count in descending order.\
select department,count(emp_id) as cnt from emp
group by department  
order by cnt desc;

-- Display employees who born before the year 2000.
select name,dob from emp
where year(dob)>2000;

-- Find and list duplicate salaries in the emp table
select count(salary) as cnt,salary  from emp
group by salary
having cnt >=2;

-- Show employees who earn the highest salary in their department.
select name,salary, department from emp e
where salary=(select max(salary) from emp where department=e.department);

-- Display total number of employees per project.
select count(emp.emp_id),project.project_name from emp
join emproject on emproject.emp_id=emp.emp_id
join project on project.project_id=emproject.project_id
group by project.project_name;

-- List all employees with project names, even if not assigned (use LEFT JOIN).
select emp.name,project.project_name from emp
left join emproject on emproject.emp_id=emp.emp_id
left join project on project.project_id=emproject.project_id;

-- Find average, maximum, and minimum salary from the emp table.
select avg(salary),max(salary),min(salary) from emp ;

-- Show employees from IT or HR department earning more than 50,000.
select name,department from emp
where department="AC" or department="HR";

-- Find employee(s) who joined most recently.
select name,dob from emp
order by dob desc limit 1;