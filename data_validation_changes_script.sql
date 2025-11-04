--Authored by Anand A on 09-10-2025.
create database swachify_dev;

--DROP TABLE master_role;
create table if not exists public.master_role(id serial not null,
role_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_role_id primary key(id),
constraint uk_master_role_role_name unique(role_name));

insert into public.master_role (role_name) SELECT 'Super Admin' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Super Admin');
insert into public.master_role (role_name) SELECT 'Admin' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Admin');
insert into public.master_role (role_name) SELECT 'Employee' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Employee');
insert into public.master_role (role_name) SELECT 'Customer' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Customer');


create table if not exists public.master_department(id bigserial not null,
department_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_department_id primary key(id),
constraint uk_master_department_department_name unique(department_name));

INSERT INTO public.master_department (department_name) SELECT 'Kitchen' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Kitchen');
INSERT INTO public.master_department (department_name) SELECT 'Bathroom' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Bathroom');
INSERT INTO public.master_department (department_name) SELECT 'Bedroom' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Bedroom');
INSERT INTO public.master_department (department_name) SELECT 'Living Area' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Living Area');
INSERT INTO public.master_department (department_name) SELECT 'Add-ons (extra charges apply)' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Add-ons (extra charges apply)');


--DROP TABLE IF EXISTS public.master_service;
create table if not exists public.master_service(id bigserial not null,
service_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_service_id primary key(id),
constraint uk_master_service_service_name unique (service_name));

insert into public.master_service (service_name)  SELECT 'All accessible areas mopped & vacuumed' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All accessible areas mopped & vacuumed');
insert into public.master_service (service_name)  SELECT 'All surfaces, backsplash, sinks & small appliances' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All surfaces, backsplash, sinks & small appliances');
insert into public.master_service (service_name)  SELECT 'All surfaces, furniture, shelves, frames & lamps dusted' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All surfaces, furniture, shelves, frames & lamps dusted');
insert into public.master_service (service_name)  SELECT 'All surfaces, sinks & toilets cleaned & sanitized' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All surfaces, sinks & toilets cleaned & sanitized');
insert into public.master_service (service_name)  SELECT 'Additional hour' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Additional hour');
insert into public.master_service (service_name)  SELECT 'Baseboards, window sills & ceiling corners' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Baseboards, window sills & ceiling corners');
insert into public.master_service (service_name)  SELECT 'Baseboards, window tracks and ceiling corners' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Baseboards, window tracks and ceiling corners');
insert into public.master_service (service_name)  SELECT 'Build up on surfaces scrubbed' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Build up on surfaces scrubbed');
insert into public.master_service (service_name)  SELECT 'Cabinet and drawer exterior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinet and drawer exterior');
insert into public.master_service (service_name)  SELECT 'Cabinets & vanity exterior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinets & vanity exterior');
insert into public.master_service (service_name)  SELECT 'Cabinets & vanity interior cleaned (upon request)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinets & vanity interior cleaned (upon request)');
insert into public.master_service (service_name)  SELECT 'Cabinets and drawer interior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinets and drawer interior');
insert into public.master_service (service_name)  SELECT 'Door handles & switch plate covers hand wiped' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Door handles & switch plate covers hand wiped');
insert into public.master_service (service_name)  SELECT 'Door interior wiped' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Door interior wiped');
insert into public.master_service (service_name)  SELECT 'Finished basement cleaned' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Finished basement cleaned');
insert into public.master_service (service_name)  SELECT 'Inside closet floors cleaned (upon request)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Inside closet floors cleaned (upon request)');
insert into public.master_service (service_name)  SELECT 'Large appliance interior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large appliance interior');
insert into public.master_service (service_name)  SELECT 'Large appliances exterior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large appliances exterior');
insert into public.master_service (service_name)  SELECT 'Large appliances interior cleaned (per appliance)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large appliances interior cleaned (per appliance)');
insert into public.master_service (service_name)  SELECT 'Linens changed (upon request)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Linens changed (upon request)');
insert into public.master_service (service_name)  SELECT 'Linens tidied' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Linens tidied');
insert into public.master_service (service_name)  SELECT 'Microwave and rangehood interior cleaned' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Microwave and rangehood interior cleaned');
insert into public.master_service (service_name)  SELECT 'Mirrors polished' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Mirrors polished');
insert into public.master_service (service_name)  SELECT 'Open shelves & picture frames dusted' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Open shelves & picture frames dusted');
insert into public.master_service (service_name)  SELECT 'Open shelves wiped' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Open shelves wiped');
insert into public.master_service (service_name)  SELECT 'Patio doors cleaned inside & out (weather permitting)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Patio doors cleaned inside & out (weather permitting)');
insert into public.master_service (service_name)  SELECT 'Tile walls, grout, bathtubs & showers' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Tile walls, grout, bathtubs & showers');
insert into public.master_service (service_name)  SELECT 'Wastebaskets emptied & relined' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Wastebaskets emptied & relined');
insert into public.master_service (service_name)  SELECT 'Windows & blind interior cleaned (within reach)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Windows & blind interior cleaned (within reach)');
insert into public.master_service (service_name)  SELECT 'Windows & blinds interior cleaned (within reach)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Windows & blinds interior cleaned (within reach)');
insert into public.master_service (service_name)  SELECT 'Windows and blind interior (within reach)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Windows and blind interior (within reach)');

select service_name,id from public.master_service;

create table if not exists public.master_service_mapping(id serial not null,
service_id bigint not null,dept_id bigint not null,
is_active boolean default true,
constraint pk_master_service_mapping_id primary key(id),
constraint fk_master_service_mapping_service_id foreign key(service_id) references master_service(id),
constraint fk_master_service_mapping_dept_id foreign key(dept_id) references master_department(id));



insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 2,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=2 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 18,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=18 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 9,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=9 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 22,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=22 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 17,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=17 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 25,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=25 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 12,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=12 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 7,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=7 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 31,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=31 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 4,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=4 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 27,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=27 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 24,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=24 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 23,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=23 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 10,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=10 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 11,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=11 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 8,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=8 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 6,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=6 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 30,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=30 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 3,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=3 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 23,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=23 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 21,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=21 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 20,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=20 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 16,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=16 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 6,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=6 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 29,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=29 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 3,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=3 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 28,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=28 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 23,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=23 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 26,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=26 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 13,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=13 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 14,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=14 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 6,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=6 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 29,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=29 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 5,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=5 and dept_id=5);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 15,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=15 and dept_id=5);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 19,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=19 and dept_id=5);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 7,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=7 and dept_id=5);


create table if not exists public.master_slots(id serial not null,
slot_time varchar(255) not null,
is_active boolean default true,
constraint pk_master_slots_id primary key(id),
constraint uk_master_slots_slot_time unique(slot_time));

insert into public.master_slots(slot_time) SELECT '10:00-11:00' WHERE NOT EXISTS (SELECT 1 FROM public.master_slots WHERE slot_time='10:00-11:00');


create table if not exists public.master_gender(id serial not null,
gender_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_gender_id primary key(id),
constraint uk_master_gender_gender_name unique(gender_name));

INSERT INTO public.master_gender(gender_name) SELECT 'Male' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender_name='Male');
INSERT INTO public.master_gender(gender_name) SELECT 'Female' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender_name='Female');
INSERT INTO public.master_gender(gender_name) SELECT 'Others' WHERE NOT EXISTS (SELECT 1 FROM public.master_gender WHERE gender_name='Others');

--DROP TABLE IF EXISTS public.user_registration;
create table if not exists public.user_registration(id bigserial not null,
first_name varchar(255) not null,last_name varchar(255) not null,role_id integer,
email varchar(100) not null,password varchar(500) not null,dept_id bigint,
mobile varchar(15) not null,age integer,gender_id integer,created_by bigint,created_date timestamp default now(),
modified_by bigint,modified_date timestamp,is_active boolean default true,
constraint pk_user_registration_id primary key(id),
constraint uk_user_registration_email unique(email),
constraint fk_user_registration_gender_id foreign key(gender_id) references master_gender(id),
constraint fk_user_registration_dept_id foreign key(dept_id) references master_department(id),
constraint fk_user_registration_role_id foreign key(role_id) references master_role(id));


create table if not exists public.master_location(id bigserial not null,
country_name varchar(255) not null,
state_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_location_id primary key(id),
constraint uk_master_location_state_name unique(state_name));

INSERT INTO public.master_location(country_name,state_name) SELECT 'Canada','Ottawa' WHERE NOT EXISTS (SELECT 1 FROM public.master_location WHERE country_name='Canada' and state_name='Ottawa');


--DROP TABLE IF EXISTS public.customer_complaints;
create table if not exists public.customer_complaints(id bigserial not null,
user_id bigint not null,
location_id bigint,
address varchar,
description text not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_customer_complaints_id primary key(id),
constraint fk_customer_complaints_user_id foreign key(user_id) references user_registration(id),
constraint fk_customer_complaints_created_by foreign key(created_by) references user_registration(id),
constraint fk_customer_complaints_modified_by foreign key(modified_by) references user_registration(id),
constraint fk_customer_complaints_location_id foreign key(location_id) references master_location(id));


--DROP TABLE IF EXISTS public.service_booking;
create table if not exists public.service_booking(id bigserial not null,
booking_id varchar(100),
dept_id bigint not null,
service_id bigint not null,
slot_id int not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_service_booking_id primary key(id),
constraint fk_service_booking_dept_id foreign key(dept_id) references master_department(id),
constraint fk_service_booking_service_id foreign key(service_id) references master_service(id),
constraint fk_service_booking_slot_id foreign key(slot_id) references master_slots(id),
constraint fk_customer_complaints_created_by foreign key(created_by) references user_registration(id),
constraint fk_customer_complaints_modified_by foreign key(modified_by) references user_registration(id));

alter table if exists public.user_registration add column if not exists location_id bigint;
alter table if exists public.user_registration add constraint fk_user_registration_location_id foreign key(location_id) references public.master_location(id);


create table if not exists public.user_auth(id bigserial not null,
user_id bigint not null,
login_name varchar(100) not null,
password varchar(500) not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_user_auth_id primary key(id),
constraint fk_user_auth_user_id foreign key(user_id) references public.user_registration(id),
constraint fk_user_auth_created_by foreign key(created_by) references public.user_registration(id),
constraint fk_user_auth_modified_by foreign key(modified_by) references public.user_registration(id));
----------------------------
--Author by Anand on 17-10-2025.
alter table if exists master_service add column if not exists regular numeric(10,2);
alter table if exists master_service add column if not exists premium numeric(10,2);
alter table if exists master_service add column if not exists ultimate numeric(10,2);

truncate table master_service_mapping restart identity;
delete from master_service;
delete from master_department;
select * from master_department;
select setval('master_service_id_seq',(select max(id)+1 from master_service));
select setval('master_department_id_seq',(select max(id)+1 from master_department));
alter sequence master_department_id_seq restart with 1;
alter sequence master_service_id_seq restart with 1;

