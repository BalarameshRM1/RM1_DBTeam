--Authored by Anand A on 24-10-2025
--drop function fn_orders_list_getlist;

create or replace function fn_orders_list_getlist(customerid bigint)
returns table(id bigint,customer_id bigint,customer_name character varying,product_id bigint,product_name character varying,price numeric,status_id bigint,status character varying,order_date character varying,total numeric,created_by bigint,created_by_name character varying,created_date character varying,modified_by bigint,modified_by_name character varying,modified_date character varying,is_active boolean)
language 'plpgsql'
as $$
begin 
return query
select o.id,o.customer_id,concat_ws(' ',c.first_name ,c.last_name)::varchar as customer_name,
o.product_id ,p.product_name ,p.price ,o.status_id ,ms.status ,to_char(o.order_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  order_date ,
o.total ,o.created_by ,concat_ws(' ',ur.first_name ,ur.last_name)::varchar created_by_name,to_char(o.created_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  created_date ,
o.modified_by ,concat_ws(' ',ur2.first_name ,ur2.last_name)::varchar modified_by_name,to_char(o.modified_date,'DD-MM-YYYY HH12:MI:SS AM')::varchar as  modified_date,o.is_active 
from orders o  
left join customer c  on o.customer_id = c.id and c.is_active =true and o.is_active =true
left join products p on p.id = o.product_id and p.is_active =true
left join master_status ms on ms.id = o.status_id and ms.is_active =true
left join user_registration ur on ur.id = o.created_by and ur.is_active =true
left join user_registration ur2 on ur2.id = o.modified_by and ur2.is_active =true
where (o.customer_id = customerid or -1=customerid);

end;
$$;