create table public.master_civil_status(id serial not null,name varchar(255) not null,is_active boolean default true,
constraint pk_master_civil_status_id primary key(id));

INSERT INTO public.master_civil_status (name)
SELECT 'Single' WHERE NOT EXISTS (SELECT 1 FROM public.master_civil_status WHERE name = 'Single');
INSERT INTO public.master_civil_status (name)
SELECT 'Married' WHERE NOT EXISTS (SELECT 1 FROM public.master_civil_status WHERE name = 'Married');

create table public.master_gender(id serial not null,gender varchar(100) not null,is_active boolean default true,
constraint pk_master_gender_id primary key(id));

INSERT INTO public.master_gender (gender)
SELECT 'Male' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender = 'Male');
INSERT INTO public.master_gender (gender)
SELECT 'Female' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender = 'Female');


create table public.master_position(id serial not null,position varchar(255) not null,is_active boolean default true,
constraint pk_master_position_id primary key(id));

INSERT INTO public.master_position (position)
SELECT 'Database Developer' WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Database Developer');
INSERT INTO public.master_position (position)
SELECT 'Data Engineer' WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Data Engineer');

create table public.master_paymethod(id serial not null,paymethod varchar(255) not null,is_active boolean default true,
constraint pk_master_paymethod_id primary key(id));

INSERT INTO public.master_paymethod (paymethod)
SELECT 'Weekly' WHERE NOT EXISTS (SELECT 1 FROM public.master_paymethod WHERE paymethod = 'Weekly');
INSERT INTO public.master_paymethod (paymethod)
SELECT 'Monthly' WHERE NOT EXISTS (SELECT 1 FROM public.master_paymethod WHERE paymethod = 'Monthly');


create table public.master_department(id serial not null,department varchar(255) not null,is_active boolean default true,
constraint pk_master_department_id primary key(id));

INSERT INTO public.master_department (department)
SELECT 'IT' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'IT');
INSERT INTO public.master_department (department)
SELECT 'Non-IT' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'Non-IT');

create table public.master_workstatus(id serial not null,workstatus varchar(255) not null,is_active boolean default true,
constraint pk_master_workstatus_id primary key(id));

INSERT INTO public.master_workstatus (workstatus)
SELECT 'Regular' WHERE NOT EXISTS (SELECT 1 FROM public.master_workstatus WHERE workstatus = 'Regular');
INSERT INTO public.master_workstatus (workstatus)
SELECT 'Contract' WHERE NOT EXISTS (SELECT 1 FROM public.master_workstatus WHERE workstatus = 'Contract');

create table public.employee_registration(
id serial not null,
first_name varchar(255) not null,
middle_name varchar(255) not null,
last_name varchar(255) not null,
address text,
civil_status_id integer not null,
gender_id integer not null,
mobile varchar(20) not null,
date_of_birth date,
birth_place varchar(200),
emergency_mobile varchar(20),
daily_rate decimal(10,2),
position_id int not null,
hired_date date,
pay_method_id int not null,
department_id int not null,
work_status_id int not null,
is_active boolean default true,
created_date timestamp default CURRENT_TIMESTAMP,
modified_date timestamp,
constraint pk_employee_registration_id primary key(id),
constraint fk_employee_registration_civil_status_id foreign key(civil_status_id) references public.master_civil_status(id),
constraint fk_employee_registration_gender_id foreign key(gender_id) references public.master_gender(id),
constraint fk_employee_registration_position_id foreign key(position_id) references public.master_position(id),
constraint fk_employee_registration_pay_method_id foreign key(pay_method_id) references public.master_paymethod(id),
constraint fk_employee_registration_department_id foreign key(department_id) references public.master_department(id),
constraint fk_employee_registration_work_status_id foreign key(work_status_id) references public.master_workstatus(id));

-------------------
create table public.master_leavetype(id serial not null,
leave_type varchar(255) not null,is_active boolean default true,
constraint pk_master_leavetype_id primary key(id));

INSERT INTO public.master_leavetype (leave_type)
SELECT 'Sick Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Sick Leave');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Casual Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Casual Leave');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Earned Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Earned Leave');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Optional Holiday' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Optional Holiday');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Loss of Pay' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Loss of Pay');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Compensatory Off' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Compensatory Off');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Paternity Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Paternity Leave');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Maternity Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Maternity Leave');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Miscarriage Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Miscarriage Leave');
INSERT INTO public.master_leavetype (leave_type)
SELECT 'Adoption Leave' WHERE NOT EXISTS (SELECT 1 FROM public.master_leavetype WHERE leave_type = 'Adoption Leave');


create table public.leave_application(id serial not null,
earned_leave_blnc bigint,
casual_leave_blnc bigint,
sick_leave_blnc bigint,
opt_holiday_blnc bigint,
leave_type_id int not null,
if_opt_holiday varchar(255),
leave_reason text not null,
location varchar(255),
leave_from date not null,
leave_to date not null,
mobile varchar(15) not null,
duration bigint,
is_active boolean default true,
created_date timestamp default CURRENT_TIMESTAMP,
modified_date timestamp,
constraint pk_leave_application_id primary key(id),
constraint fk_leave_application_leave_type_id foreign key(leave_type_id) references public.master_leavetype(id));

---

-----------09-12-2025 -----Authored by Anand A 
select * from master_position;

select * from master_leavetype;

select * from leave_request;


select * from employee_registration;

alter table if exists leave_request add column if not exists reporting_manager_id bigint not null;
alter table if exists leave_request add constraint fk_leave_request_reporting_manager_id foreign key(reporting_manager_id) references employee_registration(id);
alter table if exists leave_request add column if not exists from_date_session varchar(255);
alter table if exists leave_request add column if not exists to_date_session varchar(255);
alter table if exists leave_request add constraint ck_leave_request_from_date_session check (from_date_session in ('Session 1','Session 2'));
alter table if exists leave_request add constraint ck_leave_request_to_date_session check (to_date_session in ('Session 1','Session 2'));
alter table if exists leave_request add column if not exists mobile varchar(15)  not null;
alter table if exists leave_request add column if not exists upload_file varchar(500);
---------------------------------------

create table if not exists leave_request_cc(id bigserial not null,
leave_request_id bigint not null,
cc_to_id bigint not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_leave_request_cc_id primary key(id),
constraint fk_leave_request_cc_leave_request_id foreign key(leave_request_id) references leave_request(id),
constraint fk_leave_request_cc_cc_to_id foreign key(cc_to_id) references employee_registration(id),
constraint fk_leave_request_cc_created_by foreign key(created_by) references users(id),
constraint fk_leave_request_cc_modified_by foreign key(modified_by) references users(id));
------------------------------------------

create table if not exists job_openings(id bigserial not null,
position_id bigint not null,
department_id bigint not null,
status_id integer not null,
constraint pk_job_openings_id primary key(id),
constraint fk_job_openings_position_id foreign key(position_id) references master_position(id),
constraint fk_job_openings_department_id foreign key(department_id) references master_department(id),
constraint fk_job_openings_status_id foreign key(status_id) references master_status(id),
constraint uk_job_openings_position_id_department_id unique(department_id,position_id));
-------------------------------------------

