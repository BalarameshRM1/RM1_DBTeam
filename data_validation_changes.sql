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
--------------------------------
--Authored by Anand A on 29-11-2025.

alter table if exists user_registration add column if not exists profile_image varchar(500);
alter table if exists user_registration add column if not exists role_id integer;
alter table if exists user_registration add column if not exists skill_id integer;
alter table if exists user_registration add column if not exists experience_summary varchar;
alter table if exists user_registration add column if not exists experience_doc varchar(500);
alter table if exists user_registration add column if not exists government_id varchar(500);
alter table if exists user_registration add column if not exists first_name varchar(255);
alter table if exists user_registration add column if not exists last_name varchar(255);
alter table if exists user_registration add column if not exists unique_id varchar(255);
---
CREATE TABLE IF NOT EXISTS public.users_pre_profile_history
(
    id bigserial  NOT NULL,
    full_name character varying(255) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    mobile character varying(100) COLLATE pg_catalog."default",
    password character varying(500) COLLATE pg_catalog."default",
    gender_id integer,
    dob date,
    age integer,
    role_id integer,
    state_id integer,
    district_id integer,
    created_by bigint,
    created_date timestamp without time zone,
    modified_by bigint,
    modified_date timestamp without time zone  DEFAULT now(),
    is_active boolean,
    profile_image character varying(500) COLLATE pg_catalog."default",
    skill_id integer,
    experience_summary character varying COLLATE pg_catalog."default",
    experience_doc character varying(500) COLLATE pg_catalog."default",
    government_id character varying(500) COLLATE pg_catalog."default",
    first_name character varying(255) COLLATE pg_catalog."default",
    last_name character varying(255) COLLATE pg_catalog."default",
    unique_id character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT pk_users_pre_profile_history_id PRIMARY KEY (id));
---------------------------------
alter table if exists user_registration alter column first_name set not null;
alter table if exists user_registration alter column last_name set not null;
alter table if exists user_registration alter column unique_id set not null;

------------ 2-12-2025 - Dhanusha
-- Remodified master table like master_module, master_sub_module,master_service,master_sub_service
select * from master_module;
alter sequence master_module_id_seq restart with 1;

insert into public.master_module (module_name) SELECT 'Home & Cleaning Services' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Home & Cleaning Services');
insert into public.master_module (module_name) SELECT 'Transport' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Transport');
insert into public.master_module (module_name) SELECT 'Buy/Sale/Rentals' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Buy/Sale/Rentals');
insert into public.master_module (module_name) SELECT 'Construction Raw Materials' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Construction Raw Materials');
insert into public.master_module (module_name) SELECT 'Education' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Education');
insert into public.master_module (module_name) SELECT 'Swachify Product' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Swachify Product');
insert into public.master_module (module_name) SELECT 'Freelancing' WHERE NOT EXISTS (SELECT 1 FROM public.master_module WHERE module_name = 'Freelancing');
---------------------- 

select * from master_sub_module;
alter sequence master_sub_module_id_seq restart with 1;

INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Cleaning Services',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Cleaning Services');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Electrical Services',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Electrical Services');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Plumbing Services',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Plumbing Services');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Appliances Repair',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Appliances Repair');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Carpentary & Furniture',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Carpentary & Furniture');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Painting & Renovation',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Painting & Renovation');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'HVAC & Cooling',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'HVAC & Cooling');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Gardening & Outdoor Care',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Gardening & Outdoor Care');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Handyman / General Repair',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Handyman / General Repair');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Home Security Services',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 1 AND sub_module_name = 'Home Security Services');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Passaanger Transport',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 2 AND sub_module_name = 'Passaanger Transport');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Logistic & Cargo',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 2 AND sub_module_name = 'Logistic & Cargo');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Rental Services',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 2 AND sub_module_name = 'Rental Services');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Specialized Transport',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 2 AND sub_module_name = 'Specialized Transport');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'House Rental',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 3 AND sub_module_name = 'House Rental');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Commercial Rental',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 3 AND sub_module_name = 'Commercial Rental');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Buy & Sale products',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 3 AND sub_module_name = 'Buy & Sale products');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Old Retail Sales',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 3 AND sub_module_name = 'Old Retail Sales');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Online Ordering',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 3 AND sub_module_name = 'Online Ordering');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Wholesale Buy Near Distribution',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 3 AND sub_module_name = 'Wholesale Buy Near Distribution');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Material Supply',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 4 AND sub_module_name = 'Material Supply');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Machinary Rental',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 4 AND sub_module_name = 'Machinary Rental');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Transportation',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 4 AND sub_module_name = 'Transportation');
INSERT INTO public.master_sub_module (sub_module_name, module_id) SELECT  'Bulk Procurement',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE module_id = 4 AND sub_module_name = 'Bulk Procurement');

------------------------------

select * from master_service;
alter sequence master_service_id_seq restart with 1;

INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Residential Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Residential Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Commercial Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Commercial Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Specialized Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Specialized Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Industrial Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Industrial Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Post-Construction Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Post-Construction Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Wiring & Lighting Install' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Wiring & Lighting Install');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Fan Appliances Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Fan Appliances Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Circuit Breaker & Switchboard Fixing' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Circuit Breaker & Switchboard Fixing');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Smart Home Device Installation' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Smart Home Device Installation');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 3, 'Leak Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 3 AND service_name = 'Leak Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 3, 'Pipe Fitting' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 3 AND service_name = 'Pipe Fitting');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 3, 'Geyser Installation' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 3 AND service_name = 'Geyser Installation');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 3, 'Bathroom Fitting' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 3 AND service_name = 'Bathroom Fitting');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 3, 'Water Tank' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 3 AND service_name = 'Water Tank');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 3, 'Drain Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 3 AND service_name = 'Drain Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'AC Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'AC Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'Refrigerator Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'Refrigerator Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'Washing Machine Repairs' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'Washing Machine Repairs');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'Microwave Servicing' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'Microwave Servicing');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'TV Servicing' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'TV Servicing');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'Regular Maintenance' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'Regular Maintenance');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 4, 'Spare Parts & Replacement' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 4 AND service_name = 'Spare Parts & Replacement');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 5, 'Custom Furniture Making' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 5 AND service_name = 'Custom Furniture Making');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 5, 'Furniture Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 5 AND service_name = 'Furniture Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 5, 'Doors And Windows Fixing' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 5 AND service_name = 'Doors And Windows Fixing');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 5, 'Wardrobe And Cabinet Installation' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 5 AND service_name = 'Wardrobe And Cabinet Installation');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 6, 'Interior Painting' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 6 AND service_name = 'Interior Painting');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 6, 'Exterior Painting' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 6 AND service_name = 'Exterior Painting');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 6, 'Wallpaper And Touch-up Works' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 6 AND service_name = 'Wallpaper And Touch-up Works');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 6, 'Water Proofing' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 6 AND service_name = 'Water Proofing');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 6, 'wall Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 6 AND service_name = 'wall Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 7, 'AC Installation' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 7 AND service_name = 'AC Installation');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 7, 'AC Service' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 7 AND service_name = 'AC Service');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 7, 'AC Duct Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 7 AND service_name = 'AC Duct Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 7, 'AC Filter Replacement' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 7 AND service_name = 'AC Filter Replacement');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 7, 'Cooling System Maintenance' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 7 AND service_name = 'Cooling System Maintenance');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 8, 'Lawn Maintenance' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 8 AND service_name = 'Lawn Maintenance');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 8, 'Landscaping' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 8 AND service_name = 'Landscaping');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 8, 'Outdoor Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 8 AND service_name = 'Outdoor Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 8, 'Garden Pest Control & Care' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 8 AND service_name = 'Garden Pest Control & Care');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 9, 'TV Mounting' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 9 AND service_name = 'TV Mounting');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 9, 'Shelf Mounting' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 9 AND service_name = 'Shelf Mounting');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 9, 'Fixture Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 9 AND service_name = 'Fixture Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 9, 'Furniture Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 9 AND service_name = 'Furniture Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 9, 'Minor Home Maintenance' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 9 AND service_name = 'Minor Home Maintenance');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 10, 'CCTV Installation' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 10 AND service_name = 'CCTV Installation');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 10, 'Door Lock Installation' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 10 AND service_name = 'Door Lock Installation');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 10, 'Alarm System Setup' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 10 AND service_name = 'Alarm System Setup');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 10, 'Motion Sensor System' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 10 AND service_name = 'Motion Sensor System');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 10, 'Smart Security Device Setup' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 10 AND service_name = 'Smart Security Device Setup');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 11, 'Local Taxi' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 11 AND service_name = 'Local Taxi');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 11, 'Carpooling' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 11 AND service_name = 'Carpooling');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 11, 'Shuttle Service' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 11 AND service_name = 'Shuttle Service');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 12, 'Goods Delivery' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 12 AND service_name = 'Goods Delivery');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 12, 'Intercity Transport' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 12 AND service_name = 'Intercity Transport');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 12, 'Cargo Forwarding' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 12 AND service_name = 'Cargo Forwarding');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 13, 'Car Rentals' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 13 AND service_name = 'Car Rentals');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 13, 'Van/Truck Rentals' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 13 AND service_name = 'Van/Truck Rentals');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 14, 'Temperature Controlled Truck' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 14 AND service_name = 'Temperature Controlled Truck');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 14, 'Hazardous Handling' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 14 AND service_name = 'Hazardous Handling');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 15, 'Apartments' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 15 AND service_name = 'Apartments');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 15, 'Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 15 AND service_name = 'Villas');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 15, 'Independent House' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 15 AND service_name = 'Independent House');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 16, 'StartUp' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 16 AND service_name = 'StartUp');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 16, 'Warehouse' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 16 AND service_name = 'Warehouse');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 16, 'Open Plots' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 16 AND service_name = 'Open Plots');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 17, 'Property Listing for Sale' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 17 AND service_name = 'Property Listing for Sale');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 17, 'Property Listing for Purchase' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 17 AND service_name = 'Property Listing for Purchase');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 18, 'In-Store Billing' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 18 AND service_name = 'In-Store Billing');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 18, 'Inventory & Customer Records' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 18 AND service_name = 'Inventory & Customer Records');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 19, 'Online Ordering & Checkout' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 19 AND service_name = 'Online Ordering & Checkout');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 19, 'Digital Catalog & Product Search' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 19 AND service_name = 'Digital Catalog & Product Search');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 19, 'Online Payments (UPI / Card)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 19 AND service_name = 'Online Payments (UPI / Card)');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 19, 'Home Delivery & Tracking' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 19 AND service_name = 'Home Delivery & Tracking');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 19, 'Online Offers & Coupons' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 19 AND service_name = 'Online Offers & Coupons');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 20, 'Price Comparison & Bulk Orders' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 20 AND service_name = 'Price Comparison & Bulk Orders');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 20, 'Supplier Coordination & Stock tracking' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 20 AND service_name = 'Supplier Coordination & Stock tracking');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 21, 'Cement' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 21 AND service_name = 'Cement');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 21, 'Sand' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 21 AND service_name = 'Sand');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 21, 'Bricks' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 21 AND service_name = 'Bricks');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 21, 'Steel & TMT Bars' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 21 AND service_name = 'Steel & TMT Bars');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 21, 'Pipes' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 21 AND service_name = 'Pipes');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 21, 'Marble & Tiles' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 21 AND service_name = 'Marble & Tiles');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 22, 'Excavator Rental' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 22 AND service_name = 'Excavator Rental');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 22, 'Loader Rental' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 22 AND service_name = 'Loader Rental');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 22, 'Crane Rental' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 22 AND service_name = 'Crane Rental');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 22, 'Concrete Mixer' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 22 AND service_name = 'Concrete Mixer');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 23, 'Material Pickup' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 23 AND service_name = 'Material Pickup');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 23, 'Material Delivery ' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 23 AND service_name = 'Material Delivery ');

------------------

select * from master_sub_service;
alter sequence master_sub_service_id_seq restart with 1;

INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Homes',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 1 AND sub_service_name = 'Homes');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Apartments',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 1 AND sub_service_name = 'Apartments');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Villas',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 1 AND sub_service_name = 'Villas');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Offices',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 2 AND sub_service_name = 'Offices');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Shops & Malls',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 2 AND sub_service_name = 'Shops & Malls');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Clinics & Labs',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 2 AND sub_service_name = 'Clinics & Labs');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Schools',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 2 AND sub_service_name = 'Schools');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Furniture Care',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 3 AND sub_service_name = 'Furniture Care');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Floor & Polishing',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 3 AND sub_service_name = 'Floor & Polishing');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Glass & Windows',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 3 AND sub_service_name = 'Glass & Windows');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Assembly Areas',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 4 AND sub_service_name = 'Assembly Areas');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Production Lines',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 4 AND sub_service_name = 'Production Lines');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Waste Handling',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 4 AND sub_service_name = 'Waste Handling');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Marble & Granite',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 5 AND sub_service_name = 'Marble & Granite');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Dust Removal',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 5 AND sub_service_name = 'Dust Removal');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Paint Stain Removal',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 5 AND sub_service_name = 'Paint Stain Removal');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Prime Commericial Plots - City Centre',67 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 67 AND sub_service_name = 'Prime Commericial Plots - City Centre');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Indurstial Plot - Warehouse Zone',67 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 67 AND sub_service_name = 'Indurstial Plot - Warehouse Zone');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Office Complex Plot',67 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 67 AND sub_service_name = 'Office Complex Plot');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Boutique Hotel Development Land',68 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 68 AND sub_service_name = 'Boutique Hotel Development Land');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Luxury Hillside Villa',68 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 68 AND sub_service_name = 'Luxury Hillside Villa');
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT  'Heritage Bungalow',68 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 68 AND sub_service_name = 'Heritage Bungalow');

-----
alter table user_registration add constraint uk_user_registration_unique_id unique (unique_id);
alter table user_registration add column address varchar;

------------------------------- 3-12-2025 - Lavanya
---created master_sub_sub_service table

create table if not exists master_sub_sub_service(
id bigserial not null,
sub_service_id integer not null,
sub_sub_service_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_sub_sub_service_id primary key(id),
constraint uk_master_sub_sub_service_sub_service_id_sub_sub_service_name unique (sub_service_id,sub_sub_service_name),
constraint fk_master_sub_sub_service_sub_service_id foreign key (sub_service_id) references master_sub_service(id)
);

-------------------- 03-12-2025 - Tharun
-------insert data into master_sub_sub_service table

INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 1, 'Living Room Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 1 AND sub_sub_service_name = 'Living Room Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 1, 'Bedroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 1 AND sub_sub_service_name = 'Bedroom Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 1, 'Kitchen Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 1 AND sub_sub_service_name = 'Kitchen Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 1, 'Bathroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 1 AND sub_sub_service_name = 'Bathroom Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 2, 'Studio Apartment' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 2 AND sub_sub_service_name = 'Studio Apartment');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 2, '1 BHK Apartment' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 2 AND sub_sub_service_name = '1 BHK Apartment');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 2, '2 BHK / 3 BHK Apartment' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 2 AND sub_sub_service_name = '2 BHK / 3 BHK Apartment');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 3, 'Small Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 3 AND sub_sub_service_name = 'Small Villas');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 3, 'Duplex Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 3 AND sub_sub_service_name = 'Duplex Villas');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 3, 'Luxury Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 3 AND sub_sub_service_name = 'Luxury Villas');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 4, 'Cabin Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 4 AND sub_sub_service_name = 'Cabin Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 4, 'Workstation Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 4 AND sub_sub_service_name = 'Workstation Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 4, 'Conference Hall Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 4 AND sub_sub_service_name = 'Conference Hall Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 5, 'Shop Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 5 AND sub_sub_service_name = 'Shop Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 5, 'Mall Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 5 AND sub_sub_service_name = 'Mall Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 5, 'Showroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 5 AND sub_sub_service_name = 'Showroom Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 6, 'Laboratory Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 6 AND sub_sub_service_name = 'Laboratory Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 6, 'Clinic Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 6 AND sub_sub_service_name = 'Clinic Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 6, 'Diagnostic Centers' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 6 AND sub_sub_service_name = 'Diagnostic Centers');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 7, 'Classrooms' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 7 AND sub_sub_service_name = 'Classrooms');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 7, 'Laboratory Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 7 AND sub_sub_service_name = 'Laboratory Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 7, 'Library Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 7 AND sub_sub_service_name = 'Library Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 8, 'Sofa Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 8 AND sub_sub_service_name = 'Sofa Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 8, 'Chair Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 8 AND sub_sub_service_name = 'Chair Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 8, 'Wooden Furniture Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 8 AND sub_sub_service_name = 'Wooden Furniture Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 9, 'Marble Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 9 AND sub_sub_service_name = 'Marble Polishing');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 9, 'Tile Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 9 AND sub_sub_service_name = 'Tile Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 9, 'Granite Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 9 AND sub_sub_service_name = 'Granite Polishing');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 10, 'Indoor Glass Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 10 AND sub_sub_service_name = 'Indoor Glass Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 10, 'Outdoor Glass Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 10 AND sub_sub_service_name = 'Outdoor Glass Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 10, 'High-Rise Glass Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 10 AND sub_sub_service_name = 'High-Rise Glass Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 10, 'Home Sanitization' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 10 AND sub_sub_service_name = 'Home Sanitization');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 10, 'Office Sanitization' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 10 AND sub_sub_service_name = 'Office Sanitization');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 10, 'Commercial Sanitization' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 10 AND sub_sub_service_name = 'Commercial Sanitization');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 11, 'Assembly Areas Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 11 AND sub_sub_service_name = 'Assembly Areas Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 11, 'Production Line Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 11 AND sub_sub_service_name = 'Production Line Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 12, 'Warehouse Rack Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 12 AND sub_sub_service_name = 'Warehouse Rack Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 12, 'Warehouse Floor Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 12 AND sub_sub_service_name = 'Warehouse Floor Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 13, 'Heavy Equipment Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 13 AND sub_sub_service_name = 'Heavy Equipment Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 13, 'Precision Tools Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 13 AND sub_sub_service_name = 'Precision Tools Cleaning');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 13, 'Chemical Waste Handling' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 13 AND sub_sub_service_name = 'Chemical Waste Handling');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 13, 'Solid Waste Handling' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 13 AND sub_sub_service_name = 'Solid Waste Handling');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 14, 'Marble Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 14 AND sub_sub_service_name = 'Marble Polishing');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 14, 'Granite Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 14 AND sub_sub_service_name = 'Granite Polishing');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 15, 'Indoor Dust Removal' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 15 AND sub_sub_service_name = 'Indoor Dust Removal');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 15, 'Outdoor Dust Removal' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 15 AND sub_sub_service_name = 'Outdoor Dust Removal');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 16, 'Paint Stain from Tiles' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 16 AND sub_sub_service_name = 'Paint Stain from Tiles');
INSERT INTO public.master_sub_sub_service(sub_service_id, sub_sub_service_name) SELECT 16, 'Paint Stain From Windows' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_sub_service WHERE sub_service_id = 16 AND sub_sub_service_name = 'Paint Stain From Windows');

------------------------3-12-2025 - Lavanya
--- modified master_sub_sub_service table to master_sub_group table

create table if not exists master_sub_group(
id bigserial not null,
sub_service_id integer not null,
sub_group_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_sub_group_id primary key(id),
constraint uk_master_sub_group_sub_service_id_sub_group_name unique (sub_service_id,sub_group_name),
constraint fk_master_sub_group_sub_service_id foreign key (sub_service_id) references master_sub_service(id)
);

--------------03-12-2025 ---Tharun
--------------changing name master_sub_sub_sevice to master_sub_group
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 1, 'Living Room Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 1 AND sub_group_name = 'Living Room Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 1, 'Bedroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 1 AND sub_group_name = 'Bedroom Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 1, 'Kitchen Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 1 AND sub_group_name = 'Kitchen Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 1, 'Bathroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 1 AND sub_group_name = 'Bathroom Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 2, 'Studio Apartment' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 2 AND sub_group_name = 'Studio Apartment');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 2, '1 BHK Apartment' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 2 AND sub_group_name = '1 BHK Apartment');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 2, '2 BHK / 3 BHK Apartment' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 2 AND sub_group_name = '2 BHK / 3 BHK Apartment');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 3, 'Small Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 3 AND sub_group_name = 'Small Villas');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 3, 'Duplex Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 3 AND sub_group_name = 'Duplex Villas');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 3, 'Luxury Villas' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 3 AND sub_group_name = 'Luxury Villas');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 4, 'Cabin Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 4 AND sub_group_name = 'Cabin Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 4, 'Workstation Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 4 AND sub_group_name = 'Workstation Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 4, 'Conference Hall Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 4 AND sub_group_name = 'Conference Hall Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 5, 'Shop Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 5 AND sub_group_name = 'Shop Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 5, 'Mall Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 5 AND sub_group_name = 'Mall Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 5, 'Showroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 5 AND sub_group_name = 'Showroom Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 6, 'Laboratory Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 6 AND sub_group_name = 'Laboratory Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 6, 'Clinic Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 6 AND sub_group_name = 'Clinic Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 6, 'Diagnostic Centers' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 6 AND sub_group_name = 'Diagnostic Centers');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 7, 'Classrooms' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 7 AND sub_group_name = 'Classrooms');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 7, 'Laboratory Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 7 AND sub_group_name = 'Laboratory Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 7, 'Library Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 7 AND sub_group_name = 'Library Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 8, 'Sofa Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 8 AND sub_group_name = 'Sofa Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 8, 'Chair Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 8 AND sub_group_name = 'Chair Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 8, 'Wooden Furniture Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 8 AND sub_group_name = 'Wooden Furniture Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 9, 'Marble Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 9 AND sub_group_name = 'Marble Polishing');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 9, 'Tile Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 9 AND sub_group_name = 'Tile Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 9, 'Granite Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 9 AND sub_group_name = 'Granite Polishing');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 10, 'Indoor Glass Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 10 AND sub_group_name = 'Indoor Glass Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 10, 'Outdoor Glass Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 10 AND sub_group_name = 'Outdoor Glass Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 10, 'High-Rise Glass Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 10 AND sub_group_name = 'High-Rise Glass Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 10, 'Home Sanitization' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 10 AND sub_group_name = 'Home Sanitization');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 10, 'Office Sanitization' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 10 AND sub_group_name = 'Office Sanitization');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 10, 'Commercial Sanitization' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 10 AND sub_group_name = 'Commercial Sanitization');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 11, 'Assembly Areas Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 11 AND sub_group_name = 'Assembly Areas Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 11, 'Production Line Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 11 AND sub_group_name = 'Production Line Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 12, 'Warehouse Rack Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 12 AND sub_group_name = 'Warehouse Rack Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 12, 'Warehouse Floor Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 12 AND sub_group_name = 'Warehouse Floor Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 13, 'Heavy Equipment Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 13 AND sub_group_name = 'Heavy Equipment Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 13, 'Precision Tools Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 13 AND sub_group_name = 'Precision Tools Cleaning');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 13, 'Chemical Waste Handling' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 13 AND sub_group_name = 'Chemical Waste Handling');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 13, 'Solid Waste Handling' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 13 AND sub_group_name = 'Solid Waste Handling');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 14, 'Marble Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 14 AND sub_group_name = 'Marble Polishing');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 14, 'Granite Polishing' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 14 AND sub_group_name = 'Granite Polishing');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 15, 'Indoor Dust Removal' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 15 AND sub_group_name = 'Indoor Dust Removal');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 15, 'Outdoor Dust Removal' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 15 AND sub_group_name = 'Outdoor Dust Removal');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 16, 'Paint Stain from Tiles' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 16 AND sub_group_name = 'Paint Stain from Tiles');
INSERT INTO public.master_sub_group(sub_service_id, sub_group_name) SELECT 16, 'Paint Stain From Windows' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_group WHERE sub_service_id = 16 AND sub_group_name = 'Paint Stain From Windows');


