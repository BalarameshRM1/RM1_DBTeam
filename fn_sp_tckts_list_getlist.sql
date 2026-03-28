--support_tickets Function
CREATE OR REPLACE FUNCTION public.fn_sp_tckts_list_getlist(
	sptktid bigint)
    RETURNS TABLE(id bigint, customer_id bigint,  customer_name character varying, product_id bigint,product_name varchar,
	    order_id bigint,order_date character varying,total numeric,subject_id bigint, subject_name character varying,description text,
		created_by bigint, created_by_name character varying, created_date character varying, modified_by bigint, 
		modified_by_name character varying, modified_date character varying, is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin 
return query
select sp.id, sp.customer_id, concat_ws(' ',c.first_name ,c.last_name)::varchar as customer_name,sp.product_id,p.product_name,
       sp.order_id,to_char(o.order_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  order_date, o.total, sp.subject_id, ms.description as subject_name,sp.description,
       sp.created_by ,concat_ws(' ',ur.first_name ,ur.last_name)::varchar created_by_name,to_char(sp.created_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  created_date ,
       sp.modified_by ,concat_ws(' ',ur1.first_name ,ur1.last_name)::varchar modified_by_name,to_char(sp.modified_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  modified_date,
	   sp.is_active 
from support_tickets sp  
left join products p on p.id = sp.product_id
left join customer c  on sp.customer_id = c.id and sp.is_active =true and c.is_active =true
left join user_registration ur on ur.id = sp.created_by
left join user_registration ur1 on ur1.id = sp.modified_by
left join orders o on o.id = sp.order_id and o.is_active =true
left join master_subject ms on ms.id = sp.subject_id and ms.is_active =true
where (sp.id = sptktid or -1=sptktid);

end;
$BODY$;

--drop function fn_sp_tckts_list_getlist;

select * from fn_sp_tckts_list_getlist(-1);