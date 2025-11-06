--Authored by Anand A on 30-10-2025.
--DROP FUNCTION IF EXISTS fn_service_booking_list;
create or replace function fn_service_booking_list(custid bigint DEFAULT NULL,empid bigint DEFAULT NULL)

returns table (id bigint,booking_id character varying,slot_id bigint,slot_time character varying,full_name character varying,phone character varying,email character varying,address character varying,assign_to bigint,employee_name character varying,status_id bigint,status character varying,dept_id bigint,department_name character varying,service_id bigint,service_name character varying,service_type_id bigint,service_type character varying,total numeric,subtotal numeric,customer_requested_amount numeric,discount_amount numeric,discount_percentage numeric,discount_total numeric,created_by bigint,customer_name character varying,created_date timestamp without time zone)
language 'plpgsql'
AS $$
BEGIN


IF custid IS NULL and empid IS NULL THEN
RETURN QUERY
 
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4;

ELSIF custid IS NOT NULL THEN
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.created_by =custid or -1=custid);

ELSIF empid IS NOT NULL THEN 
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.assign_to =empid or -1=empid);

END IF;
END;
$$;

SELECT * FROM fn_service_booking_list();--all service_booking list
SELECT * FROM fn_service_booking_list(custid:=1);--for customer wise service booking list
SELECT * FROM fn_service_booking_list(empid:=1);--for employee wise service booking list
----------------------------------------------
--Remodified by Anand A on 31-10-2025.
--DROP FUNCTION IF EXISTS fn_service_booking_list;
create or replace function fn_service_booking_list(tickt_id bigint DEFAULT NULL,custid bigint DEFAULT NULL,empid bigint DEFAULT NULL)

returns table (id bigint,booking_id character varying,slot_id bigint,slot_time character varying,full_name character varying,phone character varying,email character varying,address character varying,assign_to bigint,employee_name character varying,employee_email character varying,status_id bigint,status character varying,dept_id bigint,department_name character varying,service_id bigint,service_name character varying,service_type_id bigint,service_type character varying,total numeric,subtotal numeric,customer_requested_amount numeric,discount_amount numeric,discount_percentage numeric,discount_total numeric,created_by bigint,customer_name character varying,created_date timestamp without time zone)
language 'plpgsql'
AS $$
BEGIN


IF tickt_id IS NOT NULL THEN
RETURN QUERY
 
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
WHERE (sb.id = tickt_id or -1=tickt_id);

ELSIF custid IS NOT NULL THEN
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.created_by =custid or -1=custid);

ELSIF empid IS NOT NULL THEN 
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.assign_to =empid or -1=empid);

END IF;
END;
$$;

SELECT * FROM fn_service_booking_list(tickt_id:=-1);--all service_booking list
SELECT * FROM fn_service_booking_list(custid:=1);--for customer wise service booking list
SELECT * FROM fn_service_booking_list(empid:=1);--for employee wise service booking list
------------------------------------------------
--Remodified by Anand A on 01-11-2025
--DROP FUNCTION IF EXISTS fn_service_booking_list;
create or replace function fn_service_booking_list(tickt_id bigint DEFAULT NULL,custid bigint DEFAULT NULL,empid bigint DEFAULT NULL)

returns table (id bigint,booking_id character varying,slot_id bigint,slot_time character varying,hours integer,add_on_hours integer,full_name character varying,phone character varying,email character varying,address character varying,assign_to bigint,employee_name character varying,employee_email character varying,status_id bigint,status character varying,dept_id bigint,department_name character varying,service_id bigint,service_name character varying,service_type_id bigint,service_type character varying,total numeric,subtotal numeric,customer_requested_amount numeric,discount_amount numeric,discount_percentage numeric,discount_total numeric,created_by bigint,customer_name character varying,created_date timestamp without time zone)
language 'plpgsql'
AS $$
BEGIN


IF custid IS NULL and empid IS NULL THEN
RETURN QUERY
 
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
WHERE (sb.id = tickt_id or -1=tickt_id);

