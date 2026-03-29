--Authored by Anand A.
--to get list for departments under services list in portal.
select msm.id,msm.service_id,ms.service_name,msm.dept_id,md.department_name 
from master_service_mapping msm 
join master_service ms on ms.id = msm.service_id and msm.is_active= true and ms.is_active=true
join master_department md ON md.id = msm.dept_id and md.is_active=true;