alter table if exists user_registration add column if not exists service_id integer;
alter table if exists user_registration add constraint fk_user_registration_service_id foreign key(service_id) references master_service(id);
---
INSERT INTO public.master_department (department_name) SELECT  'Cleaning & Pest Control' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name = 'Cleaning & Pest Control');
INSERT INTO public.master_department (department_name) SELECT  'Electrician, Plumber & Carpenter' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE  department_name = 'Electrician, Plumber & Carpenter');
INSERT INTO public.master_department (department_name) SELECT  'Painting & Waterproofing' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE  department_name = 'Painting & Waterproofing');
INSERT INTO public.master_department (department_name) SELECT  'AC & Appliances' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE  department_name = 'AC & Appliances');
--
INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 1, 'Bed Room', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Bed Room');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 2, 'Bath Room', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Bath Room');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 3, 'Kitchen', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Kitchen');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 4, 'Living Area', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Living Area');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 5, 'Sofa & Carpet', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Sofa & Carpet');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 6, 'Pest Control', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Pest Control');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 7, 'Switch & Sockets', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Switch & Sockets');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 8, 'Fan', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Fan');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 9, 'Wiring', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Wiring');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 10, 'Bath Fitting', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Bath Fitting');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 11, 'Sink & Basin', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Sink & Basin');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 12, 'Carpenter', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Carpenter');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 13, 'Full House Painting', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Full House Painting');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 14, 'Room Painting', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Room Painting');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 15, 'Exterior Painting', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Exterior Painting');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 16, 'Water Proofing', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Water Proofing');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 17, 'AC Service & Repair', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'AC Service & Repair');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 18, 'Refrigerator Repair', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Refrigerator Repair');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 19, 'Washing Machine Repair', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Washing Machine Repair');

INSERT INTO public.master_service (id, service_name, is_active, regular, premium, ultimate)
SELECT 20, 'Microwave Repair', true, '49.00', '79.00', '109.00'
WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name = 'Microwave Repair');
--
INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 1, 1, 1, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 1);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 2, 2, 1, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 2);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 3, 3, 1, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 3);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 4, 4, 1, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 4);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 5, 5, 1, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 5);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 6, 6, 1, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 6);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 7, 7, 2, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 7);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 8, 8, 2, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 8);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 9, 9, 2, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 9);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 10, 10, 2, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 10);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 11, 11, 2, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 11);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 12, 12, 2, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 12);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 13, 13, 3, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 13);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 14, 14, 3, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 14);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 15, 15, 3, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 15);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 16, 16, 3, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 16);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 17, 17, 4, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 17);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 18, 18, 4, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 18);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 19, 19, 4, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 19);

INSERT INTO public.master_service_mapping (id, service_id, dept_id, is_active)
SELECT 20, 20, 4, true
WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE id = 20);
---
alter table if exists user_registration drop column if exists password;
alter table if exists user_auth rename column login_name to email;
drop table if exists master_location;
truncate table master_location restart identity;
select * from master_location;
alter table if exists user_registration drop constraint fk_user_registration_location_id;
alter table if exists customer_complaints drop constraint fk_customer_complaints_location_id;

create table if not exists master_location(id serial not null,
location_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_location_id primary key(id),
constraint uk_master_location_location_name unique(location_name));

INSERT INTO public.master_location(location_name) SELECT 'Delhi' WHERE NOT EXISTS (SELECT 1 FROM public.master_location WHERE location_name = 'Delhi');
INSERT INTO public.master_location(location_name) SELECT 'Hyderabad' WHERE NOT EXISTS (SELECT 1 FROM public.master_location WHERE location_name = 'Hyderabad');
INSERT INTO public.master_location(location_name) SELECT 'Bangalore' WHERE NOT EXISTS (SELECT 1 FROM public.master_location WHERE location_name = 'Bangalore');
INSERT INTO public.master_location(location_name) SELECT 'Chennai' WHERE NOT EXISTS (SELECT 1 FROM public.master_location WHERE location_name = 'Chennai');

alter table if exists user_registration add constraint fk_user_registration_location_id foreign key(location_id) references master_location(id);
alter table if exists customer_complaints add constraint fk_customer_complaints_location_id foreign key(location_id) references master_location(id);

alter table if exists service_booking add column if not exists preferred_date date;

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 1, 'Anand', 'Akula', 3, 'anand.akula@gmail.com', 1, '7908674521', 28, 1, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 1, 5
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 1);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 2, 'Sahitha', 'Cheekatla', 3, 'sahitha.cheekatla@gmail.com', 2, '7638963458', 26, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 4, 12
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 2);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 3, 'Dhanusha', 'Nimmagadda', 3, 'dhanusha.nimmagadda@gmail.com', 4, '6890267832', 26, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 2, 17
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 3);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 4, 'Manvitha', 'Korlepara', 3, 'manvitha.korlepara@gmail.com', 3, '8936292649', 25, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 2, 15
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 4);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 5, 'Krishna', 'Nimmagadda', 3, 'krishna.nimmagadda@gmail.com', 4, '9835637282', 25, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 4, 19
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 5);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 6, 'Nikhitha', 'Punjala', 3, 'nikhitha.punjala@gmail.com', 4, '8472827562', 28, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 3, 18
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 6);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 7, 'Nandhini', 'Siva', 3, 'nandhini.siva@gmail.com', 4, '6472815492', 25, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 1, 17
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 7);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 8, 'Priya', 'Batchu', 3, 'priya.batchu@gmail.com', 2, '7829180124', 30, 2, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 3, 8
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 8);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 9, 'Hari', 'Kingumahanthi', 3, 'hari.kingumahanthi@gmail.com', 3, '8282752917', 34, 1, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 2, 14
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 9);

