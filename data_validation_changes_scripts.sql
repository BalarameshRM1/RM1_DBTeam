create table if not exists public.master_language(
   id serial not null,
   language_name varchar(255) not null,
   is_active boolean default true,
   constraint pk_master_language_id primary key(id),
   constraint uk_master_language_language_name unique(language_name)
);

create table if not exists public.master_designation(
   id serial not null,
   designation_name varchar(255) not null,
   is_active boolean default true,
   constraint pk_master_designation_id primary key(id),
   constraint uk_master_designation_designation_name unique(designation_name)
);

insert into public.master_designation(designation_name) select 'Sales Respresentative' where not exists(select 1 from public.master_designation where designation_name = 'Sales Representative');
insert into public.master_designation(designation_name) select 'Managing Broker and Broker of Record' where not exists(select 1 from public.master_designation where designation_name = 'Managing Broker and Broker of Record');
insert into public.master_designation(designation_name) select 'Sales Manager, Sales Representative' where not exists(select 1 from public.master_designation where designation_name = 'Sales Manager, Sales Representative');
insert into public.master_designation(designation_name) select 'Broker' where not exists(select 1 from public.master_designation where designation_name = 'Broker');
insert into public.master_designation(designation_name) select 'ISA Rep, Sales Representative' where not exists(select 1 from public.master_designation where designation_name = 'ISA Rep, Sales Representative');

INSERT INTO public.master_language (language_name) SELECT 'Arabic' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Arabic');
INSERT INTO public.master_language (language_name) SELECT 'Armenian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Armenian');
INSERT INTO public.master_language (language_name) SELECT 'Azerbaijani' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Azerbaijani');
INSERT INTO public.master_language (language_name) SELECT 'Bengali' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Bengali');
INSERT INTO public.master_language (language_name) SELECT 'Cantonese' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Cantonese');
INSERT INTO public.master_language (language_name) SELECT 'Croatian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Croatian');
INSERT INTO public.master_language (language_name) SELECT 'Czech' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Czech');
INSERT INTO public.master_language (language_name) SELECT 'English' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'English');
INSERT INTO public.master_language (language_name) SELECT 'Farsi' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Farsi');
INSERT INTO public.master_language (language_name) SELECT 'French' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'French');
INSERT INTO public.master_language (language_name) SELECT 'German' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'German');
INSERT INTO public.master_language (language_name) SELECT 'Gujarati' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Gujarati');
INSERT INTO public.master_language (language_name) SELECT 'Hebrew' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Hebrew');
INSERT INTO public.master_language (language_name) SELECT 'Hindi' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Hindi');
INSERT INTO public.master_language (language_name) SELECT 'Hungarian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Hungarian');
INSERT INTO public.master_language (language_name) SELECT 'Italian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Italian');
INSERT INTO public.master_language (language_name) SELECT 'Kurdish' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Kurdish');
INSERT INTO public.master_language (language_name) SELECT 'Laotian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Laotian');
INSERT INTO public.master_language (language_name) SELECT 'Malayalam' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Malayalam');
INSERT INTO public.master_language (language_name) SELECT 'Mandarin' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Mandarin');
INSERT INTO public.master_language (language_name) SELECT 'Portuguese' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Portuguese');
INSERT INTO public.master_language (language_name) SELECT 'Punjabi' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Punjabi');
INSERT INTO public.master_language (language_name) SELECT 'Russian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Russian');
INSERT INTO public.master_language (language_name) SELECT 'Serbian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Serbian');
INSERT INTO public.master_language (language_name) SELECT 'Slovak' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Slovak');
INSERT INTO public.master_language (language_name) SELECT 'Slovenian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Slovenian');
INSERT INTO public.master_language (language_name) SELECT 'Spanish' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Spanish');
INSERT INTO public.master_language (language_name) SELECT 'Tagalog' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Tagalog');
INSERT INTO public.master_language (language_name) SELECT 'Taiwanese' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Taiwanese');
INSERT INTO public.master_language (language_name) SELECT 'Tamil' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Tamil');
INSERT INTO public.master_language (language_name) SELECT 'Telugu' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Telugu');
INSERT INTO public.master_language (language_name) SELECT 'Turkish' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Turkish');
INSERT INTO public.master_language (language_name) SELECT 'Ukrainian' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Ukrainian');
INSERT INTO public.master_language (language_name) SELECT 'Urdu' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Urdu');
INSERT INTO public.master_language (language_name) SELECT 'Yoruba' WHERE NOT EXISTS (SELECT 1 FROM public.master_language WHERE language_name = 'Yoruba');

create table if not exists master_role(id serial not null,
role_name varchar(255) not null,
is_active boolean default true,
constraint pk_master_role_id primary key(id),
constraint uk_master_role_name unique(role_name));

INSERT INTO public.master_role (role_name) SELECT 'Admin' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Admin');
INSERT INTO public.master_role (role_name) SELECT 'Agent' WHERE NOT EXISTS (SELECT 1 FROM public.master_role WHERE role_name = 'Agent');

create table if not EXISTS public.master_city (
	id serial not null,
	city_name varchar(255) not null,
	is_active boolean DEFAULT true,
constraint pk_master_city_id primary key(id)
	);