ELSIF custid IS NOT NULL THEN
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.created_by =custid or -1=custid);

ELSIF empid IS NOT NULL THEN 
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.assign_to =empid or -1=empid);

END IF;
END;
$$;


SELECT * FROM fn_service_booking_list();--all service_booking list
SELECT * FROM fn_service_booking_list(custid:=1);--for customer wise service booking list
SELECT * FROM fn_service_booking_list(empid:=1);--for employee wise service booking list
-----------------------------------------------------------------------------
--Remodified by Anand A on 02-11-2025.
--Added new column in returns table 
CREATE OR REPLACE FUNCTION public.fn_service_booking_list(
    tickt_id bigint DEFAULT NULL::bigint,
    custid bigint DEFAULT NULL::bigint,
    empid bigint DEFAULT NULL::bigint)
    RETURNS TABLE(id bigint, booking_id character varying, slot_id bigint, slot_time character varying, hours integer, add_on_hours integer, full_name character varying, phone character varying, email character varying, address character varying, assign_to bigint, employee_name character varying, employee_email character varying, status_id bigint, status character varying, dept_id bigint, department_name character varying, service_id bigint, service_name character varying, service_type_id bigint, service_type character varying, total numeric, subtotal numeric, customer_requested_amount numeric, discount_amount numeric, discount_percentage numeric, discount_total numeric, created_by bigint, customer_name character varying, created_date timestamp without time zone, preferred_date date) 
    LANGUAGE plpgsql
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN


IF custid IS NULL and empid IS NULL THEN
RETURN QUERY
 
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
WHERE (sb.id = tickt_id or -1=tickt_id);

ELSIF custid IS NOT NULL THEN
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.created_by =custid or -1=custid);

ELSIF empid IS NOT NULL THEN 
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.assign_to =empid or -1=empid);

END IF;
END;
$BODY$;
---------------------------------------------------
--Remodified by Anand on 04-11-2025.
--Added Pagination logic for loading limited data and added columns room_sqfts,with_basement
--DROP FUNCTION IF EXISTS fn_service_booking_list;
CREATE OR REPLACE FUNCTION public.fn_service_booking_list(
    tickt_id bigint DEFAULT NULL::bigint,
    custid bigint DEFAULT NULL::bigint,
    empid bigint DEFAULT NULL::bigint,
	p_limit  int DEFAULT 100,
    p_offset int DEFAULT 0)
    RETURNS TABLE(id bigint, booking_id character varying, slot_id bigint, slot_time character varying, hours integer, add_on_hours integer, full_name character varying, phone character varying, email character varying, address character varying, assign_to bigint, employee_name character varying, employee_email character varying, status_id bigint, status character varying, dept_id bigint, department_name character varying, service_id bigint, service_name character varying, service_type_id bigint, service_type character varying, total numeric, subtotal numeric, customer_requested_amount numeric, discount_amount numeric, discount_percentage numeric, discount_total numeric, created_by bigint, customer_name character varying, created_date timestamp without time zone, preferred_date date,room_sqfts varchar,with_basement boolean) 
    LANGUAGE plpgsql
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN


IF custid IS NULL and empid IS NULL and tickt_id IS NOT NULL THEN
RETURN QUERY
 
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date,st.room_sqfts,st.with_basement
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
WHERE (sb.id = tickt_id or -1=tickt_id)
order by sb.id asc,sb.created_date desc
LIMIT p_limit OFFSET p_offset;

ELSIF custid IS NOT NULL THEN
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date,st.room_sqfts,st.with_basement
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.created_by =custid or -1=custid)
order by sb.id asc,sb.created_date desc
LIMIT p_limit OFFSET p_offset;

ELSIF empid IS NOT NULL THEN 
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date,st.room_sqfts,st.with_basement
from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.assign_to =empid or -1=empid)
order by sb.id asc,sb.created_date desc
LIMIT p_limit OFFSET p_offset;

END IF;
END;
$BODY$;

