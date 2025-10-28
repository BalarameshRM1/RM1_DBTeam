create or replace view vw_dashboard_report AS
    select c.id as customer_id, concat(c.first_name ,' ', c.last_name)::varchar as customer_name, o.id as order_id, 
    o.product_id, p.product_name,p.category_id, mc.category_name, o.quantity, p.price, o.total,
    o.order_date, i.stock, ur.created_date
from user_registration ur
join customer c  on c.user_id = ur.id and c.is_active =true and ur.is_active =true
left join orders o on o.customer_id = c.id and o.is_active =true
left join products p on p.id = o.product_id and p.is_active =true
left join inventory i on p.id = i.product_id and i.is_active =true
left join master_status ms on ms.id = o.status_id and ms.is_active =true
left join master_category mc on mc.id = p.category_id and mc.is_active = true
where ur.role_id=3
order by 1;

--added status
create or replace view vw_dashboard_report AS
    select c.id as customer_id, concat(c.first_name ,' ', c.last_name)::varchar as customer_name, o.id as order_id, 
    o.product_id, p.product_name, p.category_id, mc.category_name, o.quantity, p.price, o.total,
    o.order_date, o.status_id, ms.status, i.stock, ur.created_date
from user_registration ur
join customer c  on c.user_id = ur.id and c.is_active =true and ur.is_active =true
left join orders o on o.customer_id = c.id and o.is_active =true
left join products p on p.id = o.product_id and p.is_active =true
left join inventory i on p.id = i.product_id and i.is_active =true
left join master_status ms on ms.id = o.status_id and ms.is_active =true
left join master_category mc on mc.id = p.category_id and mc.is_active = true
where ur.role_id=3
order by 1;