create table if not exists master_status(id serial not null,
name varchar(255) not null,
is_active boolean default true,
constraint pk_master_status_id primary key(id),
constraint uk_master_status_name unique(name));
---------------------------------------------------

create table if not exists candidate_applied(id bigserial not null,
candidate_name varchar(255) not null,
position_id bigint not null,
email varchar(100) not null,
application_status_id integer not null,
upload_resume varchar(500),
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_candidate_applied_id primary key(id),
constraint fk_candidate_applied_position_id foreign key(position_id) references master_position(id),
constraint fk_candidate_applied_application_status_id foreign key(application_status_id) references master_status(id),
constraint fk_candidate_applied_created_by foreign key(created_by) references users(id),
constraint fk_candidate_applied_modified_by foreign key(modified_by) references users(id));
---------------------------------------------------------------

create table if not exists master_stage(id serial not null,
stage_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_stage_id primary key(id),
constraint uk_master_stage_stage_name unique (stage_name));

insert into master_stage(stage_name) values('Written Test'),('Technical Round'),('Final Round');

------------------------------------------------------------------
create table if not exists interview_scheduled(id bigserial not null,
candidate_id bigint not null,
interview_date date not null,
stage_id integer not null,
status_id integer not null,
feedback varchar(255),
rating varchar(20),
created_by bigint not null,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_interview_scheduled_id primary key(id),
constraint fk_interview_scheduled_candidate_id foreign key(candidate_id) references candidate_applied(id),
constraint fk_interview_scheduled_stage_id foreign key(stage_id) references master_stage(id),
constraint fk_interview_scheduled_status_id foreign key(status_id) references master_status(id),
constraint fk_interview_scheduled_created_by foreign key(created_by) references users(id),
constraint fk_interview_scheduled_modified_by foreign key(modified_by) references users(id));

-----------------------------------09/12/2025 - tharun
create table if not exists holiday_calendar(
id bigserial not null,
holiday_name varchar(255) not null,
holiday_date date not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_holiday_calendar_id primary key(id),
constraint uq_holiday_name_date unique (holiday_name,holiday_date)
);
insert into holiday_calendar (holiday_name, holiday_date)
values
('New Year', '2025-01-01'),
('Makara Sankranti', '2025-01-14'),
('Holi', '2025-03-14'),
('Eid-Ul-Fitr', '2025-03-31'),
('Good Friday', '2025-04-18'),
('May Day', '2025-05-01'),
('Ganesh Chaturthi', '2025-08-27');

-------------------------10-12-2025 -----Authored by Anand A 
alter table if exists leave_request alter column from_date_session type integer using from_date_session::integer;
alter table if exists leave_request alter column to_date_session type integer using from_date_session::integer;
alter table if exists leave_request drop constraint ck_leave_request_from_date_session;
alter table if exists leave_request drop constraint ck_leave_request_to_date_session;
alter table if exists leave_request add constraint ck_leave_request_from_date_session check (from_date_session in (1,2));
alter table if exists leave_request add constraint ck_leave_request_to_date_session check (to_date_session in (1,2));
----------------------------------

----- 11-dec-2025-- dhanusha
--- insert required data into master_status table
INSERT INTO public.master_status (name) SELECT 'In-Progress' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE name = 'In-Progress');
INSERT INTO public.master_status (name) SELECT 'Hired' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE name = 'Hired');
INSERT INTO public.master_status (name) SELECT 'Rejected' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE name = 'Rejected');
INSERT INTO public.master_status (name) SELECT 'Open' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE name = 'Open');
INSERT INTO public.master_status (name) SELECT 'Closed' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE name = 'Closed');
INSERT INTO public.master_status (name) SELECT 'Selected' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE name = 'Selected');

----- 17-dec-2025-- Lavanya
--- insert required data into master_department table

INSERT INTO public.master_department (department)SELECT 'Business & Operations'WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'Business & Operations');
INSERT INTO public.master_department (department)SELECT 'Media & Communication'WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'Media & Communication');
INSERT INTO public.master_department (department) SELECT 'People & Support' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'People & Support');
INSERT INTO public.master_department (department)SELECT 'Legal, Risk & Compliance'WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'Legal, Risk & Compliance');
INSERT INTO public.master_department (department)SELECT 'Supply Chain & Procurement'WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'Supply Chain & Procurement');
INSERT INTO public.master_department (department)SELECT 'Management & Strategy'WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department = 'Management & Strategy');
INSERT INTO public.master_department (department)SELECT 'Technology & Engineering'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'Technology & Engineering');
INSERT INTO public.master_department (department)SELECT 'Information Technology'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'Information Technology');
INSERT INTO public.master_department (department)SELECT 'Software Development'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'Software Development');
INSERT INTO public.master_department (department)SELECT 'DevOps & Cloud'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'DevOps & Cloud');
INSERT INTO public.master_department (department)SELECT 'Quality Assurance'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'Quality Assurance');
INSERT INTO public.master_department (department)SELECT 'Cyber Security'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'Cyber Security');
INSERT INTO public.master_department (department)SELECT 'Data & Analytics'WHERE NOT EXISTS (SELECT 1 FROM master_department WHERE department = 'Data & Analytics');


--- insert required data into master_position table

INSERT INTO public.master_position (position, dept_id)SELECT 'Operations Manager', 1 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Operations Manager');
INSERT INTO public.master_position (position, dept_id)SELECT 'Business Analyst', 1 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Business Analyst');
INSERT INTO public.master_position (position, dept_id)SELECT 'Content Manager', 2 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Content Manager');
INSERT INTO public.master_position (position, dept_id)SELECT 'Digital Marketing Executive', 2 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Digital Marketing Executive');
INSERT INTO public.master_position (position, dept_id)SELECT 'HR Executive', 3 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'HR Executive');
INSERT INTO public.master_position (position, dept_id)SELECT 'Talent Acquisition Specialist', 3 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Talent Acquisition Specialist');
INSERT INTO public.master_position (position, dept_id)SELECT 'Legal Officer', 4 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Legal Officer');
INSERT INTO public.master_position (position, dept_id)SELECT 'Compliance Manager', 4 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Compliance Manager');
INSERT INTO public.master_position (position, dept_id)SELECT 'Procurement Executive', 5 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Procurement Executive');
INSERT INTO public.master_position (position, dept_id)SELECT 'Logistics Coordinator', 5 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Logistics Coordinator');
INSERT INTO public.master_position (position, dept_id)SELECT 'Project Manager', 6 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Project Manager');
INSERT INTO public.master_position (position, dept_id)SELECT 'Strategy Analyst', 6 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Strategy Analyst');
INSERT INTO public.master_position (position, dept_id)SELECT 'Technology Lead', 7 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Technology Lead');
INSERT INTO public.master_position (position, dept_id)SELECT 'IT Support Engineer', 8WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'IT Support Engineer');
INSERT INTO public.master_position (position, dept_id)SELECT 'Software Engineer', 9 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Software Engineer');
INSERT INTO public.master_position (position, dept_id)SELECT 'DevOps Engineer', 10 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'DevOps Engineer');
INSERT INTO public.master_position (position, dept_id)SELECT 'QA Engineer', 11 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'QA Engineer');
INSERT INTO public.master_position (position, dept_id)SELECT 'Security Analyst', 12 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Security Analyst');
INSERT INTO public.master_position (position, dept_id)SELECT 'Data Analyst', 13 WHERE NOT EXISTS (SELECT 1 FROM public.master_position WHERE position = 'Data Analyst');