--------------05-12-2025 ---Tharun
-----------created table employee_geo_tracking 
create table if not exists employee_geo_tracking(
id bigserial not null,
user_id bigint not null,
latitude varchar(100) not null, 
longitude varchar(100) not null,
tracking_time timestamp not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_employee_geo_tracking_id primary key (id),
constraint fk_employee_geo_tracking_user_id foreign key (user_id) references user_registration (id),
constraint fk_employee_geo_tracking_created_by foreign key (created_by) references user_registration (id),
constraint fk_employee_geo_tracking_modified_by foreign key (modified_by) references user_registration (id)
);

---- 5-dec-2025 - dhanusha 
-- created user_role table
create table if not exists user_role (
 	id bigserial not null,
 	user_id bigint not null,
 	role_id bigint not null,
 	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_user_role_id primary key(id),
	constraint fk_user_role_user_id foreign key (user_id) references user_registration(id),
	constraint fk_user_role_role_id foreign key (role_id) references master_role(id),
	constraint uk_user_role_user_id_role_id unique (user_id,role_id),
	constraint fk_user_role_created_by foreign key (created_by) references user_registration(id),
	constraint fk_user_role_modified_by foreign key (modified_by) references user_registration(id)
);

--------- 5-12-2025 - Lavanya
-- created master_status table
Create table if not exists  master_status(
id serial not null,
status_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_status_id primary key(id));

---
alter table if exists user_registration add column status_id bigint; 

alter table if exists user_registration
add constraint fk_user_registration_status_id foreign key (status_id) references master_status(id);

--------- 09-12-2025 Dhanusha
-- created home_service table and related master tables
create table if not exists home_service(
	id bigserial not null,
	module_id int not null,
	sub_module_id int not null,
	service_id bigint not null,
	sub_service_id int ,
	sub_group_id bigint ,
	full_name varchar(255) not null,
	email varchar(150) not null,
	mobile varchar(255) not null,
	address varchar(500) not null,
	service_type_id int ,
	issue_id bigint,
	problem_Description varchar(500),
	property_size_sqft varchar(150),
	add_on_id int,
	preferred_date date,
	time_slot_id int,
	special_instructions varchar(500),
	payment_type_id int,
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_home_service_id primary key (id),
	constraint fk_home_service_module_id foreign key (module_id) references master_module (id),
	constraint fk_home_service_sub_module_id foreign key (sub_module_id) references master_sub_module (id),
	constraint fk_home_service_service_id foreign key (service_id) references master_service (id),
	constraint fk_home_service_sub_service_id foreign key (sub_service_id) references master_sub_service (id),
	constraint fk_home_service_sub_group_id foreign key (sub_group_id) references master_sub_group (id),
	constraint fk_home_service_service_type_id foreign key (service_type_id) references master_service_type (id),
	constraint fk_home_service_issue_id foreign key (issue_id) references master_issue (id),
	constraint fk_home_service_add_on_id foreign key (add_on_id) references master_add_on (id),
	constraint fk_home_service_time_slot_id foreign key (time_slot_id) references master_time_slot (id),
	constraint fk_home_service_payment_type_id foreign key (payment_type_id) references master_payment_type (id),
	constraint fk_home_service_created_by foreign key (created_by) references user_registration(id),
	constraint fk_home_service_modified_by foreign key (modified_by) references user_registration(id)

);

	


-------
select * from master_service_type;
Create table if not exists  master_service_type(
id serial not null,
service_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_service_type_id primary key(id),
constraint uk_master_service_type_service_type unique (service_type));

INSERT INTO master_service_type (service_type)SELECT 'Regular Cleaning'WHERE NOT EXISTS (SELECT 1 FROM master_service_type WHERE service_type = 'Regular Cleaning');
INSERT INTO master_service_type (service_type)SELECT 'Deep Cleaning'WHERE NOT EXISTS (SELECT 1 FROM master_service_type WHERE service_type = 'Deep Cleaning');
INSERT INTO master_service_type (service_type)SELECT 'Move-in/Move-out Cleaning'WHERE NOT EXISTS (SELECT 1 FROM master_service_type WHERE service_type = 'Move-in/Move-out Cleaning');
INSERT INTO master_service_type (service_type)SELECT 'Grease Removal'WHERE NOT EXISTS (SELECT 1 FROM master_service_type WHERE service_type = 'Grease Removal');

------

create table master_add_on(
	id serial not null,
	add_on varchar(255) not null,
	price numeric(10,2) not null,
	is_active boolean default true,
	constraint pk_master_add_on_id primary key (id),
	constraint uk_master_add_on_add_on unique (add_on)
);

INSERT INTO master_add_on (add_on, price) SELECT 'Kitchen Deep Clean', 199 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Kitchen Deep Clean' AND price = 199);
INSERT INTO master_add_on (add_on, price) SELECT 'Balcony wash', 149 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Balcony wash' AND price = 149);
INSERT INTO master_add_on (add_on, price) SELECT 'Sofa shampooing', 299 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Sofa shampooing' AND price = 299);
INSERT INTO master_add_on (add_on, price) SELECT 'Window Cleaning', 150 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Window Cleaning' AND price = 150);
INSERT INTO master_add_on (add_on, price) SELECT 'Balcony Cleaning', 150 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Balcony Cleaning' AND price = 150);
INSERT INTO master_add_on (add_on, price) SELECT 'Carpet Shampooing', 200 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Carpet Shampooing' AND price = 200);
INSERT INTO master_add_on (add_on, price) SELECT 'Oven Deep Clean', 300 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE add_on = 'Oven Deep Clean' AND price = 300);

----------


create table if not exists master_payment_type(
id serial not null,
payment_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_payment_type_id primary key (id),
constraint uk_master_payment_type_payment_name unique (payment_name)
);

INSERT INTO master_payment_type (payment_name) SELECT 'Full Payment' WHERE NOT EXISTS (SELECT 1 FROM master_payment_type WHERE payment_name = 'Full Payment');
INSERT INTO master_payment_type (payment_name) SELECT 'Partial Payment (Advance)' WHERE NOT EXISTS (SELECT 1 FROM master_payment_type WHERE payment_name = 'Partial Payment (Advance)');

--------

create table if not exists master_time_slot(
id serial not null,
time_slot varchar(255),
is_active boolean default true,
constraint pk_master_time_slot_id primary key (id),
constraint uk_master_time_slot_time_slot unique (time_slot)
); 

INSERT INTO master_time_slot (time_slot)SELECT '9:00 AM - 11:00 AM' WHERE NOT EXISTS (SELECT 1 FROM master_time_slot WHERE time_slot = '9:00 AM - 11:00 AM');
INSERT INTO master_time_slot (time_slot)SELECT '11:00 AM - 1:00 PM' WHERE NOT EXISTS (SELECT 1 FROM master_time_slot WHERE time_slot = '11:00 AM - 1:00 PM');
INSERT INTO master_time_slot (time_slot)SELECT '1:00 PM - 3:00 PM' WHERE NOT EXISTS (SELECT 1 FROM master_time_slot WHERE time_slot = '1:00 PM - 3:00 PM');
INSERT INTO master_time_slot (time_slot)SELECT '3:00 PM - 5:00 PM'WHERE NOT EXISTS (SELECT 1 FROM master_time_slot WHERE time_slot = '3:00 PM - 5:00 PM');
INSERT INTO master_time_slot (time_slot)SELECT '5:00 PM - 7:00 PM'WHERE NOT EXISTS (SELECT 1 FROM master_time_slot WHERE time_slot = '5:00 PM - 7:00 PM');

-------

create table if not exists master_bedroom (
	id serial not null,
	bedroom_count varchar(255) not null,
	is_active boolean default true,
	constraint pk_master_bedroom_id primary key (id)	
);

INSERT INTO master_bedroom (bedroom_count) SELECT '1' WHERE NOT EXISTS (SELECT 1 FROM master_bedroom WHERE bedroom_count = '1');
INSERT INTO master_bedroom (bedroom_count) SELECT '2' WHERE NOT EXISTS (SELECT 1 FROM master_bedroom WHERE bedroom_count = '2');
INSERT INTO master_bedroom (bedroom_count) SELECT '3' WHERE NOT EXISTS (SELECT 1 FROM master_bedroom WHERE bedroom_count = '3');
INSERT INTO master_bedroom (bedroom_count) SELECT '4+' WHERE NOT EXISTS (SELECT 1 FROM master_bedroom WHERE bedroom_count = '4+');

-----
create table if not exists master_bathroom (
	id serial not null,
	bathroom_count varchar(255) not null,
	is_active boolean default true,
	constraint pk_master_bathroom_id primary key (id)	
);

INSERT INTO master_bathroom (bathroom_count) SELECT '1' WHERE NOT EXISTS (SELECT 1 FROM master_bathroom WHERE bathroom_count = '1');
INSERT INTO master_bathroom (bathroom_count) SELECT '2' WHERE NOT EXISTS (SELECT 1 FROM master_bathroom WHERE bathroom_count = '2');
INSERT INTO master_bathroom (bathroom_count) SELECT '3+' WHERE NOT EXISTS (SELECT 1 FROM master_bathroom WHERE bathroom_count = '3+');

------

create table if not exists master_issue(
id bigserial not null, 
issue_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_issue_id primary key(id));
alter sequence public.master_issue_id_seq restart with 1;

insert into master_issue (issue_type) select 'Wiring Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wiring Issue');
insert into master_issue (issue_type) select 'Bulb Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bulb Not Working');
insert into master_issue (issue_type) select 'Short Circuit' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Short Circuit');
insert into master_issue (issue_type) select 'Switch Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Switch Issue');
insert into master_issue (issue_type) select 'Loose Connections' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Connections');
insert into master_issue (issue_type) select 'Fan Not Rotating' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Fan Not Rotating');
insert into master_issue (issue_type) select 'Fan Making Noise' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Fan Making Noise');
insert into master_issue (issue_type) select 'Fan Not Starting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Fan Not Starting');
insert into master_issue (issue_type) select 'Regulator Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Regulator Issue');
insert into master_issue (issue_type) select 'Low Fan Speed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Fan Speed');
insert into master_issue (issue_type) select 'Breaker Tripping' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Breaker Tripping');
insert into master_issue (issue_type) select 'Overload Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Overload Issues');
insert into master_issue (issue_type) select 'Loose Switches' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Switches');
insert into master_issue (issue_type) select 'Socket Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Socket Not Working');
insert into master_issue (issue_type) select 'Sparking Problem' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Sparking Problem');
insert into master_issue (issue_type) select 'Device Not Pairing' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Device Not Pairing');
insert into master_issue (issue_type) select 'Connectivty Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Connectivty Issue');
insert into master_issue (issue_type) select 'Incorrect Setup' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Incorrect Setup');
insert into master_issue (issue_type) select 'App Integration Problem' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='App Integration Problem');
insert into master_issue (issue_type) select 'Power Supply Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Power Supply Issue');
insert into master_issue (issue_type) select 'Tap Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Tap Leakage');
insert into master_issue (issue_type) select 'Pipe Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Pipe Leakage');
insert into master_issue (issue_type) select 'Water Dripping' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Dripping');
insert into master_issue (issue_type) select 'Joint Loose' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Joint Loose');
insert into master_issue (issue_type) select 'Moisture Patches' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Moisture Patches');
insert into master_issue (issue_type) select 'Loose Pipe Joints' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Pipe Joints');
insert into master_issue (issue_type) select 'Pipe Replacement Needed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Pipe Replacement Needed');
insert into master_issue (issue_type) select 'Low Water Flow' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Water Flow');
insert into master_issue (issue_type) select 'Pipe Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Pipe Cracks');
insert into master_issue (issue_type) select 'Improper Fitting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Improper Fitting');
insert into master_issue (issue_type) select 'Geyser Not Heating' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Geyser Not Heating');
insert into master_issue (issue_type) select 'Water Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Leakage');
insert into master_issue (issue_type) select 'Incorrect Installation' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Incorrect Installation');
insert into master_issue (issue_type) select 'Pipe Fitting Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Pipe Fitting Issue');
insert into master_issue (issue_type) select 'Pressure Problems' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Pressure Problems');
insert into master_issue (issue_type) select 'Tap Loose' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Tap Loose');
insert into master_issue (issue_type) select 'Shower Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Shower Leakage');
insert into master_issue (issue_type) select 'Broken Fitting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken Fitting');
insert into master_issue (issue_type) select 'Low Water Pressure' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Water Pressure');
insert into master_issue (issue_type) select 'Improper Installation' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Improper Installation');
insert into master_issue (issue_type) select 'Dirty Water' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Dirty Water');
insert into master_issue (issue_type) select 'Foul Smell' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Foul Smell');
insert into master_issue (issue_type) select 'Algae Build-Up' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Algae Build-Up');
insert into master_issue (issue_type) select 'Sediment Accumulation' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Sediment Accumulation');
insert into master_issue (issue_type) select 'Overflow Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Overflow Issue');
insert into master_issue (issue_type) select 'Drain Blockage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Drain Blockage');
insert into master_issue (issue_type) select 'Slow Water Flow' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Slow Water Flow');
insert into master_issue (issue_type) select 'Bad Drain Smell' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bad Drain Smell');
insert into master_issue (issue_type) select 'Grease Buildup' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Grease Buildup');
insert into master_issue (issue_type) select 'Hair Clogging' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Hair Clogging');
insert into master_issue (issue_type) select 'AC Not Cooling' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='AC Not Cooling');
insert into master_issue (issue_type) select 'Water Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Leakage');
insert into master_issue (issue_type) select 'Bad Smell' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bad Smell');
insert into master_issue (issue_type) select 'Low Airflow' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Airflow');
insert into master_issue (issue_type) select 'Compressor Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Compressor Issue');
insert into master_issue (issue_type) select 'Not Cooling' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Not Cooling');
insert into master_issue (issue_type) select 'Water Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Leakage');
insert into master_issue (issue_type) select 'Freezer Over-Icing' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Freezer Over-Icing');
insert into master_issue (issue_type) select 'Noise From Compressor' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Noise From Compressor');
insert into master_issue (issue_type) select 'Door Not Sealing' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Door Not Sealing');
insert into master_issue (issue_type) select 'Machine Not Spinning' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Machine Not Spinning');
insert into master_issue (issue_type) select 'Water Not Draining' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Not Draining');
insert into master_issue (issue_type) select 'Motor Noise' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Motor Noise');
insert into master_issue (issue_type) select 'Vibration Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Vibration Issues');
insert into master_issue (issue_type) select 'Door Not Locking' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Door Not Locking');
insert into master_issue (issue_type) select 'Not Heating' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Not Heating');
insert into master_issue (issue_type) select 'Plate Not Rotating' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Plate Not Rotating');
insert into master_issue (issue_type) select 'Sparking Inside' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Sparking Inside');
insert into master_issue (issue_type) select 'Burning Smell' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Burning Smell');
insert into master_issue (issue_type) select 'Button Malfunction' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Button Malfunction');
insert into master_issue (issue_type) select 'No Display' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='No Display');
insert into master_issue (issue_type) select 'No Sound' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='No Sound');
insert into master_issue (issue_type) select 'Lines on Screen' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Lines on Screen');
insert into master_issue (issue_type) select 'Port Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Port Not Working');
insert into master_issue (issue_type) select 'Remote Not Responding' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Remote Not Responding');
insert into master_issue (issue_type) select 'Low Performance' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Performance');
insert into master_issue (issue_type) select 'Overheating Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Overheating Issue');
insert into master_issue (issue_type) select 'Noise From Appliance' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Noise From Appliance');
insert into master_issue (issue_type) select 'Irregular Functioning' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Irregular Functioning');
insert into master_issue (issue_type) select 'Wear and Tear' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wear and Tear');
insert into master_issue (issue_type) select 'Broken Components' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken Components');
insert into master_issue (issue_type) select 'Damaged Wiring' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Damaged Wiring');
insert into master_issue (issue_type) select 'Worn-Out Parts' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Worn-Out Parts');
insert into master_issue (issue_type) select 'Non-Functional Buttons' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Non-Functional Buttons');
insert into master_issue (issue_type) select 'Motor or Compressor Faults' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Motor or Compressor Faults');
insert into master_issue (issue_type) select 'New Furniture Requirement' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='New Furniture Requirement');
insert into master_issue (issue_type) select 'Custom Size Needed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Custom Size Needed');
insert into master_issue (issue_type) select 'Design Modification ' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Design Modification ');
insert into master_issue (issue_type) select 'Material Selection Help' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Material Selection Help');
insert into master_issue (issue_type) select 'Loose Structure Concerns' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Structure Concerns');
insert into master_issue (issue_type) select 'Broken Furniture' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken Furniture');
insert into master_issue (issue_type) select 'Loose Joins' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Joins');
insert into master_issue (issue_type) select 'Scratches & Dents' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Scratches & Dents');
insert into master_issue (issue_type) select 'Damaged Hinges' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Damaged Hinges');
insert into master_issue (issue_type) select 'Home Service' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Home Service');
insert into master_issue (issue_type) select 'Door Not Closing' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Door Not Closing');
insert into master_issue (issue_type) select 'Window Jammed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Window Jammed');
insert into master_issue (issue_type) select 'Loose Hinges' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Hinges');
insert into master_issue (issue_type) select 'Lock Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Lock Not Working');
insert into master_issue (issue_type) select 'Frame Misalignment' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Frame Misalignment');
insert into master_issue (issue_type) select 'Cabinet Misalignment' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Cabinet Misalignment');
insert into master_issue (issue_type) select 'Broken hinges' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken hinges');
insert into master_issue (issue_type) select 'Loose Shelves' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Shelves');
insert into master_issue (issue_type) select 'Sliding Not Smooth' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Sliding Not Smooth');
insert into master_issue (issue_type) select 'New Installation Required' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='New Installation Required');
insert into master_issue (issue_type) select 'Wall Discoloration' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Discoloration');
insert into master_issue (issue_type) select 'Peeling Paint' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Peeling Paint');
insert into master_issue (issue_type) select 'Cracks on Walls' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Cracks on Walls');
insert into master_issue (issue_type) select 'Faded Colors' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Faded Colors');
insert into master_issue (issue_type) select 'Moisture Patches' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Moisture Patches');
insert into master_issue (issue_type) select 'Paint Fading' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Paint Fading');
insert into master_issue (issue_type) select 'Exterior Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Exterior Cracks');
insert into master_issue (issue_type) select 'Water Damage Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Damage Cracks');
insert into master_issue (issue_type) select 'Wall Roughness' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Roughness');
insert into master_issue (issue_type) select 'Peeling Layers' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Peeling Layers');
insert into master_issue (issue_type) select 'Wallpaper Peeling' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wallpaper Peeling');
insert into master_issue (issue_type) select 'Wall Bubbles' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Bubbles');
insert into master_issue (issue_type) select 'Misalignment Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Misalignment Issues');
insert into master_issue (issue_type) select 'Minor Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Minor Cracks');
insert into master_issue (issue_type) select 'Paint Scratches' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Paint Scratches');
insert into master_issue (issue_type) select 'Wall Seepage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Seepage');
insert into master_issue (issue_type) select 'Water Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Leakage');
insert into master_issue (issue_type) select 'Damp Patches' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Damp Patches');
insert into master_issue (issue_type) select 'Ceiling Moisture' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Ceiling Moisture');
insert into master_issue (issue_type) select 'Crack Water Flow' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Crack Water Flow');
insert into master_issue (issue_type) select 'Wall Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Cracks');
insert into master_issue (issue_type) select 'Holes in Wall' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Holes in Wall');
insert into master_issue (issue_type) select 'Uneven Surface' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Uneven Surface');
insert into master_issue (issue_type) select 'Chipped Plaster' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Chipped Plaster');
insert into master_issue (issue_type) select 'Damaged Corners' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Damaged Corners');
insert into master_issue (issue_type) select 'Water Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Leakage');
insert into master_issue (issue_type) select 'Improper Cooling' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Improper Cooling');
insert into master_issue (issue_type) select 'Vibration issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Vibration issues');
insert into master_issue (issue_type) select 'Loose Mounting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Mounting');
insert into master_issue (issue_type) select 'High Noise' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='High Noise');
insert into master_issue (issue_type) select 'Low Cooling' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Cooling');
insert into master_issue (issue_type) select 'Bad Smell' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bad Smell');
insert into master_issue (issue_type) select 'Water Dripping' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Dripping');
insert into master_issue (issue_type) select 'Dirty Filters' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Dirty Filters');
insert into master_issue (issue_type) select 'High Power Usage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='High Power Usage');
insert into master_issue (issue_type) select 'Dust In Vents' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Dust In Vents');
insert into master_issue (issue_type) select 'Low Airflow' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Airflow');
insert into master_issue (issue_type) select 'Bad Odor' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bad Odor');
insert into master_issue (issue_type) select 'Allergy Triggers' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Allergy Triggers');
insert into master_issue (issue_type) select 'Clogged Ducts' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Clogged Ducts');
insert into master_issue (issue_type) select 'Dirty Filters' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Dirty Filters');
insert into master_issue (issue_type) select 'Weak Cooling' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Weak Cooling');
insert into master_issue (issue_type) select 'Bad Airflow' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bad Airflow');
insert into master_issue (issue_type) select 'High Noise' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='High Noise');
insert into master_issue (issue_type) select 'Odor Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Odor Issue');
insert into master_issue (issue_type) select 'Frequent Breakdowns' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Frequent Breakdowns');
insert into master_issue (issue_type) select 'Cooling Delay' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Cooling Delay');
insert into master_issue (issue_type) select 'Thermostat Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Thermostat Issue');
insert into master_issue (issue_type) select 'Gas Leakage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Gas Leakage');
insert into master_issue (issue_type) select 'Over Heating' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Over Heating');
insert into master_issue (issue_type) select 'Overgrown Grass' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Overgrown Grass');
insert into master_issue (issue_type) select 'Weed Spread' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Weed Spread');
insert into master_issue (issue_type) select 'Uneven Edges' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Uneven Edges');
insert into master_issue (issue_type) select 'Dry Patches' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Dry Patches');
insert into master_issue (issue_type) select 'Insect Damage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Insect Damage');
insert into master_issue (issue_type) select 'Poor Layout' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Poor Layout');
insert into master_issue (issue_type) select 'Unhealthy Plants' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Unhealthy Plants');
insert into master_issue (issue_type) select 'Soil Imbalance' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Soil Imbalance');
insert into master_issue (issue_type) select 'Patchy Design' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Patchy Design');
insert into master_issue (issue_type) select 'Water Drainage Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Water Drainage Issue');
insert into master_issue (issue_type) select 'Dirty Pathways' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Dirty Pathways');
insert into master_issue (issue_type) select 'Excess Leaves' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Excess Leaves');
insert into master_issue (issue_type) select 'Moss Buildup' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Moss Buildup');
insert into master_issue (issue_type) select 'Outdoor Stains' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Outdoor Stains');
insert into master_issue (issue_type) select 'Garbage Accumulation' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Garbage Accumulation');
insert into master_issue (issue_type) select 'Plant Pests' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Plant Pests');
insert into master_issue (issue_type) select 'Leaf Damage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Leaf Damage');
insert into master_issue (issue_type) select 'Soil Insects' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Soil Insects');
insert into master_issue (issue_type) select 'Fungal Infection' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Fungal Infection');
insert into master_issue (issue_type) select 'Plant Wilting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Plant Wilting');
insert into master_issue (issue_type) select 'Loose Tv Mount' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Tv Mount');
insert into master_issue (issue_type) select 'Tilt Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Tilt Not Working');
insert into master_issue (issue_type) select 'Wall Alignment Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Alignment Issue');
insert into master_issue (issue_type) select 'Bracket Replacement Needed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Bracket Replacement Needed');
insert into master_issue (issue_type) select 'Drilling Support Required' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Drilling Support Required');
insert into master_issue (issue_type) select 'Shelf Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Shelf Not Working');
insert into master_issue (issue_type) select 'Loose Screws' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Screws');
insert into master_issue (issue_type) select 'Wall Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Cracks');
insert into master_issue (issue_type) select 'Incorrect Placement' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Incorrect Placement');
insert into master_issue (issue_type) select 'Heavy Load Concerns' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Heavy Load Concerns');
insert into master_issue (issue_type) select 'Loose Handles' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Handles');
insert into master_issue (issue_type) select 'Broken Hinges' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken Hinges');
insert into master_issue (issue_type) select 'Damaged Fixtures' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Damaged Fixtures');
insert into master_issue (issue_type) select 'Misalignment' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Misalignment');
insert into master_issue (issue_type) select 'Wear And Tear' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wear And Tear');
insert into master_issue (issue_type) select 'Loose Joints' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Joints');
insert into master_issue (issue_type) select 'Wobbling Chair' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wobbling Chair');
insert into master_issue (issue_type) select 'Broken Drawer' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken Drawer');
insert into master_issue (issue_type) select 'Cracked Wood' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Cracked Wood');
insert into master_issue (issue_type) select 'Damaged Hinges' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Damaged Hinges');
insert into master_issue (issue_type) select 'Loose Fittings' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Fittings');
insert into master_issue (issue_type) select 'Wall Damage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wall Damage');
insert into master_issue (issue_type) select 'Small Cracks' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Small Cracks');
insert into master_issue (issue_type) select 'Stuck Doors' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Stuck Doors');
insert into master_issue (issue_type) select 'Minor Wear Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Minor Wear Issues');
insert into master_issue (issue_type) select 'Camera Not Recording' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Camera Not Recording');
insert into master_issue (issue_type) select 'Blurry Video Feed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Blurry Video Feed');
insert into master_issue (issue_type) select 'App Not Connecting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='App Not Connecting');
insert into master_issue (issue_type) select 'Cable Damage' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Cable Damage');
insert into master_issue (issue_type) select 'DVR Storage Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='DVR Storage Issues');
insert into master_issue (issue_type) select 'Loose Lock' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Loose Lock');
insert into master_issue (issue_type) select 'Key Not Turning' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Key Not Turning');
insert into master_issue (issue_type) select 'Broken Latch' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Broken Latch');
insert into master_issue (issue_type) select 'Door Misalignment' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Door Misalignment');
insert into master_issue (issue_type) select 'Lock Replacement Needed' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Lock Replacement Needed');
insert into master_issue (issue_type) select 'No Alarm Sound' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='No Alarm Sound');
insert into master_issue (issue_type) select 'Sensor Not Detecting' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Sensor Not Detecting');
insert into master_issue (issue_type) select 'Mobile Alters Not Working' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Mobile Alters Not Working');
insert into master_issue (issue_type) select 'Wiring Fault' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Wiring Fault');
insert into master_issue (issue_type) select 'Low Battery Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Battery Issues');
insert into master_issue (issue_type) select 'Sensor Not Triggering' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Sensor Not Triggering');
insert into master_issue (issue_type) select 'False Alerts' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='False Alerts');
insert into master_issue (issue_type) select 'Low Range' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Low Range');
insert into master_issue (issue_type) select 'Connectivity Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Connectivity Issues');
insert into master_issue (issue_type) select 'Power Supply Fault' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Power Supply Fault');
insert into master_issue (issue_type) select 'Device Not Pairing' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Device Not Pairing');
insert into master_issue (issue_type) select 'App - Sync Issues' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='App - Sync Issues');
insert into master_issue (issue_type) select 'Smart Hub Offline' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Smart Hub Offline');
insert into master_issue (issue_type) select 'Voice Assistant Errors' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Voice Assistant Errors');
insert into master_issue (issue_type) select 'Battery Or Power Issue' WHERE NOT EXISTS (SELECT 1 FROM master_issue WHERE  issue_type ='Battery Or Power Issue');

