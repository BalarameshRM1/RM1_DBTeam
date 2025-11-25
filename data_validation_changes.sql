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
