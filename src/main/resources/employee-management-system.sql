--create sequence for position table
CREATE SEQUENCE position_id
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;
-- create position table
CREATE TABLE position
(
    id          bigint                 NOT NULL DEFAULT nextval('position_id'::regclass),
    name        character varying(255) NOT NULL,
    description character varying(255),
    CONSTRAINT position_pkey PRIMARY KEY (id)
);
-- create sequence for employee table
CREATE SEQUENCE employee_id
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;
-- create employee table
CREATE TABLE employee
(
    id          bigint                 NOT NULL DEFAULT nextval('employee_id'::regclass),
    first_name  character varying(255) NOT NULL,
    last_name   character varying(255) NOT NULL,
    email       character varying(255),
    age         integer,
    phone       character varying(255),
    position_id bigint                 NOT NULL,
    salary      numeric(10, 2),
    CONSTRAINT employee_pkey PRIMARY KEY (id),
    CONSTRAINT employee_position_id_fkey FOREIGN KEY (position_id) REFERENCES position (id)
);

-- create sequence for salary grades table
CREATE SEQUENCE salary_grade_id
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;
-- create salary grades table
CREATE TABLE salary_grade
(
    id          bigint                 NOT NULL DEFAULT nextval('salary_grade_id'::regclass),
    name        character varying(255) NOT NULL,
    min_salary  numeric(10, 2)         NOT NULL,
    max_salary  numeric(10, 2)         NOT NULL,
    position_id bigint                 NOT NULL,
    CONSTRAINT salary_grade_pkey PRIMARY KEY (id),
    CONSTRAINT salary_grade_position_id_fkey FOREIGN KEY (position_id) REFERENCES position (id)
);

-- create sequence for project table
CREATE SEQUENCE project_id
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;
-- create project table
CREATE TABLE project
(
    id          bigint                 NOT NULL DEFAULT nextval('project_id'::regclass),
    name        character varying(255) NOT NULL,
    description character varying(255),
    start_date  date,
    end_date    date,
    budget      numeric(10, 2),
    CONSTRAINT project_pkey PRIMARY KEY (id)
);

-- create sequence for employee_project table
CREATE SEQUENCE employee_project_id
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;
-- create employee_project table
CREATE TABLE employee_project
(
    id          bigint NOT NULL DEFAULT nextval('employee_project_id'::regclass),
    employee_id bigint NOT NULL,
    project_id  bigint NOT NULL,
    CONSTRAINT employee_project_pkey PRIMARY KEY (id),
    CONSTRAINT employee_project_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES employee (id),
    CONSTRAINT employee_project_project_id_fkey FOREIGN KEY (project_id) REFERENCES project (id)
);

-- insert data into position table
INSERT INTO position (name, description)
VALUES ('Software Engineer', 'Develops software applications'),
       ('Project Manager', 'Manages software development projects'),
       ('Quality Assurance', 'Ensures software quality');

-- insert data into employee table
INSERT INTO employee (first_name, last_name, email, age, phone, position_id, salary)
VALUES ('John', 'Doe', '', 30, '123456789', 1, 50000),
       ('Jane', 'Doe', '', 25, '987654321', 2, 70000),
       ('Alice', 'Smith', '', 35, '123456789', 3, 80000),
       ('Bob', 'Johnson', '', 40, '987654321', 1, 55000),
       ('Charlie', 'Brown', '', 45, '123456789', 2, 65000);

-- insert data into salary_grade table
INSERT INTO salary_grade (name, min_salary, max_salary, position_id)
VALUES ('Grade 1', 50000, 60000, 1),
       ('Grade 2', 60000, 70000, 2),
       ('Grade 3', 70000, 80000, 3);

-- insert data into project table
INSERT INTO project (name, description, start_date, end_date, budget)
VALUES ('Project 1', 'Develops software application', '2021-01-01', '2021-12-31', 100000),
       ('Project 2', 'Manages software development project', '2021-02-01', '2021-11-30', 150000),
       ('Project 3', 'Ensures software quality', '2021-03-01', '2021-10-31', 120000);

-- insert data into employee_project table
INSERT INTO employee_project (employee_id, project_id)
VALUES (1, 1),
       (1, 2),
       (2, 2),
       (3, 3),
       (4, 1),
       (5, 2);



-- 1. Display employees involved in at least two projects and show the project names alongside
-- employee data.
SELECT e,
       p.name AS project_name
FROM employee e
         JOIN employee_project ep ON e.id = ep.employee_id
         JOIN project p ON ep.project_id = p.id
where e.id in (select employee_id from employee_project group by employee_id having count(employee_id) >= 2);

--2. Calculate the average salary rate per position and display it in ascending order.
SELECT p.name,
       avg(e.salary) AS avg_salary
FROM employee e
         JOIN position p ON e.position_id = p.id
GROUP BY p.name
ORDER BY avg_salary;

-- 3. Update the salary of all employees by 10% if they are involved in a project with a budget
-- exceeding 100,000 euros.
UPDATE employee
SET salary = salary * 1.1
WHERE id IN (SELECT employee_id
             FROM employee_project ep
                      JOIN project p ON ep.project_id = p.id
             WHERE p.budget > 100000);

-- Delete all employees older than 40 years who are not involved in any projects
DELETE FROM employee
WHERE age > 40 AND id NOT IN (SELECT employee_id FROM employee_project);