-----------17-12-2025 - Lavanya
-- created hs_add_on table

create table if not exists hs_add_on(
    id serial not null,
    home_service_id int not null,
    add_on_id int not null,
    created_by bigint,
    created_date timestamp default now(),
    modified_by bigint,
    modified_date timestamp,
    is_active boolean default true,
    constraint pk_hs_add_on_id primary key (id),
    constraint fk_hs_add_on_home_service_id foreign key (home_service_id) references home_service (id),
	constraint fk_hs_add_on_add_on_id foreign key (add_on_id) references master_add_on (id));
----------18-12-2025 - Lavanya
alter table master_bedroom add constraint uk_master_bedroom_bedroom_count unique(bedroom_count);
alter table master_issue add constraint uk_master_issue_issue_type unique(issue_type); 
alter table master_role add constraint uk_master_role_role_name unique(role_name);
alter table master_skill add constraint uk_master_skill_skill unique(skill);
alter table master_status add constraint uk_master_status_status_name unique(status_name);
---
alter table home_service add column service_price numeric(10,2);


---- 29-dec-2025 -- danusha
INSERT INTO public.master_status (status_name) SELECT 'Assigned' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE status_name = 'Assigned');
INSERT INTO public.master_status (status_name) SELECT 'Not Assigned' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE status_name = 'Not Assigned');


--- 31st - dec-2025 --dhanusha

SELECT setval('public.master_status_id_seq', (SELECT COALESCE(MAX(id),0)+1 FROM public.master_status), false);
INSERT INTO master_status (status_name) SELECT 'Completed' WHERE NOT EXISTS (SELECT 1 FROM master_status WHERE status_name = 'Completed');

----2/1/2026 --lavanya
----created master table
Create table if not exists master_work_status(
id serial not null,
work_status_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_work_status_id primary key(id),
constraint uk_master_work_status_work_status_name unique (work_status_name));
---
INSERT INTO public.master_work_status (work_status_name)SELECT 'On The Way' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_status WHERE work_status_name = 'On The Way');
INSERT INTO public.master_work_status (work_status_name)SELECT 'Reached Location' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_status WHERE work_status_name = 'Reached Location');
INSERT INTO public.master_work_status (work_status_name)SELECT 'Job Started' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_status WHERE work_status_name = 'Job Started');
INSERT INTO public.master_work_status (work_status_name)SELECT 'Job Completed' WHERE NOT EXISTS (SELECT 1 FROM public.master_work_status WHERE work_status_name = 'Job Completed');

-----
update master_role set role_name = 'Freelancer' where id = 4;
cluster master_role using pk_master_role_id;

-----------2nd-jan-2026 -dhanusha

INSERT INTO public.master_skill (skill) SELECT 'Gardening' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Gardening');
INSERT INTO public.master_skill (skill) SELECT 'Home Mainteance' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Home Mainteance');
INSERT INTO public.master_skill (skill) SELECT 'Interior Design' WHERE NOT EXISTS (SELECT 1 FROM public.master_skill WHERE skill = 'Interior Design');


--------------------

create table if not exists freelancer_task_history (
	id bigserial not null,
	home_service_id bigint not null,
	freelancer_id bigint not null,
	work_status_id bigint not null,
	upload_img varchar(500),
	created_by bigint, 
	created_date timestamp default now(),
  	modified_by bigint, 
  	modified_date timestamp, 
	is_active boolean default true,
	constraint pk_freelancer_task_history_id primary key(id),
	constraint fk_freelancer_task_history_home_service_id foreign key (home_service_id) references home_service(id),
	constraint fk_freelancer_task_history_home_freelancer_id foreign key (freelancer_id) references master_role(id),
	constraint fk_freelancer_task_history_home_work_status_id foreign key (work_status_id) references master_work_status(id)
);


--------------- dhanusha--5th-dec-2026

INSERT INTO public.master_status (status_name) SELECT 'Assigned' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE status_name = 'Assigned');
INSERT INTO public.master_status (status_name) SELECT 'Not Assigned' WHERE NOT EXISTS (SELECT 1 FROM public.master_status WHERE status_name = 'Not Assigned');

-------5/1/2026 lavanya

alter table user_registration add column reg_payment_done boolean;
alter table user_registration add column reg_fee numeric(10,2);
alter table user_registration add constraint fk_user_registration_skill_id foreign key (skill_id) references master_skill(id);

------7/1/2026 lavanya

alter table home_service add column rating int;
alter table home_service add constraint ck_home_service_rating check (rating between 1 and 5);
alter table freelancer_task_history add column rating int;
alter table freelancer_task_history add constraint ck_freelancer_task_history_rating check (rating between 1 and 5);
alter table user_registration alter column government_id type json using government_id::json;


-----8/1/2026 lavanya

create table if not exists user_services(
	id bigserial not null,
	module_id int not null,
	user_id int not null,
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_user_services_id primary key (id),
	constraint fk_user_services_module_id foreign key (module_id) references master_module (id),
	constraint fk_user_services_user_id foreign key (user_id) references user_registration (id)
	);


-----

create table if not exists user_skill(
	id bigserial not null,
	skill_id int not null,
	user_id int not null,
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_user_skill_id primary key (id),
	constraint fk_user_skill_skill_id foreign key (skill_id) references master_skill (id),
	constraint fk_user_skill_user_id foreign key (user_id) references user_registration (id)
	);

	----
create table if not exists student_qualification(
	id bigserial not null,
	user_id int not null,
	degree varchar(255) not null,
	institute varchar(255) not null,
	percentage varchar(255) not null,
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_student_qualification_id primary key (id),
	constraint fk_student_qualification_user_id foreign key (user_id) references user_registration (id)
	);
	
	----
	
create table if not exists student_certificate(
	id bigserial not null,
    user_id int not null,
	certificate_name varchar(255) not null,
	issued_by varchar(255) not null,
	year int not null,
	upload_certificate varchar(500) not null,
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_student_certificate_id primary key (id),
    constraint fk_student_certificate_user_id foreign key (user_id) references user_registration (id)
);
---
alter table if exists user_registration add column user_services_id int;
alter table if exists user_registration add column user_skill_id int;
alter table if exists user_registration add column student_qualification_id int;
alter table if exists user_registration add column student_certificate_id int;
---
alter table if exists user_registration add constraint fk_user_registration_user_services_id foreign key(user_services_id) references user_services(id);
alter table if exists user_registration add constraint fk_user_registration_user_skill_id foreign key(user_skill_id) references user_skill(id);
alter table if exists user_registration add constraint fk_user_registration_student_qualification_id foreign key(student_qualification_id) references student_qualification(id);
alter table if exists user_registration add constraint fk_user_registration_student_certificate_id foreign key(student_certificate_id) references student_certificate(id);

alter table user_registration drop column skill_id;
alter table user_registration add column experience_in_years ;

------
create table if not exists master_duration(
id serial not null,
duration varchar(255) not null,
is_active boolean default true,
constraint pk_master_duration_id primary key(id),
constraint uk_master_duration_duration unique(duration));

insert into master_duration(duration) select '1 hour' where not exists(select 1 from master_duration where duration = '1 hour');
insert into master_duration(duration) select '2 hours' where not exists(select 1 from master_duration where duration = '2 hours');
insert into master_duration(duration) select '3 hours' where not exists(select 1 from master_duration where duration = '3 hours');
insert into master_duration(duration) select '4 hours' where not exists(select 1 from master_duration where duration = '4 hours');
insert into master_duration(duration) select '5 hours' where not exists(select 1 from master_duration where duration = '5 hours');
insert into master_duration(duration) select '6 hours' where not exists(select 1 from master_duration where duration = '6 hours');
insert into master_duration(duration) select '7 hours' where not exists(select 1 from master_duration where duration = '7 hours');
insert into master_duration(duration) select '8 hours' where not exists(select 1 from master_duration where duration = '8 hours');
insert into master_duration(duration) select '9 hours' where not exists(select 1 from master_duration where duration = '9 hours');

alter table if exists home_service add column if not exists duration_id integer;
alter table if exists hs_add_on add column if not exists duration_id integer;
alter table if exists home_service add constraint fk_home_service_duration_id foreign key(duration_id) references master_duration(id);
alter table if exists hs_add_on add constraint fk_hs_add_on_duration_id foreign key(duration_id) references master_duration(id);

-----
alter table user_services add constraint fk_user_services_created_by foreign key(created_by) references user_registration (id);
alter table user_skill add constraint fk_user_skill_created_by foreign key(created_by) references user_registration (id);
alter table student_qualification add constraint fk_student_qualification_created_by foreign key(created_by) references user_registration (id);
alter table student_certificate add constraint fk_student_certificate_created_by foreign key(created_by) references user_registration (id);

alter table user_services add constraint fk_user_services_modified_by foreign key(modified_by) references user_registration (id);
alter table user_skill add constraint fk_user_skill_modified_by foreign key(modified_by) references user_registration (id);
alter table student_qualification add constraint fk_student_qualification_modified_by foreign key(modified_by) references user_registration (id);
alter table student_certificate add constraint fk_student_certificate_modified_by foreign key(modified_by) references user_registration (id);

alter table freelancer_task_history add constraint fk_freelancer_task_history_created_by foreign key(created_by) references user_registration (id);
alter table hs_add_on add constraint fk_hs_add_on_created_by foreign key(created_by) references user_registration (id);
alter table freelancer_task_history add constraint fk_freelancer_task_history_modified_by foreign key(modified_by) references user_registration (id);
alter table hs_add_on add constraint fk_hs_add_on_modified_by foreign key(modified_by) references user_registration (id);

------9/1/2026 lavanya
INSERT INTO public.master_module(id,module_name) SELECT 5, 'Education' WHERE NOT EXISTS (SELECT 5 FROM public.master_module WHERE id = 5 AND module_name = 'Education');
----
alter table user_registration add column noc_number varchar(255);
alter table user_registration add column police_station_name varchar(255);
alter table user_registration add column issue_year int;
alter table user_registration add column upload_noc varchar(500);


---- 13/1/2026 dhanusha

INSERT INTO public.master_sub_module (module_id, sub_module_name) SELECT 1, 'Home Services' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module  WHERE module_id = 1 AND sub_module_name = 'Home Services');
INSERT INTO public.master_sub_module (module_id, sub_module_name) SELECT 1, 'Cleaning Services' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module  WHERE module_id = 1 AND sub_module_name = 'Cleaning Services');


INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Floor Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Floor Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Kitchen Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Kitchen Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Washroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Washroom Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Carpentry' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Carpentry');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Electrician' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Electrician');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 1, 'Floor/Tiles Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 1 AND service_name = 'Floor/Tiles Repair');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Apartment Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Apartment Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Commercial/Office Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Commercial/Office Cleaning');
INSERT INTO public.master_service (sub_module_id, service_name) SELECT 2, 'Vehicle Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE sub_module_id = 2 AND service_name = 'Vehicle Cleaning');


INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 7, 'Floor Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 7 AND sub_service_name = 'Floor Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 7, 'Kitchen Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 7 AND sub_service_name = 'Kitchen Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 7, 'Washroom Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 7 AND sub_service_name = 'Washroom Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 7, 'Carpentry' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 7 AND sub_service_name = 'Carpentry');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 7, 'Electrician' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 7 AND sub_service_name = 'Electrician');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 7, 'Floor/Tiles Repair' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 7 AND sub_service_name = 'Floor/Tiles Repair');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 8, 'Office Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 8 AND sub_service_name = 'Office Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 8, 'Pool Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 8 AND sub_service_name = 'Pool Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 8, 'Villa Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 8 AND sub_service_name = 'Villa Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 9, 'Car Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 9 AND sub_service_name = 'Car Cleaning');
INSERT INTO public.master_sub_service (service_id, sub_service_name) SELECT 9, 'Bike Cleaning' WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE service_id = 9 AND sub_service_name = 'Bike Cleaning');


-------------- delete script
begin;
rollback

delete from home_service where sub_module_id between 1 and 24;

delete from master_sub_group where sub_service_id in 
(select id from master_sub_service where service_id in 
(select id from master_service where sub_module_id in 
(select id from master_sub_module where id between 1 and 49)));

delete from master_sub_service where service_id in 
(select id from master_service where sub_module_id in
 (select id from master_sub_module where id between 1 and 22));

delete from master_service where sub_module_id in 
(select id from master_sub_module where id between 1 and 89);

delete from master_sub_module where id between 1 and 24;

commit;
-----------------

alter table home_service add column others_address varchar(255);
alter table home_service drop column sub_group_id;
-------13/1/2026
alter table home_service alter column sub_service_id type bigint using sub_service_id::bigint;
alter table home_service alter column module_id type bigint using module_id::bigint;
alter table home_service alter column sub_module_id type bigint using sub_module_id::bigint;

------14/1/2026 lavanya
alter table home_service add column work_status_id int; 
alter table home_service add constraint fk_home_service_work_status_id foreign key(work_status_id) references master_work_status(id); 
alter table home_service add column latitude numeric(9,6) ; 
alter table home_service add column longitude numeric(9,6);
alter table user_registration add column latitude numeric(9,6) ;
alter table user_registration add column longitude numeric(9,6);
alter table freelancer_task_history add column latitude numeric(9,6); 
alter table freelancer_task_history add column longitude numeric(9,6);
---------------
16-jan-2026
create drop table if  exists job_openings (
id bigserial,
job_id bigint not null,
company_name varchar(255) not null,
company_address varchar(255) not null,
location_type_id int not null,
work_type_id int not null,
role_description varchar(500),
requirements varchar(500),
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_job_openings_id primary key (id),
constraint fk_job_openings_job_id foreign key (job_id) references master_job(id),
constraint fk_job_openings_location_type_id foreign key(location_type_id) references master_location_type (id),
constraint fk_job_openings_work_type_id foreign key (work_type_id) references master_work_type (id)
);
alter table job_openings add column sub_module_id bigint;
------------------------	

create table if not exists job_skill(
id bigserial,
job_openings_id bigint not null,
skill_id bigint not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_job_skill_id primary key (id),
constraint fk_job_skill_job_openings_id foreign key (job_openings_id) references job_openings (id),
constraint fk_job_skill_skill_id foreign key (skill_id) references master_skill (id)
);


----------------------
	create table if not exists job_application (
	id bigserial,
	user_id bigint not null,
	job_openings_id bigint not null,
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	mobile_number varchar(255) not null,
	mobile_code_id bigint not null,
	email varchar(150) not null,
	city_id bigint not null,
	upload_resume  varchar(500) not null,
	title varchar(255),
	company varchar(255),
	from_date date,
	to_date date,
	company_city_id bigint,
	description  varchar(255),
	current_ctc numeric(10,2),
	expected_ctc numeric(10,2),
	fresher boolean default false,
	experienced boolean default false,
	notice_period_in_days int not null,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
	constraint pk_job_application_id primary key (id),
	constraint fk_job_application_user_id foreign key (user_id) references user_registration (id),
	constraint fk_job_application_job_openings_id foreign key (job_openings_id) references job_openings (id),
	constraint fk_job_application_mobile_code_id foreign key (mobile_code_id) references master_mobile_code (id),
	constraint fk_job_application_city_id foreign key (city_id) references master_city (id),
	constraint fk_job_application_company_city_id foreign key (company_city_id) references master_city (id),
	constraint ck_job_application_fresher_experienced 	check ((fresher = true and experienced = false and company is null and from_date is null and to_date is null and company_city_id is null and current_ctc is null) 
	or (fresher = false and experienced = true and company is not null and from_date is not null and to_date is not null and company_city_id is not null and current_ctc is not null)
	)
	

);

-------16/1/2026 lavanya
create table if not exists public.master_job(
id bigserial not null,
job_name varchar(255),
is_active boolean default true,
constraint pk_master_job_id primary key (id),
constraint uk_master_job_job_name unique (job_name)
); 

INSERT INTO master_job (job_name) SELECT 'Backend Developer' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Backend Developer');
INSERT INTO master_job (job_name) SELECT 'Business Analyst' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Business Analyst');
INSERT INTO master_job (job_name) SELECT 'Cloud Architect' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Cloud Architect');
INSERT INTO master_job (job_name) SELECT 'Data Analyst' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Data Analyst');
INSERT INTO master_job (job_name) SELECT 'Database Administrator' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Database Administrator');
INSERT INTO master_job (job_name) SELECT 'DevOps Engineer' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'DevOps Engineer');
INSERT INTO master_job (job_name) SELECT 'Frontend Developer' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Frontend Developer');
INSERT INTO master_job (job_name) SELECT 'Mobile App Developer' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Mobile App Developer');
INSERT INTO master_job (job_name) SELECT 'QA Engineer' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'QA Engineer');
INSERT INTO master_job (job_name) SELECT 'Software Engineer' WHERE NOT EXISTS (SELECT 1 FROM master_job WHERE job_name = 'Software Engineer');

------
create table if not exists public.master_location_type(
id serial not null,
location_type varchar(255),
is_active boolean default true,
constraint pk_master_location_type_id primary key (id),
constraint uk_master_location_type_location_type unique (location_type)

); 

INSERT INTO master_location_type (location_type) SELECT 'Client Location' WHERE NOT EXISTS (SELECT 1 FROM master_location_type WHERE location_type = 'Client Location');
INSERT INTO master_location_type (location_type) SELECT 'Hybrid' WHERE NOT EXISTS (SELECT 1 FROM master_location_type WHERE location_type = 'Hybrid');
INSERT INTO master_location_type (location_type) SELECT 'Onsite' WHERE NOT EXISTS (SELECT 1 FROM master_location_type WHERE location_type = 'Onsite');
INSERT INTO master_location_type (location_type) SELECT 'Remote' WHERE NOT EXISTS (SELECT 1 FROM master_location_type WHERE location_type = 'Remote');
INSERT INTO master_location_type (location_type) SELECT 'Work From Home' WHERE NOT EXISTS (SELECT 1 FROM master_location_type WHERE location_type = 'Work From Home');

------
create table if not exists public.master_work_type(
id serial not null,
work_type varchar(255),
is_active boolean default true,
constraint pk_master_work_type_id primary key (id),
constraint uk_master_work_type_work_type unique (work_type)
); 

