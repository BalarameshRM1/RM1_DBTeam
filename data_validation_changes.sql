--Authored on 25-11-2025

--master_gender
create table if not exists public.master_gender(
  id serial not null,
  gender_name varchar(255) not null,
  is_active boolean default true,
  constraint pk_master_gender_id primary key(id),
  constraint uk_master_gender_gender_name unique(gender_name));

INSERT INTO public.master_gender(gender_name) SELECT 'Male' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender_name='Male');
INSERT INTO public.master_gender(gender_name) SELECT 'Female' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender_name='Female');
INSERT INTO public.master_gender(gender_name) SELECT 'Others' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender_name='Others');

--master_state
create table if not exists public.master_state ( 
  id serial not null,
  state_code bigint not null,
  state_name varchar(255) not null,
  is_active boolean default true,
  constraint pk_master_state_id primary key(id),
  constraint uk_master_state_state_code unique(state_code),
  constraint uk_master_state_state_name unique(state_name)
);
--master_district
create table if not exists public.master_district ( 
  id serial not null,
  district_code bigint not null,
  district_name varchar(255) not null,
  state_id integer not null,
  is_active boolean default true,
  constraint pk_master_district_id primary key(id),
  constraint uk_master_district_district_code unique(district_code),
  constraint fk_master_district_state_id foreign key(state_id) references master_state(id),
  constraint uk_master_district_district_name_state_id unique(district_name, state_id)
);

------master_skill
create table if not exists public.master_skill(
  id serial not null,
  skill varchar(255) not null,
  is_active boolean default true,
  constraint pk_master_skill_id primary key(id)
);

INSERT INTO public.master_skill (skill) SELECT 'AC Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'AC Repair');
INSERT INTO public.master_skill (skill) SELECT 'Carpentary' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Carpentary');
INSERT INTO public.master_skill (skill) SELECT 'Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Cleaning');
INSERT INTO public.master_skill (skill) SELECT 'Electrical' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Electrical');
INSERT INTO public.master_skill (skill) SELECT 'Moving' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Moving');
INSERT INTO public.master_skill (skill) SELECT 'Painting' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Painting');
INSERT INTO public.master_skill (skill) SELECT 'Plumbing' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Plumbing');

---------user_registration
create table if not exists public.user_registration(
  id bigserial not null,
  full_name varchar(255) not null,
  email varchar(100) not null,
  mobile varchar(100) not null,
  password varchar(500) not null,
  gender_id integer not null, dob date, age integer, 
  role_id integer not null,
  state_id integer , district_id integer ,
  created_by bigint, created_date timestamp default now(),
  modified_by bigint, modified_date timestamp, is_active boolean default true,
  constraint pk_user_registration_id primary key (id),
  constraint uk_user_registration_email unique(email),
  constraint uk_user_registration_mobile unique(mobile),
  constraint fk_user_registration_gender_id foreign key(gender_id) references master_gender(id),
  constraint fk_user_registration_role_id foreign key(role_id) references master_role(id),
  constraint fk_user_registration_state_id foreign key(state_id) references master_state(id),
  constraint fk_user_registration_district_id foreign key(district_id) references master_district(id)
);

--created employee table

create table if not exists public.employee(
	id bigserial not null,
	full_name varchar(255) not null,
	date_of_birth date,
	age int,
	mobile varchar(255) not null,
	email varchar(100) not null, 
	skill_id integer not null,
	experience_summary varchar,
	experience_doc varchar(500) not null,
	government_id varchar(500) not null,
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
constraint pk_employee_id primary key(id),
constraint uk_employee_mobile unique (mobile),
constraint uk_employee_email unique (email),
constraint fk_employee_skill_id foreign key (skill_id) references master_skill (id)
	);


--- create master role table

create table if not exists public.master_role (

	id serial not null,
	role_name varchar(255) not null,
	is_active boolean default true,
constraint pk_master_role_id primary key (id)
	);

--insert data into master role