INSERT INTO public.user_registration (id, first_name, last_name, role_id, email, dept_id, mobile, age, gender_id, created_by, created_date, modified_by, modified_date, is_active, location_id, service_id)
SELECT 10, 'Bala', 'Kollu', 3, 'bala.kollu@gmail.com', 1, '9472562284', 27, 1, NULL, '2025-10-17 17:01:55.692082', NULL, NULL, true, 2, 4
WHERE NOT EXISTS (SELECT 1 FROM public.user_registration WHERE id = 10);
---
alter table if exists user_registration alter column service_id type bigint;
----
truncate table master_slots restart identity;

alter table if exists service_booking drop constraint fk_service_booking_slot_id;

select * from master_slots;

INSERT INTO public.master_slots (slot_time)
SELECT '9AM - 11AM'
WHERE NOT EXISTS (SELECT 1 FROM public.master_slots WHERE slot_time = '9AM - 11AM');

INSERT INTO public.master_slots (slot_time)
SELECT '11AM - 1 PM'
WHERE NOT EXISTS (SELECT 1 FROM public.master_slots WHERE slot_time = '11AM - 1 PM');

INSERT INTO public.master_slots (slot_time)
SELECT '1PM - 3PM'
WHERE NOT EXISTS (SELECT 1 FROM public.master_slots WHERE slot_time = '1PM - 3PM');

INSERT INTO public.master_slots (slot_time)
SELECT '3PM - 5 PM'
WHERE NOT EXISTS (SELECT 1 FROM public.master_slots WHERE slot_time = '3PM - 5 PM');

alter table if exists service_booking add constraint fk_service_booking_slot_id foreign key(slot_id) references master_slots(id);
---------------------------------
--Authored by Anand A on 21-10-2025.
create table if not exists otp_history(id bigserial not null,
otp bigint not null,
user_id bigint not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_otp_history_id primary key(id),
constraint fk_otp_history_user_id foreign key(user_id) references user_registration(id),
constraint fk_otp_history_created_by foreign key(created_by) references user_registration(id),
constraint fk_otp_history_modified_by foreign key(modified_by) references user_registration(id));


select * from otp_history;

select * from user_registration where id=17;

select * from user_registration ur
join user_auth ua on 

select * from master_role;

update user_registration set role_id=1,email='superadminswachify@gmail.com',first_name='Swachify',last_name='Super Admin',mobile='9807654073',gender_id=1 where id = 17;

select * from user_auth where user_id=17;

update user_auth set email='superadminswachify@gmail.com' where user_id=17;

select * from master_service;

truncate table  master_department restart identity;
truncate table  master_service restart identity;
truncate table  master_service_mapping restart identity;


delete from master_service;
alter sequence master_service_id_seq restart with 1;

delete from service_booking where service_id in 
(select id from master_service);

delete from user_registration where service_id in 
(select id from master_service);

delete from master_department;
alter sequence master_department_id_seq restart with 1;

INSERT INTO public.master_department (department_name) SELECT 'Kitchen' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Kitchen');
INSERT INTO public.master_department (department_name) SELECT 'Bathroom' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Bathroom');
INSERT INTO public.master_department (department_name) SELECT 'Bedroom' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Bedroom');
INSERT INTO public.master_department (department_name) SELECT 'Living Area' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Living Area');
INSERT INTO public.master_department (department_name) SELECT 'Add-ons (extra charges apply)' WHERE NOT EXISTS (SELECT 1 FROM public.master_department WHERE department_name='Add-ons (extra charges apply)');

insert into public.master_service (service_name)  SELECT 'All accessible areas mopped & vacuumed' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All accessible areas mopped & vacuumed');
insert into public.master_service (service_name)  SELECT 'All surfaces, backsplash, sinks & small appliances' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All surfaces, backsplash, sinks & small appliances');
insert into public.master_service (service_name)  SELECT 'All surfaces, furniture, shelves, frames & lamps dusted' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All surfaces, furniture, shelves, frames & lamps dusted');
insert into public.master_service (service_name)  SELECT 'All surfaces, sinks & toilets cleaned & sanitized' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='All surfaces, sinks & toilets cleaned & sanitized');
insert into public.master_service (service_name)  SELECT 'Additional hour' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Additional hour');
insert into public.master_service (service_name)  SELECT 'Baseboards, window sills & ceiling corners' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Baseboards, window sills & ceiling corners');
insert into public.master_service (service_name)  SELECT 'Baseboards, window tracks and ceiling corners' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Baseboards, window tracks and ceiling corners');
insert into public.master_service (service_name)  SELECT 'Build up on surfaces scrubbed' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Build up on surfaces scrubbed');
insert into public.master_service (service_name)  SELECT 'Cabinet and drawer exterior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinet and drawer exterior');
insert into public.master_service (service_name)  SELECT 'Cabinets & vanity exterior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinets & vanity exterior');
insert into public.master_service (service_name)  SELECT 'Cabinets & vanity interior cleaned (upon request)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinets & vanity interior cleaned (upon request)');
insert into public.master_service (service_name)  SELECT 'Cabinets and drawer interior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Cabinets and drawer interior');
insert into public.master_service (service_name)  SELECT 'Door handles & switch plate covers hand wiped' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Door handles & switch plate covers hand wiped');
insert into public.master_service (service_name)  SELECT 'Door interior wiped' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Door interior wiped');
insert into public.master_service (service_name)  SELECT 'Finished basement cleaned' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Finished basement cleaned');
insert into public.master_service (service_name)  SELECT 'Inside closet floors cleaned (upon request)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Inside closet floors cleaned (upon request)');
insert into public.master_service (service_name)  SELECT 'Large appliance interior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large appliance interior');
insert into public.master_service (service_name)  SELECT 'Large appliances exterior' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large appliances exterior');
insert into public.master_service (service_name)  SELECT 'Large appliances interior cleaned (per appliance)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large appliances interior cleaned (per appliance)');
insert into public.master_service (service_name)  SELECT 'Linens changed (upon request)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Linens changed (upon request)');
insert into public.master_service (service_name)  SELECT 'Linens tidied' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Linens tidied');
insert into public.master_service (service_name)  SELECT 'Microwave and rangehood interior cleaned' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Microwave and rangehood interior cleaned');
insert into public.master_service (service_name)  SELECT 'Mirrors polished' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Mirrors polished');
insert into public.master_service (service_name)  SELECT 'Open shelves & picture frames dusted' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Open shelves & picture frames dusted');
insert into public.master_service (service_name)  SELECT 'Open shelves wiped' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Open shelves wiped');
insert into public.master_service (service_name)  SELECT 'Patio doors cleaned inside & out (weather permitting)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Patio doors cleaned inside & out (weather permitting)');
insert into public.master_service (service_name)  SELECT 'Tile walls, grout, bathtubs & showers' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Tile walls, grout, bathtubs & showers');
insert into public.master_service (service_name)  SELECT 'Wastebaskets emptied & relined' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Wastebaskets emptied & relined');
insert into public.master_service (service_name)  SELECT 'Windows & blind interior cleaned (within reach)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Windows & blind interior cleaned (within reach)');
insert into public.master_service (service_name)  SELECT 'Windows & blinds interior cleaned (within reach)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Windows & blinds interior cleaned (within reach)');
insert into public.master_service (service_name)  SELECT 'Windows and blind interior (within reach)' WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Windows and blind interior (within reach)');

