CREATE OR REPLACE FUNCTION public.fn_products_list_getlist(
	prdctid bigint)
    RETURNS TABLE(id bigint, product_name character varying, category_id bigint, category_name character varying, price numeric, is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin 
return query
select p.id, p.product_name, p.category_id, c.category_name, p.price, p.is_active 
from products p  
left join master_category c  on p.category_id = c.id and p.is_active =true and c.is_active =true
where (p.id = prdctid or -1=prdctid);

end;
$BODY$;

select * from fn_products_list_getlist(-1);