--------------------------------------------------
--6-11-2025 --re-modified for adding the withbasement_price_column
--drop function fn_service_booking_list;
CREATE OR REPLACE FUNCTION public.fn_service_booking_list(
    tickt_id bigint DEFAULT NULL::bigint,
    custid bigint DEFAULT NULL::bigint,
    empid bigint DEFAULT NULL::bigint,
	p_limit  int DEFAULT 100,
    p_offset int DEFAULT 0)
    RETURNS TABLE(id bigint, booking_id character varying, slot_id bigint, slot_time character varying, hours integer, add_on_hours integer, full_name character varying, phone character varying, email character varying, address character varying, assign_to bigint, employee_name character varying, employee_email character varying, status_id bigint, status character varying, dept_id bigint, department_name character varying, service_id bigint, service_name character varying, service_type_id bigint, service_type character varying, total numeric, subtotal numeric, customer_requested_amount numeric, discount_amount numeric, discount_percentage numeric, discount_total numeric, created_by bigint, customer_name character varying, created_date timestamp without time zone, preferred_date date,room_sqfts varchar,with_basement boolean,with_basement_price numeric,without_basement_price numeric) 
    LANGUAGE plpgsql
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN


IF custid IS NULL and empid IS NULL and tickt_id IS NOT NULL THEN
RETURN QUERY
 
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date,st.room_sqfts,st.with_basement,
CASE WHEN st.with_basement = TRUE THEN st.with_basement_price else 0 END AS with_basement_price,
CASE WHEN st.with_basement = False THEN st.with_basement_price else 0 END AS without_basement_price

from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
WHERE (sb.id = tickt_id or -1=tickt_id)
order by sb.id asc,sb.created_date desc
LIMIT p_limit OFFSET p_offset;

ELSIF custid IS NOT NULL THEN
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date,st.room_sqfts,st.with_basement,
CASE WHEN st.with_basement = TRUE THEN st.with_basement_price else 0 END AS with_basement_price,
CASE WHEN st.with_basement = False THEN st.with_basement_price else 0 END AS without_basement_price

from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.created_by =custid or -1=custid)
order by sb.id asc,sb.created_date desc
LIMIT p_limit OFFSET p_offset;

ELSIF empid IS NOT NULL THEN 
RETURN QUERY
select sb.id,sb.booking_id,sb.slot_id,ms.slot_time,sb.hours,sb.add_on_hours,sb.full_name,sb.phone,sb.email,sb.address,sb.assign_to,concat_ws(' ',ur.first_name ,ur.last_name)::varchar as employee_name,ur.email as employee_email,
sb.status_id,ms2.status,st.dept_id,md.department_name,st.service_id,msc.service_name,st.service_type_id,mst.service_type,
sb.total,sb.subtotal,sb.customer_requested_amount,sb.discount_amount,sb.discount_percentage,sb.discount_total,
sb.created_by,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar as customer_name,sb.created_date,sb.preferred_date,st.room_sqfts,st.with_basement,
CASE WHEN st.with_basement = TRUE THEN st.with_basement_price else 0 END AS with_basement_price,
CASE WHEN st.with_basement = False THEN st.with_basement_price else 0 END AS without_basement_price

from service_booking sb 
join service_tracking st on st.service_booking_id = sb.id and sb.is_active =true and st.is_active =true 
left join master_slots ms on ms.id = sb.slot_id and ms.is_active =true
left join master_department md on md.id = st.dept_id and md.is_active =true
left join master_service msc on msc.id = st.service_id and msc.is_active = true
left join master_service_type mst on mst.id = st.service_type_id and mst.is_active =true
left join master_status ms2 on ms2.id = sb.status_id and ms2.is_active =true
left join user_registration ur on ur.id = sb.assign_to and ur.is_active = true and ur.role_id = 3
left join user_registration ur2 on ur2.id = sb.created_by and ur2.is_active =true and ur2.role_id =4
where (sb.assign_to =empid or -1=empid)
order by sb.id asc,sb.created_date desc
LIMIT p_limit OFFSET p_offset;

END IF;
END;
$BODY$;