INSERT INTO master_work_type (work_type) SELECT 'Contract' WHERE NOT EXISTS (SELECT 1 FROM master_work_type WHERE work_type = 'Contract');
INSERT INTO master_work_type (work_type) SELECT 'Freelance' WHERE NOT EXISTS (SELECT 1 FROM master_work_type WHERE work_type = 'Freelance');
INSERT INTO master_work_type (work_type) SELECT 'Full Time' WHERE NOT EXISTS (SELECT 1 FROM master_work_type WHERE work_type = 'Full Time');
INSERT INTO master_work_type (work_type) SELECT 'Internship' WHERE NOT EXISTS (SELECT 1 FROM master_work_type WHERE work_type = 'Internship');
INSERT INTO master_work_type (work_type) SELECT 'Part Time' WHERE NOT EXISTS (SELECT 1 FROM master_work_type WHERE work_type = 'Part Time');
INSERT INTO master_work_type (work_type) SELECT 'Temporary' WHERE NOT EXISTS (SELECT 1 FROM master_work_type WHERE work_type = 'Temporary');

---
create table if not exists public.master_job_skill(
id bigserial not null,
skill varchar(255),
is_active boolean default true,
constraint pk_master_job_skill_id primary key (id),
constraint uk_master_job_skill_skill unique (skill)
); 

INSERT INTO master_job_skill (skill) SELECT 'AWS' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'AWS');
INSERT INTO master_job_skill (skill) SELECT 'CSS' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'CSS');
INSERT INTO master_job_skill (skill) SELECT 'Docker' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'Docker');
INSERT INTO master_job_skill (skill) SELECT 'Git' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'Git');
INSERT INTO master_job_skill (skill) SELECT 'HTML' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'HTML');
INSERT INTO master_job_skill (skill) SELECT 'Java' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'Java');
INSERT INTO master_job_skill (skill) SELECT 'JavaScript' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'JavaScript');
INSERT INTO master_job_skill (skill) SELECT 'Linux' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'Linux');
INSERT INTO master_job_skill (skill) SELECT 'MongoDB' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'MongoDB');
INSERT INTO master_job_skill (skill) SELECT 'MySQL' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'MySQL');
INSERT INTO master_job_skill (skill) SELECT 'PostgreSQL' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'PostgreSQL');
INSERT INTO master_job_skill (skill) SELECT 'Python' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'Python');
INSERT INTO master_job_skill (skill) SELECT 'React' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'React');
INSERT INTO master_job_skill (skill) SELECT 'SQL' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'SQL');
INSERT INTO master_job_skill (skill) SELECT 'Terraform' WHERE NOT EXISTS (SELECT 1 FROM master_job_skill WHERE skill = 'Terraform');

---
create table if not exists public.master_mobile_code(
id bigserial not null,
mobile_code varchar(255),
is_active boolean default true,
constraint pk_master_mobile_code_id primary key (id),
constraint uk_master_mobile_code_mobile_code unique (mobile_code)
); 

INSERT INTO master_mobile_code (mobile_code) SELECT '+1' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+1');
INSERT INTO master_mobile_code (mobile_code) SELECT '+44' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+44');
INSERT INTO master_mobile_code (mobile_code) SELECT '+91' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+91');
INSERT INTO master_mobile_code (mobile_code) SELECT '+61' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+61');
INSERT INTO master_mobile_code (mobile_code) SELECT '+81' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+81');
INSERT INTO master_mobile_code (mobile_code) SELECT '+49' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+49');
INSERT INTO master_mobile_code (mobile_code) SELECT '+33' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+33');
INSERT INTO master_mobile_code (mobile_code) SELECT '+86' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+86');
INSERT INTO master_mobile_code (mobile_code) SELECT '+971' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+971');
INSERT INTO master_mobile_code (mobile_code) SELECT '+65' WHERE NOT EXISTS (SELECT 1 FROM master_mobile_code WHERE mobile_code = '+65');

---

create table if not exists public.master_city(
id bigserial not null,
city varchar(255),
is_active boolean default true,
constraint pk_master_city_id primary key (id),
constraint uk_master_city_city unique (city)
); 
INSERT INTO master_city (city) SELECT 'Ahmedabad' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Ahmedabad');
INSERT INTO master_city (city) SELECT 'Bengaluru' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Bengaluru');
INSERT INTO master_city (city) SELECT 'Berlin' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Berlin');
INSERT INTO master_city (city) SELECT 'Chennai' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Chennai');
INSERT INTO master_city (city) SELECT 'Delhi' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Delhi');
INSERT INTO master_city (city) SELECT 'Dubai' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Dubai');
INSERT INTO master_city (city) SELECT 'Hyderabad' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Hyderabad');
INSERT INTO master_city (city) SELECT 'Jaipur' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Jaipur');
INSERT INTO master_city (city) SELECT 'Kolkata' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Kolkata');
INSERT INTO master_city (city) SELECT 'London' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'London');
INSERT INTO master_city (city) SELECT 'Los Angeles' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Los Angeles');
INSERT INTO master_city (city) SELECT 'Mumbai' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Mumbai');
INSERT INTO master_city (city) SELECT 'New York' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'New York');
INSERT INTO master_city (city) SELECT 'Paris' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Paris');
INSERT INTO master_city (city) SELECT 'Pune' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Pune');
INSERT INTO master_city (city) SELECT 'San Francisco' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'San Francisco');
INSERT INTO master_city (city) SELECT 'Singapore' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Singapore');
INSERT INTO master_city (city) SELECT 'Sydney' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Sydney');
INSERT INTO master_city (city) SELECT 'Toronto' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Toronto');
INSERT INTO master_city (city) SELECT 'Zurich' WHERE NOT EXISTS (SELECT 1 FROM master_city WHERE city = 'Zurich');

---

INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Students', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Students' AND module_id = 5 );
 
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Internship/projects', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Internship/projects' AND module_id = 5 );
 
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Companies', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Companies' AND module_id = 5 );
 
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Training', 5 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Training' AND module_id = 5 );
 
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Buy', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Buy' AND module_id = 3 );
 
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Sale', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Sale' AND module_id = 3 );
 
INSERT INTO public.master_sub_module (sub_module_name, module_id)
 SELECT 'Rent', 3 WHERE NOT EXISTS ( SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Rent' AND module_id = 3 );
 
------------------------------------ dhanusha 17/01/2026
create table if not exists public.master_property_type (
    id serial not null,
    property_type varchar(255),
    is_active boolean default true,
    constraint pk_master_property_type_id primary key (id),
	constraint uk_master_property_type_property_type unique(property_type)
);
insert into master_property_type (property_type)select 'Land' where not exists (select 1 from master_property_type where property_type = 'Land');
insert into master_property_type (property_type)select 'Apartment/Flat' where not exists (select 1 from master_property_type where property_type = 'Apartment / Flat');
insert into master_property_type (property_type)select 'Independent House/Villa' where not exists (select 1 from master_property_type where property_type = 'Independent House / Villa');

---------------
create table if not exists public.master_land_type (
    id serial not null,
    land_type varchar(255),
    is_active boolean default true,
    constraint pk_master_land_type_id primary key (id),
	constraint uk_master_land_type_land_type unique(land_type)
);

insert into master_land_type (land_type)select 'Residential' where not exists (select 1 from master_land_type where land_type = 'Residential');
insert into master_land_type (land_type)select 'Commercial' where not exists (select 1 from master_land_type where land_type = 'Commercial');
insert into master_land_type (land_type)select 'Agricultural' where not exists (select 1 from master_land_type where land_type = 'Agricultural');
insert into master_land_type (land_type)select 'Industrial' where not exists (select 1 from master_land_type where land_type = 'Industrial');
insert into master_land_type (land_type)select 'Open Plot' where not exists (select 1 from master_land_type where land_type = 'Open Plot');

------------

create table if not exists public.master_boundary_type (
    id serial not null,
    boundary_type varchar(255),
    is_active boolean default true,
    constraint pk_master_boundary_type_id primary key (id),
	constraint uk_master_boundary_type_boundary_type unique(boundary_type)
);

insert into master_boundary_type (boundary_type)select 'Open' where not exists (select 1 from master_boundary_type where boundary_type = 'Open');
insert into master_boundary_type (boundary_type)select 'Fenced' where not exists (select 1 from master_boundary_type where boundary_type = 'Fenced');
insert into master_boundary_type (boundary_type)select 'Compound Wall' where not exists (select 1 from master_boundary_type where boundary_type = 'Compound Wall');


------------------

create table if not exists public.master_facing (
    id serial not null,
    facing varchar(100),
    is_active boolean default true,
    constraint pk_master_facing_id primary key (id),
	constraint uk_master_facing_facing unique(facing)
);

insert into master_facing (facing)select 'East' where not exists (select 1 from master_facing where facing = 'East');
insert into master_facing (facing)select 'West' where not exists (select 1 from master_facing where facing = 'West');
insert into master_facing (facing)select 'North'where not exists (select 1 from master_facing where facing = 'North');
insert into master_facing (facing)select 'South' where not exists (select 1 from master_facing where facing = 'South');

------------------------------
create table if not exists public.master_approval_type (
    id serial not null,
    approval_type varchar(255),
    is_active boolean default true,
    constraint pk_master_approval_type_id primary key (id),
	constraint uk_master_approval_type_approval_type unique(approval_type)
);

insert into master_approval_type(approval_type) select 'DTCP' where not exists (select 1 from master_approval_type where approval_type='DTCP');
insert into master_approval_type(approval_type) select 'HMDA' where not exists (select 1 from master_approval_type where approval_type='HMDA');
insert into master_approval_type(approval_type) select 'Panchayat' where not exists (select 1 from master_approval_type where approval_type='Panchayat');
insert into master_approval_type(approval_type) select 'Unapproved' where not exists (select 1 from master_approval_type where approval_type='Unapproved');

---------------------------
create table if not exists public.master_ownership_type (
    id serial not null,
    ownership_type varchar(255),
    is_active boolean default true,
    constraint pk_master_ownership_type_id primary key (id),
	constraint uk_master_ownership_type_ownership_type unique(ownership_type)
);

insert into master_ownership_type(ownership_type) select 'Single' where not exists (select 1 from master_ownership_type where ownership_type='Single');
insert into master_ownership_type(ownership_type) select 'Joint' where not exists (select 1 from master_ownership_type where ownership_type='Joint');

=--------------------

create table if not exists public.master_parking (
    id serial not null,
    parking_type varchar(100),
    is_active boolean default true,
    constraint pk_master_parking_type_id primary key (id),
	constraint uk_master_parking_type_parking_type unique(parking_type)
);

insert into master_parking(parking_type) select 'Bike' where not exists (select 1 from master_parking where parking_type='Bike');
insert into master_parking(parking_type) select 'Car' where not exists (select 1 from master_parking where parking_type='Car');
insert into master_parking(parking_type) select 'Both' where not exists (select 1 from master_parking where parking_type='Both');
insert into master_parking(parking_type) select 'None' where not exists (select 1 from master_parking where parking_type='None');

-----------------------------
create table if not exists public.master_availability_status (
    id serial not null,
    availability_status varchar(255),
    is_active boolean default true,
    constraint pk_master_availability_status_id primary key (id),
	constraint uk_master_availability_status_availability_status unique(availability_status)
);

insert into master_availability_status(availability_status) select 'Ready to Move' where not exists (select 1 from master_availability_status where availability_status='Ready to Move');
insert into master_availability_status(availability_status) select 'Under Construction' where not exists (select 1 from master_availability_status where availability_status='Under Construction');

-------------------------------

create table if not exists public.master_preferred_tenants (
    id serial not null,
    tenant_type varchar(255),
    is_active boolean default true,
    constraint pk_master_preferred_tenants_id primary key (id),
	constraint uk_master_preferred_tenants_tenant_type unique(tenant_type)
);

insert into master_preferred_tenants(tenant_type) select 'Family' where not exists (select 1 from master_preferred_tenants where tenant_type='Family');
insert into master_preferred_tenants(tenant_type) select 'Bachelors' where not exists (select 1 from master_preferred_tenants where tenant_type='Bachelors');
insert into master_preferred_tenants(tenant_type) select 'Company' where not exists (select 1 from master_preferred_tenants where tenant_type='Company');

----------------------------

create table if not exists public.master_lease_type (
    id serial not null,
    lease_type varchar(100),
    is_active boolean default true,
    constraint pk_master_lease_type_id primary key (id),
	constraint uk_master_lease_type_lease_type unique(lease_type)
);

insert into master_lease_type(lease_type) select 'Rent' where not exists (select 1 from master_lease_type where lease_type='Rent');
insert into master_lease_type(lease_type) select 'Lease' where not exists (select 1 from master_lease_type where lease_type='Lease');

------------------------
create table if not exists public.master_posted_by (
    id serial not null,
    posted_by varchar(100),
    is_active boolean default true,
    constraint pk_master_posted_by_id primary key (id),
	constraint uk_master_posted_by_posted_by unique(posted_by)
);

insert into master_posted_by(posted_by) select 'Owner' where not exists (select 1 from master_posted_by where posted_by='Owner');
insert into master_posted_by(posted_by) select 'Agent' where not exists (select 1 from master_posted_by where posted_by='Agent');



create table if not exists public.master_bhk_type (
    id bigserial not null,
    bhk_type varchar(10),
    is_active boolean default true,
    constraint pk_master_bhk_type_id primary key (id),
	constraint uk_master_bhk_type unique(bhk_type)
);

insert into master_bhk_type(bhk_type) select '1 BHK' where not exists (select 1 from master_bhk_type where bhk_type='1 BHK');
insert into master_bhk_type(bhk_type) select '2 BHK' where not exists (select 1 from master_bhk_type where bhk_type='2 BHK');
insert into master_bhk_type(bhk_type) select '3 BHK' where not exists (select 1 from master_bhk_type where bhk_type='3 BHK');
insert into master_bhk_type(bhk_type) select '4 BHK' where not exists (select 1 from master_bhk_type where bhk_type='4 BHK');


------------------
create table if not exists public.master_furnishing(
id serial not null,
furnisher_type varchar(255),
is_active boolean default true,
constraint pk_master_furnishing_id primary key (id),
constraint uk_master_furnishig_furnisher_type unique(furnisher_type)

); 

INSERT INTO public.master_furnishing (furnisher_type)SELECT 'Fully Furnished'WHERE NOT EXISTS (SELECT 1 FROM public.master_furnishing WHERE furnisher_type = 'Fully Furnished');
INSERT INTO public.master_furnishing (furnisher_type)SELECT 'Semi Furnished'WHERE NOT EXISTS (SELECT 1 FROM public.master_furnishing WHERE furnisher_type = 'Semi Furnished');
INSERT INTO public.master_furnishing (furnisher_type)SELECT 'Unfurnished'WHERE NOT EXISTS (SELECT 1 FROM public.master_furnishing WHERE furnisher_type = 'Unfurnished');

------------17/1/2026 lavanya
create table if not exists property_sell_listing (
id bigserial not null,
module_id bigint not null,
sub_module_id bigint not null,
property_type_id int,
land_type_id int,
plot_area numeric(10,2),
length_breadth varchar(255),
facing_id int,
road_width numeric(10,2),
boundary_type_id int,
water_availability boolean,
electricity_connection boolean,
approval_type_id int,
ownership_type_id int,
expected_price numeric(10,2),
negotiable boolean,
road_access varchar(255),
suitable_for varchar(255),
warehouse varchar(255),
monthly_rent numeric(10,2),
lease_duration varchar(255),
security_deposit numeric(10,2),
available_from date,
bhk_type_id int not null,
built_up_area numeric(10,2),
carpet_area numeric(10,2),
floor_number int,
total_floors int,
property_age int,
furnishing_id int not null,
preferred_tenants_id int,
parking_id int not null,
bathrooms int,
maintenance_charges numeric(10,2),
balconies int,
lease_type_id int,
availability_status_id int ,
state_id bigint,
city_id bigint not null,
locality_area varchar(255) not null,
landmark varchar(255) not null,
pincode int not null,
upload_photos varchar(500) not null,
upload_videos varchar(500),
property_description varchar(255),
owner_name varchar(255) not null,
mobile_number varchar(255) not null,
email varchar(255) ,
best_time_to_call varchar(255),
posted_by_id int,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_property_sell_listing primary key (id),
constraint fk_property_sell_listing_module_id foreign key (module_id) references master_module(id),
constraint fk_property_sell_listing_sub_module_id foreign key (sub_module_id) references master_sub_module(id),
constraint fk_property_sell_listing_property_type_id foreign key (property_type_id) references master_property_type(id),
constraint fk_property_sell_listing_land_type_id foreign key (land_type_id) references master_land_type(id),
constraint fk_property_sell_listing_facing_id foreign key (facing_id) references master_facing(id),
constraint fk_property_sell_listing_boundary_type_id foreign key (boundary_type_id) references master_boundary_type(id),
constraint fk_property_sell_listing_approval_type_id foreign key (approval_type_id) references master_approval_type(id),
constraint fk_property_sell_listing_ownership_type_id foreign key (ownership_type_id) references master_ownership_type(id),
constraint fk_property_sell_listing_bhk_type_id foreign key (bhk_type_id) references master_bhk_type(id),
constraint fk_property_sell_listing_furnishing_id foreign key (furnishing_id) references master_furnishing(id),
constraint fk_property_sell_listing_preferred_tenants_id foreign key (preferred_tenants_id) references master_preferred_tenants(id),
constraint fk_property_sell_listing_parking_id foreign key (parking_id) references master_parking(id),
constraint fk_property_sell_listing_lease_type_id foreign key (lease_type_id) references master_lease_type(id),
constraint fk_property_sell_listing_availability_status_id foreign key (availability_status_id) references master_availability_status(id),
constraint fk_property_sell_listing_state_id foreign key (state_id) references master_state(id),
constraint fk_property_sell_listing_city_id foreign key (city_id) references master_city(id),
constraint fk_property_sell_listing_posted_by_id foreign key (posted_by_id) references master_posted_by(id),
constraint fk_property_sell_listing_created_by foreign key (created_by) references user_registration (id),
constraint fk_property_sell_listing_modified_by foreign key (modified_by) references user_registration (id)

);

---------------
create table if not exists property_listing (
id bigserial not null,
property_sell_listing_id bigint not null,
user_id bigint not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_property_listing_id primary key(id),
constraint fk_property_listing_property_sell_listing_id foreign key (property_sell_listing_id) references property_sell_listing(id),
constraint fk_property_listing_user_id foreign key (user_id) references user_registration(id),
constraint fk_property_listing_created_by foreign key (created_by) references user_registration (id),
constraint fk_property_listing_modified_by foreign key (modified_by) references user_registration (id)
);

----

update master_sub_module set sub_module_name = 'sell' where id =8;

---------------- 19/1/2026 dhanusha
create table if not exists master_task_type(
id serial not null,
task_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_task_type_id primary key(id),
constraint uk_master_task_type unique(task_type));

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
user_id bigint not null,
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
constraint fk_tasks_user_id foreign key (user_id) references user_registration (id),
constraint fk_tasks_status_id foreign key (status_id) references master_status (id),
constraint uk_tasks_title_task_type_id_project_id_user_id_status_id unique (title,task_type_id,project_id,user_id,status_id)
);

select * from tasks;

create table if not exists task_history( 
id bigserial not null,
task_id bigint not null,
user_id bigint not  null,
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
constraint fk_task_history_user_id foreign key (user_id) references user_registration (id),
constraint ck_task_history_rating check (rating between 1 and 5),
constraint fk_task_history_reporting_manager_id foreign key (reporting_manager_id) references user_registration(id),
constraint fk_task_history_from_assignee_id foreign key (from_assignee_id) references user_registration(id),
constraint fk_task_history_to_assignee_id foreign key (to_assignee_id) references user_registration(id)
);


-----------------------------

swachify_productmodule
----------
create table if not exists public.master_business_type (
    id bigserial not null,
    business_type varchar(255),
    is_active boolean default true,
    constraint pk_master_business_type_id primary key (id)
);

insert into master_business_type(business_type) select 'Shop owners and Entrepreneurs' where not exists (select 1 from master_business_type where business_type='Shop owners and Entrepreneurs');
insert into master_business_type(business_type) select 'Farmers' where not exists (select 1 from master_business_type where business_type='Farmers');
insert into master_business_type(business_type) select 'Chefs' where not exists (select 1 from master_business_type where business_type='Chefs');
insert into master_business_type(business_type) select 'Plumbers' where not exists (select 1 from master_business_type where business_type='Plumbers');
insert into master_business_type(business_type) select 'Mechanics' where not exists (select 1 from master_business_type where business_type='Mechanics');
insert into master_business_type(business_type) select 'Beauticians' where not exists (select 1 from master_business_type where business_type='Beauticians');
--


--------------- raw matrials.
create table if not exists raw_material_details(
id bigserial not null,
module_id bigint not null,
raw_material_type_id bigint not null,
quantity int not null,
cost numeric(10,2) not null,
latitude numeric(9,6) not null,
longitude numeric(9,6) not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_raw_material_details_id primary key (id),
constraint fk_raw_material_details_raw_module_id foreign key (module_id) references master_module(id),
constraint fk_raw_material_details_raw_sub_module_id foreign key (sub_module_id) references master_sub_module(id),
constraint fk_raw_material_details_raw_material_type_id foreign key (raw_material_type_id) references master_raw_material_type(id)
);


create table if not exists public.master_raw_material_type (
    id bigserial not null,
    raw_material_type varchar(255),
    is_active boolean default true,
    constraint pk_master_raw_material_type primary key (id)
);

insert into master_raw_material_type(raw_material_type) select 'Steel' where not exists (select 1 from master_raw_material_type where raw_material_type='Steel');
insert into master_raw_material_type(raw_material_type) select 'Cement' where not exists (select 1 from master_raw_material_type where raw_material_type='Cement');
insert into master_raw_material_type(raw_material_type) select 'Wood' where not exists (select 1 from master_raw_material_type where raw_material_type='Wood');
insert into master_raw_material_type(raw_material_type) select 'Plastic' where not exists (select 1 from master_raw_material_type where raw_material_type='Plastic');
insert into master_raw_material_type(raw_material_type) select 'Aluminium' where not exists (select 1 from master_raw_material_type where raw_material_type='Aluminium');
insert into master_raw_material_type(raw_material_type) select 'Copper' where not exists (select 1 from master_raw_material_type where raw_material_type='Copper');

-------19/1/2026 lavanya
alter table if exists user_registration add column if not exists business_type_id int;
alter table if exists user_registration add constraint fk_user_registration_business_type_id foreign key(business_type_id) references master_business_type(id);
alter table if exists user_registration add column if not exists product_name varchar(255);
alter table if exists user_registration add column if not exists business_description varchar(255);
alter table if exists user_registration add column if not exists org_name varchar(255);
alter table if exists user_registration add column if not exists gst_number varchar(100);
alter table if exists user_registration add column if not exists job_skill_id int;
alter table if exists user_registration add constraint fk_user_registration_job_skill_id foreign key(job_skill_id) references master_job_skill(id);


CREATE TABLE IF NOT EXISTS public.master_designation
(
id bigserial NOT NULL ,
designation_name NOT NULL,
is_active boolean DEFAULT true,
dept_id integer,
CONSTRAINT pk_master_designation_id PRIMARY KEY (id),
CONSTRAINT uk_master_designation_designation_name_dept_id UNIQUE (designation_name, dept_id),
CONSTRAINT fk_master_designation_dept_id FOREIGN KEY (dept_id)
REFERENCES public.master_department (id)
);

INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Operations Manager',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Operations Manager' AND dept_id=1);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Business Analyst',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Business Analyst' AND dept_id=1);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Content Manager',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Content Manager' AND dept_id=2);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Digital Marketing Executive',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Digital Marketing Executive' AND dept_id=2);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'HR Executive',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='HR Executive' AND dept_id=3);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Talent Acquisition Specialist',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Talent Acquisition Specialist' AND dept_id=3);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Legal Officer',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Legal Officer' AND dept_id=4);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Compliance Manager',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Compliance Manager' AND dept_id=4);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Procurement Executive',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Procurement Executive' AND dept_id=5);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Logistics Coordinator',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Logistics Coordinator' AND dept_id=5);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Project Manager',6 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Project Manager' AND dept_id=6);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Strategy Analyst',6 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Strategy Analyst' AND dept_id=6);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Technology Lead',7 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Technology Lead' AND dept_id=7);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'IT Support Engineer',8 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='IT Support Engineer' AND dept_id=8);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Software Engineer',9 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Software Engineer' AND dept_id=9);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'DevOps Engineer',10 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='DevOps Engineer' AND dept_id=10);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'QA Engineer',11 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='QA Engineer' AND dept_id=11);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Security Analyst',12 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Security Analyst' AND dept_id=12);
INSERT INTO public.master_designation (designation_name, dept_id) SELECT 'Data Analyst',13 WHERE NOT EXISTS (SELECT 1 FROM public.master_designation WHERE designation_name='Data Analyst' AND dept_id=13);
---------------
CREATE TABLE IF NOT EXISTS master_department
(
id bigserial NOT NULL ,
department character varying(255) NOT NULL,
is_active boolean DEFAULT true,
CONSTRAINT pk_master_department_id PRIMARY KEY (id),
CONSTRAINT uk_master_department_department UNIQUE (department)
);

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

-----------21/1/2026 lavanya
create table if not exists public.master_aggregate(
id serial not null,
aggregate varchar(255),
is_active boolean default true,
constraint pk_master_aggregate_id primary key (id)); 

INSERT INTO public.master_aggregate (aggregate) SELECT 'All' WHERE NOT EXISTS (SELECT 1 FROM public.master_aggregate WHERE aggregate='All'); 
INSERT INTO public.master_aggregate (aggregate) SELECT '90%+' WHERE NOT EXISTS (SELECT 1 FROM public.master_aggregate WHERE aggregate='90%+'); 
INSERT INTO public.master_aggregate (aggregate) SELECT '80-90%' WHERE NOT EXISTS (SELECT 1 FROM public.master_aggregate WHERE aggregate='80-90%');
INSERT INTO public.master_aggregate (aggregate) SELECT '60-80%' WHERE NOT EXISTS (SELECT 1 FROM public.master_aggregate WHERE aggregate='60-80%');

create table if not exists public.master_internship_status(
id serial not null,
internship_status varchar(255),
is_active boolean default true,
constraint pk_master_internship_status_id primary key (id)); 

INSERT INTO public.master_internship_status (internship_status) SELECT 'All' WHERE NOT EXISTS (SELECT 1 FROM public.master_internship_status WHERE internship_status='All'); 
INSERT INTO public.master_internship_status (internship_status) SELECT 'Completed' WHERE NOT EXISTS (SELECT 1 FROM public.master_internship_status WHERE internship_status='Completed'); 
INSERT INTO public.master_internship_status (internship_status) SELECT 'In Progress' WHERE NOT EXISTS (SELECT 1 FROM public.master_internship_status WHERE internship_status='In Progress');


create table student_attendance (
    id bigserial not null,
    user_id bigint,
    attendance_percentage numeric(5,2),
    is_active boolean default true,
	constraint pk_student_attendance_id primary key (id),
	constraint fk_student_attendance_user_id foreign key (user_id) references user_registration(id)
);
-----------22/1/2026
INSERT INTO public.master_role (role_name) SELECT 'Doctor' WHERE NOT EXISTS (SELECT 1 FROM master_role WHERE role_name = 'Doctor');
INSERT INTO public.master_module (module_name) SELECT 'Health Care' WHERE NOT EXISTS (SELECT 1 FROM master_module WHERE module_name = 'Health Care');
------------

create table if not exists public.master_internship_duration
(
    id bigserial not null,
    duration_type varchar(100) not null,
    is_active boolean default true,
	constraint pk_master_internship_duration_id primary key (id),
    constraint uk_master_internship_duration_duration_type unique (duration_type)
);
INSERT INTO public.master_internship_duration (duration_type) SELECT '1 month' WHERE NOT EXISTS (SELECT 1 FROM public.master_internship_duration WHERE duration_type = '1 month');
INSERT INTO public.master_internship_duration (duration_type) SELECT '3 Months' WHERE NOT EXISTS (SELECT 1 FROM public.master_internship_duration WHERE duration_type = '3 Months');
INSERT INTO public.master_internship_duration (duration_type) SELECT '6 Months' WHERE NOT EXISTS (SELECT 1 FROM public.master_internship_duration WHERE duration_type = '6 Months');

CREATE TABLE IF NOT EXISTS public.master_category
(
    id bigserial not null,
    category_name VARCHAR(100) not null,
	is_active boolean default true,
	constraint pk_master_master_category_id primary key (id),
    constraint uk_master_master_category_category_name unique (category_name)
);

INSERT INTO public.master_category (category_name) SELECT 'Design' WHERE NOT EXISTS (SELECT 1 FROM public.master_category WHERE category_name = 'Design');
INSERT INTO public.master_category (category_name) SELECT 'Engineering' WHERE NOT EXISTS (SELECT 1 FROM public.master_category WHERE category_name = 'Engineering');
INSERT INTO public.master_category (category_name) SELECT 'Marketing' WHERE NOT EXISTS (SELECT 1 FROM public.master_category WHERE category_name = 'Marketing');

alter table public.job_openings add column category_id bigint, add column internship_duration_id bigint;

alter table public.job_openings add constraint fk_job_openings_category_id foreign key (category_id) references public.master_category(id);
alter table public.job_openings add constraint fk_job_openings_duration foreign key (internship_duration_id) references public.master_internship_duration(id);
------------------
create table if not exists master_stipend_type(
    id serial not null,
    stipend_type varchar(50) not null,  
    is_active boolean default true,
    constraint pk_master_stipend_type_id primary key (id),
    constraint uk_master_stipend_type_stipend_type unique (stipend_type)
);

-- Insert values
insert into master_stipend_type (stipend_type) select 'Paid' where not exists (select 1 from master_stipend_type where stipend_type = 'Paid');
insert into master_stipend_type (stipend_type) select 'Unpaid' where not exists (select 1 from master_stipend_type where stipend_type = 'Unpaid');

alter table job_openings add column stipend_type_id int;

alter table job_openings add constraint fk_job_openings_stipend_type_id
foreign key (stipend_type_id) references master_stipend_type(id);
--------
CREATE TABLE IF NOT EXISTS master_health_categories (
    id SERIAL NOT NULL,
    category_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_health_categories_id PRIMARY KEY (id),
    CONSTRAINT uk_master_health_categories_category_name UNIQUE (category_name)
);

INSERT INTO master_health_categories (category_name) SELECT 'Heart' WHERE NOT EXISTS (SELECT 1 FROM master_health_categories WHERE category_name = 'Heart');
INSERT INTO master_health_categories (category_name) SELECT 'Skin' WHERE NOT EXISTS (SELECT 1 FROM master_health_categories WHERE category_name = 'Skin');
INSERT INTO master_health_categories (category_name) SELECT 'Eyes' WHERE NOT EXISTS (SELECT 1 FROM master_health_categories WHERE category_name = 'Eyes');
INSERT INTO master_health_categories (category_name) SELECT 'Mental' WHERE NOT EXISTS (SELECT 1 FROM master_health_categories WHERE category_name = 'Mental');
INSERT INTO master_health_categories (category_name)SELECT 'Diet' WHERE NOT EXISTS (SELECT 1 FROM master_health_categories WHERE category_name = 'Diet');

---------

CREATE TABLE IF NOT EXISTS master_doctor_specialization (
    id SERIAL NOT NULL,
    specialization_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_doctor_specialization_id PRIMARY KEY (id),
    CONSTRAINT uk_master_doctor_specialization_name UNIQUE (specialization_name)
);

INSERT INTO master_doctor_specialization (specialization_name) SELECT 'General Practitioner' WHERE NOT EXISTS (SELECT 1 FROM master_doctor_specialization WHERE specialization_name = 'General Practitioner');
INSERT INTO master_doctor_specialization (specialization_name) SELECT 'Cardiologist' WHERE NOT EXISTS (SELECT 1 FROM master_doctor_specialization WHERE specialization_name = 'Cardiologist');
INSERT INTO master_doctor_specialization (specialization_name) SELECT 'Dermatologist' WHERE NOT EXISTS (SELECT 1 FROM master_doctor_specialization WHERE specialization_name = 'Dermatologist');
INSERT INTO master_doctor_specialization (specialization_name) SELECT 'Psychiatrist' WHERE NOT EXISTS (SELECT 1 FROM master_doctor_specialization WHERE specialization_name = 'Psychiatrist');
INSERT INTO master_doctor_specialization (specialization_name) SELECT 'Ophthalmologist' WHERE NOT EXISTS (SELECT 1 FROM master_doctor_specialization WHERE specialization_name = 'Ophthalmologist');

CREATE TABLE IF NOT EXISTS doctor_profile (
    id BIGSERIAL NOT NULL,
    user_id BIGINT NOT NULL,
    specialization_id BIGINT NOT NULL,
    experience_years INT,
    rating NUMERIC(3,2),
    fees_per_hour NUMERIC(10,2),
    is_active BOOLEAN DEFAULT TRUE,
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT NOW(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_doctor_profile_id PRIMARY KEY (id),
    CONSTRAINT fk_doctor_profile_user_id FOREIGN KEY (user_id) REFERENCES user_registration(id),
    CONSTRAINT fk_doctor_profile_specialization_id FOREIGN KEY (specialization_id) REFERENCES master_doctor_specialization(id),
    CONSTRAINT uk_doctor_profile_user_id UNIQUE (user_id)
);

--------------------- 23/1/2026
CREATE TABLE IF NOT EXISTS public.master_industry
(
    id bigserial NOT NULL,
    industry_name VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    CONSTRAINT pk_master_industry_id PRIMARY KEY (id),
    CONSTRAINT uk_master_industry_name UNIQUE (industry_name)
);

INSERT INTO public.master_industry (industry_name) SELECT 'Artificial Intelligence & Machine Learning' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Artificial Intelligence & Machine Learning');
INSERT INTO public.master_industry (industry_name) SELECT 'Cloud Computing' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Cloud Computing');
INSERT INTO public.master_industry (industry_name) SELECT 'Consulting & Professional Services' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Consulting & Professional Services');
INSERT INTO public.master_industry (industry_name) SELECT 'Cybersecurity' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Cybersecurity');
INSERT INTO public.master_industry (industry_name) SELECT 'E-Commerce' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'E-Commerce');
INSERT INTO public.master_industry (industry_name) SELECT 'EdTech' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'EdTech');
INSERT INTO public.master_industry (industry_name) SELECT 'Energy & Utilities' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Energy & Utilities');
INSERT INTO public.master_industry (industry_name) SELECT 'Finance & Banking' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Finance & Banking');
INSERT INTO public.master_industry (industry_name) SELECT 'Healthcare' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Healthcare');
INSERT INTO public.master_industry (industry_name) SELECT 'Logistics & Supply Chain' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Logistics & Supply Chain');
INSERT INTO public.master_industry (industry_name) SELECT 'Manufacturing' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Manufacturing');
INSERT INTO public.master_industry (industry_name) SELECT 'Media & Entertainment' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Media & Entertainment');
INSERT INTO public.master_industry (industry_name) SELECT 'Retail' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Retail');
INSERT INTO public.master_industry (industry_name) SELECT 'Software Engineering' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Software Engineering');
INSERT INTO public.master_industry (industry_name) SELECT 'Telecommunications' WHERE NOT EXISTS (SELECT 1 FROM public.master_industry WHERE industry_name = 'Telecommunications');


CREATE TABLE IF NOT EXISTS public.master_company_size
(
    id bigserial NOT NULL,
    size_range VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    CONSTRAINT pk_master_company_size_id PRIMARY KEY (id),
    CONSTRAINT uk_master_company_size_range UNIQUE (size_range)
);

INSERT INTO public.master_company_size (size_range) SELECT 'All' WHERE NOT EXISTS (SELECT 1 FROM public.master_company_size WHERE size_range = 'All');
INSERT INTO public.master_company_size (size_range) SELECT '50-200' WHERE NOT EXISTS (SELECT 1 FROM public.master_company_size WHERE size_range = '50-200');
INSERT INTO public.master_company_size (size_range) SELECT '200-500' WHERE NOT EXISTS (SELECT 1 FROM public.master_company_size WHERE size_range = '200-500');
INSERT INTO public.master_company_size (size_range) SELECT '500+' WHERE NOT EXISTS (SELECT 1 FROM public.master_company_size WHERE size_range = '500+');
INSERT INTO public.master_company_size (size_range) SELECT '1000+' WHERE NOT EXISTS (SELECT 1 FROM public.master_company_size WHERE size_range = '1000+');

ALTER TABLE public.job_openings ADD COLUMN industry_id BIGINT,ADD COLUMN company_size_id BIGINT;
ALTER TABLE public.job_openings ADD CONSTRAINT fk_job_openings_industry FOREIGN KEY (industry_id) REFERENCES public.master_industry(id);
ALTER TABLE public.job_openings ADD CONSTRAINT fk_job_openings_company_size FOREIGN KEY (company_size_id) REFERENCES public.master_company_size(id);

--------------24/1/2026
INSERT INTO public.master_sub_service (sub_service_name, service_id) SELECT 'Truck Cleaning', 9 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name = 'Truck Cleaning' AND service_id = 9);
------------

insert into master_property_type (property_type)select 'Land' where not exists (select 1 from master_property_type where property_type = 'Land');
insert into master_property_type (property_type)select 'Apartment/Flat' where not exists (select 1 from master_property_type where property_type = 'Apartment / Flat');
insert into master_property_type (property_type)select 'Independent House/Villa' where not exists (select 1 from master_property_type where property_type = 'Independent House / Villa');
insert into master_property_type (property_type)select 'Bike' where not exists (select 1 from master_property_type where property_type = 'Bike');
insert into master_property_type (property_type)select 'Car' where not exists (select 1 from master_property_type where property_type = 'Car');
insert into master_property_type (property_type)select 'Lorry' where not exists (select 1 from master_property_type where property_type = 'Lorry');
insert into master_property_type (property_type)select 'Auto' where not exists (select 1 from master_property_type where property_type = 'Auto');
insert into master_property_type (property_type)select 'Bus' where not exists (select 1 from master_property_type where property_type = 'Bus');
insert into master_property_type (property_type)select 'Office' where not exists (select 1 from master_property_type where property_type = 'Office');
insert into master_property_type (property_type)select 'Hospital' where not exists (select 1 from master_property_type where property_type = 'Hospital');
insert into master_property_type (property_type)select 'Commercial Space' where not exists (select 1 from master_property_type where property_type = 'Commercial Space');
insert into master_property_type (property_type)select 'All' where not exists (select 1 from master_property_type where property_type = 'All');
insert into master_property_type (property_type)select 'Hostel' where not exists (select 1 from master_property_type where property_type = 'Hostel');

----------------------
CREATE TABLE IF NOT EXISTS public.master_vehicle_brand (
    id BIGSERIAL NOT NULL,
    brand_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_vehicle_brand_id PRIMARY KEY (id),
    CONSTRAINT uk_master_vehicle_brand_name UNIQUE (brand_name)
);

INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Audi' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Audi');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Ashok Leyland' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Ashok Leyland');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Bajaj' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Bajaj');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'BMW' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'BMW');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Eicher' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Eicher');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Ford' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Ford');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Hero' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Hero');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Honda' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Honda');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Hyundai' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Hyundai');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Jeep' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Jeep');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Kia' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Kia');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Mahindra' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Mahindra');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Maruti Suzuki' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Maruti Suzuki');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Mercedes-Benz' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Mercedes-Benz');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Nissan' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Nissan');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Royal Enfield' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Royal Enfield');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Suzuki' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Suzuki');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Tata' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Tata');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Toyota' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Toyota');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'TVS' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'TVS');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Volkswagen' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Volkswagen');
INSERT INTO public.master_vehicle_brand (brand_name) SELECT 'Volvo' WHERE NOT EXISTS (SELECT 1 FROM public.master_vehicle_brand WHERE brand_name = 'Volvo');
----------------------------------
CREATE TABLE IF NOT EXISTS public.master_fuel_type (
    id BIGSERIAL NOT NULL,
    fuel_type_name VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_fuel_type_id PRIMARY KEY (id),
    CONSTRAINT uk_master_fuel_type_name UNIQUE (fuel_type_name),
	
);
----------
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Bio-Diesel' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Bio-Diesel');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'CNG' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'CNG');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Diesel' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Diesel');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Electric' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Electric');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Hybrid' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Hybrid');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Hydrogen' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Hydrogen');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'LNG' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'LNG');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'LPG' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'LPG');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Petrol' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Petrol');
INSERT INTO public.master_fuel_type (fuel_type_name) SELECT 'Plug-in Hybrid (PHEV)' WHERE NOT EXISTS (SELECT 1 FROM public.master_fuel_type WHERE fuel_type_name = 'Plug-in Hybrid (PHEV)');
-----
alter table home_service add column vehicle_brand_id bigint;
alter table home_service add column fuel_type_id bigint;
alter table home_service add constraint fk_home_service_vehicle_brand_id  foreign key(vehicle_brand_id ) references master_vehicle_brand(id);
alter table home_service add constraint fk_home_service_fuel_type_id foreign key(fuel_type_id) references master_fuel_type(id);

CREATE TABLE IF NOT EXISTS public.master_hostel_type (
    id SERIAL NOT NULL,
    hostel_type VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_hostel_type_id PRIMARY KEY (id)
);

INSERT INTO public.master_hostel_type (hostel_type)SELECT 'Boys Hostel'WHERE NOT EXISTS (SELECT 1 FROM public.master_hostel_type WHERE hostel_type = 'Boys Hostel');
INSERT INTO public.master_hostel_type (hostel_type)SELECT 'Girls Hostel'WHERE NOT EXISTS ( SELECT 1 FROM public.master_hostel_type WHERE hostel_type = 'Girls Hostel');
INSERT INTO public.master_hostel_type (hostel_type)SELECT 'Co-Living' WHERE NOT EXISTS (SELECT 1 FROM public.master_hostel_type WHERE hostel_type = 'Co-Living');

CREATE TABLE IF NOT EXISTS public.master_item_condition (
    id SERIAL NOT NULL,
    item_condition VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_item_condition_id PRIMARY KEY (id)
);

INSERT INTO public.master_item_condition (item_condition)SELECT 'New item'WHERE NOT EXISTS (SELECT 1 FROM public.master_item_condition WHERE item_condition = 'New item');
INSERT INTO public.master_item_condition (item_condition)SELECT 'Old item'WHERE NOT EXISTS (SELECT 1 FROM public.master_item_condition WHERE item_condition = 'Old item');

select * from property_sell_listing
alter table property_sell_listing add column item_condition_id int;
alter table property_sell_listing add column hostel_type_id int;
alter table property_sell_listing add column total_rooms int;
alter table property_sell_listing add column available_rooms int;
alter table property_sell_listing add column food_included boolean;
alter table property_sell_listing add column location int;
alter table property_sell_listing add constraint fk_property_sell_listing_item_condition_id foreign key (item_condition_id) references master_item_condition (id);
alter table property_sell_listing add constraint fk_property_sell_listing_hostel_type_id foreign key (hostel_type_id) references master_hostel_type (id);


----------------------------------- vehicle_cleaning 24/12/2026 to 27/12/2026
. master_vehicle_brand

create table if not exists master_vehicle_brand(
    id serial not null,
    brand_name varchar(255) not null,
    is_active boolean default true,
    constraint pk_master_vehicle_brand_id primary key(id),
    constraint uk_master_vehicle_brand_name unique (brand_name)
);

insert into master_vehicle_brand (brand_name)
select 'Audi' where not exists (select 1 from master_vehicle_brand where brand_name='Audi');

insert into master_vehicle_brand (brand_name)
select 'BMW' where not exists (select 1 from master_vehicle_brand where brand_name='BMW');

insert into master_vehicle_brand (brand_name)
select 'Bajaj' where not exists (select 1 from master_vehicle_brand where brand_name='Bajaj');

insert into master_vehicle_brand (brand_name)
select 'Ashok Leyland' where not exists (select 1 from master_vehicle_brand where brand_name='Ashok Leyland');

------------
3. master_fuel_type

create table if not exists master_fuel_type(
    id serial not null,
    fuel_type_name varchar(255) not null,
    is_active boolean default true,
    constraint pk_master_fuel_type_id primary key(id),
    constraint uk_master_fuel_type_name unique (fuel_type_name)
);

insert into master_fuel_type (fuel_type_name)
select 'Petrol' where not exists (select 1 from master_fuel_type where fuel_type_name='Petrol');

insert into master_fuel_type (fuel_type_name)
select 'Diesel' where not exists (select 1 from master_fuel_type where fuel_type_name='Diesel');

insert into master_fuel_type (fuel_type_name)
select 'Electric' where not exists (select 1 from master_fuel_type where fuel_type_name='Electric');

insert into master_fuel_type (fuel_type_name)
select 'CNG' where not exists (select 1 from master_fuel_type where fuel_type_name='CNG');

insert into master_fuel_type (fuel_type_name)
select 'LNG' where not exists (select 1 from master_fuel_type where fuel_type_name='LNG');

----------------------

4. vehicle_brand_fuel (Mapping)

create table if not exists vehicle_brand_fuel(
    id serial not null,
    sub_service_id bigint not null,
    brand_id bigint not null,
    fuel_id bigint not null,
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active boolean default true,
    constraint pk_vehicle_brand_fuel_id primary key(id),
    constraint fk_vehicle_brand_fuel_sub_service_id foreign key (sub_service_id) references master_sub_service(id),
    constraint fk_vehicle_brand_fuel_brand_id foreign key (brand_id) references master_vehicle_brand(id),
    constraint fk_vehicle_brand_fuel_fuel_id foreign key (fuel_id) references master_fuel_type(id),
    constraint uk_vehicle_brand_fuel unique (sub_service_id, brand_id, fuel_id)
);

--------------------------------
create table if not exists master_garage(
    id serial not null,
    garage_name varchar(255) not null,
    address varchar(500) not null,
    rating numeric(2,1),
    sub_service_id bigint not null,   -- Car, Bike, Truck
    is_active boolean default true,
    constraint pk_master_garage_id primary key(id),
    constraint fk_master_garage_sub_service_id foreign key (sub_service_id) references master_sub_service(id),
    constraint uk_master_garage_name_sub_service unique (garage_name, sub_service_id)
);
insert into master_garage (garage_name, address, rating, sub_service_id)
select 'Supreme Car Care','102, Royal Plaza, Rajkot',4.8,10
where not exists (select 1 from master_garage where garage_name='Supreme Car Care' and sub_service_id=10);