----
Create table if not exists  master_blood_group(
id serial not null,
blood_group varchar(255) not null,
is_active boolean default true,
constraint pk_master_blood_group_id primary key(id));


INSERT INTO public.master_blood_group (id, blood_group) SELECT 1, 'A+' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 1 AND blood_group = 'A+');
INSERT INTO public.master_blood_group (id, blood_group) SELECT 2, 'A-' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 2 AND blood_group = 'A-');
INSERT INTO public.master_blood_group (id, blood_group) SELECT 3, 'B+' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 3 AND blood_group = 'B+');
INSERT INTO public.master_blood_group (id, blood_group) SELECT 4, 'B-' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 4 AND blood_group = 'B-');
INSERT INTO public.master_blood_group (id, blood_group) SELECT 5, 'AB+' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 5 AND blood_group = 'AB+');
INSERT INTO public.master_blood_group (id, blood_group) SELECT 6, 'AB-' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 6 AND blood_group = 'AB-');
INSERT INTO public.master_blood_group (id, blood_group) SELECT 7, 'O+' WHERE NOT EXISTS (SELECT 1 FROM public.master_blood_group WHERE id = 7 AND blood_group = 'O+');

-----
Create table if not exists  master_occupation(
id serial not null,
occupation_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_occupation_id primary key(id));

INSERT INTO public.master_occupation(id, occupation_name) SELECT 1, 'Government Employee' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 1 AND occupation_name = 'Government Employee');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 2, 'Private Employee' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 2 AND occupation_name = 'Private Employee');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 3, 'Business' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 3 AND occupation_name = 'Business');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 4, 'Farmer' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 4 AND occupation_name = 'Farmer');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 5, 'Self Employed' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 5 AND occupation_name = 'Self Employed');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 6, 'Labourer' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 6 AND occupation_name = 'Labourer');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 7, 'Teacher' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 7 AND occupation_name = 'Teacher');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 8, 'Driver' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 8 AND occupation_name = 'Driver');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 9, 'Home Maker' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 9 AND occupation_name = 'Home Maker');
INSERT INTO public.master_occupation(id, occupation_name) SELECT 10, 'Retired' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE id = 10 AND occupation_name = 'Retired');

----

Create table if not exists  master_work_location(
id serial not null,
work_location varchar(255) not null,
is_active boolean default true,
constraint pk_master_work_location_id primary key(id));

INSERT INTO public.master_work_location (work_location) SELECT 'Hyderabad' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_location WHERE  work_location = 'Hyderabad');
INSERT INTO public.master_work_location (work_location) SELECT 'Bangalore' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_location WHERE  work_location = 'Bangalore');
INSERT INTO public.master_work_location (work_location) SELECT 'Chennai' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_location WHERE  work_location = 'Chennai');

-----

Create table if not exists  master_shift(
id serial not null,
shift_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_shift_id primary key(id));

INSERT INTO public.master_shift (shift_type) SELECT  'Day' WHERE NOT EXISTS (SELECT 1 FROM public.master_shift WHERE  shift_type = 'Day');
INSERT INTO public.master_shift (shift_type) SELECT  'Night' WHERE NOT EXISTS (SELECT 1 FROM public.master_shift WHERE  shift_type = 'Night');
INSERT INTO public.master_shift (shift_type) SELECT  'Flexible' WHERE NOT EXISTS (SELECT 1 FROM public.master_shift WHERE  shift_type = 'Flexible');
------
Create table if not exists  master_relation(
id serial not null,
relation_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_relation_id primary key(id));

INSERT INTO public.master_relation (relation_type) SELECT  'Father' WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE   relation_type = 'Father');
INSERT INTO public.master_relation (relation_type) SELECT  'Mother' WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE   relation_type = 'Mother');
INSERT INTO public.master_relation (relation_type) SELECT  'Spouse' WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE   relation_type = 'Spouse');
INSERT INTO public.master_relation (relation_type) SELECT  'Son' WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE   relation_type = 'Son');
INSERT INTO public.master_relation (relation_type) SELECT  'Daughter' WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE   relation_type = 'Daughter');
  
-----------------------17/12/2025 ----tharun
alter table if exists employee_registration add column if not exists father_name varchar(255);
alter table if exists employee_registration add column if not exists blood_group_id int;
alter table employee_registration add constraint fk_employee_registration_blood_group_id foreign key (blood_group_id) references master_blood_group(id);

alter table master_civil_status rename to master_marital_status
alter table employee_registration rename column civil_status_id to marital_status_id
alter table master_marital_status rename constraint pk_master_civil_status_id to pk_master_marital_status_id;
alter sequence master_civil_status_id_seq rename to master_marital_status_id_seq;


alter table employee_registration rename column address to present_address

alter table if exists employee_registration add column if not exists permanent_address varchar(255);

alter table if exists employee_registration add column if not exists role_id int;
alter table employee_registration add constraint fk_employee_registration_role_id foreign key (role_id) references master_role(id);

alter table master_position rename to master_designation
alter table employee_registration rename column position_id to designation_id
alter table master_designation rename column "position" to designation_name;


alter table master_designation rename constraint pk_master_position_id to pk_master_designation_id;
alter sequence master_position_id_seq rename to master_designation_id_seq;


alter table master_workstatus rename to master_employee_type
alter table  employee_registration rename column work_status_id to employee_type_id
alter table master_employee_type rename constraint pk_master_workstatus_id to pk_master_employee_type_id;
alter sequence master_workstatus_id_seq rename to master_employee_type_id_seq;
alter table master_employee_type rename column workstatus to employee_type

insert into master_employee_type(employee_type)values('Intern')

alter table if exists employee_registration add column if not exists work_location_id int;
alter table if exists employee_registration add column if not exists shift_id int;

alter table if exists employee_registration add column if not exists probation_end_date date;

insert into master_status(name)values('Active'),('On leave'),('Resigned');

alter table if exists employee_registration add column if not exists aadhaar varchar(15);
alter table if exists employee_registration add column if not exists ctc numeric(10,2);
alter table if exists employee_registration add column if not exists reference_mobile varchar(15);