update master_service set regular=49.00,premium=79.00,ultimate=109.00;

alter table if exists master_service add column if not exists is_regular boolean;
alter table if exists master_service add column if not exists is_premium boolean;
alter table if exists master_service add column if not exists is_ultimate boolean;


insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 2,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=2 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 18,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=18 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 9,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=9 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 22,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=22 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 17,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=17 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 25,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=25 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 12,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=12 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 7,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=7 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 31,1  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=31 and dept_id=1);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 4,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=4 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 27,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=27 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 24,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=24 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 23,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=23 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 10,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=10 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 11,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=11 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 8,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=8 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 6,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=6 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 30,2  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=30 and dept_id=2);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 3,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=3 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 23,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=23 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 21,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=21 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 20,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=20 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 16,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=16 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 6,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=6 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 29,3  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=29 and dept_id=3);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 1,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=1 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 3,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=3 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 28,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=28 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 23,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=23 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 26,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=26 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 13,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=13 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 14,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=14 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 6,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=6 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 29,4  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=29 and dept_id=4);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 5,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=5 and dept_id=5);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 15,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=15 and dept_id=5);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 19,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=19 and dept_id=5);
insert into public.master_service_mapping (service_id,dept_id)  SELECT 7,5  WHERE NOT EXISTS (SELECT 1 FROM public.master_service_mapping WHERE service_id=7 and dept_id=5);


select msm.dept_id,md.department_name,msm.service_id,ms.service_name
from master_service_mapping msm  
left join master_service ms on ms.id = msm.service_id
left join  master_department md on md.id = msm.dept_id
order by 3,1;

update master_service set is_regular=true where id in (1,2,23);
update master_service set is_regular=false where id not in (1,2,23);

update master_service set is_premium=true where id in (1,2,23,28);
update master_service set is_premium=false where id not in (1,2,23,28);

update master_service set is_ultimate=false where id in (5,15,19,7);
update master_service set is_ultimate=true where id not in (5,15,19,7);


create table if not exists user_department(id bigserial not null,
user_id bigint not null,
dept_id bigint not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_user_department_id primary key(id),
constraint fk_user_department_user_id foreign key(user_id) references user_registration(id),
constraint fk_user_department_dept_id foreign key(dept_id) references master_department(id),
constraint fk_user_department_created_by foreign key(created_by) references user_registration(id),
constraint fk_user_department_modified_by foreign key(modified_by) references user_registration(id),
constraint uk_user_department_dept_id_user_id unique(dept_id,user_id));

alter table if exists service_booking add column if not exists full_name  varchar(255);  
alter table if exists service_booking add column if not exists phone  varchar(15); 
alter table if exists service_booking add column if not exists email  varchar(100); 
alter table if exists service_booking add column if not exists address  varchar(500); 

select * from service_booking;

create table if not exists master_status(id bigserial not null,
status varchar(255) not null,
is_active boolean default true,
constraint pk_master_status_id primary key(id),
constraint uk_master_status_status unique(status));

insert into master_status(status) select 'Open' where not exists (select 1 from master_status where status='Open');
insert into master_status(status) select 'Pending' where not exists (select 1 from master_status where status='Pending');
insert into master_status(status) select 'In-Progress' where not exists (select 1 from master_status where status='In-Progress');
insert into master_status(status) select 'Completed' where not exists (select 1 from master_status where status='Completed');

alter table if exists service_booking add column if not exists status_id bigint;
alter table if exists service_booking add constraint fk_service_booking_status_id foreign key(status_id) references master_status(id);

create table if not exists booking_template(id bigserial not null,
title varchar(255) not null,
description text not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_booking_template_id primary key(id),
constraint uk_booking_template_title unique(title)); 


select * from booking_template;

select * from user_department;