INSERT INTO public.master_city (city_name) SELECT 'Ontario' WHERE NOT EXISTS (SELECT 1 FROM public.master_city WHERE city_name = 'Ontario');
INSERT INTO public.master_city (city_name) SELECT 'British Columbia' WHERE NOT EXISTS (SELECT 1 FROM public.master_city WHERE city_name = 'British Columbia');
INSERT INTO public.master_city (city_name) SELECT 'Alberta' WHERE NOT EXISTS (SELECT 1 FROM public.master_city WHERE city_name = 'Alberta');


create table if not exists public.master_area (
	id serial not null,
	city_id bigint not null,
	area_name varchar(255) not null,
	is_active boolean default true,
constraint pk_master_area_id primary key(id),
constraint fk_master_area_city_id foreign key (city_id) REFERENCES master_city(id)
);

INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'GTA' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'GTA');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Guelph' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Guelph');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Bancroft / Haliburton / Madoc / Barry''s Bay' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Bancroft / Haliburton / Madoc / Barry''s Bay');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Norfolk County' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Norfolk County');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'North Bay' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'North Bay');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Erin' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Erin');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Sarnia / Windsor' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Sarnia / Windsor');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'York' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'York');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Grey/Bruce' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Grey/Bruce');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Toronto' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Toronto');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'South East ON' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'South East ON');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Grimsby / St. Catharines / Niagara' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Grimsby / St. Catharines / Niagara');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Caledon' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Caledon');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Bradford & East Gwillimbury' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Bradford & East Gwillimbury');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'London' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'London');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Barrie / Innisfil / Orillia /Simcoe' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Barrie / Innisfil / Orillia /Simcoe');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Ottawa' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Ottawa');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Kitchener / Waterloo / Cambridge' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Kitchener / Waterloo / Cambridge');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Peterborough / Kawarthas / Northumberland' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Peterborough / Kawarthas / Northumberland');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Hamilton' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Hamilton');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Durham' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Durham');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Peel' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Peel');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Halton' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Halton');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Woodstock' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Woodstock');
INSERT INTO public.master_area (city_id, area_name) SELECT 1, 'Muskoka' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 1 AND area_name = 'Muskoka');
INSERT INTO public.master_area (city_id, area_name) SELECT 2, 'Kelowna' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 2 AND area_name = 'Kelowna');
INSERT INTO public.master_area (city_id, area_name) SELECT 2, 'Sea to Sky' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 2 AND area_name = 'Sea to Sky');
INSERT INTO public.master_area (city_id, area_name) SELECT 2, 'Victoria' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 2 AND area_name = 'Victoria');
INSERT INTO public.master_area (city_id, area_name) SELECT 2, 'Fraser Valley' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 2 AND area_name = 'Fraser Valley');
INSERT INTO public.master_area (city_id, area_name) SELECT 2, 'Vancouver' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 2 AND area_name = 'Vancouver');
INSERT INTO public.master_area (city_id, area_name) SELECT 2, 'Terrace' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 2 AND area_name = 'Terrace');
INSERT INTO public.master_area (city_id, area_name) SELECT 3, 'Edmonton' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 3 AND area_name = 'Edmonton');
INSERT INTO public.master_area (city_id, area_name) SELECT 3, 'Calgary' WHERE NOT EXISTS (SELECT 1 FROM public.master_area WHERE city_id = 3 AND area_name = 'Calgary');

create table if not exists public.agent_registration (
	id bigserial not null,
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	designation_id bigint,
	language_id bigint,
	agent_image varchar(500),
	created_by bigint,
	created_date timestamp default now(),
	modified_by bigint,
	modified_date timestamp,
	is_active boolean default true,
constraint pk_agent_registration_id primary key(id),
constraint fk_agent_registration_designation_id foreign key (designation_id) REFERENCES master_designation(id),
constraint fk_agent_registration_language_id foreign key (language_id) REFERENCES master_language(id)
	);
	
insert into agent_registration(first_name,last_name,designation_id,language_id values('Erkan', 'Tatar',1,8);
insert into agent_registration(first_name,last_name,designation_id,language_id values('Dan', 'Holt',4,8);
insert into agent_registration(first_name,last_name,designation_id,language_id values('Ashkan', 'Rahimi',3,8);
insert into agent_registration(first_name,last_name,designation_id,language_id values('Catarina', 'DeBastos',5,8);
insert into agent_registration(first_name,last_name,designation_id,language_id values('Karen ', 'Grunlund',2,8);

create table if not exists user_registration(id bigserial not null,
first_name varchar(255) not null,
last_name varchar(255) not null,
email varchar(100) not null,
password varchar(500) not null,
mobile varchar(15) not null,
city_id integer,
role_id integer,
created_by bigint,
created_date timestamp default now(),
modified_by bigint,
modified_date timestamp,
is_active boolean default true,
constraint pk_user_registration_id primary key(id),
constraint fk_user_registration_city_id foreign key(city_id) references master_city(id),
constraint fk_user_registration_role_id foreign key(role_id) references master_role(id),
constraint fk_user_registration_created_by foreign key(created_by) references user_registration(id),
constraint fk_user_registration_modified_by foreign key(modified_by) references user_registration(id),
constraint uk_user_registration_email unique(email),
constraint uk_user_registration_mobile unique(mobile));