select * from master_role
INSERT INTO public.master_role (role_name) SELECT 'Admin' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Admin');
INSERT INTO public.master_role (role_name) SELECT 'Customer' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Customer');
INSERT INTO public.master_role (role_name) SELECT 'Delivery_Partner' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Delivery_Partner');
INSERT INTO public.master_role (role_name) SELECT 'Employee' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Employee');
INSERT INTO public.master_role (role_name) SELECT 'Student' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Student');
INSERT INTO public.master_role (role_name) SELECT 'Vendor' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Vendor');


----
--- 26/11/2025 create master modules tables
create table if not exists public.master_module(
	id serial not null,
	module_name varchar(255) not null,
	is_active boolean default true,
constraint pk_master_module_id primary key (id),
constraint uk_master_module_module_name unique (module_name)
	
	);

insert into public.master_module (module_name) SELECT 'Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Cleaning');
insert into public.master_module (module_name) SELECT 'Packers & Movers' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Packers & Movers');
insert into public.master_module (module_name) SELECT 'Home Services' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Home services');
insert into public.master_module (module_name) SELECT 'Rentals' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Rentals');
insert into public.master_module (module_name) SELECT 'Buy&Sale Properties' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Buy&Sale Properties');
insert into public.master_module (module_name) SELECT 'Construction Materials' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Construction Materials');
insert into public.master_module (module_name) SELECT 'Freelancer' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Freelancer');	
insert into public.master_module (module_name) SELECT 'Education' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Education');
insert into public.master_module (module_name) SELECT 'Farming' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Farming');

--------------------------
create table if not exists public.master_sub_module(
  id serial not null,
  sub_module_name varchar(255) not null,
  module_id integer not null,
  is_active boolean default true,
  constraint pk_master_sub_module_id primary key(id),
  constraint fk_master_sub_module_module_id foreign key(module_id) references master_module(id),
  constraint uk_master_sub_module_sub_module_name_module_id unique(sub_module_name, module_id)
);

INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Residential Cleaning', 1 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Residential Cleaning' AND module_id = 1 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Commercial Cleaning', 1 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Commercial Cleaning' AND module_id = 1 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Specialized Cleaning', 1 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Specialized Cleaning' AND module_id = 1 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Industrial Cleaning', 1 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Industrial Cleaning' AND module_id = 1 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Post-Construction Cleaning', 2 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Post-Construction Cleaning' AND module_id = 2 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Passenger Transport', 2 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Passenger Transport' AND module_id = 2 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Logistics & Cargo', 2 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Logistics & Cargo' AND module_id = 2 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Rental Services', 2 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Rental Services' AND module_id = 2 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Specialized Transport', 2 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Specialized Transport' AND module_id = 2 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Cleaning Services', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Cleaning Services' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Electrical Services', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Electrical Services' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Plumbing Service', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Plumbing Service' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Appliances Repair', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Appliances Repair' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Carpentary & Furniture', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Carpentary & Furniture' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Painting & Renovation', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Painting & Renovation' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'HVAC & Cooling', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'HVAC & Cooling' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Gardening & Outdoor Care', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Gardening & Outdoor Care' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Handyman/General Repair', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Handyman/General Repair' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Home Security Services', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Home Security Services' AND module_id = 3 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'House Rental', 4 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'House Rental' AND module_id = 4 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Commercial Rental', 4 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Commercial Rental' AND module_id = 4 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Buy & Sale Products', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Buy & Sale Products' AND module_id = 5 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Old Retail Sales', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Old Retail Sales' AND module_id = 5 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Online Ordering', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Online Ordering' AND module_id = 5 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Wholesale Buy Near Distribution', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Wholesale Buy Near Distribution' AND module_id = 5 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Material Supply', 6 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Material Supply' AND module_id = 6 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Machinery Rental', 6 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Machinery Rental' AND module_id = 6 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Transportation', 6 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Transportation' AND module_id = 6 );
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Bulk Procurement', 6 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Bulk Procurement' AND module_id = 6 );

----------modifications on 27-11-2015 sahitha
alter table if exists user_registration
alter column role_id drop not null;

alter table if exists user_registration
alter column state_id drop not null;

alter table if exists user_registration
alter column district_id drop not null;
---------------------------------------------------------------------------
