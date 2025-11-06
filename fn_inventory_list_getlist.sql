--inventory Function
CREATE OR REPLACE FUNCTION public.fn_inventory_list_getlist(
	invtid bigint)
    RETURNS TABLE(id bigint, product_id bigint, product_name character varying,
	            stock integer, created_by bigint, created_date character varying,
				 modified_by bigint, modified_date character varying,  is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin 
return query
select i.id, i.product_id, p.product_name, i.stock,
       i.created_by, to_char(i.created_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  created_date, i.modified_by, 
	   to_char(i.modified_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  modified_date, i.is_active 
from inventory i   
left join products p  on i.product_id = p.id and p.is_active =true and i.is_active =true
where (i.id = invtid or -1=invtid);

end;
$BODY$;

select * from fn_inventory_list_getlist(-1);

--modified on 06-11-2025

CREATE OR REPLACE FUNCTION public.fn_inventory_list_getlist(
	invtid bigint)
    RETURNS TABLE(id bigint, product_id bigint, product_name character varying,
	            category_id bigint, category_name character varying, price numeric,
	            stock integer, created_by bigint, created_date character varying,
				 modified_by bigint, modified_date character varying,  is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000
AS $BODY$
begin 
return query
select i.id, i.product_id, p.product_name,
       i.category_id, mc.category_name, i.price,
       i.stock,
       i.created_by, to_char(i.created_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  created_date, i.modified_by, 
	   to_char(i.modified_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  modified_date, i.is_active 
from inventory i   
left join products p  on i.product_id = p.id and p.is_active =true and i.is_active =true
left join master_category mc  on i.category_id = mc.id and mc.is_active =true 
where (i.id = invtid or -1=invtid);
end;
$BODY$;
