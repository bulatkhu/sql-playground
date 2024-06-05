-- employee_id    first_name     last_name    salary     department_id
-- 1               John            Doe         50000       10
-- 2               Jane            Smith       60000       20
-- 3               Bob             Johnson     55000       10
-- 4               Alice           Brown       70000       20
-- 5               Charlie         Davis       50000       30
drop table if exists departments;
create table departments (
    id int primary key generated by default as identity,
    number DECIMAL(4, 2),
    created_timestamp timestamp default now(),
    created_time time default now(),
    created_date date default now()
);
insert into departments (id, number) values (10, 99), (20, 99), (30, 99);

drop table if exists employees;
create table employees (
   employee_id int primary key generated always as identity,
   first_name varchar(255),
   last_name varchar(255),
   salary bigint,
   department_id int,
   foreign key (department_id) references departments(id)
);

insert into employees (first_name, last_name, salary, department_id)
values
    ('John', 'Doe', 50000, 10),
    ('Jane', 'Smith', 60000, 20),
    ('Bob', 'Johnson', 55000, 10),
    ('Alice', 'Brown', 70000, 20),
    ('Charlie', 'Davis', 50000, 30)
returning *;

select * from employees
left join departments d on employees.department_id = d.id;
-- employee_id first_name  last_name   salary  department_id   id
-- 3           Bob         Johnson     55000   10              10
-- 1           John        Doe         50000   10              10
-- 4           Alice       Brown       70000   20              20
-- 2           Jane        Smith       60000   20              20
-- 5           Charlie     Davis       50000   30              30

update departments set number = 99.99 where id = 10;
select * from departments group by departments.id limit 1;

begin;
savepoint before_salary_increase;

select * from employees
left join departments d on employees.department_id = d.id
order by employee_id;

update employees
    set salary = salary * 1.1
    where department_id = 10;

select * from employees
left join departments d on employees.department_id = d.id
order by employee_id;

rollback;
select * from employees
left join departments d on employees.department_id = d.id
order by employee_id;
commit;