------------------------
create table if not exists employee_family_member(
id bigserial not null,
emp_id int not null,
relation_id int not null,
first_name varchar(255) not null,
last_name varchar(255) not null,
date_of_birth date not null,
occupation_id int not null,
phone varchar(255) ,
email varchar(150) ,
present_address varchar(255) not null,
permanent_address varchar(255) not null,
bank_account varchar(255) ,
ifsc_code varchar(255) ,
pan varchar(255),
aadhar varchar(255) not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,  	
is_active boolean default true,
constraint pk_employee_family_member_id primary key (id),
constraint fk_employee_family_member_emp_id foreign key (emp_id) references employee_registration(id),
constraint fk_employee_family_member_relation_id foreign key (relation_id) references master_relation (id),
constraint fk_employee_family_member_occuupation_id foreign key (occuupation_id) references master_occupation (id),
constraint uk_employee_family_member_email unique (email));

select * from employee_family_member;
--------------------------------23/12/2025 
insert into master_status (name) select 'Approved' where not exists (select 1 from master_status where name='Approved');
insert into master_status (name) select 'Pending' where not exists (select 1 from master_status where name='Pending');
alter table if exists leave_request drop constraint fk_leave_request_approval_status_id;
alter table if exists leave_request rename column approval_status_id to status_id;
alter table if exists leave_request add constraint fk_leave_request_status_id foreign key (status_id) references master_status(id);
drop table if exists master_approval_status;

------------------------30/12/2025 ---Tharun

delete from candidate_applied where designation_id in 
(select id  from master_designation where dept_id in
(select id from master_department where id between 15 and 36));

delete from job_openings where designation_id in 
(select id  from master_designation where dept_id in
(select id from master_department where id between 15 and 36));

delete from job_openings where department_id in 
(select id from master_department where id between 15 and 36);


delete from master_designation where dept_id in
(select id from master_department where id between 15 and 36);

delete from public.master_department where id between 15 and 36;

delete from master_designation where id in (23,24)

update  master_department set is_active ='true';
update master_designation set is_active = 'true';
update job_openings set is_active = 'true';
SELECT setval('master_department_id_seq', (SELECT MAX(id) +1 FROM master_department));
SELECT setval('master_designation_id_seq', (SELECT MAX(id) +1 FROM master_designation));

cluster master_department using pk_master_department_id;
cluster master_designation using pk_master_designation_id;


---30-dec-2025 -- dhanusha
alter table leave_request drop constraint ck_leave_request_from_date_session;
alter table leave_request drop constraint ck_leave_request_to_date_session
------29/12/2025 lavanya

create table if not exists public.master_session (
id serial not null,
session_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_session_id primary key (id),
constraint uk_master_session_session_name unique(session_name));


INSERT INTO public.master_session (session_name) SELECT  'First Half' WHERE NOT EXISTS (SELECT 1 FROM public.master_session WHERE  session_name = 'First Half');
INSERT INTO public.master_session (session_name)  SELECT 'Second Half' WHERE NOT EXISTS (SELECT 1 FROM public.master_session WHERE  session_name = 'Second Half');
INSERT INTO public.master_session (session_name)  SELECT 'Full Day' WHERE NOT EXISTS (SELECT 1 FROM public.master_session WHERE  session_name = 'Full Day');

alter sequence master_session_id_seq restart with 1;

select * from leave_request where 
alter table leave_request rename to_date_session to  to_date_session_id;
alter table leave_request rename from_date_session to from_date_session_id;

alter table leave_request add constraint fk_leave_request_to_date_session_id foreign key (to_date_session_id) references master_session(id);
alter table leave_request add constraint fk_leave_request_from_date_session_id foreign key (from_date_session_id) references master_session(id);

--------------------31/12/2025 ---Tharun

alter table payslips add column perc_cal_id int
alter table payslips add constraint fk_payslips_perc_cal_id foreign key (perc_cal_id) references master_perc_cal_id(id)

create table if not exists master_perc_cal_id(
id  serial not null,
basic_perc numeric(10,2) not null,
conveyance_perc numeric(10,2) not null,
hra_perc numeric(10,2),
medical_allowance_perc numeric(10,2) not null,
special_allowance_perc numeric(10,2) not null,
arrears_perc numeric(10,2) not null,
total_earnings_perc numeric(10,2) not null,
pf_perc numeric(10,2) not null,
esic_perc numeric(10,2) not null,
pt_perc numeric(10,2) not null,
tds_perc numeric(10,2) not null,
other_deductions_perc numeric(10,2) not null,
total_deductions_perc numeric(10,2) not null,
gross_earning_perc numeric(10,2) not null,
deduction_perc numeric(10,2) not null,
net_pay_perc numeric(10,2) not null,
net_pay_in_words_perc numeric(10,2) not null,
is_active boolean default true,
constraint pk_master_perc_calc_id primary key (id)
);
-----
drop function  fn_leave_request_before_save() CASCADE;
------
delete from master_session where id = 3;
update master_session set session_name ='Session 1' where id = 1;
update master_session set session_name ='Session 2' where id = 2;

-------- Tharun ---02/01/2026

INSERT INTO public.master_perc_cal_id (basic_perc, conveyance_perc, hra_perc, medical_allowance_perc, special_allowance_perc, arrears_perc, total_earnings_perc, pf_perc, esic_perc, pt_perc, tds_perc, other_deductions_perc, total_deductions_perc, gross_earning_perc, deduction_perc, net_pay_perc, net_pay_in_words_perc)
SELECT 40.00, 10.00, 20.00, 5.00, 15.00, 0.00, 90.00, 12.00, 0.75, 2.00, 5.00, 1.25, 21.00, 90.00, 21.00, 69.00, 69.00
WHERE NOT EXISTS (SELECT 1 FROM public.master_perc_cal_id m WHERE m.basic_perc = 40.00 AND m.conveyance_perc = 10.00 AND m.hra_perc = 20.00
      AND m.medical_allowance_perc = 5.00
      AND m.special_allowance_perc = 15.00
      AND m.arrears_perc = 0.00
      AND m.total_earnings_perc = 90.00
      AND m.pf_perc = 12.00
      AND m.esic_perc = 0.75
      AND m.pt_perc = 2.00
      AND m.tds_perc = 5.00
      AND m.other_deductions_perc = 1.25
      AND m.total_deductions_perc = 21.00
      AND m.gross_earning_perc = 90.00
      AND m.deduction_perc = 21.00
      AND m.net_pay_perc = 69.00
      AND m.net_pay_in_words_perc = 69.00
);
--------
update payslips set perc_cal_id = 1;
------- insert into master_occupation 
INSERT INTO public.master_occupation(occupation_name) SELECT 'Government Employee' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Government Employee');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Private Employee' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Private Employee');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Business' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Business');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Farmer' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Farmer');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Self Employed' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Self Employed');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Labourer' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Labourer');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Teacher' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Teacher');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Driver' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Driver');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Home Maker' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Home Maker');
INSERT INTO public.master_occupation(occupation_name) SELECT 'Retired' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'Retired');
INSERT INTO public.master_occupation(occupation_name) SELECT 'N/A' WHERE NOT EXISTS (SELECT 1 FROM public.master_occupation WHERE occupation_name = 'N/A');

alter sequence master_occupation_id_seq restart with 1;

--------------insert into master_relation 

SELECT setval('master_relation_id_seq', (SELECT MAX(id) FROM master_relation));
INSERT INTO public.master_relation(relation_type) SELECT 'Husband' WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE relation_type = 'Husband');

