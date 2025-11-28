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
--- 26/11/2025 create master modules tables dhanusha
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
--create master tables on 27-11-2025 -Lavanya
create table if not exists public.master_service(
id bigserial not null, 
sub_module_id integer not null,
service_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_service_id primary key(id),
constraint uk_master_service_sub_module_id_service_name unique (sub_module_id,service_name),
constraint fk_master_service_sub_module_id foreign key (sub_module_id) references master_sub_module(id)
);

insert into public.master_service(sub_module_id,service_name) select 1,'Homes' where not exists(select 1 from public.master_service where sub_module_id = 1 and service_name = 'Homes');
insert into public.master_service(sub_module_id,service_name) select 1,'Apartments' where not exists(select 1 from public.master_service where sub_module_id = 1 and service_name = 'Apartments');
insert into public.master_service(sub_module_id,service_name) select 1,'Villas' where not exists(select 1 from public.master_service where sub_module_id = 1 and service_name = 'Villas');
insert into public.master_service(sub_module_id,service_name) select 2,'Offices' where not exists(select 1 from public.master_service where sub_module_id = 2 and service_name = 'Offices');
insert into public.master_service(sub_module_id,service_name) select 2,'Shops & Malls' where not exists(select 1 from public.master_service where sub_module_id = 2 and service_name = 'Shops & Malls');
insert into public.master_service(sub_module_id,service_name) select 2,'Clinics & Labs' where not exists(select 1 from public.master_service where sub_module_id = 2 and service_name = 'Clinics & Labs');
insert into public.master_service(sub_module_id,service_name) select 2,'Schools' where not exists(select 1 from public.master_service where sub_module_id = 2 and service_name = 'Schools');
insert into public.master_service(sub_module_id,service_name) select 3,'Furniture Care' where not exists(select 1 from public.master_service where sub_module_id = 3 and service_name = 'Furniture Care');
insert into public.master_service(sub_module_id,service_name) select 3,'Floor & Polishing' where not exists(select 1 from public.master_service where sub_module_id = 3 and service_name = 'Floor & Polishing');
insert into public.master_service(sub_module_id,service_name) select 3,'Glass & Windows' where not exists(select 1 from public.master_service where sub_module_id = 3 and service_name = 'Glass & Windows');
insert into public.master_service(sub_module_id,service_name) select 4,'Assembly Areas' where not exists(select 1 from public.master_service where sub_module_id = 4 and service_name = 'Assembly Areas');
insert into public.master_service(sub_module_id,service_name) select 4,'Production Lines' where not exists(select 1 from public.master_service where sub_module_id = 4 and service_name = 'Production Lines');
insert into public.master_service(sub_module_id,service_name) select 4,'Waste Handling' where not exists(select 1 from public.master_service where sub_module_id = 4 and service_name = 'Waste Handling');
insert into public.master_service(sub_module_id,service_name) select 5,'Marble & Granite' where not exists(select 1 from public.master_service where sub_module_id = 5 and service_name = 'Marble & Granite');
insert into public.master_service(sub_module_id,service_name) select 5,'Dust Removal' where not exists(select 1 from public.master_service where sub_module_id = 5 and service_name = 'Dust Removal');
insert into public.master_service(sub_module_id,service_name) select 5,'Paint Stain Removal' where not exists(select 1 from public.master_service where sub_module_id = 5 and service_name = 'Paint Stain Removal');
insert into public.master_service(sub_module_id,service_name) select 6,'Local Taxi' where not exists(select 1 from public.master_service where sub_module_id = 6 and service_name = 'Local Taxi');
insert into public.master_service(sub_module_id,service_name) select 6,'Carpooling' where not exists(select 1 from public.master_service where sub_module_id = 6 and service_name = 'Carpooling');
insert into public.master_service(sub_module_id,service_name) select 6,'Shuttle Service' where not exists(select 1 from public.master_service where sub_module_id = 6 and service_name = 'Shuttle Service');
insert into public.master_service(sub_module_id,service_name) select 7,'Goods Delivery' where not exists(select 1 from public.master_service where sub_module_id = 7 and service_name = 'Goods Delivery');
insert into public.master_service(sub_module_id,service_name) select 7,'Intercity Transport' where not exists(select 1 from public.master_service where sub_module_id = 7 and service_name = 'Intercity Transport');
insert into public.master_service(sub_module_id,service_name) select 7,'Cargo Forwarding' where not exists(select 1 from public.master_service where sub_module_id = 7 and service_name = 'Cargo Forwarding');
insert into public.master_service(sub_module_id,service_name) select 8,'Car Rentals' where not exists(select 1 from public.master_service where sub_module_id = 8 and service_name = 'Car Rentals');
insert into public.master_service(sub_module_id,service_name) select 8,'Van/Truck Rentals' where not exists(select 1 from public.master_service where sub_module_id = 8 and service_name = 'Van/Truck Rentals');
insert into public.master_service(sub_module_id,service_name) select 9,'Temperature Controlled Truck' where not exists(select 1 from public.master_service where sub_module_id = 9 and service_name = 'Temperature Controlled Truck');
insert into public.master_service(sub_module_id,service_name) select 9,'Hazardous Handling' where not exists(select 1 from public.master_service where sub_module_id = 9 and service_name = 'Hazardous Handling');
insert into public.master_service(sub_module_id,service_name) select 10,'Home Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 10 and service_name = 'Home Cleaning');
insert into public.master_service(sub_module_id,service_name) select 10,'Mattress Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 10 and service_name = 'Mattress Cleaning');
insert into public.master_service(sub_module_id,service_name) select 10,'Kitchen Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 10 and service_name = 'Kitchen Cleaning');
insert into public.master_service(sub_module_id,service_name) select 10,'Bathroom Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 10 and service_name = 'Bathroom Cleaning');
insert into public.master_service(sub_module_id,service_name) select 10,'Pest Control & Disinfection' where not exists(select 1 from public.master_service where sub_module_id = 10 and service_name = 'Pest Control & Disinfection');
insert into public.master_service(sub_module_id,service_name) select 11,'Wiring & Lighting Install' where not exists(select 1 from public.master_service where sub_module_id = 11 and service_name = 'Wiring & Lighting Install');
insert into public.master_service(sub_module_id,service_name) select 11,'Fan Appliances Repair' where not exists(select 1 from public.master_service where sub_module_id = 11 and service_name = 'Fan Appliances Repair');
insert into public.master_service(sub_module_id,service_name) select 11,'Circuit Breaker & Switchboard Fixing' where not exists(select 1 from public.master_service where sub_module_id = 11 and service_name = 'Circuit Breaker & Switchboard Fixing');
insert into public.master_service(sub_module_id,service_name) select 11,'Smart Home Device Installation' where not exists(select 1 from public.master_service where sub_module_id = 11 and service_name = 'Smart Home Device Installation');
insert into public.master_service(sub_module_id,service_name) select 12,'Leak Repair' where not exists(select 1 from public.master_service where sub_module_id = 12 and service_name = 'Leak Repair');
insert into public.master_service(sub_module_id,service_name) select 12,'Pipe Fitting' where not exists(select 1 from public.master_service where sub_module_id = 12 and service_name = 'Pipe Fitting');
insert into public.master_service(sub_module_id,service_name) select 12,'Geyser Installation' where not exists(select 1 from public.master_service where sub_module_id = 12 and service_name = 'Geyser Installation');
insert into public.master_service(sub_module_id,service_name) select 12,'Bathroom Fitting' where not exists(select 1 from public.master_service where sub_module_id = 12 and service_name = 'Bathroom Fitting');
insert into public.master_service(sub_module_id,service_name) select 12,'Water Tank' where not exists(select 1 from public.master_service where sub_module_id = 12 and service_name = 'Water Tank');
insert into public.master_service(sub_module_id,service_name) select 12,'Drain Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 12 and service_name = 'Drain Cleaning');
insert into public.master_service(sub_module_id,service_name) select 13,'AC Repair' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'AC Repair');
insert into public.master_service(sub_module_id,service_name) select 13,'Refrigerator Repair' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'Refrigerator Repair');
insert into public.master_service(sub_module_id,service_name) select 13,'Washing Machine Repairs' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'Washing Machine Repairs');
insert into public.master_service(sub_module_id,service_name) select 13,'Microwave Servicing' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'Microwave Servicing');
insert into public.master_service(sub_module_id,service_name) select 13,'TV Servicing' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'TV Servicing');
insert into public.master_service(sub_module_id,service_name) select 13,'Regular Maintenance' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'Regular Maintenance');
insert into public.master_service(sub_module_id,service_name) select 13,'Spare Parts & Replacement' where not exists(select 1 from public.master_service where sub_module_id = 13 and service_name = 'Spare Parts & Replacement');
insert into public.master_service(sub_module_id,service_name) select 14,'Custom Furniture Making' where not exists(select 1 from public.master_service where sub_module_id = 14 and service_name = 'Custom Furniture Making');
insert into public.master_service(sub_module_id,service_name) select 14,'Furniture Repair' where not exists(select 1 from public.master_service where sub_module_id = 14 and service_name = 'Furniture Repair');
insert into public.master_service(sub_module_id,service_name) select 14,'Doors And Windows Fixing' where not exists(select 1 from public.master_service where sub_module_id = 14 and service_name = 'Doors And Windows Fixing');
insert into public.master_service(sub_module_id,service_name) select 14,'Wardrobe And Cabinet Installation' where not exists(select 1 from public.master_service where sub_module_id = 14 and service_name = 'Wardrobe And Cabinet Installation');
insert into public.master_service(sub_module_id,service_name) select 15,'Interior Painting' where not exists(select 1 from public.master_service where sub_module_id = 15 and service_name = 'Interior Painting');
insert into public.master_service(sub_module_id,service_name) select 15,'Exterior Painting' where not exists(select 1 from public.master_service where sub_module_id = 15 and service_name = 'Exterior Painting');
insert into public.master_service(sub_module_id,service_name) select 15,'Wallpaper And Touch-Up Works' where not exists(select 1 from public.master_service where sub_module_id = 15 and service_name = 'Wallpaper And Touch-Up Works');
insert into public.master_service(sub_module_id,service_name) select 15,'Water Proofing' where not exists(select 1 from public.master_service where sub_module_id = 15 and service_name = 'Water Proofing');
insert into public.master_service(sub_module_id,service_name) select 15,'Wall Repair' where not exists(select 1 from public.master_service where sub_module_id = 15 and service_name = 'Wall Repair');
insert into public.master_service(sub_module_id,service_name) select 16,'AC Installation' where not exists(select 1 from public.master_service where sub_module_id = 16 and service_name = 'AC Installation');
insert into public.master_service(sub_module_id,service_name) select 16,'AC Service' where not exists(select 1 from public.master_service where sub_module_id = 16 and service_name = 'AC Service');
insert into public.master_service(sub_module_id,service_name) select 16,'AC Duct Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 16 and service_name = 'AC Duct Cleaning');
insert into public.master_service(sub_module_id,service_name) select 16,'AC Filter Replacement' where not exists(select 1 from public.master_service where sub_module_id = 16 and service_name = 'AC Filter Replacement');
insert into public.master_service(sub_module_id,service_name) select 16,'Cooling System Maintenance' where not exists(select 1 from public.master_service where sub_module_id = 16 and service_name = 'Cooling System Maintenance');
insert into public.master_service(sub_module_id,service_name) select 17,'Lawn Maintenance' where not exists(select 1 from public.master_service where sub_module_id = 17 and service_name = 'Lawn Maintenance');
insert into public.master_service(sub_module_id,service_name) select 17,'Landscaping' where not exists(select 1 from public.master_service where sub_module_id = 17 and service_name = 'Landscaping');
insert into public.master_service(sub_module_id,service_name) select 17,'Outdoor Cleaning' where not exists(select 1 from public.master_service where sub_module_id = 17 and service_name = 'Outdoor Cleaning');
insert into public.master_service(sub_module_id,service_name) select 17,'Garden Pest Control & Care' where not exists(select 1 from public.master_service where sub_module_id = 17 and service_name = 'Garden Pest Control & Care');
insert into public.master_service(sub_module_id,service_name) select 18,'TV Mounting' where not exists(select 1 from public.master_service where sub_module_id = 18 and service_name = 'TV Mounting');
insert into public.master_service(sub_module_id,service_name) select 18,'Shelf Mounting' where not exists(select 1 from public.master_service where sub_module_id = 18 and service_name = 'Shelf Mounting');
insert into public.master_service(sub_module_id,service_name) select 18,'Fixture Repair' where not exists(select 1 from public.master_service where sub_module_id = 18 and service_name = 'Fixture Repair');
insert into public.master_service(sub_module_id,service_name) select 18,'Furniture Repair' where not exists(select 1 from public.master_service where sub_module_id = 18 and service_name = 'Furniture Repair');
insert into public.master_service(sub_module_id,service_name) select 18,'Minor Home Maintenance' where not exists(select 1 from public.master_service where sub_module_id = 18 and service_name = 'Minor Home Maintenance');
insert into public.master_service(sub_module_id,service_name) select 19,'CCTV Installation' where not exists(select 1 from public.master_service where sub_module_id = 19 and service_name = 'CCTV Installation');
insert into public.master_service(sub_module_id,service_name) select 19,'Door Lock Installation' where not exists(select 1 from public.master_service where sub_module_id = 19 and service_name = 'Door Lock Installation');
insert into public.master_service(sub_module_id,service_name) select 19,'Alarm System Setup' where not exists(select 1 from public.master_service where sub_module_id = 19 and service_name = 'Alarm System Setup');
insert into public.master_service(sub_module_id,service_name) select 19,'Motion Sensor Systems' where not exists(select 1 from public.master_service where sub_module_id = 19 and service_name = 'Motion Sensor Systems');
insert into public.master_service(sub_module_id,service_name) select 19,'Smart Security Device Setup' where not exists(select 1 from public.master_service where sub_module_id = 19 and service_name = 'Smart Security Device Setup');
insert into public.master_service(sub_module_id,service_name) select 20,'Apartments' where not exists(select 1 from public.master_service where sub_module_id = 20 and service_name = 'Apartments');
insert into public.master_service(sub_module_id,service_name) select 20,'Villas' where not exists(select 1 from public.master_service where sub_module_id = 20 and service_name = 'Villas');
insert into public.master_service(sub_module_id,service_name) select 20,'Independent House' where not exists(select 1 from public.master_service where sub_module_id = 20 and service_name = 'Independent House');
insert into public.master_service(sub_module_id,service_name) select 21,'StartUp' where not exists(select 1 from public.master_service where sub_module_id = 21 and service_name = 'StartUp');
insert into public.master_service(sub_module_id,service_name) select 21,'Warehouse' where not exists(select 1 from public.master_service where sub_module_id = 21 and service_name = 'Warehouse');
insert into public.master_service(sub_module_id,service_name) select 21,'Open Plots' where not exists(select 1 from public.master_service where sub_module_id = 21 and service_name = 'Open Plots');
insert into public.master_service(sub_module_id,service_name) select 22,'Property Listing for Sale' where not exists(select 1 from public.master_service where sub_module_id = 22 and service_name = 'Property Listing for Sale');
insert into public.master_service(sub_module_id,service_name) select 22,'Property Listing for Purchase' where not exists(select 1 from public.master_service where sub_module_id = 22 and service_name = 'Property Listing for Purchase');
insert into public.master_service(sub_module_id,service_name) select 23,'In-Store Billing' where not exists(select 1 from public.master_service where sub_module_id = 23 and service_name = 'In-Store Billing');
insert into public.master_service(sub_module_id,service_name) select 23,'Inventory & Customer Records' where not exists(select 1 from public.master_service where sub_module_id = 23 and service_name = 'Inventory & Customer Records');
insert into public.master_service(sub_module_id,service_name) select 24,'Online Ordering & Checkout' where not exists(select 1 from public.master_service where sub_module_id = 24 and service_name = 'Online Ordering & Checkout');
insert into public.master_service(sub_module_id,service_name) select 24,'Digital Catalog & Product Search' where not exists(select 1 from public.master_service where sub_module_id = 24 and service_name = 'Digital Catalog & Product Search');
insert into public.master_service(sub_module_id,service_name) select 24,'Online Payments (UPI / Card)' where not exists(select 1 from public.master_service where sub_module_id = 24 and service_name = 'Online Payments (UPI / Card)');
insert into public.master_service(sub_module_id,service_name) select 24,'Home Delivery & Tracking' where not exists(select 1 from public.master_service where sub_module_id = 24 and service_name = 'Home Delivery & Tracking');
insert into public.master_service(sub_module_id,service_name) select 24,'Online Offers & Coupons' where not exists(select 1 from public.master_service where sub_module_id = 24 and service_name = 'Online Offers & Coupons');
insert into public.master_service(sub_module_id,service_name) select 25,'Price Comparison & Bulk Orders' where not exists(select 1 from public.master_service where sub_module_id = 25 and service_name = 'Price Comparison & Bulk Orders');
insert into public.master_service(sub_module_id,service_name) select 25,'Supplier Coordination & Stock ' where not exists(select 1 from public.master_service where sub_module_id = 25 and service_name = 'Supplier Coordination & Stock ');
insert into public.master_service(sub_module_id,service_name) select 26,'Cement' where not exists(select 1 from public.master_service where sub_module_id = 26 and service_name = 'Cement');
insert into public.master_service(sub_module_id,service_name) select 26,'Sand' where not exists(select 1 from public.master_service where sub_module_id = 26 and service_name = 'Sand');
insert into public.master_service(sub_module_id,service_name) select 26,'Bricks' where not exists(select 1 from public.master_service where sub_module_id = 26 and service_name = 'Bricks');
insert into public.master_service(sub_module_id,service_name) select 26,'Steel & TMT Bars' where not exists(select 1 from public.master_service where sub_module_id = 26 and service_name = 'Steel & TMT Bars');
insert into public.master_service(sub_module_id,service_name) select 26,'Pipes' where not exists(select 1 from public.master_service where sub_module_id = 26 and service_name = 'Pipes');
insert into public.master_service(sub_module_id,service_name) select 26,'Marble & Tiles' where not exists(select 1 from public.master_service where sub_module_id = 26 and service_name = 'Marble & Tiles');
insert into public.master_service(sub_module_id,service_name) select 27,'Excavators Rental' where not exists(select 1 from public.master_service where sub_module_id = 27 and service_name = 'Excavators Rental');
insert into public.master_service(sub_module_id,service_name) select 27,'Loader Rental' where not exists(select 1 from public.master_service where sub_module_id = 27 and service_name = 'Loader Rental');
insert into public.master_service(sub_module_id,service_name) select 27,'Crane Rental' where not exists(select 1 from public.master_service where sub_module_id = 27 and service_name = 'Crane Rental');
insert into public.master_service(sub_module_id,service_name) select 27,'Concrete Mixer Rental' where not exists(select 1 from public.master_service where sub_module_id = 27 and service_name = 'Concrete Mixer Rental');
insert into public.master_service(sub_module_id,service_name) select 28,'Material Pickup' where not exists(select 1 from public.master_service where sub_module_id = 28 and service_name = 'Material Pickup');
insert into public.master_service(sub_module_id,service_name) select 28,'Material Delivery Services' where not exists(select 1 from public.master_service where sub_module_id = 28 and service_name = 'Material Delivery Services');
-----
create table if not exists public.master_sub_service(
id serial not null, 
sub_service_name varchar(255) not null,
service_id integer not null,
is_active boolean default true,
constraint pk_master_sub_service_id primary key(id),
constraint uk_master_sub_service_sub_service_name_service_id unique (sub_service_name,service_id),
constraint fk_master_sub_service_service_id foreign key (service_id) references master_service(id)
);

INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Living Room Cleaning', 1  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Living Room Cleaning' AND service_id = 1  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Bedroom Cleaning', 1  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Bedroom Cleaning' AND service_id = 1  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Kitchen Cleaning', 1  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Kitchen Cleaning' AND service_id = 1  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Bathroom Cleaning', 1  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Bathroom Cleaning' AND service_id = 1  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Studio Apartment', 2  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Studio Apartment' AND service_id = 2  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT '1 BHK Apartment', 2  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = '1 BHK Apartment' AND service_id = 2  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT '2 BHK / 3 BHK Apartment', 2  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = '2 BHK / 3 BHK Apartment' AND service_id = 2  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Small Villas', 3  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Small Villas' AND service_id = 3  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Duplex Villas', 3  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Duplex Villas' AND service_id = 3  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Luxury Villas', 3  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Luxury Villas' AND service_id = 3  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Cabin Cleaning', 4  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Cabin Cleaning' AND service_id = 4  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Workstation Cleaning', 4  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Workstation Cleaning' AND service_id = 4  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Conference Hall Cleaning', 4  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Conference Hall Cleaning' AND service_id = 4  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Shop Cleaning', 5  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Shop Cleaning' AND service_id = 5  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Mall Cleaning', 5  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Mall Cleaning' AND service_id = 5  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Showroom Cleaning', 5  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Showroom Cleaning' AND service_id = 5  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Laboratory Cleaning', 6  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Laboratory Cleaning' AND service_id = 6  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Clinic Cleaning', 6  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Clinic Cleaning' AND service_id = 6  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Diagnostic Centers', 6  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Diagnostic Centers' AND service_id = 6  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Classrooms', 7  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Classrooms' AND service_id = 7  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Laboratory Cleaning', 7  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Laboratory Cleaning' AND service_id = 7  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Library Cleaning', 7  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Library Cleaning' AND service_id = 7  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Sofa Cleaning', 8  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Sofa Cleaning' AND service_id = 8  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Chair Cleaning', 8  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Chair Cleaning' AND service_id = 8  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Wooden Furniture Cleaning', 8  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Wooden Furniture Cleaning' AND service_id = 8  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Marble Polishing', 9  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Marble Polishing' AND service_id = 9  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Tile Cleaning', 9  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Tile Cleaning' AND service_id = 9  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Granite Polishing', 9  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Granite Polishing' AND service_id = 9  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Indoor Glass Cleaning', 10  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Indoor Glass Cleaning' AND service_id = 10  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Outdoor Glass Cleaning', 10  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Outdoor Glass Cleaning' AND service_id = 10  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'High-Rise Glass Cleaning', 10  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'High-Rise Glass Cleaning' AND service_id = 10  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Home Sanitization', 10  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Home Sanitization' AND service_id = 10  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Office Sanitization', 10  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Office Sanitization' AND service_id = 10  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Commercial Sanitization', 10  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Commercial Sanitization' AND service_id = 10  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Assembly Area Cleaning', 11  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Assembly Area Cleaning' AND service_id = 11  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Production Line Cleaning', 11  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Production Line Cleaning' AND service_id = 11  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Warehouse Rack Cleaning', 12  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Warehouse Rack Cleaning' AND service_id = 12  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Warehouse Floor Cleaning', 12  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Warehouse Floor Cleaning' AND service_id = 12  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Heavy Equipment Cleaning', 13  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Heavy Equipment Cleaning' AND service_id = 13  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Precision Tools Cleaning', 13  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Precision Tools Cleaning' AND service_id = 13  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Chemical Waste Handling', 13  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Chemical Waste Handling' AND service_id = 13  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Solid Waste Handling', 13  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Solid Waste Handling' AND service_id = 13  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Luxury 2 BHK Apartment', 77  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Luxury 2 BHK Apartment' AND service_id = 77  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Modern 1 BHK Studio', 77  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Modern 1 BHK Studio' AND service_id = 77  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Luxury 3 BHK Penthouse', 77  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Luxury 3 BHK Penthouse' AND service_id = 77  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Spacious 3 BHK Penthouse', 77  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Spacious 3 BHK Penthouse' AND service_id = 77  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Premium 4 BHK Villa', 78  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Premium 4 BHK Villa' AND service_id = 78  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Modern 3 BHK Villa', 78  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Modern 3 BHK Villa' AND service_id = 78  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Luxury 2 BHK Villa', 78  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Luxury 2 BHK Villa' AND service_id = 78  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Semi-Modern 3 BHK Villa', 78  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Semi-Modern 3 BHK Villa' AND service_id = 78  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT '3 BHK Independent House', 79  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = '3 BHK Independent House' AND service_id = 79  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT '2 BHK Corner House', 79  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = '2 BHK Corner House' AND service_id = 79  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT '3 BHK Luxury House', 79  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = '3 BHK Luxury House' AND service_id = 79  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT '2 BHK Modern House', 79  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = '2 BHK Modern House' AND service_id = 79  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Premium Co-working Office', 80  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Premium Co-working Office' AND service_id = 80  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Budget Startup Space', 80  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Budget Startup Space' AND service_id = 80  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Large Industrial Warehouse', 81  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Large Industrial Warehouse' AND service_id = 81  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Medium Storage Warehouse', 81  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Medium Storage Warehouse' AND service_id = 81  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Prime Commercial Plot', 82  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Prime Commercial Plot' AND service_id = 82  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'City Center Plot', 82  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'City Center Plot' AND service_id = 82  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Prime Commercial Plot - City Center', 83  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Prime Commercial Plot - City Center' AND service_id = 83  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Industrial Plot - Warehouse Zone', 83  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Industrial Plot - Warehouse Zone' AND service_id = 83  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Office Complex Plot', 83  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Office Complex Plot' AND service_id = 83  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Boutique Hotel Development Land', 84  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Boutique Hotel Development Land' AND service_id = 84  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Luxury Hillside Villa', 84  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Luxury Hillside Villa' AND service_id = 84  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Heritage Bungalow', 84  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Heritage Bungalow' AND service_id = 84  );
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Corporate Office Tower Floor', 84  WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Corporate Office Tower Floor' AND service_id = 84  );

