create or replace function fn_users_list(userid bigint,roleid bigint)
returns table (user_id bigint,user_name character varying,role_id bigint,role_name character varying,email character varying,mobile character varying,age bigint,gender_id bigint,dept_id bigint,department_name character varying,service_id bigint,service_name character varying,location_id bigint,location_name character varying)
language 'plpgsql'
as $$
begin
return query
select ur.id  as user_id,concat_ws(' ',ur.first_name,ur.last_name)::varchar as user_name,ur.role_id,mr.role_name,ur.email,ur.mobile,
ur.age,ur.gender_id,ur.dept_id,md.department_name,ur.service_id,ms.service_name,ur.location_id,ml.location_name
from user_registration ur 
join master_role mr on mr.id = ur.role_id and ur.is_active =true and mr.is_active =true
left join master_gender mg on mg.id = ur.gender_id and mg.is_active =true
left join master_location ml on ml.id = ur.location_id and ml.is_active =true
left join master_department md on md.id = ur.dept_id and md.is_active =true
left join master_service ms on ms.id = ur.service_id and ms.is_active =true
where (ur.id = userid or -1=userid) and (ur.role_id = roleid or -1=roleid)
order by 1;
end;
$$;


select * from fn_users_list(-1,1);
select * from fn_users_list(userid, roleid)