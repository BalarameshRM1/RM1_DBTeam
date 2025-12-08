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