insert into booking_template(title,description)
select 'Service Assignment Mail to EMP','<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>New Service Assigned – [TicketID]</title>
    <style>
      body {
        margin: 0;
        padding: 0;
        background-color: #edfdfE;
        font-family: "Segoe UI", Arial, sans-serif;
      }

      table {
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        width: 600px;
        margin: 40px auto;
        border-collapse: collapse;
      }

      .header {
        text-align: center;
        background-color: #16a34a;
        padding: 20px 0;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
      }

      .header h1 {
        color: #ffffff;
        font-size: 26px;
        margin: 0;
      }

      .content {
        padding: 30px 40px;
        color: #333333;
        font-size: 16px;
        line-height: 1.7;
      }

      .content a {
        color: #16a34a;
        text-decoration: none;
      }

      .content strong.green {
        color: #16a34a;
      }

      .details {
        background-color: #f7fdfd;
        border: 1px solid #d1fae5;
        border-radius: 8px;
        padding: 15px 20px;
        margin: 20px 0;
      }

      .details p {
        margin: 8px 0;
      }

      .footer {
        text-align: center;
        background-color: #f7fdfd;
        padding: 20px;
        font-size: 14px;
        color: #777777;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      .bottom-link {
        text-align: center;
        background-color: #f3f4f6;
        padding: 15px;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      .bottom-link a {
        color: #2563eb;
        text-decoration: none;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <table>
     
      <tr>
        <td class="header">
          <h1>New Service Assigned – {booking.booking_id ?? "TicketID"}</h1>
        </td>
      </tr>

      
      <tr>
        <td class="content">
          <p>Hello <strong>{employee.employee_name ?? "Team Member"}</strong>,</p>

          <p>
            You’ve been assigned a new
            <strong class="green">cleaning service request</strong>.
          </p>

          <div class="details">
            <p>🧾 <strong>Ticket ID:</strong> {0}</p>
            <p>👤 <strong>Customer:</strong> {1}</p>
            <p>📍 <strong>Location:</strong> {2}</p>
            <p>📅 <strong>Scheduled Date &amp; Time:</strong> {3}</p>
          </div>

          <p>
            Please review the details and confirm your readiness in the
            <strong class="green">Swachify App</strong>.
          </p>

          <p>
            If you have any questions, contact your supervisor or the admin
            team.
          </p>

          <p>
            Best regards,<br />
            <strong>Swachify Admin</strong>
          </p>
        </td>
      </tr>

     
      <tr>
        <td class="footer">
          &copy; 2025 Swachify. All rights reserved.
        </td>
      </tr>

      <tr>
        <td class="bottom-link">
          <a href="https://swachify.com">Visit Swachify Portal</a>
        </td>
      </tr>
    </table>
  </body>
</html>' where not exists (select 1 from booking_template where description='<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>New Service Assigned – [TicketID]</title>
    <style>
      body {
        margin: 0;
        padding: 0;
        background-color: #edfdfE;
        font-family: "Segoe UI", Arial, sans-serif;
      }

      table {
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        width: 600px;
        margin: 40px auto;
        border-collapse: collapse;
      }

      .header {
        text-align: center;
        background-color: #16a34a;
        padding: 20px 0;
        border-top-left-radius: 10px;
        border-top-right-radius: 10px;
      }

      .header h1 {
        color: #ffffff;
        font-size: 26px;
        margin: 0;
      }

      .content {
        padding: 30px 40px;
        color: #333333;
        font-size: 16px;
        line-height: 1.7;
      }

      .content a {
        color: #16a34a;
        text-decoration: none;
      }

      .content strong.green {
        color: #16a34a;
      }

      .details {
        background-color: #f7fdfd;
        border: 1px solid #d1fae5;
        border-radius: 8px;
        padding: 15px 20px;
        margin: 20px 0;
      }

      .details p {
        margin: 8px 0;
      }

      .footer {
        text-align: center;
        background-color: #f7fdfd;
        padding: 20px;
        font-size: 14px;
        color: #777777;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      .bottom-link {
        text-align: center;
        background-color: #f3f4f6;
        padding: 15px;
        border-bottom-left-radius: 10px;
        border-bottom-right-radius: 10px;
      }

      .bottom-link a {
        color: #2563eb;
        text-decoration: none;
        font-weight: bold;
      }
    </style>
  </head>
  <body>
    <table>
     
      <tr>
        <td class="header">
          <h1>New Service Assigned – {booking.booking_id ?? "TicketID"}</h1>
        </td>
      </tr>

      
      <tr>
        <td class="content">
          <p>Hello <strong>{employee.employee_name ?? "Team Member"}</strong>,</p>

          <p>
            You’ve been assigned a new
            <strong class="green">cleaning service request</strong>.
          </p>

          <div class="details">
            <p>🧾 <strong>Ticket ID:</strong> {0}</p>
            <p>👤 <strong>Customer:</strong> {1}</p>
            <p>📍 <strong>Location:</strong> {2}</p>
            <p>📅 <strong>Scheduled Date &amp; Time:</strong> {3}</p>
          </div>

          <p>
            Please review the details and confirm your readiness in the
            <strong class="green">Swachify App</strong>.
          </p>

          <p>
            If you have any questions, contact your supervisor or the admin
            team.
          </p>

          <p>
            Best regards,<br />
            <strong>Swachify Admin</strong>
          </p>
        </td>
      </tr>

     
      <tr>
        <td class="footer">
          &copy; 2025 Swachify. All rights reserved.
        </td>
      </tr>

      <tr>
        <td class="bottom-link">
          <a href="https://swachify.com">Visit Swachify Portal</a>
        </td>
      </tr>
    </table>
  </body>
</html>' and title='Service Assignment Mail to EMP');
---------------------------------------------------------
--Authored by Anand A on 22-10-2025
update service_booking set status_id = 1 where id in 
(select id from service_booking order by 1 limit 7);

update service_booking set status_id = 2 where id in 
(select id from service_booking order by 1 offset 7 limit 7);

update service_booking set status_id = 3 where id in 
(select id from service_booking order by 1 offset 14 limit 7);

update service_booking set status_id = 4 where id in 
(select id from service_booking order by 1 offset 21 limit 7);
------------------------------------------------------
--Authored by Anand A on 25-10-2025.
insert into public.booking_template values (
    7,
    'Welcome! Please reset your password',
    '<!DOCTYPE html> <html lang="en"> <head> <meta charset="UTF-8" /> <meta name="viewport" content="width=device-width, initial-scale=1.0" /> <title>Your Cleaning Service Is Complete!</title> <style> body { margin: 0; padding: 0; background-color: #edfdfE; font-family: "Segoe UI", Arial, sans-serif; } table { background-color: #ffffff; border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); width: 600px; margin: 40px auto; border-collapse: collapse; } .header { text-align: center; background-color: #16a34a; padding: 20px 0; border-top-left-radius: 10px; border-top-right-radius: 10px; } .header h1 { color: #ffffff; font-size: 26px; margin: 0; } .content { padding: 30px 40px; color: #333333; font-size: 16px; line-height: 1.7; } .content a { color: #16a34a; text-decoration: none; } .content strong.green { color: #16a34a; } .button { display: inline-block; background-color: #16a34a; color: #ffffff !important; text-decoration: none; padding: 12px 25px; border-radius: 8px; font-weight: bold; margin-top: 15px; } .footer { text-align: center; background-color: #f7fdfd; padding: 20px; font-size: 14px; color: #777777; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; } .bottom-link { text-align: center; background-color: #f3f4f6; padding: 15px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; } .bottom-link a { color: #2563eb; text-decoration: none; font-weight: bold; } </style> </head> <body> <table> <tr> <td class="header"> <h1>Welcome to the Swachify!</h1> </td> </tr> <tr> <td class="content"> <p>Dear <strong>{0}</strong>,</p> <p>Your account has been created. Your default password is your email address. </p> <p>Please reset your password using the link below:</p> <p><a href="{resetLink}">Reset Password</a></p> <p> Warm regards,<br /> <strong>Team Swachify</strong><br /> <em>“Making Spaces Shine, Every Time!”</em> </p> </td> </tr> <tr> <td class="footer"> &copy; 2025 Swachify. All rights reserved. </td> </tr> <tr> <td class="bottom-link"> <a href="https://swachify.com">Visit Our Website</a> </td> </tr> </table> </body> </html>'
    ,NULL,NULL,null,null,true);
-------------------------------------------------
--Authored by Anand A on 27-10-2025.
create table if not exists service_tracking(
id bigserial not null,
service_booking_id bigint not null,
status_id bigint,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_service_tracking_id primary key(id),
constraint fk_service_tracking_service_booking_id foreign key(service_booking_id) references service_booking(id),
constraint fk_service_tracking_status_id foreign key(status_id) references master_status(id)
);
-------------------------------------
--Authored by Anand on 28-10-2025.
select * from master_department;

update master_department set department_name = 'With Basement / Without Basement' where id = 5;

select setval('master_department_id_seq',(select max(id)+1 from master_department));

ALTER TABLE IF EXISTS master_service DROP COLUMN regular,DROP COLUMN premium,DROP COLUMN ultimate,DROP COLUMN is_regular,DROP COLUMN is_premium,DROP COLUMN is_ultimate;

select * from  master_service;

DELETE FROM master_service_mapping;

DELETE FROM user_auth where user_id in 
(select id from user_registration where service_id in 
(select id from master_service));

DELETE FROM user_department where user_id in 
(select id from user_registration where service_id in 
(select id from master_service));

DELETE FROM user_registration WHERE service_id IN 
(select id from master_service);

DELETE FROM service_booking;
DELETE FROM master_service;

select * from master_service;

select * from user_registration;

ALTER SEQUENCE master_service_id_seq RESTART WITH 1;

ALTER TABLE IF EXISTS master_service ADD COLUMN IF NOT EXISTS dept_id bigint;

ALTER TABLE IF EXISTS master_service ADD CONSTRAINT fk_master_service_dept_id FOREIGN KEY (dept_id) REFERENCES master_department(id);

insert into public.master_service (service_name,dept_id)  SELECT 'Single',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Single' and dept_id = 3 );
insert into public.master_service (service_name,dept_id)  SELECT 'Double',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Double' and dept_id = 3);
insert into public.master_service (service_name,dept_id)  SELECT 'Triple',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Triple' and dept_id = 3);
insert into public.master_service (service_name,dept_id)  SELECT '4Bedroom',3 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='4Bedroom' and dept_id = 3) ;
insert into public.master_service (service_name,dept_id)  SELECT 'Single',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Single' and dept_id = 2);
insert into public.master_service (service_name,dept_id)  SELECT 'Double',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Double' and dept_id = 2);
insert into public.master_service (service_name,dept_id)  SELECT 'Triple',2 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Triple' and dept_id = 2);
insert into public.master_service (service_name,dept_id)  SELECT 'Small',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Small' and dept_id = 1);
insert into public.master_service (service_name,dept_id)  SELECT 'Medium',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Medium' and dept_id = 1);
insert into public.master_service (service_name,dept_id)  SELECT 'Large',1 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Large' and dept_id = 1);
insert into public.master_service (service_name,dept_id)  SELECT 'With Dining',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='With Dining' and dept_id = 4);
insert into public.master_service (service_name,dept_id)  SELECT 'Without Dining',4 WHERE NOT EXISTS (SELECT 1 FROM public.master_service WHERE service_name='Without Dining' and dept_id = 4);

