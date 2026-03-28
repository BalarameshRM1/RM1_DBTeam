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

--modified on 06-11-2025

CREATE OR REPLACE FUNCTION public.fn_products_list_getlist(
	prdctid bigint)
    RETURNS TABLE(id bigint, product_name character varying, category_id bigint, category_name character varying,
	              stock integer,
				  price numeric,
				  product_status_id bigint, product_status character varying,
				  is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin 
return query
select p.id, p.product_name, p.category_id, c.category_name,
p.stock,
p.price,
p.product_status_id, ps.product_status,
p.is_active 
from products p  
left join master_category c  on p.category_id = c.id and p.is_active =true and c.is_active =true
left join master_product_status ps  on p.product_status_id = ps.id and ps.is_active =true 
where (p.id = prdctid or -1=prdctid);

end;
$BODY$;

---modified on 11-11-2025

CREATE OR REPLACE FUNCTION public.fn_products_list_getlist(
	prdctid bigint)
    RETURNS TABLE(id bigint, product_name character varying, category_id bigint, category_name character varying,
	              stock integer,
				  price numeric,
				  product_status_id bigint, product_status character varying,
				  is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin 
return query
select p.id, p.product_name, p.category_id, c.category_name,
p.stock,
p.price,
p.product_status_id, ps.product_status,
p.is_active 
from products p  
left join master_category c  on p.category_id = c.id and p.is_active =true and c.is_active =true
left join master_product_status ps  on p.product_status_id = ps.id and ps.is_active =true 
where (p.id = prdctid or -1=prdctid)
order by 1;

end;
$BODY$;

---------modified on 12-11-2025
CREATE OR REPLACE FUNCTION public.fn_products_list_getlist(
	prdctid bigint)
    RETURNS TABLE(id bigint, product_name character varying, category_id bigint, category_name character varying,
	              stock integer,
				  price numeric,
				  product_status_id bigint, product_status character varying,
				  is_active boolean) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin 
return query
select p.id, p.product_name, p.category_id, c.category_name,
i.stock,
p.price,
i.product_status_id, ps.product_status,
p.is_active 
from products p  
left join master_category c  on p.category_id = c.id and p.is_active =true and c.is_active =true
left join master_product_status ps  on p.product_status_id = ps.id and ps.is_active =true 
left join inventory i on i.product_id = p.id and i.is_active = true
where (p.id = prdctid or -1=prdctid)
order by 1;

end;
$BODY$;



