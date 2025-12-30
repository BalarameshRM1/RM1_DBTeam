------22/12/2025
---created master tables

Create table if not exists  master_role(
id serial not null,
role_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_role_id primary key(id),
constraint uk_master_role_role_name unique (role_name)
);


INSERT INTO public.master_role(role_name) SELECT 'Investor' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE  role_name = 'Investor');
INSERT INTO public.master_role(role_name) SELECT 'Vendor' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE  role_name = 'Vendor');

-----
Create table if not exists master_gender(
id serial not null,
gender_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_gender_id primary key(id),
constraint uk_master_gender_gender_name unique (gender_name)
);

INSERT INTO public.master_gender(gender_name) SELECT 'Male'  WHERE NOT EXISTS (SELECT 1 FROM public.master_gender  WHERE  gender_name = 'Male');
INSERT INTO public.master_gender(gender_name) SELECT 'Female'  WHERE NOT EXISTS (SELECT 1 FROM public.master_gender  WHERE  gender_name = 'Female');
INSERT INTO public.master_gender(gender_name) SELECT 'Others'  WHERE NOT EXISTS (SELECT 1 FROM public.master_gender  WHERE  gender_name = 'Others');

---
Create table if not exists  master_plan_type(
id serial not null,
plan_type varchar(255) not null,
percentage varchar(10) not null,
returns_in_days varchar(100) not null,
is_active boolean default true,
constraint pk_master_plan_type_id primary key(id),
constraint uk_master_plan_type_plan_type unique (plan_type)
);

INSERT INTO public.master_plan_type (plan_type, percentage, returns_in_days) values ('1 Month Plan', '8 %', '30 Days');
INSERT INTO public.master_plan_type (plan_type, percentage, returns_in_days) values ('3 Month Plan', '12 %', '90 Days');
INSERT INTO public.master_plan_type (plan_type, percentage, returns_in_days) values ('6 Month Plan', '18 %', '180 Days');
INSERT INTO public.master_plan_type (plan_type, percentage, returns_in_days) values ('Yearly Plan', '24 %', '365 Days');




---
Create table if not exists user_registration(
id bigserial not null,
first_name varchar(255) not null,
last_name varchar(255) not null,
email varchar(255) not null,
mobile varchar(255) not null,
password varchar(500) not null,
gender_id int not null,
age int  not null,
dob date  not null,
inv_reg_id varchar(255) not null,
role_id int  not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_user_registration_id primary key (id),
constraint fk_user_registration_gender_id foreign key (gender_id) references master_gender(id),
constraint fk_user_registration_role_id foreign key (role_id) references master_role(id),
constraint uk_user_registration_email unique (email),
constraint uk_user_registration_mobile unique (mobile),
constraint uk_user_registration_inv_reg_id unique (inv_reg_id));

----

create table if not exists inv_config(
id bigserial not null,
principal_amount numeric(10,2) not null,
plan_type_id int not null,
interest_amount numeric(10,2) not null,
Maturity_amount numeric(10,2) not null,
uk_inv_id varchar(255) not null,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_inv_config_id primary key(id),
constraint fk_inv_config_plan_type_id foreign key (plan_type_id) references master_plan_type(id),
constraint uk_inv_config_uk_inv_id unique (uk_inv_id)
);


---29-dec-2025 -- dhanusha

alter table inv_config add column maturity_date date not null;
alter table inv_config add column upload_file varchar(500);
delete from user_registration;
alter sequence user_registration_id_seq restart with 1;

--- 30-dec-2025 -- dhanusha

alter table user_registration add column is_verified boolean ;