insert into master_garage (garage_name, address, rating, sub_service_id)
select 'Apex Auto Garage','Plot 45, GIDC Phase 3, Rajkot',4.9,10
where not exists (select 1 from master_garage where garage_name='Apex Auto Garage' and sub_service_id=10);

insert into master_garage (garage_name, address, rating, sub_service_id)
select 'Luxury Wheels Rajkot','University Road, Rajkot',4.6,10
where not exists (select 1 from master_garage where garage_name='Luxury Wheels Rajkot' and sub_service_id=10);
--------------
create table if not exists master_garage_service(
    id serial not null,
    sub_service_id bigint not null,         -- Car Cleaning, Bike Cleaning, Truck Cleaning
    service_name varchar(255) not null,     -- e.g. Engine Oil Replacement
    price numeric(10,2) not null,           -- e.g. 1500.00
    is_active boolean default true,
    constraint pk_master_garage_service_id primary key(id),
    constraint fk_master_garage_service_sub_service_id foreign key (sub_service_id) references master_sub_service(id),
    constraint uk_master_garage_service unique (sub_service_id, service_name)
);
insert into master_garage_service (sub_service_id, service_name, price)
select 10,'Engine Oil Replacement',1500 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='Engine Oil Replacement');

insert into master_garage_service (sub_service_id, service_name, price)
select 10,'Oil Filter Change',450 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='Oil Filter Change');

insert into master_garage_service (sub_service_id, service_name, price)
select 10,'AC Filter Cleaning',600 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='AC Filter Cleaning');

insert into master_garage_service (sub_service_id, service_name, price)
select 10,'Brake Pad Checking',600 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='Brake Pad Checking');

insert into master_garage_service (sub_service_id, service_name, price)
select 10,'Coolant Top-up',300 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='Coolant Top-up');

insert into master_garage_service (sub_service_id, service_name, price)
select 10,'Wheel Alignment',1200 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='Wheel Alignment');

insert into master_garage_service (sub_service_id, service_name, price)
select 10,'Interior Vacuuming',500 where not exists (select 1 from master_garage_service where sub_service_id=10 and service_name='Interior Vacuuming');
insert into master_garage_service (sub_service_id, service_name, price)
select 11,'Chain Lubrication',150 where not exists (select 1 from master_garage_service where sub_service_id=11 and service_name='Chain Lubrication');

insert into master_garage_service (sub_service_id, service_name, price)
select 11,'Spark Plug Cleaning',100 where not exists (select 1 from master_garage_service where sub_service_id=11 and service_name='Spark Plug Cleaning');

insert into master_garage_service (sub_service_id, service_name, price)
select 11,'Engine Oil (Bike)',450 where not exists (select 1 from master_garage_service where sub_service_id=11 and service_name='Engine Oil (Bike)');

insert into master_garage_service (sub_service_id, service_name, price)
select 11,'Brake Shoe Adjustment',200 where not exists (select 1 from master_garage_service where sub_service_id=11 and service_name='Brake Shoe Adjustment');

insert into master_garage_service (sub_service_id, service_name, price)
select 11,'Air Filter Cleaning',150 where not exists (select 1 from master_garage_service where sub_service_id=11 and service_name='Air Filter Cleaning');

insert into master_garage_service (sub_service_id, service_name, price)
select 11,'Clutch Cable Tightening',100 where not exists (select 1 from master_garage_service where sub_service_id=11 and service_name='Clutch Cable Tightening');
insert into master_garage_service (sub_service_id, service_name, price)
select 12,'Hydraulic System Check',2500 where not exists (select 1 from master_garage_service where sub_service_id=12 and service_name='Hydraulic System Check');

insert into master_garage_service (sub_service_id, service_name, price)
select 12,'Air Brake Adjustment',1200 where not exists (select 1 from master_garage_service where sub_service_id=12 and service_name='Air Brake Adjustment');

insert into master_garage_service (sub_service_id, service_name, price)
select 12,'Grease Point Lubrication',800 where not exists (select 1 from master_garage_service where sub_service_id=12 and service_name='Grease Point Lubrication');

insert into master_garage_service (sub_service_id, service_name, price)
select 12,'Heavy Duty Oil Change',4500 where not exists (select 1 from master_garage_service where sub_service_id=12 and service_name='Heavy Duty Oil Change');

insert into master_garage_service (sub_service_id, service_name, price)
select 12,'Suspension Inspection',1500 where not exists (select 1 from master_garage_service where sub_service_id=12 and service_name='Suspension Inspection');

insert into master_garage_service (sub_service_id, service_name, price)
select 12,'Fuel Filter Replacement',1800 where not exists (select 1 from master_garage_service where sub_service_id=12 and service_name='Fuel Filter Replacement');




create table if not exists master_mechanic(
    id serial not null,
    garage_id bigint not null,
    mechanic_name varchar(255) not null,
    rating numeric(2,1),
    is_active boolean default true,
    constraint pk_master_mechanic_id primary key(id),
    constraint fk_master_mechanic_garage_id foreign key (garage_id) references master_garage(id),
    constraint uk_master_mechanic_name_garage unique (garage_id, mechanic_name)
);

insert into master_mechanic (garage_id, mechanic_name, rating)
select 1,'Rahul M',4.8 where not exists (select 1 from master_mechanic where garage_id=1 and mechanic_name='Rahul M');
insert into master_mechanic (garage_id, mechanic_name, rating)
select 1,'Suresh K',4.9 where not exists (select 1 from master_mechanic where garage_id=1 and mechanic_name='Suresh K');
insert into master_mechanic (garage_id, mechanic_name, rating)
select 1,'Amit P',4.7 where not exists (select 1 from master_mechanic where garage_id=1 and mechanic_name='Amit P');
-------------------

TRANSACTION TABLES
vehicle_service_booking

CREATE TABLE IF NOT EXISTS vehicle_service_booking (
    id BIGSERIAL NOT NULL,
    sub_service_id BIGINT NOT NULL,
    brand_id BIGINT NOT NULL,
    fuel_id BIGINT NOT NULL,
    garage_id BIGINT NOT NULL,
	mechanic_id BIGINT,
	problem_description varchar(500),
	address varchar(500),	
	customer_name varchar(255),
	contact_number varchar(255),
	preferred_date DATE,
    time_slot_id BIGINT,	
    image_urls varchar(500),
	items_total numeric(10,2),
	garage_base_fee numeric(10,2),
	final_amount numeric(10,2),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_vehicle_service_booking_id PRIMARY KEY (id),
    CONSTRAINT fk_vehicle_service_booking_sub_service_id FOREIGN KEY (sub_service_id) REFERENCES master_sub_service(id),
    CONSTRAINT fk_vehicle_service_booking_brand_id FOREIGN KEY (brand_id) REFERENCES master_vehicle_brand(id),
    CONSTRAINT fk_vehicle_service_booking_fuel_id FOREIGN KEY (fuel_id) REFERENCES master_fuel_type(id),
    CONSTRAINT fk_vehicle_service_booking_garage_id FOREIGN KEY (garage_id) REFERENCES master_garage(id),
    CONSTRAINT fk_vehicle_service_booking_mechanic_id FOREIGN KEY (mechanic_id) REFERENCES master_mechanic(id),
    CONSTRAINT fk_vehicle_service_booking_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES master_time_slot(id),
    CONSTRAINT fk_vehicle_service_booking_created_by FOREIGN KEY (created_by) REFERENCES user_registration(id),
    CONSTRAINT fk_vehicle_service_booking_modified_by FOREIGN KEY (modified_by) REFERENCES user_registration(id)
);

CREATE TABLE IF NOT EXISTS booking_service_mapping (
    id BIGSERIAL NOT NULL,
    booking_id BIGINT NOT NULL,
    garage_service_id BIGINT NOT NULL,
    quantity INT ,
    service_price numeric(10,2), -- snapshot price
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
CONSTRAINT pk_booking_service_mapping_id PRIMARY KEY (id),
CONSTRAINT fk_booking_service_mapping_booking_id FOREIGN KEY (booking_id) REFERENCES vehicle_service_booking(id),
CONSTRAINT fk_booking_service_mapping_garage_service_id FOREIGN KEY (garage_service_id)REFERENCES master_garage_service(id),
CONSTRAINT uq_booking_service UNIQUE (booking_id, garage_service_id)
);

-----------------------27/01/2026  -------tharun 
CREATE TABLE IF NOT EXISTS public.master_ambulance
(
    id bigserial NOT NULL,
    service_provider VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    availability_status VARCHAR(20) DEFAULT 'Available',
    is_active boolean DEFAULT true,
    CONSTRAINT pk_master_ambulance_id PRIMARY KEY (id),
    CONSTRAINT uk_master_ambulance_service_provider UNIQUE (service_provider)
);
-------------------------
INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active) SELECT 'Apollo Ambulance', '+91-40-23607777', 'Available', true WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Apollo Ambulance');

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active) SELECT 'Care Ambulance', '+91-40-61656565', 'Available', true WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Care Ambulance');

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active) SELECT 'Medico Ambulance', '+91-40-24556677', 'Available', true WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Medico Ambulance');


----------------------27/1/2026
alter table ambulance_booking add column patient_name varchar(255);
alter table ambulance_booking add column aadhar_number varchar(50) ;

CREATE TABLE IF NOT EXISTS public.master_hospital (
    id BIGSERIAL NOT NULL,
    hospital_name VARCHAR(255) NOT NULL,
    specialty_type VARCHAR(50),   
    location VARCHAR(255),
    distance_km NUMERIC(5,2),
    estimated_arrival_mins INT,
    contact_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_hospital_id PRIMARY KEY (id)
    
);

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active)
SELECT 'Apollo Ambulance', '+91-40-23607777', 'Available', true
WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Apollo Ambulance');

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active)
SELECT 'Care Ambulance', '+91-40-61656565', 'Available', true
WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Care Ambulance');

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active)
SELECT 'Yashoda Ambulance', '+91-40-23550000', 'Available', true
WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Yashoda Ambulance');

SELECT * FROM public.master_ambulance;

INSERT INTO public.master_hospital 
(hospital_name, specialty_type, location, distance_km, estimated_arrival_mins, contact_number, is_active)
SELECT 'Apollo Hospital', 'Multi-Specialty', 'Jubilee Hills, Hyderabad', 2.3, 8, '+91-40-23607777', TRUE
WHERE NOT EXISTS (SELECT 1 FROM public.master_hospital WHERE hospital_name = 'Apollo Hospital');

INSERT INTO public.master_hospital 
(hospital_name, specialty_type, location, distance_km, estimated_arrival_mins, contact_number, is_active)
SELECT 'Care Hospital', 'Multi-Specialty', 'Banjara Hills, Hyderabad', 3.1, 12, '+91-40-61656565', TRUE
WHERE NOT EXISTS (SELECT 1 FROM public.master_hospital WHERE hospital_name = 'Care Hospital');

INSERT INTO public.master_hospital 
(hospital_name, specialty_type, location, distance_km, estimated_arrival_mins, contact_number, is_active)
SELECT 'Yashoda Hospital', 'Super-Specialty', 'Somajiguda, Hyderabad', 4.5, 15, '+91-40-23550000', TRUE
WHERE NOT EXISTS (SELECT 1 FROM public.master_hospital WHERE hospital_name = 'Yashoda Hospital');
---------
insert into master_role (role_name)select 'Garage_Owner' where not exists (select 1 from master_role where role_name='Garage_Owner');

insert into master_role (role_name)select 'Mechanic' where not exists (select 1 from master_role where role_name='Mechanic');
  
------------------------ healthcare
ALTER TABLE public.master_ambulance ADD COLUMN hospital_id BIGINT;
ALTER TABLE public.master_ambulance 
  ADD CONSTRAINT fk_ambulance_hospital FOREIGN KEY (hospital_id) REFERENCES public.master_hospital(id);
-----------
CREATE TABLE IF NOT EXISTS public.master_assistants
(
    id bigserial NOT NULL,
    name VARCHAR(100) NOT NULL,
    rating numeric(3,2),
    role VARCHAR(50) DEFAULT 'Professional',
    is_active boolean DEFAULT true,
    CONSTRAINT pk_master_assistants_id PRIMARY KEY (id),
    CONSTRAINT uk_master_assistants_name UNIQUE (name)
);
-- Insert Assistant A
INSERT INTO public.master_assistants (name, rating, role, is_active) SELECT 'Assistant A', 4.90, 'Professional', true WHERE NOT EXISTS (SELECT 1 FROM public.master_assistants WHERE name = 'Assistant A');

-- Insert Assistant B
INSERT INTO public.master_assistants (name, rating, role, is_active) SELECT 'Assistant B', 4.10, 'Professional', true WHERE NOT EXISTS (SELECT 1 FROM public.master_assistants WHERE name = 'Assistant B');

-- Insert Assistant C
INSERT INTO public.master_assistants (name, rating, role, is_active) SELECT 'Assistant C', 4.11, 'Professional', true WHERE NOT EXISTS (SELECT 1 FROM public.master_assistants WHERE name = 'Assistant C');


--------------------
CREATE TABLE IF NOT EXISTS public.appointments
(
    id bigserial NOT NULL,
    user_id bigint NOT NULL,
    doctor_id bigint,
	doctor_specialization_id INT,
    consultation_type VARCHAR(20) NOT NULL,
    appointment_time timestamp NOT NULL,
    description varchar,
	days_of_suffering int,
	health_insurance boolean,
	upload_prescription varchar(500),
	upload_test_list varchar(500),
	required_ambulance boolean,
    required_assistant boolean,
    ambulance_id bigint,
    pickup_time timestamp,
    assistant_id bigint,
	pharmacies_id bigint,
	labs_id bigint,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT NOW(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_appointments_id PRIMARY KEY (id),
    CONSTRAINT fk_appointments_user_id FOREIGN KEY (user_id) REFERENCES user_registration(id),
    CONSTRAINT fk_appointments_doctor_id FOREIGN KEY (doctor_id) REFERENCES doctor_profile(id),
    CONSTRAINT fk_appointments_doctor_specialization_id FOREIGN KEY (doctor_specialization_id) REFERENCES master_doctor_specialization(id),
    CONSTRAINT fk_appointments_ambulance_id FOREIGN KEY (ambulance_id) REFERENCES master_ambulance(id),
    CONSTRAINT fk_appointments_assistant_id FOREIGN KEY (assistant_id) REFERENCES master_assistants(id),
	CONSTRAINT fk_appointments_pharmacies_id FOREIGN KEY (pharmacies_id) REFERENCES master_pharmacies(id),
    CONSTRAINT fk_appointments_labs_id FOREIGN KEY (labs_id) REFERENCES master_labs(id)

);
----------------------
CREATE TABLE IF NOT EXISTS public.ambulance_booking
(
    id bigserial NOT NULL,
    appointment_id bigint NOT NULL,
    ambulance_id bigint NOT NULL,
	
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT NOW(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_ambulance_booking_id PRIMARY KEY (id),
    CONSTRAINT fk_ambulance_booking_appointment FOREIGN KEY (appointment_id) REFERENCES public.appointments(id),
    CONSTRAINT fk_ambulance_booking_ambulance FOREIGN KEY (ambulance_id) REFERENCES public.master_ambulance(id)
);
---------------------------

CREATE TABLE IF NOT EXISTS public.master_pharmacies
(
    id bigserial NOT NULL,
    pharmacy_name VARCHAR(255) UNIQUE NOT NULL,
    pharmacy_type VARCHAR(100), -- Retail, Discount, 24/7
    services varchar(255),
    rating int ,
    delivery_time VARCHAR(50),
    is_active boolean DEFAULT true,
	CONSTRAINT pk_master_pharmacies_id PRIMARY KEY (id),
    CONSTRAINT ck_master_pharmacies_rating check (rating between 1 and 5)

);
-------	------
INSERT INTO public.master_pharmacies (pharmacy_name, pharmacy_type, services, rating, delivery_time, is_active)SELECT 'HealthCare Pharmacy', 'Retail Pharmacy', 'Prescription medicines, OTC drugs', 4, '30-50 mins', true WHERE NOT EXISTS (SELECT 1 FROM public.master_pharmacies WHERE pharmacy_name = 'HealthCare Pharmacy');
INSERT INTO public.master_pharmacies (pharmacy_name, pharmacy_type, services, rating, delivery_time, is_active)SELECT 'Green Cross Pharma', 'Discount Pharmacy', 'Generic & Branded drugs', 5, '15-30 mins', true WHERE NOT EXISTS (SELECT 1 FROM public.master_pharmacies WHERE pharmacy_name = 'Green Cross Pharma');
INSERT INTO public.master_pharmacies (pharmacy_name, pharmacy_type, services, rating, delivery_time, is_active) SELECT 'MedLife Pharmacy', '24/7 Pharmacy', 'Emergency supplies, Vitamins', 5, 'Immediate', true WHERE NOT EXISTS (SELECT 1 FROM public.master_pharmacies WHERE pharmacy_name = 'MedLife Pharmacy');
----------

CREATE TABLE IF NOT EXISTS public.master_labs
(
    id bigserial NOT NULL,
    lab_name VARCHAR(255) UNIQUE NOT NULL,
    services varchar(255),
    rating int,
    home_collection boolean ,
    is_active boolean DEFAULT true,
	CONSTRAINT pk_master_labs_id PRIMARY KEY (id),
    CONSTRAINT ck_master_labs_rating check (rating between 1 and 5)

);

INSERT INTO public.master_labs (lab_name, services, rating, home_collection, is_active) SELECT 'Apollo Diagnostics', 'Blood tests, Imaging, Pathology', 5, true, true WHERE NOT EXISTS (SELECT 1 FROM public.master_labs WHERE lab_name = 'Apollo Diagnostics');
INSERT INTO public.master_labs (lab_name, services, rating, home_collection, is_active) SELECT 'Dr. Lal PathLabs', 'Pathology, Biochemistry, Home sample collection', 4, true, true WHERE NOT EXISTS (SELECT 1 FROM public.master_labs WHERE lab_name = 'Dr. Lal PathLabs');
INSERT INTO public.master_labs (lab_name, services, rating, home_collection, is_active) SELECT 'SRL Diagnostics', 'Full body checkups, Radiology, Home collection', 5, true, true WHERE NOT EXISTS (SELECT 1 FROM public.master_labs WHERE lab_name = 'SRL Diagnostics');


----------
drop table master_fuel_type;
drop table master_vehicle_brand;

alter table home_service drop column vehicle_brand_id;
alter table home_service drop column fuel_type_id;

ALTER TABLE public.master_pharmacies ADD COLUMN latitude NUMERIC(9,6),ADD COLUMN longitude NUMERIC(9,6);

ALTER TABLE public.master_labs ADD COLUMN latitude NUMERIC(9,6),ADD COLUMN longitude NUMERIC(9,6);
-----------
ALTER TABLE public.doctor_profile
ALTER COLUMN rating TYPE INT USING rating::INT;

ALTER TABLE public.doctor_profile ADD CONSTRAINT ck_doctor_profile_rating CHECK (rating BETWEEN 1 AND 5);
-----------
alter table ambulance_booking add column patient_name varchar(255);
alter table ambulance_booking add column aadhar_number varchar(50) ;

CREATE TABLE IF NOT EXISTS public.master_hospital (
    id BIGSERIAL NOT NULL,
    hospital_name VARCHAR(255) NOT NULL,
    specialty_type VARCHAR(50),   
    location VARCHAR(255),
    distance_km NUMERIC(5,2),
    estimated_arrival_mins INT,
    contact_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_hospital_id PRIMARY KEY (id)
	
);

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active)
SELECT 'Apollo Ambulance', '+91-40-23607777', 'Available', true
WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Apollo Ambulance');

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active)
SELECT 'Care Ambulance', '+91-40-61656565', 'Available', true
WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Care Ambulance');

INSERT INTO public.master_ambulance (service_provider, contact_number, availability_status, is_active)
SELECT 'Yashoda Ambulance', '+91-40-23550000', 'Available', true
WHERE NOT EXISTS (SELECT 1 FROM public.master_ambulance WHERE service_provider = 'Yashoda Ambulance');

INSERT INTO public.master_hospital 
(hospital_name, specialty_type, location, distance_km, estimated_arrival_mins, contact_number, is_active)
SELECT 'Apollo Hospital', 'Multi-Specialty', 'Jubilee Hills, Hyderabad', 2.3, 8, '+91-40-23607777', TRUE
WHERE NOT EXISTS (SELECT 1 FROM public.master_hospital WHERE hospital_name = 'Apollo Hospital');

INSERT INTO public.master_hospital 
(hospital_name, specialty_type, location, distance_km, estimated_arrival_mins, contact_number, is_active)
SELECT 'Care Hospital', 'Multi-Specialty', 'Banjara Hills, Hyderabad', 3.1, 12, '+91-40-61656565', TRUE
WHERE NOT EXISTS (SELECT 1 FROM public.master_hospital WHERE hospital_name = 'Care Hospital');

INSERT INTO public.master_hospital 
(hospital_name, specialty_type, location, distance_km, estimated_arrival_mins, contact_number, is_active)
SELECT 'Yashoda Hospital', 'Super-Specialty', 'Somajiguda, Hyderabad', 4.5, 15, '+91-40-23550000', TRUE
WHERE NOT EXISTS (SELECT 1 FROM public.master_hospital WHERE hospital_name = 'Yashoda Hospital');

SELECT * FROM master_hospital 
ALTER TABLE public.master_ambulance ADD COLUMN hospital_id BIGINT;
ALTER TABLE public.master_ambulance  ADD CONSTRAINT fk_ambulance_hospital FOREIGN KEY (hospital_id) REFERENCES public.master_hospital(id);
-------
Create table if not exists  master_relation(
id serial not null,
relation_type varchar(255) not null,
is_active boolean default true,
constraint pk_master_relation_id primary key(id));

INSERT INTO public.master_relation (relation_type, is_active) SELECT 'Father', TRUE WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE relation_type = 'Father');
INSERT INTO public.master_relation (relation_type, is_active) SELECT 'Mother', TRUE WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE relation_type = 'Mother');
INSERT INTO public.master_relation (relation_type, is_active) SELECT 'Brother', TRUE WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE relation_type = 'Brother');
INSERT INTO public.master_relation (relation_type, is_active) SELECT 'Sister', TRUE WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE relation_type = 'Sister');
INSERT INTO public.master_relation (relation_type, is_active) SELECT 'Spouse', TRUE WHERE NOT EXISTS (SELECT 1 FROM public.master_relation WHERE relation_type = 'Spouse');

Create table if not exists student_family_members(
id serial not null,
user_id bigint not null,
relation_type_id int not null,
first_name varchar(255),
last_name varchar(255),
phone_number varchar(255),
created_by bigint,
created_date timestamp DEFAULT now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_student_family_members_id primary key(id),
constraint fk_student_family_members_user_id foreign key (user_id) references user_registration (id),
constraint fk_student_family_members_relation_type_id foreign key (relation_type_id) references master_relation (id)
);

