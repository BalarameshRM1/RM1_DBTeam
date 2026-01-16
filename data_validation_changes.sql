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