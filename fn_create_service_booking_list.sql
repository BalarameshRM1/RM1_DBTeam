--drop function fn_create_service_booking_list;
create or replace function fn_create_service_booking_list(
p_booking_id varchar,p_slot_id bigint,p_preferred_date date,
p_full_name varchar,p_phone varchar,p_email varchar,p_address varchar,p_gender_id bigint,
p_status_id bigint,p_assign_to bigint,p_unavailable boolean,
p_service_type_id bigint,p_total numeric,p_subtotal numeric,
p_customer_requested_amount numeric,
p_discount_amount numeric,p_discount_percentage numeric,
p_discount_total numeric,p_hours integer,p_add_on_hours integer)

returns void
language 'plpgsql'
as $$
declare v_first_name varchar;v_last_name varchar;v_exists boolean;

begin
	v_first_name:=split_part(p_full_name,' ', 1);
	v_last_name:=split_part(p_full_name,' ', 2);

--Authored by Anand A on 02-12-2025.

insert into service_booking(booking_id,slot_id,preferred_date,full_name,phone,email,address,status_id,assign_to,unavailable,service_type_id,total,subtotal,customer_requested_amount,
discount_amount,discount_percentage,discount_total,hours,add_on_hours,gender_id)
values (p_booking_id,p_slot_id,p_preferred_date,p_full_name,p_phone,p_email,p_address,p_status_id,p_assign_to,p_unavailable,p_service_type_id,p_total,p_subtotal,p_customer_requested_amount,
p_discount_amount,p_discount_percentage,p_discount_total,p_hours,p_add_on_hours,p_gender_id);

select exists (select 1 from user_registration where email=p_email or mobile=p_phone) into v_exists;--this is the condition for email or mobile is exists in user_registraion or not 

if not v_exists then 
insert into user_registration(first_name ,last_name ,role_id ,email,mobile,gender_id,address)
values(v_first_name,v_last_name,4,p_email,p_phone,p_gender_id,p_address);

end if;

end;
$$;