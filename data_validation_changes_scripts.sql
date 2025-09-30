create table master_salutation (
id serial not null,
salutation varchar(100),
is_active boolean default true,
constraint pk_master_salutation_id primary key(id));

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