----------------------- 28 jan 2026 --- dhanusha-buy & sale


----swachify_product
CREATE TABLE IF NOT EXISTS product_rating (
    id SERIAL not null,
    product_id INT NOT NULL,
    user_id BIGINT NOT NULL,
    rating NUMERIC(2,1) NOT NULL,
	created_by BIGINT, 
	created_date TIMESTAMP DEFAULT NOW(),
	modified_by BIGINT, 
	modified_date TIMESTAMP, 
	is_active BOOLEAN DEFAULT TRUE,
	constraint pk_product_rating_id primary key (id),
   constraint fk_product_rating_product_id FOREIGN KEY (product_id) REFERENCES product_registration(id),
    constraint fk_product_rating_user_id FOREIGN KEY (user_id) REFERENCES user_registration(id)
);
---------------------------------------------

CREATE TABLE IF NOT EXISTS master_vehicle_type (
    id SERIAL PRIMARY KEY,
    vehicle_type_name VARCHAR(100) UNIQUE,
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO master_vehicle_type (vehicle_type_name)
SELECT 'Bike'
WHERE NOT EXISTS (
    SELECT 1 FROM master_vehicle_type WHERE vehicle_type_name = 'Bike'
);

INSERT INTO master_vehicle_type (vehicle_type_name)
SELECT 'Light Motor Cargo'
WHERE NOT EXISTS (
    SELECT 1 FROM master_vehicle_type WHERE vehicle_type_name = 'Light Motor Cargo'
);

INSERT INTO master_vehicle_type (vehicle_type_name)
SELECT 'DCM Van'
WHERE NOT EXISTS (
    SELECT 1 FROM master_vehicle_type WHERE vehicle_type_name = 'DCM Van'
);

INSERT INTO master_vehicle_type (vehicle_type_name)
SELECT 'Freight/Lorry'
WHERE NOT EXISTS (
    SELECT 1 FROM master_vehicle_type WHERE vehicle_type_name = 'Freight/Lorry'
);

------------------------------------------------------
CREATE TABLE IF NOT EXISTS product_order (
    id SERIAL NOT NULL,
    user_id BIGINT NOT NULL,
    product_id INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    delivery_address TEXT NOT NULL,
    quantity VARCHAR(50) NOT NULL, -- e.g., 2 kg / 5 pcs / 1 pack
    vehicle_type_id INT, -- FK to master_vehicle_type
    order_date TIMESTAMP DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'Pending',
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT NOW(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    
    CONSTRAINT pk_product_order_id PRIMARY KEY (id),
    CONSTRAINT fk_product_order_user_id FOREIGN KEY (user_id) REFERENCES user_registration(id),
    CONSTRAINT fk_product_order_product_id FOREIGN KEY (product_id) REFERENCES product_registration(id),
    CONSTRAINT fk_product_order_vehicle_type_id FOREIGN KEY (vehicle_type_id) REFERENCES master_vehicle_type(id)
);

-------------------------------------------



select * from product_registration
alter table product_registration add column latitude  numeric(9,6) ;
alter table product_registration add column longitude  numeric(9,6) ;

------------------------------------ 29th jan 2026
CREATE OR REPLACE FUNCTION public.fn_get_internship_list(
    p_category_id BIGINT DEFAULT -1,
    p_location_type_id INT DEFAULT -1,
    p_limit INT DEFAULT 100,
    p_offset INT DEFAULT 0
)
RETURNS TABLE (
    internship_id BIGINT,
    job_id BIGINT,
    company_name VARCHAR(255),
    company_address VARCHAR(255),
    role_description VARCHAR(500),
    internship_stipend BOOLEAN,
    stipend_type_id INT,
    internship_duration_id BIGINT,
    category_id BIGINT,
    location_type_id INT,
    work_type_id INT,
    created_date TIMESTAMP
)
LANGUAGE plpgsql
AS $BODY$
BEGIN
    RETURN QUERY
    SELECT
        jo.id AS internship_id,
        jo.job_id,
        jo.company_name,
        jo.company_address,
        jo.role_description,
        jo.internship_stipend,
        jo.stipend_type_id,
        jo.internship_duration_id,
        jo.category_id,
        jo.location_type_id,
        jo.work_type_id,
        jo.created_date
    FROM public.job_openings jo
    WHERE jo.is_active = TRUE
      AND (p_category_id = -1 OR jo.category_id = p_category_id)
      AND (p_location_type_id = -1 OR jo.location_type_id = p_location_type_id)
    ORDER BY jo.created_date DESC
    LIMIT p_limit OFFSET p_offset;
END;
$BODY$;


select * from master_module
select * from master_sub_module

select * from master_service
select * from master_sub_service

update master_module set module_name = 'Buy/Sell/Rent' where id =3

update master_sub_module set sub_module_name = 'Home Cleaning' where id =1;
update master_sub_module set sub_module_name = 'Home Service' where id =2;

update master_service set service_name = 'Home Cleaning' where id =1;
update master_service set service_name = 'Commercial Cleaning' where id =2;
update master_service set service_name = 'Vehicle Cleaning' where id =3;
update master_service set service_name = 'Plumbing' where id =4;
update master_service set service_name = 'Painting' where id =5;
update master_service set service_name = 'Electrician' where id =6;
update master_service set service_name = 'AC Repair' where id =7;
update master_service set service_name = 'Chef' where id =8;


update master_service set sub_module_id = 1 where id =1;
update master_service set sub_module_id = 1 where id =2;
update master_service set sub_module_id = 1 where id =3;
update master_service set sub_module_id = 2 where id =4;
update master_service set sub_module_id = 2 where id =5;
update master_service set sub_module_id = 2 where id =6;
update master_service set sub_module_id = 2 where id =7;
update master_service set sub_module_id = 2 where id =8;
delete from master_service where id =9;
-----------------------
select * from master_sub_service
begin;
update master_sub_service set service_id =1  
rollback
update master_sub_service set sub_service_name = 'Kitchen Cleaning' , service_id = 1 where id =1;
update master_sub_service set sub_service_name = 'Washroom Cleaning' , service_id = 1  where id =2;
update master_sub_service set sub_service_name = 'Sofa Cleaning' , service_id = 1  where id =3;
update master_sub_service set sub_service_name = 'Bedroom Cleaning' , service_id = 1  where id =4;
update master_sub_service set sub_service_name = 'Window Cleaning' , service_id = 1  where id =5;
update master_sub_service set sub_service_name = 'Full Deep Cleaning' , service_id = 1  where id =6;
update master_sub_service set sub_service_name = 'Small Office' , service_id = 2 where id =7;
update master_sub_service set sub_service_name = 'Medium Office' , service_id = 2 where id =8;
update master_sub_service set sub_service_name = 'Large Corporate Office' , service_id = 2 where id =9;
update master_sub_service set sub_service_name = 'Retail Shop/Showroom' , service_id = 2 where id =10;
update master_sub_service set sub_service_name = 'Warehouse/Clinic' , service_id = 2 where id =11;
update master_sub_service set sub_service_name = 'Car' , service_id = 3 where id =12;
update master_sub_service set sub_service_name = 'Bike' , service_id = 3 where id =13;
update master_sub_service set sub_service_name = 'Truck', service_id = 3 where id =14;

INSERT INTO master_sub_service (sub_service_name, service_id)
SELECT 'Bike', 3
WHERE NOT EXISTS (
    SELECT 1
    FROM master_sub_service
    WHERE sub_service_name = 'Bike'
      AND service_id = 3
);

INSERT INTO master_sub_service (sub_service_name, service_id)
SELECT 'Truck', 3
WHERE NOT EXISTS (
    SELECT 1
    FROM master_sub_service
    WHERE sub_service_name = 'Truck'
      AND service_id = 3
);


-------------------------------------------------------------------- 30jan-2026 -- dhanusha
-------------------- 30 jan
INSERT INTO public.master_sub_module (sub_module_name, module_id)SELECT 'Institute', 5 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_module WHERE sub_module_name = 'Institute' AND module_id = 5 );
----------------------
CREATE TABLE IF NOT EXISTS public.institution_registration (
    id SERIAL NOT NULL,
    institution_name VARCHAR(255) NOT NULL,
    institution_type_id INT NOT NULL,
    identity_type_id INT NOT NULL,
    identity_number VARCHAR(100) NOT NULL,
    upload_id_proof varchar(500),
    upload_address_proof varchar(500),
    Location varchar(500) NOT NULL,
    representative_name VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone_number VARCHAR(100) NOT NULL,
    institute_website varchar(500),
    total_branches INT ,
    academic_year_start DATE,
    academic_year_end DATE,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_institution_registration_id PRIMARY KEY (id),
    CONSTRAINT fk_institution_registration_institution_type_id FOREIGN KEY (institution_type_id) REFERENCES master_institute_type(id),
    CONSTRAINT fk_institution_registration_identity_type_id FOREIGN KEY (identity_type_id) REFERENCES master_identity_type(id),
    CONSTRAINT uk_institution_registration UNIQUE (institution_name, identity_number)
);

-------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.institution_branch (
    id SERIAL NOT NULL,
    institution_id BIGINT NOT NULL,
    branch_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    branch_code VARCHAR(100) NOT NULL,
    branch_head VARCHAR(255) NOT NULL,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_institution_branch_id PRIMARY KEY (id),
    CONSTRAINT fk_institution_branch_institution_institution_id FOREIGN KEY (institution_id) REFERENCES institution_registration(id),
    CONSTRAINT uk_institution_branch UNIQUE (institution_id, branch_code)
);
alter table  institution_branch add column created_by BIGINT;
ALTER TABLE public.institution_branch
ADD CONSTRAINT uq_institution_branch_branch_name UNIQUE (branch_name);

--------------------
CREATE TABLE IF NOT EXISTS public.master_institute_type (
    id SERIAL NOT NULL,
    institute_type VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_institute_type_id PRIMARY KEY (id)
);

INSERT INTO public.master_institute_type (institute_type)SELECT 'University'WHERE NOT EXISTS (SELECT 1 FROM public.master_institute_type WHERE institute_type = 'University');
INSERT INTO public.master_institute_type (institute_type)SELECT 'College'WHERE NOT EXISTS (SELECT 1 FROM public.master_institute_type WHERE institute_type = 'College');
INSERT INTO public.master_institute_type (institute_type)SELECT 'Institute' WHERE NOT EXISTS (SELECT 1 FROM public.master_institute_type WHERE institute_type = 'Institute');
INSERT INTO public.master_institute_type (institute_type)SELECT 'Academy'WHERE NOT EXISTS (SELECT 1 FROM public.master_institute_type WHERE institute_type = 'Academy');

CREATE TABLE IF NOT EXISTS public.master_identity_type (
    id SERIAL NOT NULL,
    identity_type_name VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_identity_type_id PRIMARY KEY (id)
);

INSERT INTO public.master_identity_type (identity_type_name)SELECT 'Registration Certificate' WHERE NOT EXISTS (SELECT 1 FROM public.master_identity_type WHERE identity_type_name = 'Registration Certificate');
INSERT INTO public.master_identity_type (identity_type_name)SELECT 'Government Approval' WHERE NOT EXISTS (SELECT 1 FROM public.master_identity_type WHERE identity_type_name = 'Government Approval');

---------------------------------------------- 
-------------------


CREATE TABLE IF NOT EXISTS  public.student_profile (
    id SERIAL not null,
    branch_id BIGINT NOT NULL,
	branch_name varchar(255) not null,
    student_name VARCHAR(255) NOT NULL,
    student_id VARCHAR(150) NOT NULL,
    academic_year varchar(100) NOT NULL,
    profile_image_url varchar(500),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
	constraint pk_student_profile_id primary key (id),
    CONSTRAINT fk_student_profile_branch_id FOREIGN KEY (branch_id) REFERENCES public.institution_branch(id),
	CONSTRAINT fk_student_profile_branch_name FOREIGN KEY (branch_name) REFERENCES public.institution_branch(branch_name),
	CONSTRAINT uk_student_profile_student_id unique  (student_id) 

);

------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.student_academic_finance (
    id BIGSERIAL NOT NULL,
    student_id VARCHAR(150) NOT NULL,
    father_name VARCHAR(255),
    background VARCHAR(255),
    admission_date DATE,
    aadhaar_number VARCHAR(150),
    pan_number VARCHAR(150),
    scholarship_amount NUMERIC(10,2),
    scholarship_disbursed_date DATE,
    sgpa NUMERIC(10,2),
    attendance_percent INT,
    backlogs INT,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_student_academic_finance_id PRIMARY KEY (id),
    CONSTRAINT fk_student_academic_finance_student_id FOREIGN KEY (student_id) REFERENCES public.student_profile(student_id),
    CONSTRAINT uk_student_academic_finance_student_id UNIQUE (student_id)
);
--------------------------------------------
CREATE TABLE IF NOT EXISTS public.student_fee_installments (
    id BIGSERIAL NOT NULL,
    student_id VARCHAR(150) NOT NULL,
    installment_no INT NOT NULL,
    installment_amount NUMERIC NOT NULL,
    due_date DATE NOT NULL,
    paid_date DATE,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_student_fee_installments_id PRIMARY KEY (id),
    CONSTRAINT fk_student_fee_installments_student_id FOREIGN KEY (student_id) REFERENCES public.student_profile(student_id),
    CONSTRAINT uk_student_fee_installments UNIQUE (student_id, installment_no)
);

---------------------------------------------------------
	
---------------------------------------------------------------------------------------
ALTER TABLE public.student_profile ADD COLUMN parent_mobile VARCHAR(100);
--------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.exam_schedule (
    id SERIAL NOT NULL,
    branch_id BIGINT NOT NULL,
    exam_type VARCHAR(100) NOT NULL, -- e.g. 'Mid-Term', 'Final'
    subject_name VARCHAR(100) NOT NULL,
    exam_date DATE NOT NULL,
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_exam_schedule_id PRIMARY KEY (id),
    CONSTRAINT fk_exam_schedule_branch_branch_id FOREIGN KEY (branch_id) REFERENCES institution_branch(id),
    CONSTRAINT uk_exam_schedule UNIQUE (branch_id, exam_type, subject_name, exam_date)
);

-----------------------------------------------------------------------------

-------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.otp_verification (
    id SERIAL NOT NULL,
    institution_id INT NOT NULL,
    identity_number VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    otp_code VARCHAR(10) NOT NULL,
    expires_at TIMESTAMP NOT NULL,
    is_verified BOOLEAN ,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_otp_verification_id PRIMARY KEY (id),
    CONSTRAINT fk_otp_verification_institution_id FOREIGN KEY (institution_id) REFERENCES institution_registration(id),
    CONSTRAINT uk_otp_verification UNIQUE (identity_number, email, otp_code)
);


----------------------------------------------------------------------------------------------- 


CREATE TABLE IF NOT EXISTS public.ai_documents (
    id BIGSERIAL NOT NULL,
    doc_id VARCHAR(150) NOT NULL,          
    chunk_id INT NOT NULL,               
    content varchar NOT NULL,              
    embedding VECTOR(384) NOT NULL,    
    language VARCHAR(50),               
    metadata JSONB,    
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_documents_id PRIMARY KEY (id),
    CONSTRAINT uk_documents_doc_chunk UNIQUE (doc_id, chunk_id)
);


CREATE INDEX ON public.ai_documents
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);

CREATE EXTENSION IF NOT EXISTS vector;


----------------------------------
CREATE TABLE IF NOT EXISTS public.student_sem_academic_progress (
    id BIGSERIAL NOT NULL,
    student_id VARCHAR(150) NOT NULL,
    academic_year VARCHAR(100) NOT NULL,   -- e.g., '2023-24'
    semester_no INT NOT NULL,            -- 1, 2, 3, 4...
    sgpa NUMERIC(10,2),
    attendance_percent INT,
    backlogs INT,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_student_sem_academic_progress_id PRIMARY KEY (id),
    CONSTRAINT fk_student_sem_academic_progress_student_id FOREIGN KEY (student_id) REFERENCES public.student_profile(student_id),
    CONSTRAINT uk_student_sem_academic_progress UNIQUE (student_id, academic_year, semester_no)
);

ALTER TABLE public.student_fee_installments ADD COLUMN academic_year VARCHAR(100);



------------------------------------------------- 30 jan 2026 -- dhanusha
CREATE TABLE IF NOT EXISTS public.enrollment_status (
    id BIGSERIAL NOT NULL,
    institute_id BIGINT NOT NULL,          -- link to institution_branch
    total_capacity INT NOT NULL,
    approved_seats INT NOT NULL,
    last_updated TIMESTAMP DEFAULT now(),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_enrollment_status_id PRIMARY KEY (id),
    CONSTRAINT fk_enrollment_status_institute FOREIGN KEY (institute_id) REFERENCES public.institution_branch(id)
);

-------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.bus_fleet (
    id BIGSERIAL NOT NULL,
    bus_id VARCHAR(20) NOT NULL,
    bus_name VARCHAR(100),
    driver_name VARCHAR(100),
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_bus_fleet_id PRIMARY KEY (id),
    CONSTRAINT uk_bus_fleet_bus_id UNIQUE (bus_id)
);


CREATE TABLE IF NOT EXISTS public.bus_tracking_status (
    id BIGSERIAL NOT NULL,
    bus_id VARCHAR(20) NOT NULL,
    status VARCHAR(50),              -- MOVING, IDLE, OFF-ROUTE
    location_description TEXT,
    current_speed NUMERIC(5,2),
    next_stop VARCHAR(100),
	eta_minutes INT,
    last_updated TIMESTAMP DEFAULT now(),
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_bus_tracking_status_id PRIMARY KEY (id),
    CONSTRAINT fk_bus_tracking_status_bus_id FOREIGN KEY (bus_id) REFERENCES public.bus_fleet(bus_id)
);


CREATE TABLE IF NOT EXISTS public.bus_alert_log (
    id BIGSERIAL NOT NULL,
    bus_id VARCHAR(20) NOT NULL,
    alert_type VARCHAR(100),         -- GPS_LAG, OFF_ROUTE
    alert_message TEXT,
    alert_time TIMESTAMP DEFAULT now(),
    resolved BOOLEAN DEFAULT FALSE,
	created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_bus_alert_log_id PRIMARY KEY (id),
    CONSTRAINT fk_bus_alert_log_bus_id FOREIGN KEY (bus_id) REFERENCES public.bus_fleet(bus_id)
);

----------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.staff_profile (
    id BIGSERIAL NOT NULL,
    staff_id VARCHAR(50) NOT NULL,
    staff_name VARCHAR(255) NOT NULL,
    job_title VARCHAR(255),
    department VARCHAR(100),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_staff_profile_id PRIMARY KEY (id),
    CONSTRAINT uk_staff_profile_staff_id UNIQUE (staff_id)
);

CREATE TABLE IF NOT EXISTS public.staff_payslip (
    id BIGSERIAL NOT NULL,
    staff_id VARCHAR(50) NOT NULL,
    payroll_month VARCHAR(20) NOT NULL,  -- e.g., 'Sep 2023'
    payment_date DATE,
    basic_pay NUMERIC(10,2),
    hra NUMERIC(10,2),
    medical_allowance NUMERIC(10,2),
    conveyance NUMERIC(10,2),
    performance_bonus NUMERIC(10,2),
    gross_earnings NUMERIC(10,2),
    pf_deduction NUMERIC(10,2),
    income_tax NUMERIC(10,2),
    professional_tax NUMERIC(10,2),
    health_insurance NUMERIC(10,2),
    total_deductions NUMERIC(10,2),
    net_salary NUMERIC(10,2),
    status VARCHAR(50) DEFAULT 'DISBURSED',
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_staff_payslip_id PRIMARY KEY (id),
    CONSTRAINT fk_staff_payslip_staff_id FOREIGN KEY (staff_id) REFERENCES public.staff_profile(staff_id),
    CONSTRAINT uk_staff_payslip UNIQUE (staff_id, payroll_month)
);

CREATE TABLE IF NOT EXISTS public.payroll_summary (
    id BIGSERIAL NOT NULL,
    payroll_month VARCHAR(20) NOT NULL UNIQUE,
    total_net_disbursement NUMERIC(12,2),
    staff_count INT,
    status VARCHAR(50) DEFAULT 'DISBURSED',
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_payroll_summary_id PRIMARY KEY (id)
);

------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.maintenance_budget (
    id BIGSERIAL NOT NULL,
    institute_id BIGINT NOT NULL,              -- FK to institution_branch
    budget_limit NUMERIC(10,2),
    budget_used NUMERIC(10,2),
    status VARCHAR(50),                        -- UNDER_BUDGET, OVER_BUDGET
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_maintenance_budget_id PRIMARY KEY (id),
    CONSTRAINT fk_maintenance_budget_institute FOREIGN KEY (institute_id) REFERENCES public.institution_branch(id)
);

----------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS public.exam_schedule (
    id BIGSERIAL NOT NULL,
    institute_id BIGINT NOT NULL,              -- FK to institution_branch
    exam_type VARCHAR(255) NOT NULL,            -- MID_TERM, FINAL
    subject_name VARCHAR(255) NOT NULL,
    exam_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    location VARCHAR(255),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_exam_schedule_id PRIMARY KEY (id),
    CONSTRAINT fk_exam_schedule_institute FOREIGN KEY (institute_id) REFERENCES public.institution_branch(id)
);


CREATE TABLE IF NOT EXISTS public.exam_notification_log (
    id BIGSERIAL NOT NULL,
    exam_schedule_id BIGINT NOT NULL,          -- FK to exam_schedule
    message varchar(255),
    sent_count INT,
    failed_count INT,
    retry_success INT,
    scheduled_date DATE,
    status VARCHAR(255),                        -- SENT, FAILED, DRAFT
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_exam_notification_log_id PRIMARY KEY (id),
    CONSTRAINT fk_exam_notification_log_exam FOREIGN KEY (exam_schedule_id) REFERENCES public.exam_schedule(id)
);

CREATE TABLE IF NOT EXISTS public.exam_reminder_settings (
    id BIGSERIAL NOT NULL,
    exam_schedule_id BIGINT NOT NULL,          -- FK to exam_schedule
    enable_notifications BOOLEAN DEFAULT TRUE,
    trigger_time VARCHAR(255),                  -- 15 min, 1 hour, 1 day, etc.
    notification_sound VARCHAR(150),            -- Chime, Bell, Alert, etc.
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_exam_reminder_settings_id PRIMARY KEY (id),
    CONSTRAINT fk_exam_reminder_settings_exam FOREIGN KEY (exam_schedule_id) REFERENCES public.exam_schedule(id)
);

CREATE TABLE IF NOT EXISTS public.exam_invigilation_assignment (
    id BIGSERIAL NOT NULL,
    exam_schedule_id BIGINT NOT NULL,          -- FK to exam_schedule
    staff_id BIGINT NOT NULL,                  -- FK to staff_profile
    duty_notes varchar(255),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_exam_invigilation_assignment_id PRIMARY KEY (id),
    CONSTRAINT fk_exam_invigilation_assignment_exam FOREIGN KEY (exam_schedule_id) REFERENCES public.exam_schedule(id),
    CONSTRAINT fk_exam_invigilation_assignment_staff FOREIGN KEY (staff_id) REFERENCES public.staff_profile(id)
);