------------- insert into to ctc column constraint null to not null

update employee_registration set ctc = 320000 where id between 1 and 8;
update employee_registration set ctc = 420000 where id = 20;
update employee_registration set ctc = 420000 where id = 90;
alter table employee_registration alter column ctc set not null;

---------------
delete from leave_request_cc where leave_request_id in 
(select id from public.leave_request where status_id in 
(select id from master_status where name ='Approved'));

delete from public.leave_request where status_id in 
(select id from master_status where name ='Approved');
    
-------- dhanusha --5th-jan-2026

alter table employee_registration rename constraint  fk_employee_registration_position_id to fk_employee_registration_designation_id

alter table employee_registration add constraint fk_employee_registration_bank_id foreign key (bank_id) references master_bank(id);

--------------06/01/2026  ----Tharun

alter table employee_registration drop column paymethod_id;
----------
create table if not exists master_module(
id serial not null,
module_name varchar(255) not null,
fa_fa_icon varchar(500),
routes varchar(255),
order_by int,
is_active boolean DEFAULT true,
constraint pk_master_module_id primary key (id)
);

INSERT INTO master_module (module_name) SELECT 'Dashboard' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Dashboard');

INSERT INTO master_module (module_name) SELECT 'Employees' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Employees');

INSERT INTO master_module (module_name) SELECT 'Attendance Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Attendance Management');

INSERT INTO master_module (module_name) SELECT 'Task Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Task Management');

INSERT INTO master_module (module_name) SELECT 'Leave Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Leave Management');

INSERT INTO master_module (module_name) SELECT 'Payroll' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Payroll');

INSERT INTO master_module (module_name) SELECT 'Performance' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Performance');

INSERT INTO master_module (module_name) SELECT 'Recruitment' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Recruitment');

INSERT INTO master_module (module_name) SELECT 'Reports' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Reports');

INSERT INTO master_module (module_name) SELECT 'Analytics' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Analytics');

INSERT INTO master_module (module_name) SELECT 'Access Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Access Management');

INSERT INTO master_module (module_name) SELECT 'Settings' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Settings');

select * from master_module;

---------

create table if not exists master_screen(
id serial not null,
screen_name varchar(255) not null,
module_id int,
screen_label varchar(255),
fa_fa_icon varchar(500),
routes varchar(255),
order_by int,
is_active boolean DEFAULT true,
constraint pk_master_screen_id primary key(id),
constraint fk_master_screen_module_id foreign key (module_id) references master_module(id)
);

INSERT INTO master_screen (screen_name) SELECT 'Leave Apply' WHERE NOT EXISTS ( SELECT 1 FROM master_screen WHERE screen_name = 'Leave Apply');

INSERT INTO master_screen (screen_name) SELECT 'Leave Balance' WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Leave Balance');

INSERT INTO master_screen (screen_name) SELECT 'Leave Calendar' WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Leave Calendar');

INSERT INTO master_screen (screen_name) SELECT 'Holiday Calendar' WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Holiday Calendar');

select * from master_screen;
-----------

create table if not exists master_screen_permission(
id serial not null,
module_id int,
screen_id int,
role_id int,
can_view  boolean,
can_edit boolean,
can_delete boolean,
can_access boolean,
can_update boolean,
is_active boolean DEFAULT true,
constraint pk_master_screen_permission_id primary key (id),
constraint fk_master_screen_permission_module_id foreign key (module_id) references master_module(id),
constraint fk_master_screen_permission_screen_id foreign key (screen_id) references master_screen(id),
constraint fk_master_screen_permission_role_id foreign key (role_id) references master_role(id)
);

select * from master_screen_permission;

-----------------07/01/2026  ----Tharun

CREATE TABLE IF NOT EXISTS public.employee_rating
(
    id bigint NOT NULL ,
    emp_id int NOT NULL,
    designation_id int NOT NULL,
    rating numeric(2,1) NOT NULL,
    reviewer_id int NOT NULL,
    created_by bigint,
    created_date timestamp without time zone DEFAULT now(),
    modified_by bigint,
    modified_date timestamp without time zone,
    is_active boolean DEFAULT true,
    CONSTRAINT pk_employee_rating_id PRIMARY KEY (id),
    CONSTRAINT fk_employee_rating_designation_id FOREIGN KEY (designation_id) REFERENCES public.master_designation (id),
    CONSTRAINT fk_employee_rating_emp_id FOREIGN KEY (emp_id) REFERENCES public.employee_registration (id),
    CONSTRAINT fk_employee_rating_reviewer_id FOREIGN KEY (reviewer_id) REFERENCES public.employee_registration (id)
);

-----------------

create or replace view vw_performance_rating as
with perf_rating as (
select e.id as emp_id,concat_ws(' ',e.first_name,e.last_name)::varchar as employee_name
from employee_registration e where e.is_active = true)

select er.id,
    er.emp_id,
    pr.employee_name,
    er.designation_id,
    d.designation_name,
    er.rating,
    er.reviewer_id as reviewer_id,
    pr1.employee_name as reviewer_name,
    er.created_date
from employee_rating er
left join perf_rating pr on pr.emp_id = er.emp_id
left join perf_rating pr1 on pr1.emp_id = er.reviewer_id
left join master_designation d on d.id = er.designation_id and d.is_active = true
where er.is_active = true
order by 1 desc;

--------------- Tharun ---08/01/2026

INSERT INTO master_module (module_name) SELECT 'Dashboard' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Dashboard');

INSERT INTO master_module (module_name) SELECT 'Employees' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Employees');

INSERT INTO master_module (module_name) SELECT 'Attendance Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Attendance Management');

INSERT INTO master_module (module_name) SELECT 'Task Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Task Management');

INSERT INTO master_module (module_name) SELECT 'Leave Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Leave Management');

INSERT INTO master_module (module_name) SELECT 'Payroll management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Payroll management');

INSERT INTO master_module (module_name) SELECT 'Salary' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Salary');

INSERT INTO master_module (module_name) SELECT 'Performance' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Performance');

INSERT INTO master_module (module_name) SELECT 'Recruitment' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Recruitment');

INSERT INTO master_module (module_name) SELECT 'Reports' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Reports');

INSERT INTO master_module (module_name) SELECT 'Analytics' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Analytics');

INSERT INTO master_module (module_name) SELECT 'Access' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Access');

INSERT INTO master_module (module_name) SELECT 'Access Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Access Management');

INSERT INTO master_module (module_name) SELECT 'Settings' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Settings');



begin;
delete from master_module;
rollback;
commit;

ALTER SEQUENCE master_module_id_seq RESTART WITH 1;

---------------
select * from master_screen;


delete from master_screen;
ALTER SEQUENCE master_screen_id_seq RESTART WITH 1;

INSERT INTO master_screen (screen_name, module_id) SELECT 'Leave Apply', 5 WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Leave Apply' AND module_id = 5);

INSERT INTO master_screen (screen_name, module_id) SELECT 'Leave Balance', 5 WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Leave Balance' AND module_id = 5);

