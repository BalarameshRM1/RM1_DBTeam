create table if not exists public.master_language(
   id bigserial not null,
   language_name varchar(255) not null,
   is_active boolean default true,
   constraint pk_master_language_id primary key(id),
   constraint uk_master_language_language_name unique(language_name)
);

create table if not exists public.master_designation(
   id bigserial not null,
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