--------------------------- 2 jan 2026 --dhanusha
alter table appointments drop column consultation_type;
alter table appointments add column consultation_type_id int;
alter table appointments add constraint fk_appointments_consultation_type_id foreign key (consultation_type_id) references master_consultation_type(id); 

alter table appointments drop column upload_prescription;
alter table appointments drop column upload_test_list;

ALTER TABLE public.master_labs RENAME TO available_labs;
ALTER TABLE public.master_pharmacies RENAME TO available_pharmacies;

ALTER TABLE public.master_pharmacies add columns

ALTER TABLE public.available_labs add column created_by BIGINT;
ALTER TABLE public.available_labs add column created_date TIMESTAMP DEFAULT now();
ALTER TABLE public.available_labs add column modified_by BIGINT;
ALTER TABLE public.available_labs add column modified_date TIMESTAMP;
ALTER TABLE public.available_labs add column upload_prescription varchar(500);
ALTER TABLE public.available_labs add column proceed_type varchar(255);
ALTER TABLE public.available_labs add column delivery_address varchar(255);
ALTER TABLE public.available_labs add column special_instructions varchar(255);


ALTER TABLE public.available_pharmacies add column created_by BIGINT;
ALTER TABLE public.available_pharmacies add column created_date TIMESTAMP DEFAULT now();
ALTER TABLE public.available_pharmacies add column modified_by BIGINT;
ALTER TABLE public.available_pharmacies add column modified_date TIMESTAMP;
ALTER TABLE public.available_pharmacies add column upload_prescription varchar(500);
ALTER TABLE public.available_pharmacies add column proceed_type varchar(255);
ALTER TABLE public.available_pharmacies add column delivery_address varchar(255);
ALTER TABLE public.available_pharmacies add column special_instructions varchar(255);


DROP VIEW IF EXISTS public.vw_active_pharmacies;
DROP VIEW IF EXISTS public.vw_active_labs;
DROP VIEW IF EXISTS public.vw_available_doctors;


------------------------------------------------------------------------------------------------
select * from public.appointments

CREATE TABLE IF NOT EXISTS public.master_consultation_type (
    id SERIAL NOT NULL,
    consultation_type VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_master_consultation_type_id PRIMARY KEY (id)
);

INSERT INTO public.master_consultation_type (consultation_type)SELECT 'Online' WHERE NOT EXISTS (SELECT 1 FROM public.master_consultation_type WHERE consultation_type = 'Online');
INSERT INTO public.master_consultation_type (consultation_type)SELECT 'Offline' WHERE NOT EXISTS (SELECT 1 FROM public.master_consultation_type WHERE consultation_type = 'Offline');


--------------------------------------------------------------------------------------------------

ALTER TABLE public.master_hospital ADD COLUMN rating numeric(3,2)
alter TABLE public.master_hospital add constraint ck_master_hospital_rating	check (rating between 1 and 5)
ADD COLUMN next_open TIMESTAMP;
ADD COLUMN timing_from TIME,
ADD COLUMN timing_to TIME,
ADD COLUMN is_24x7 BOOLEAN;


ALTER TABLE doctor_profile
ADD COLUMN hospital_id BIGINT REFERENCES master_hospital(id),
ADD COLUMN consultation_type_id INT REFERENCES master_consultation_type(id);


-----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.service_requests
(
    id BIGSERIAL NOT NULL,
    user_id BIGINT NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    doctor_id BIGINT,
    lab_id BIGINT,
    pharmacy_id BIGINT,
    upload_prescription VARCHAR(500),
    delivery_address VARCHAR(255),
    special_instructions VARCHAR(255),
    status VARCHAR(50) DEFAULT 'PENDING',
    created_date TIMESTAMP DEFAULT now(),
CONSTRAINT pk_service_requests_id PRIMARY KEY (id),
CONSTRAINT fk_service_requests_user_id FOREIGN KEY (user_id) REFERENCES user_registration(id),
CONSTRAINT fk_service_requests_doctor_id FOREIGN KEY (doctor_id) REFERENCES doctor_profile(id),
CONSTRAINT fk_service_requests_lab_id FOREIGN KEY (lab_id)REFERENCES available_labs(id),
CONSTRAINT fk_service_requests_pharmacy_id FOREIGN KEY (pharmacy_id)REFERENCES available_pharmacies(id),
CONSTRAINT ck_service_requests_service_type CHECK (service_type IN ('DOCTOR','LAB','PHARMACY')),
CONSTRAINT ck_service_requests_one_service_only CHECK (
            (doctor_id IS NOT NULL AND lab_id IS NULL AND pharmacy_id IS NULL)
         OR (doctor_id IS NULL AND lab_id IS NOT NULL AND pharmacy_id IS NULL)
         OR (doctor_id IS NULL AND lab_id IS NULL AND pharmacy_id IS NOT NULL)
        )
);
--------------------------------------------------------------------------------
ALTER TABLE appointments
ADD COLUMN service_request_id BIGINT REFERENCES service_requests(id);

ALTER TABLE appointments
ADD COLUMN hospital_id BIGINT REFERENCES master_hospital(id);

ALTER TABLE appointments
ADD COLUMN status VARCHAR(50) DEFAULT 'PENDING';

ALTER TABLE appointments
ADD CONSTRAINT ck_appointments_status CHECK (status IN ('PENDING','CONFIRMED','CANCELLED'));



-------------------------------------------------------------------------
------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.payments (
    id BIGSERIAL NOT NULL,
    service_request_id BIGINT NOT NULL,
    appointment_id BIGINT,
    user_id BIGINT NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(50) DEFAULT 'PENDING',
    transaction_id VARCHAR(100),
    remarks VARCHAR(255),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    CONSTRAINT pk_payments_id PRIMARY KEY (id),
    CONSTRAINT fk_payments_service_request_id FOREIGN KEY (service_request_id) REFERENCES service_requests(id),
    CONSTRAINT fk_payments_appointment_id FOREIGN KEY (appointment_id) REFERENCES appointments(id),
    CONSTRAINT fk_payments_user_id FOREIGN KEY (user_id) REFERENCES user_registration(id),
    CONSTRAINT ck_payments_method CHECK (payment_method IN ('CARD','UPI','CASH')),
    CONSTRAINT ck_payments_status CHECK (payment_status IN ('PENDING','CONFIRMED','FAILED','SUCCESS')),
    CONSTRAINT uk_payments_transaction UNIQUE (transaction_id)
);


--------------------------------------- 2 feb 2026 -- lavanya

select * from exam_schedule
select * from exam_notification_log
select * from exam_reminder_settings
select * from exam_invigilation_assignment


select * from public.institution_branch

ALTER TABLE institution_branch ADD CONSTRAINT uq_branch_name_per_institution UNIQUE (institution_id, branch_name);
ALTER TABLE student_profile DROP CONSTRAINT fk_student_profile_branch_name;
ALTER TABLE institution_branch DROP CONSTRAINT uq_institution_branch_branch_name;


create table if not exists payroll_period (
    id bigserial not null,
    month varchar not null,
    year int not null,
    start_date timestamp,
    end_date timestamp,
    created_by bigint,
    created_date timestamp default now(),
    modified_by bigint,
    modified_date timestamp,
    is_active boolean default true,
    constraint pk_payroll_period_id primary key (id)
);


create table if not exists salary_overview (
    id bigserial not null,
    payroll_period_id bigint not null,
    total_net_disbursement numeric(12,2) not null,
    gross_earnings numeric(12,2) not null,
    total_deductions numeric(12,2) not null,
    staff_count int,
    status varchar, -- disbursed / pending
    created_by bigint,
    created_date timestamp default now(),
    modified_by bigint,
    modified_date timestamp,
    is_active boolean default true,
    constraint pk_salary_overview_id primary key (id),
    constraint fk_salary_overview_payroll_period_id foreign key (payroll_period_id) references payroll_period(id)
);

create table if not exists salary_earnings (
    id bigserial not null,
    salary_overview_id bigint not null,
	basic_salary numeric(10,2),
	hra numeric(10,2),
	medical numeric(10,2),
	conveyance numeric(10,2),
	gross_earnings numeric(12,2),
    created_by bigint,
    created_date timestamp default now(),
    modified_by bigint,
    modified_date timestamp,
    is_active boolean default true,
    constraint pk_salary_earnings_id primary key (id),
    constraint fk_salary_earnings_salary_overview_id foreign key (salary_overview_id) references salary_overview(id)
);


create table if not exists salary_deductions (
    id bigserial not null,
    salary_overview_id bigint not null,
	pf numeric(10,2),
	professional_tax numeric(10,2),
	insurance numeric(10,2),
    total_deduction numeric(10,2) not null, 
    created_by bigint,
    created_date timestamp default now(),
    modified_by bigint,
    modified_date timestamp,
    is_active boolean default true,
    constraint pk_salary_deductions_id primary key (id),
    constraint fk_salary_deductions_salary_overview_id foreign key (salary_overview_id) references salary_overview(id)
);

------------------------------- 3rd_feb_2026 dhanusha
drop table salary_deductions
drop table salary_earnings
 drop table salary_overview
 
create table if not exists salary_earnings (
    id bigserial not null,
    payroll_period_id bigint not null,
	total_net_disbursement numeric(12,2) not null,
    staff_count int,
    status varchar, -- disbursed / pending
	basic_salary numeric(10,2),
	hra numeric(10,2),
	medical numeric(10,2),
	conveyance numeric(10,2),
	gross_earnings numeric(12,2),
	pf numeric(10,2),
	professional_tax numeric(10,2),
	insurance numeric(10,2),
    total_deduction numeric(10,2) not null, 
    created_by bigint,
    created_date timestamp default now(),
    modified_by bigint,
    modified_date timestamp,
    is_active boolean default true,
    constraint pk_salary_earnings_id primary key (id),
    constraint fk_salary_earnings_payroll_period_id foreign key (payroll_period_id) references payroll_period(id)

);
----------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.master_lab_specialization (
    id SERIAL not null,
    specialization_name VARCHAR(100) NOT NULL UNIQUE,
    description varchar(255),
    is_active BOOLEAN DEFAULT TRUE,
	constraint pk_master_lab_specialization_id primary key (id)
);
============
INSERT INTO public.master_lab_specialization (specialization_name, description)
VALUES 
('Pathology', 'Blood, urine, and tissue testing'),
('Radiology', 'X-ray, MRI, CT scans'),
('Microbiology', 'Infection and bacteria testing'),
('Biochemistry', 'Chemical analysis of body fluids'),
('Genetics', 'DNA and genetic testing');

==================================================

ALTER TABLE public.available_labs ADD COLUMN specialization_id INTEGER;

ALTER TABLE public.available_labs
ADD CONSTRAINT fk_available_labs_specialization_id
FOREIGN KEY (specialization_id)
REFERENCES public.master_lab_specialization(id);

ALTER TABLE public.available_labs ADD COLUMN fees_per_test NUMERIC(10,2);
ALTER TABLE public.available_labs
ADD COLUMN IF NOT EXISTS specialization_id INTEGER,
ADD COLUMN IF NOT EXISTS fees_per_test NUMERIC(10,2),
ADD COLUMN IF NOT EXISTS available_from TIME,
ADD COLUMN IF NOT EXISTS available_to TIME,
ADD COLUMN IF NOT EXISTS estimated_delivery VARCHAR(50),
ADD COLUMN IF NOT EXISTS latitude NUMERIC(9,6),
ADD COLUMN IF NOT EXISTS longitude NUMERIC(9,6),
ADD COLUMN IF NOT EXISTS home_collection BOOLEAN DEFAULT FALSE;
ALTER TABLE public.available_labs ADD COLUMN is_available BOOLEAN DEFAULT TRUE;
===============================

ALTER TABLE public.doctor_profile DROP CONSTRAINT ck_doctor_profile_rating;
ALTER TABLE public.doctor_profile ALTER COLUMN rating TYPE NUMERIC(3,2) USING rating::NUMERIC;
alter table public.doctor_profile add constraint ck_public.doctor_profile_rating check (rating between 1 and 5);

------------------------------------------4/2/2026 dhanusha 
CREATE TABLE IF NOT EXISTS public.master_mechanic
(
    id BIGSERIAL not null,
    garage_id BIGINT NOT NULL,              -- FK to master_garage
    user_id BIGINT NOT NULL,                -- FK to user_registration (mechanic profile)
    rating NUMERIC(3,2),                -- average rating from feedback
    is_active BOOLEAN DEFAULT TRUE,         -- active/inactive mechanic
    created_date TIMESTAMP DEFAULT now(),
    modified_date TIMESTAMP,
constraint pk_master_mechanic_id primary key (id),
CONSTRAINT uk_mechanic_garage_garage_id_user_id UNIQUE (garage_id, user_id),
CONSTRAINT fk_master_mechanic_garage_id FOREIGN KEY (garage_id) REFERENCES public.master_garage (id),
CONSTRAINT fk_master_mechanic_user_id FOREIGN KEY (user_id) REFERENCES public.user_registration (id)
);

ALTER TABLE master_mechanic ADD COLUMN mechanic_name varchar(255);
UPDATE master_mechanic m
SET mechanic_name = CONCAT_WS(' ', u.first_name, u.last_name)
FROM user_registration u
WHERE m.user_id = u.id;


alter table freelancer_task_history add column home_service_booking_id bigint;
CREATE TABLE IF NOT EXISTS public.home_service_booking (
    id BIGSERIAL NOT NULL,

    -- Service Hierarchy
    module_id BIGINT NOT NULL,
    sub_module_id BIGINT NOT NULL,
    service_id BIGINT NOT NULL,
    sub_service_id BIGINT NOT NULL,

    -- Customer Info
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL,
    mobile VARCHAR(255) NOT NULL,

    -- Address & Location
    address VARCHAR(500) NOT NULL,
    others_address VARCHAR(255),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),

    -- Booking Details
    preferred_date DATE NOT NULL,
    time_slot_id INTEGER,
    extra_hours INTEGER DEFAULT 0,
    bhk_type_id INT,
    brand_id INT,
    fule_id INT,
    garage_id INT,
    garage_service_id INT,
    mechanic_id INT,
    special_instructions VARCHAR(500),

    -- Services & Media
    service_summary JSONB NOT NULL,
    upload_photos VARCHAR(500),

    -- Payment
    total_amount NUMERIC(10,2) NOT NULL,
    payment_done BOOLEAN,

    -- Status & Audit
    status_id INTEGER,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,

    CONSTRAINT pk_home_service_booking_id PRIMARY KEY (id),

    -- Foreign Keys
    CONSTRAINT fk_booking_module_id FOREIGN KEY (module_id) REFERENCES public.master_module(id),
    CONSTRAINT fk_booking_sub_module_id FOREIGN KEY (sub_module_id) REFERENCES public.master_sub_module(id),
    CONSTRAINT fk_booking_service_id FOREIGN KEY (service_id) REFERENCES public.master_service(id),
    CONSTRAINT fk_booking_sub_service_id FOREIGN KEY (sub_service_id) REFERENCES public.master_sub_service(id),
    CONSTRAINT fk_booking_time_slot_id FOREIGN KEY (time_slot_id) REFERENCES public.master_time_slot(id),
    CONSTRAINT fk_booking_status_id FOREIGN KEY (status_id) REFERENCES public.master_status(id),
    CONSTRAINT fk_booking_created_by FOREIGN KEY (created_by) REFERENCES public.user_registration(id),
    CONSTRAINT fk_booking_modified_by FOREIGN KEY (modified_by) REFERENCES public.user_registration(id),
    CONSTRAINT fk_booking_bhk_type_id FOREIGN KEY (bhk_type_id) REFERENCES public.master_bhk_type(id),
    CONSTRAINT fk_booking_brand_id FOREIGN KEY (brand_id) REFERENCES public.master_vehicle_brand(id),
    CONSTRAINT fk_booking_fuel_id FOREIGN KEY (fule_id) REFERENCES public.master_fuel_type(id),
    CONSTRAINT fk_booking_garage_id FOREIGN KEY (garage_id) REFERENCES public.master_garage(id),
    CONSTRAINT fk_booking_garage_service_id FOREIGN KEY (garage_service_id) REFERENCES public.master_garage_service(id),
    CONSTRAINT fk_booking_mechanic_id FOREIGN KEY (mechanic_id) REFERENCES public.master_mechanic(id),

    -- Uniqueness to prevent duplicate bookings for same config
    CONSTRAINT uq_booking_vehicle_combo UNIQUE (
        sub_service_id,
        brand_id,
        fule_id,
        garage_id,
        garage_service_id,
        mechanic_id
    )
);

ALTER TABLE public.home_service_booking ADD COLUMN convenience_fee NUMERIC(10,2) DEFAULT 0;
ALTER TABLE public.home_service_booking ADD COLUMN payment_id BIGINT;

ALTER TABLE public.home_service_booking
ADD CONSTRAINT fk_booking_payment_id FOREIGN KEY (payment_id) REFERENCES public.home_service_payment(id);
 
ALTER TABLE public.home_service_booking ADD COLUMN item_total NUMERIC(10,2) DEFAULT 0;

ALTER TABLE public.home_service_booking RENAME COLUMN payment_id TO home_service_payment_id;

============================================================

CREATE TABLE IF NOT EXISTS public.home_service_booking_add_on (
    id BIGSERIAL PRIMARY KEY,
    home_service_booking_id INTEGER NOT NULL,
    add_on_id INTEGER NOT NULL,
    duration_id INTEGER,
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,

    CONSTRAINT fk_booking_add_on_booking_id FOREIGN KEY (home_service_booking_id)
        REFERENCES public.home_service_booking(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_booking_add_on_id FOREIGN KEY (add_on_id)
        REFERENCES public.master_package_add_on(id),
    CONSTRAINT fk_booking_add_on_duration_id FOREIGN KEY (duration_id)
        REFERENCES public.master_duration(id),
    CONSTRAINT fk_booking_add_on_created_by FOREIGN KEY (created_by)
        REFERENCES public.user_registration(id),
    CONSTRAINT fk_booking_add_on_modified_by FOREIGN KEY (modified_by)
        REFERENCES public.user_registration(id),
    CONSTRAINT uq_booking_add_on_unique_combo UNIQUE (home_service_booking_id, add_on_id)
);
CREATE TABLE IF NOT EXISTS public.home_service_payment (
    id BIGSERIAL NOT NULL,
    booking_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    payment_mode VARCHAR(100),         -- UPI, Card, Netbanking, etc.
    payment_gateway VARCHAR(100),      -- Razorpay, Paytm, etc.
    transaction_id VARCHAR(255),       -- Gateway transaction reference
    item_total NUMERIC(10,2) NOT NULL,
    convenience_fee NUMERIC(10,2) DEFAULT 0,
    total_paid NUMERIC(10,2) NOT NULL,
    payment_status VARCHAR(50),        -- SUCCESS, FAILED, PENDING
    payment_date TIMESTAMP DEFAULT now(),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
 CONSTRAINT pk_home_service_payment_id PRIMARY KEY (id),
CONSTRAINT fk_payment_booking_id FOREIGN KEY (booking_id) REFERENCES public.home_service_booking(id),
 CONSTRAINT fk_payment_user_id FOREIGN KEY (user_id) REFERENCES public.user_registration(id),
CONSTRAINT fk_payment_created_by FOREIGN KEY (created_by) REFERENCES public.user_registration(id),
CONSTRAINT fk_payment_modified_by FOREIGN KEY (modified_by) REFERENCES public.user_registration(id),
CONSTRAINT uk_home_service_payment_transaction_id UNIQUE (transaction_id)
);

========================================================

CREATE TABLE IF NOT EXISTS public.home_service_booking_service_map (
    id BIGSERIAL PRIMARY KEY,
    home_service_booking_id BIGINT NOT NULL,
    garage_service_id BIGINT NOT NULL,
    quantity INTEGER DEFAULT 1,
    service_price NUMERIC(10,2),
    created_by BIGINT,
    created_date TIMESTAMP DEFAULT now(),
    modified_by BIGINT,
    modified_date TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,

    CONSTRAINT uq_booking_service UNIQUE (home_service_booking_id, garage_service_id),

    CONSTRAINT fk_booking_service_booking_id FOREIGN KEY (home_service_booking_id)
        REFERENCES public.home_service_booking(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_booking_service_garage_service_id FOREIGN KEY (garage_service_id)
        REFERENCES public.master_garage_service(id),

    CONSTRAINT fk_booking_service_created_by FOREIGN KEY (created_by)
        REFERENCES public.user_registration(id),

    CONSTRAINT fk_booking_service_modified_by FOREIGN KEY (modified_by)
        REFERENCES public.user_registration(id)
);
=============================================================lavanya

update master_sub_module set sub_module_name = 'Cleaning Services' where id =1;
delete from master_service where id =9;

INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Pipe Leakage',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Pipe Leakage' AND service_id=4);
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Tap Fixing',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Tap Fixing' AND service_id=4);
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Bathroom Fitting',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Bathroom Fitting' AND service_id=4);
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Water Tank Cleaning',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Water Tank Cleaning' AND service_id=4);
============================
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Interior Painting',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Interior Painting' AND service_id=5);
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Exterior Painting',5 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Exterior Painting' AND service_id=5);
=============================
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Wiring',6 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Wiring' AND service_id=6);
INSERT INTO public.master_sub_service (sub_service_name,service_id) SELECT 'Fan Repair',6 WHERE NOT EXISTS (SELECT 1 FROM public.master_sub_service WHERE sub_service_name='Fan Repair' AND service_id=6);
==============================
alter table  appointments add column call_booking_status varchar(255);

alter table  master_add_on rename column add_on to packages_add_on;
alter table  master_add_on add column sub_service_id int;
alter table  master_add_on add constraint fk_master_add_on_sub_service_id foreign key (sub_service_id) references master_sub_service(id);
alter table master_add_on add constraint uk_master_add_on_sub_service_id_packages_add_on unique (sub_service_id,packages_add_on);

update master_add_on set packages_add_on = 'Chimney Cleaning',price = 799 ,sub_service_id =  1 where id =1;
update master_add_on set packages_add_on = 'Complete Kitchen Deep Cleaning',price = 1499 ,sub_service_id =  1 where id =2;
update master_add_on set packages_add_on = 'Fridge Deep Cleaning',price = 499 ,sub_service_id =  1 where id =3;
===========
update master_add_on set packages_add_on = 'Intense Bathroom Cleaning',price = 599 ,sub_service_id =  2 where id =4;
update master_add_on set packages_add_on = 'Bathroom Sanitization',price = 299 ,sub_service_id =  2 where id =5;
==============
update master_add_on set packages_add_on = '3-Seater Sofa Cleaning',price = 599 ,sub_service_id =  3 where id =6;
update master_add_on set packages_add_on = '5-Seater Sofa Cleaning',price = 899 ,sub_service_id =  3 where id =7;
INSERT INTO master_add_on (packages_add_on,price,sub_service_id) SELECT 'Cushion Cleaning(Set of 5)',199,3 WHERE NOT EXISTS (SELECT 1 FROM master_add_on WHERE packages_add_on='Cushion Cleaning(Set of 5)' AND sub_service_id=3);