INSERT INTO master_screen (screen_name, module_id) SELECT 'Leave Calendar', 5 WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Leave Calendar' AND module_id = 5);

INSERT INTO master_screen (screen_name, module_id) SELECT 'Holiday Calendar', 5 WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Holiday Calendar' AND module_id = 5);

INSERT INTO master_screen (screen_name, module_id) SELECT 'Payslips', 7 WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name = 'Payslips' AND module_id = 7);


---------------------------------

select * from master_designation order by 1;

BEGIN;

DELETE FROM master_designation
WHERE id BETWEEN 21 AND 27;

SELECT * FROM master_designation order by 1;

COMMIT;

UPDATE master_designation SET is_active = true;
cluster master_designation using pk_master_designation_id;

------------Tharun ---09/01/2026
create table if not exists employee_activity(
id bigserial not null,
emp_id int not null,
module_id int not null,
screen_id int not null,
activity_description varchar(255) not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,  	
is_active boolean default true,
constraint pk_employee_activity_id primary key (id),
constraint fk_employee_activity_emp_id foreign key (emp_id) references employee_registration (id),
constraint fk_employee_activity_module_id foreign key (module_id) references master_module (id),
constraint fk_employee_activity_screen_id foreign key (screen_id) references master_screen (id)
);

select * from employee_activity;

-------------
create or replace view vw_recent_activity as
with active_employees AS (
select id as emp_id,
CONCAT_WS(' ', first_name, last_name)::varchar as employee_name
from employee_registration
where is_active = true
)
select ea.emp_id,ae.employee_name, ea.module_id, mm.module_name,ea.screen_id, ms.screen_name,
TO_CHAR(ea.created_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar AS created_date, ea.activity_description
from employee_activity ea
left join active_employees ae on ae.emp_id = ea.emp_id and ea.is_active = true
left join master_module mm on mm.id = ea.module_id and mm.is_active = true
left join master_screen ms on ms.id = ea.screen_id and ms.is_active = true
where ea.is_active = true
order by ea.created_date desc;

select * from vw_recent_activity where (emp_id = emp_id or -1 = emp_id);

---- 9-jan ---dhanusha
create view vw_view_login_list as

select er.id as emp_id, u.id as user_id, concat_ws(' ',u.first_name,u.last_name)::varchar as user_name,
u.email,u.password,mr.id as role_id,mr.role_name 
from users u
left join employee_registration er ON er.user_id = u.id and er.is_active = true
left join master_role mr on mr.id = u.role_id and mr.is_active=true


create view vw_screen_permission_list as
select mm.id as module_id,mm.module_name,ms.id as screen_id,ms.screen_name,msp.role_id,
mm.fa_fa_icon,mm.routes,msp.can_view,msp.can_edit,msp.can_delete,msp.can_access,msp.can_update
from master_module mm
left join master_screen ms on ms.module_id = mm.id and ms.is_active =true
left join master_screen_permission msp on msp.screen_id = ms.id and msp.is_active =true

--- added unique constraints for below table 

alter table employee_registration add constraint uk_employee_registration_user_id unique (user_id);
alter table master_screen_permission add constraint uk_master_screen_permission_module_screen_role_id unique(module_id,screen_id,role_id);
alter table  master_screen add constraint uk_master_screen_module_id_screen_name unique(module_id,screen_name);



-------------- tharun ----12/01/2026
insert into master_module (module_name) select 'All' where not exists (select 1 from master_module where module_name ='All');
insert into master_screen (screen_name) select 'All' where not exists (select 1 from master_screen where screen_name ='All');

---------
truncate table master_screen_permission restart identity;
delete from employee_activity;
delete from master_screen;
delete from master_module;


-- call public.sp_sequence_reset_or_restart('public');

INSERT INTO master_module(module_name) SELECT 'Dashboard' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Dashboard');
INSERT INTO master_module(module_name) SELECT 'Employees' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Employees');
INSERT INTO master_module(module_name) SELECT 'Attendance Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Attendance Management');
INSERT INTO master_module(module_name) SELECT 'Task Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Task Management');
INSERT INTO master_module(module_name) SELECT 'Leave Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Leave Management');
INSERT INTO master_module(module_name) SELECT 'Payroll Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Payroll management');
INSERT INTO master_module(module_name) SELECT 'Salary' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Salary');
INSERT INTO master_module(module_name) SELECT 'Performance' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Performance');
INSERT INTO master_module(module_name) SELECT 'Recruitment' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Recruitment');
INSERT INTO master_module(module_name) SELECT 'Config' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Config');
INSERT INTO master_module(module_name) SELECT 'Reports' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Reports');
INSERT INTO master_module(module_name) SELECT 'Analytics' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Analytics');
INSERT INTO master_module(module_name) SELECT 'Access' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Access');
INSERT INTO master_module(module_name) SELECT 'Access Management' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Access Management');
INSERT INTO master_module(module_name) SELECT 'Settings' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='Settings');
INSERT INTO master_module(module_name) SELECT 'All' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name='All');

-------
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Dashboard',1,'Dashboard'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Dashboard' AND module_id=1  AND screen_label='Dashboard');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Employees',2,'Employees'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Employees' AND module_id=2  AND screen_label='Employees');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Attendance Management',3,'AttendanceManagement'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Attendance Management' AND module_id=3  AND screen_label='AttendanceManagement');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Task Management',4,'TaskManagement'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Task Management' AND module_id=4  AND screen_label='TaskManagement');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Leave Management',5,'LeaveManagement'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Leave Management' AND module_id=5  AND screen_label='LeaveManagement');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Leave Apply',5,'LeaveApply'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Leave Apply' AND module_id=5  AND screen_label='LeaveApply');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Leave Balance',5,'LeaveBalance'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Leave Balance' AND module_id=5  AND screen_label='LeaveBalance');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Leave Calendar',5,'LeaveCalendar'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Leave Calendar' AND module_id=5  AND screen_label='LeaveCalendar');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Holiday Calendar',5,'HolidayCalendar'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Holiday Calendar' AND module_id=5  AND screen_label='HolidayCalendar');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Payroll management',6,'PayrollManagement'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Payroll management' AND module_id=6  AND screen_label='PayrollManagement');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Payslips',7,'Payslips'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Payslips' AND module_id=7  AND screen_label='Payslips');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Performance',8,'Performance'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Performance' AND module_id=8  AND screen_label='Performance');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Recruitment',9,'Recruitment'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Recruitment' AND module_id=9  AND screen_label='Recruitment');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Config',10,'Config'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Config' AND module_id=10  AND screen_label='Config');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Reports',11,'Reports'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Reports' AND module_id=11  AND screen_label='Reports');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Analytics',12,'Analytics'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Analytics' AND module_id=12  AND screen_label='Analytics');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Access',13,'Access'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Access' AND module_id=13  AND screen_label='Access');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Access Management',14,'AccessManagement'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Access Management' AND module_id=14  AND screen_label='AccessManagement');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'Settings',15,'Settings'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='Settings' AND module_id=15  AND screen_label='Settings');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'ALL',16,'ALL'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='ALL' AND module_id=16  AND screen_label='ALL');