select * from master_service;

ALTER TABLE IF EXISTS public.master_service DROP CONSTRAINT uk_master_service_service_name;
ALTER TABLE IF EXISTS public.master_service ADD CONSTRAINT uk_master_service_service_name unique(service_name,dept_id);

select setval('master_service_id_seq',(select max(id)+1 from master_service));

create table if not exists public.master_service_type(
id bigserial not null,
service_type varchar(255) not null,
price numeric(10,2),
hours integer,
is_active boolean default true,
constraint pk_master_service_type_id primary key(id));


INSERT INTO public.master_service_type (service_type,price,hours)  SELECT 'Normal Cleaning',49.00,3 WHERE NOT EXISTS (SELECT 1 FROM public.master_service_type WHERE service_type='Normal Cleaning' and price=49.00 and hours=3);
INSERT INTO public.master_service_type (service_type,price,hours)  SELECT 'Deep Cleaning',49.00,3 WHERE NOT EXISTS (SELECT 1 FROM public.master_service_type WHERE service_type='Deep Cleaning' and price=49.00 and hours=3);

DROP TABLE IF EXISTS master_service_mapping;

select * from master_service_type;


alter table if exists service_booking add column if not exists service_type_id bigint,add constraint fk_service_booking_service_type_id foreign key(service_type_id) references master_service_type(id);
alter table if exists service_booking DROP COLUMN IF EXISTS is_regular;
alter table if exists service_booking DROP COLUMN IF EXISTS is_premium;
alter table if exists service_booking DROP COLUMN IF EXISTS is_ultimate;

