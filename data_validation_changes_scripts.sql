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
create table public.master_holiday(id serial not null,occassion varchar(255) not null,holiday_date date not null,holiday_day varchar(255) not  null,
is_active boolean default true,
constraint pk_master_holiday_id primary key(id));
--
ALTER TABLE public.master_holiday add is_occassional varchar(100);

ALTER TABLE public.master_holiday add constraint ck_master_holiday_is_occassional check (is_occassional in ('Optional','Yes'));

INSERT INTO public.master_holiday (occassion,holiday_date,holiday_day,is_occassional)
SELECT 'New Year`s Day','2025-01-01','Wednesday','Yes' WHERE NOT EXISTS (SELECT 1 FROM public.master_holiday WHERE occassion='New Year`s Day' and holiday_date='2025-01-01' and holiday_day='Wednesday' and is_occassional='Yes');
INSERT INTO public.master_holiday (occassion,holiday_date,holiday_day,is_occassional)
SELECT 'Makar Sankranthi','2025-01-14','Tuesday','Yes' WHERE NOT EXISTS (SELECT 1 FROM public.master_holiday WHERE occassion='Makar Sankranthi' and holiday_date='2025-01-14' and holiday_day='Tuesday' and is_occassional='Yes');

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