-----------
-- DROP VIEW public.vw_screen_permission_list;

CREATE OR REPLACE VIEW public.vw_screen_permission_list
 AS
 SELECT mm.id AS module_id,
    mm.module_name,
    ms.id AS screen_id,
    ms.screen_name,
    ms.screen_label,
    ms.fa_fa_icon AS screen_icon,
    ms.routes AS screen_routes,
    msp.role_id,
    mr.role_name,
    msp.can_view,
    msp.can_edit,
    msp.can_delete,
    msp.can_access,
    msp.can_update
   FROM master_module mm
     LEFT JOIN master_screen ms ON ms.module_id = mm.id AND ms.is_active = true
     LEFT JOIN master_screen_permission msp ON msp.screen_id = ms.id AND msp.is_active = true
     LEFT JOIN master_role mr ON mr.id = msp.role_id AND mr.is_active = true AND mm.is_active = true
  ORDER BY mm.id, mm.module_name DESC;
  
  ----------------- 19/01/2026   ---Tharun

  create table if not exists master_task_type(
id serial not null,
task_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_task_type_id primary key(id),
constraint uk_master_task_task_type unique(task_type));

INSERT INTO master_task_type (task_type) SELECT 'Bug' WHERE NOT EXISTS ( SELECT 1 FROM master_task_type WHERE task_type = 'Bug' );
INSERT INTO master_task_type (task_type) SELECT 'Feature' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Feature');
INSERT INTO master_task_type (task_type) SELECT 'Improvement' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Improvement');
INSERT INTO master_task_type (task_type) SELECT 'Incident' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Incident');
INSERT INTO master_task_type (task_type) SELECT 'Task' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Task');
INSERT INTO master_task_type (task_type) SELECT 'Change Request' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Change Request');
INSERT INTO master_task_type (task_type) SELECT 'Documentation' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Documentation');
INSERT INTO master_task_type (task_type) SELECT 'Database Change' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Database Change');
INSERT INTO master_task_type (task_type) SELECT 'Configuration Change' WHERE NOT EXISTS (SELECT 1 FROM master_task_type WHERE task_type = 'Configuration Change');

select * from master_task_type;

create table if not exists  master_project(
id serial not null,
project_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_project_id primary key(id),
constraint uk_master_project unique(project_name));

select * from master_project;

create table if not exists tasks(
id bigserial not null,
title varchar(255) not null,
description text not null,
task_type_id integer not null,
project_id integer not null,
emp_id bigint not null,
reporting_manager_id bigint,
task_manager_id bigint,
status_id integer not null,
due_date date not null,
efforts_in_days integer,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,  	
is_active boolean default true,
constraint pk_tasks_id primary key(id),
constraint fk_tasks_task_type_id foreign key (task_type_id) references master_task_type(id),
constraint fk_tasks_project_id foreign key (project_id) references master_project(id),
constraint fk_tasks_emp_id foreign key (emp_id) references employee_registration (id),
constraint fk_tasks_status_id foreign key (status_id) references master_status (id),
constraint uk_tasks_title_task_type_id_project_id_emp_id_status_id unique (title,task_type_id,project_id,emp_id,status_id)
);

select * from tasks;

create table if not exists task_history( 
id bigserial not null,
task_id bigint not null,
emp_id bigint not  null,
project_id bigint not null,
from_assignee_id bigint,
to_assignee_id bigint,
reporting_manager_id bigint,
comments varchar,
rating int, 
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,  	
is_active boolean default true,
constraint pk_task_history_id primary key (id),
constraint fk_task_history_task_id foreign key (task_id) references tasks(id),
constraint fk_task_history_emp_id foreign key (emp_id) references employee_registration (id),
constraint ck_task_history_rating check (rating between 1 and 5),
constraint fk_task_history_project_id foreign key (project_id) references master_project(id),
constraint fk_task_history_reporting_manager_id foreign key (reporting_manager_id) references employee_registration(id),
constraint fk_task_history_from_assignee_id foreign key (from_assignee_id) references employee_registration(id),
constraint fk_task_history_to_assignee_id foreign key (to_assignee_id) references employee_registration(id)
);

select * from task_history;

-------------------21/01/2026  ------tharun
create or replace view vw_task_history_details as
with emp_details as (
select
id,concat_ws(' ', first_name, last_name)::varchar as emp_name
from employee_registration
where is_active = true
),
active_task_history as (
select
task_id,rating,comments,description,modified_date,from_assignee_id,to_assignee_id
from task_history
where is_active = true
)
select
t.id as task_id, t.title, t.emp_id,e.emp_name as employee_name,t.project_id, mp.project_name,
t.reporting_manager_id,e1.emp_name as reporting_manager_name, ath.comments, ath.rating,
t.efforts_in_days,ath.description as description,
    ath.modified_date,ath.from_assignee_id,ath.to_assignee_id
from tasks t
left join active_task_history ath on ath.task_id = t.id
left join emp_details e on e.id = t.emp_id
left join emp_details e1 on e1.id = t.reporting_manager_id
left join emp_details e2 on e2.id = ath.from_assignee_id
left join emp_details e3 on e3.id = ath.to_assignee_id
left join master_project mp on mp.id = t.project_id and mp.is_active = true
where t.is_active = true;

------
alter table task_history add column description varchar(500);

------------------22/01/2026  -----tharun

create table if not exists master_project_module(
id serial not null,
project_module varchar(255) not null,
project_id bigint not null,
is_active boolean default true,
constraint pk_master_project_module_id primary key (id),
constraint fk_master_project_module_project_id foreign key (project_id) references master_project(id)
);

select * from master_project_module;

alter table tasks add column project_module_id bigint;
alter table tasks add constraint fk_tasks_project_module_id foreign key(project_module_id) references master_project_module(id);

alter table tasks add column project_screen_id bigint not null;
alter table tasks add constraint fk_tasks_project_screen_id foreign key(project_screen_id) references master_project_screen(id);


alter table task_history add column project_module_id bigint;
alter table task_history add constraint fk_task_history_project_module_id foreign key(project_module_id) references master_project_module(id);

alter table task_history add column project_screen_id bigint not null;
alter table task_history add constraint fk_task_history_project_screen_id foreign key(project_screen_id) references master_project_screen(id);

--------
create or replace view vw_task_history_details as
with emp_details as (
select
id,
concat_ws(' ', first_name, last_name)::varchar as emp_name
from employee_registration
where is_active = true
),
active_task_history as (
select
task_id,
rating,
comments,
from_assignee_id,
project_module_id,
to_assignee_id
from task_history
where is_active = true
)
select
t.id as task_id, t.title, t.emp_id,e.emp_name as employee_name,t.project_id, mp.project_name,
t.reporting_manager_id,e1.emp_name as reporting_manager_name, ath.comments, ath.rating,
t.efforts_in_days,t.description,ath.from_assignee_id,ath.to_assignee_id,pm.id as project_module_id,pm.project_module

