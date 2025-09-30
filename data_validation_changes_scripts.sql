--Creting a master Salutation table
  
create table master_salutation (
id serial not null,
salutation varchar(100) not null,
is_active boolean default true,
constraint pk_master_salutation_id primary key(id)
constraint uk_master_salutation_salutation unique(salutation));

insert into master_salutation (salutation) select 'Mr.' where not exists (select 1 from master_salutation  where salutation='Mr.');
insert into master_salutation (salutation) select 'Mrs.' where not exists (select 1 from master_salutation  where salutation='Mrs.');
insert into master_salutation (salutation) select 'Ms.' where not exists (select 1 from master_salutation  where salutation='Ms.');
insert into master_salutation (salutation) select 'Miss' where not exists (select 1 from master_salutation  where salutation='Miss');
insert into master_salutation (salutation) select 'Dr.' where not exists (select 1 from master_salutation  where salutation='Dr.');
insert into master_salutation (salutation) select 'Prof.' where not exists (select 1 from master_salutation  where salutation='Prof.');
insert into master_salutation (salutation) select 'Rev.' where not exists (select 1 from master_salutation  where salutation='Rev.');
insert into master_salutation (salutation) select 'Sir' where not exists (select 1 from master_salutation  where salutation='Sir');
insert into master_salutation (salutation) select 'Madam' where not exists (select 1 from master_salutation  where salutation='Madam');
SELECT * FROM master_salutation;

--Creating Master Exemption table
  create table master_exemption (
id serial not null,
exemption_name varchar(100) not null,
is_active boolean default true,
constraint pk_master_exemption_id primary key(id)
constraint uk_master_exemption_exemption_name unique (exemption_name));

insert into master_exemption (exemption_name) select 'Recent Organ Transplant' where not exists (select 1 from master_exemption  where exemption_name='Recent Organ Transplant');
insert into master_exemption (exemption_name) select 'Tuberculosis or other Active Infection' where not exists (select 1 from master_exemption  where exemption_name='Tuberculosis or other Active Infection');
insert into master_exemption (exemption_name) select 'Pregnancy' where not exists (select 1 from master_exemption  where exemption_name='Pregnancy');
insert into master_exemption (exemption_name) select 'Acute Severe Illness' where not exists (select 1 from master_exemption  where exemption_name='Acute Severe Illness');
insert into master_exemption (exemption_name) select 'Neurological Disorders' where not exists (select 1 from master_exemption  where exemption_name='Neurological Disorders');
insert into master_exemption (exemption_name) select 'Active Cancer Treatment' where not exists (select 1 from master_exemption  where exemption_name='Active Cancer Treatment');
select * from master_exemption ;


--create master gender table

create table if not exists master_gender (
id serial not null,
gender varchar not null(100) ,
is_active boolean default true,
constraint pk_master_gender_id primary key(id),
constraint uk_master_gender_gender unique (gender)
);

insert into master_gender (gender) select 'Male' where not exists (select 1 from master_gender where gender = 'Male' );
insert into master_gender (gender) select 'Female' where not exists (select 1 from master_gender where gender = 'Female');
insert into master_gender (gender) select 'Others' where not exists (select 1 from master_gender where gender = 'Others');

select * from master_gender;

--- create master nationality table

create table master_nationality(
id serial not null,
nationality varchar(255) not null,
is_active boolean default true,
constraint pk_master_nationality_id primary key(id),
constraint uk_master_nationality_nationality unique (nationality)

);

insert into master_nationality(nationality) select 'Indian' where not exists (select 1 from master_nationality where nationality = 'Indian' );
insert into master_nationality(nationality) select 'Non-Indian' where not exists (select 1 from master_nationality where nationality = 'Non-Indian' );

select * from master_nationality

--Create master blood group table
  
create table master_blood_group(
id serial not null,
blood_group varchar(5) not null,
is_active boolean default true,
constraint pk_master_blood_group_id primary key(id),
constraint uk_master_blood_group_blood_group unique (blood_group)
);

insert into master_blood_group(blood_group) select 'A⁺' where not exists(select 1 from master_blood_group where blood_group = 'A⁺');
insert into master_blood_group(blood_group) select 'A⁻' where not exists(select 1 from master_blood_group where blood_group = 'A⁻');
insert into master_blood_group(blood_group) select 'B⁺' where not exists(select 1 from master_blood_group where blood_group = 'B⁺');
insert into master_blood_group(blood_group) select 'B⁻' where not exists(select 1 from master_blood_group where blood_group = 'B⁻');
insert into master_blood_group(blood_group) select 'AB⁺' where not exists(select 1 from master_blood_group where blood_group = 'AB⁺');
insert into master_blood_group(blood_group) select 'AB⁻' where not exists(select 1 from master_blood_group where blood_group = 'AB⁻');
insert into master_blood_group(blood_group) select 'O⁺' where not exists(select 1 from master_blood_group where blood_group = 'O⁺');
insert into master_blood_group(blood_group) select 'O⁻' where not exists(select 1 from master_blood_group where blood_group = 'O⁻');

select * from master_blood_group


