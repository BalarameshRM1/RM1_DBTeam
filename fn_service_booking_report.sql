CREATE OR REPLACE FUNCTION public.fn_service_booking_report(ticket_id bigint)
    RETURNS TABLE(id bigint, 
	booking_id character varying,
	dept_id bigint, 
	department_name character varying,
	service_id bigint, 
	service_name character varying,
	slot_id bigint,
	slot_time character varying,
	preferred_date date,
	address character varying, 
	status_id bigint,
	status character varying, 
	assign_to bigint,
	assign_to_name character varying, 
	created_by bigint,
	created_by_name character varying, 
	created_date timestamp without time zone,
	modified_by bigint,
	modified_by_name character varying, 
	modified_date timestamp without time zone
	) 
	LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY

with ur as (select *   
            from user_registration   
            where is_active =true)  

select sb.id,sb.booking_id,sb.dept_id,md.department_name,sb.service_id,ms.service_name,sb.slot_id,mst.slot_time,sb.preferred_date,
sb.address,sb.status_id,mss.status,sb.assign_to,concat_ws(' ',user3.first_name,user3.last_name)::varchar as assign_to_name,  
sb.created_by,concat_ws(' ',user1.first_name,user1.last_name)::varchar as created_by_name,sb.created_date,  
sb.modified_by,concat_ws(' ',user2.first_name,user2.last_name)::varchar as modified_by_name,sb.modified_date 
from service_booking sb  
left join master_department md on md.id = sb.service_id and sb.is_active=true and md.is_active=true  
left join master_service ms on ms.id = sb.service_id and ms.is_active=true  
left join master_slots mst on mst.id = sb.slot_id and mst.is_active=true  
left join ur user1 on user1.id = sb.created_by and user1.is_active=true  
left join ur user2 on sb.modified_by=user2.id and user2.is_active=true  
left join ur user3 on user3.id = sb.assign_to and user3.is_active=true  
left join master_status mss on mss.id = sb.status_id and mss.is_active=true  
where (sb.id = ticket_id or -1=ticket_id)  
order by 1;
END;
$BODY$;
    