from tasks t
left join active_task_history ath on ath.task_id = t.id
left join emp_details e on e.id = t.emp_id
left join emp_details e1 on e1.id = t.reporting_manager_id
left join emp_details e2 on e2.id = ath.from_assignee_id
left join emp_details e3 on e3.id = ath.to_assignee_id
left join master_project mp on mp.id = t.project_id and mp.is_active = true
left join master_project_module pm on pm.id = ath.project_module_id and pm.is_active = true
where t.is_active = true;


INSERT INTO master_project_module (project_module, project_id) SELECT 'Dashboard', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Dashboard');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Employees', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Employees');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Task Management', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Task Management');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Leave Management', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Leave Management');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Payroll Management', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Payroll Management');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Salary', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Salary');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Performance', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Performance');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Recruitment', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Recruitment');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Config', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Config');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Reports', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Reports');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Analytics', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Analytics');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Access Management', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Access Management');
INSERT INTO master_project_module (project_module, project_id) SELECT 'Settings', 1 WHERE NOT EXISTS (SELECT 1 FROM master_project_module WHERE project_id = 1 AND project_module = 'Settings');


------------------23/01/2026  -----tharun
create table if not exists master_sub_module(
id serial not null,
sub_module_name varchar(255) not null,
module_id int,
screen_label varchar(255),
fa_fa_icon varchar(500),
routes varchar(255),
order_by int,
is_active boolean DEFAULT true,
constraint pk_master_sub_module_id primary key(id),
constraint fk_master_sub_module_module_id foreign key (module_id) references master_module(id)
);
-------
ALTER TABLE master_screen_permission
DROP CONSTRAINT fk_master_screen_permission_screen_id;

ALTER TABLE master_screen_permission
RENAME COLUMN screen_id TO sub_module_id;


ALTER TABLE master_screen_permission
ADD CONSTRAINT fk_master_screen_permission_sub_module_id
FOREIGN KEY (sub_module_id)
REFERENCES master_sub_module (id);

---
ALTER TABLE employee_activity
DROP CONSTRAINT fk_employee_activity_screen_id;

ALTER TABLE employee_activity
RENAME COLUMN screen_id TO sub_module_id;

ALTER TABLE employee_activity
ADD CONSTRAINT fk_employee_activity_sub_module_id
FOREIGN KEY (sub_module_id)
REFERENCES master_sub_module(id);
------------------ modified
create view vw_screen_permission_list as
select mm.id as module_id,mm.module_name,ms.id as sub_module_id,ms.sub_module_name,msp.role_id,
ms.fa_fa_icon,ms.routes,msp.can_view,msp.can_edit,msp.can_delete,msp.can_access,msp.can_update
from master_module mm
left join master_sub_module ms on ms.module_id = mm.id and ms.is_active =true
left join master_screen_permission msp on msp.sub_module_id = ms.id and msp.is_active =true

select * from vw_screen_permission_list;
--------------------- modified
create or replace view vw_recent_activity as
with active_employees AS (
select id as emp_id,
CONCAT_WS(' ', first_name, last_name)::varchar as employee_name
from employee_registration
where is_active = true
)
select ea.emp_id,ae.employee_name, ea.module_id, mm.module_name,ea.sub_module_id, ms.sub_module_name,
TO_CHAR(ea.created_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar AS created_date, ea.activity_description
from employee_activity ea
left join active_employees ae on ae.emp_id = ea.emp_id and ea.is_active = true
left join master_module mm on mm.id = ea.module_id and mm.is_active = true
left join master_sub_module ms on ms.id = ea.sub_module_id and ms.is_active = true
where ea.is_active = true
order by ea.created_date desc;

select * from vw_recent_activity where (emp_id = emp_id or -1 = emp_id);
----------
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Create Task', 4, 'Task Management' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Create Task' AND module_id = 4);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Assign Task', 4, 'Task Management' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Assign Task'AND module_id = 4);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Task Board', 4, 'Task Management'WHERE NOT EXISTS ( SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Task Board'AND module_id = 4);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Task History', 4, 'Task Management'WHERE NOT EXISTS ( SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Task History'AND module_id = 4);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Leave Apply', 5, 'Leave Management' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Leave Apply' AND module_id = 5);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Leave Balance', 5, 'Leave Management' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Leave Balance' AND module_id = 5);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Leave Calendar', 5, 'Leave Management' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Leave Calendar' AND module_id = 5);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'My Approvals', 5, 'Leave Management'WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'My Approvals' AND module_id = 5);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Holiday Calendar', 5, 'Leave Management'WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Holiday Calendar' AND module_id = 5);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label)SELECT 'Payslips', 7, 'Salary' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Payslips' AND module_id = 7);
INSERT INTO master_sub_module (sub_module_name, module_id, screen_label) SELECT 'Salary Revision', 7, 'Salary' WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name = 'Salary Revision' AND module_id = 7);
INSERT INTO master_sub_module(sub_module_name,module_id,screen_label) SELECT 'ALL',16,'ALL'   WHERE NOT EXISTS (SELECT 1 FROM master_sub_module WHERE sub_module_name='ALL' AND module_id=16  AND screen_label='ALL');
INSERT INTO master_screen(screen_name,module_id,screen_label) SELECT 'ALL',16,'ALL'   WHERE NOT EXISTS (SELECT 1 FROM master_screen WHERE screen_name='ALL' AND module_id=16  AND screen_label='ALL');

----------------27/01/2026  ------tharun

ALTER TABLE employee_registration
ADD CONSTRAINT uk_employee_email UNIQUE (email),
ADD CONSTRAINT uk_employee_pan UNIQUE (pan),
ADD CONSTRAINT uk_employee_uan UNIQUE (uan),
ADD CONSTRAINT uk_employee_aadhaar UNIQUE (aadhaar),
ADD CONSTRAINT uk_employee_bank UNIQUE (bank_ac_no),
ADD CONSTRAINT uk_employee_mobile UNIQUE (mobile);

------------------------03/02/2026 -----tharun

ALTER TABLE employee_registration ADD COLUMN password VARCHAR(500) not null;

ALTER TABLE employee_registration ADD COLUMN status_id INT not null;
Alter table  employee_registration add constraint fk_employee_registration_status_id foreign key (status_id) references master_emp_status(id);

create table if not exists master_emp_status(
id serial not null,
status_name varchar(255)not null,
is_active boolean DEFAULT true,
constraint pk_master_emp_status_id primary key (id)
);

INSERT INTO master_emp_status (status_name) SELECT 'Active'  WHERE NOT EXISTS (SELECT 1 FROM master_emp_status WHERE status_name = 'Active');
INSERT INTO master_emp_status (status_name) SELECT 'Inactive'WHERE NOT EXISTS (SELECT 1 FROM master_emp_status WHERE status_name = 'Inactive');
INSERT INTO master_emp_status (status_name) SELECT 'On leave' WHERE NOT EXISTS (SELECT 1 FROM master_emp_status WHERE status_name = 'On leave');
INSERT INTO master_emp_status (status_name) SELECT 'Resigned' WHERE NOT EXISTS (SELECT 1 FROM master_emp_status WHERE status_name = 'Resigned');