-------------------
--Authored by Anand A on 29-10-2025.
alter table if exists service_booking add column if not exists total numeric(10,2);
alter table if exists service_booking add column if not exists subtotal numeric(10,2);
alter table if exists service_booking add column if not exists customer_requested_amount numeric(10,2);
alter table if exists service_booking add column if not exists discount_amount numeric(10,2);
alter table if exists service_booking add column if not exists discount_percentage numeric(10,2);
alter table if exists service_booking add column if not exists discount_total numeric(10,2);
alter table if exists service_booking drop column if  exists service_id;
alter table if exists service_booking drop column if  exists dept_id;

alter table if exists service_tracking add column if not exists dept_id bigint;
alter table if exists service_tracking add column if not exists service_id bigint;
alter table if exists service_tracking add column if not exists service_type_id bigint;
alter table if exists service_tracking add constraint fk_service_tracking_dept_id foreign key(dept_id) references master_department(id);
alter table if exists service_tracking add constraint fk_service_tracking_service_id foreign key(service_id) references master_service(id)
alter table if exists service_tracking add constraint fk_service_tracking_service_type_id foreign key(service_type_id) references master_service_type(id)
alter table if exists service_tracking add column if not exists booking_id varchar(100);
----------------------------------------------------------------------------------
--Authored by Anand A on 30-10-2025.
create table if not exists master_service_mapping(id bigserial not null,
service_id bigint not null,service_type_id bigint not null,is_active boolean default true,
constraint pk_master_service_mapping_id primary key(id),
constraint fk_master_service_mapping_service_id foreign key(service_id) references master_service(id),
constraint fk_master_service_mapping_service_type_id foreign key(service_type_id) references master_service_type(id),
constraint uk_master_service_mapping_service_id_service_type_id unique(service_type_id,service_id));

insert into master_service_mapping(service_id,service_type_id)
select * from 
(select * from 
(select id,1 from master_service order by 1)a
union
select * from 
(select id,2 from master_service order by 1)b)c
order by 1;
---------------------------------------------------------------------------------
--Authored by Anand on 31-10-2025.
--to remove all related departments.
delete from master_service_mapping where service_id in 
(select id from master_service where dept_id in 
(select id from master_department where id = 6));

delete from master_service where dept_id in 
(select id from master_department where id = 6);

delete from master_department where id=6;
---------------------------------------------------------------------------------
update service_booking set service_type_id=1;
update service_tracking set service_type_id=1;
-----------------------------------------------------------------------------------------
--Authored by Anand A on 01-11-2025.
alter table if exists service_booking add column if not exists hours integer;
alter table if exists service_booking add column if not exists add_on_hours integer;
-------------------------------------------------------------------------------------
--Authored by Anand A on 02-11-2025.

update master_slots set slot_time='9AM - 12PM' where id=1;

delete from master_service_mapping where service_id in 
(select id from master_service where dept_id in 
(select id from master_department where id in (6,7)));

delete from master_service where dept_id in 
(select id from master_department where id in (6,7));

delete from user_department where dept_id in 
(select id from master_department where id in (6,7));

delete from master_department where id in (6,7);

delete from master_service_type where id in (3,4,5);

select setval('master_department_id_seq',(select max(id)+1 from master_department));
select setval('user_department_id_seq',(select max(id)+1 from user_department));
select setval('master_service_id_seq',(select max(id)+1 from master_service));
select setval('master_service_mapping_id_seq',(select max(id)+1 from master_service_mapping));
select setval('master_service_type_id_seq',(select max(id)+1 from master_service_type));

update master_department set is_active = false where id=5;
-------------------------------------------
--Authored by Anand A on 04-11-2025.
alter table if exists booking_template add constraint fk_booking_template_created_by foreign key(created_by) references user_registration(id);
alter table if exists booking_template add constraint fk_booking_template_modified_by foreign key(modified_by) references user_registration(id);


