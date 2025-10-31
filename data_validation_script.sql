--Authored by Anand A.
--to get list for departments under services list in portal.
SELECT md.id AS department_id,md.department_name,ms.id AS service_id,ms.service_name,mst.id AS service_type_id,mst.service_type,mst.price,mst.hours  
FROM master_department md 
LEFT JOIN master_service ms ON ms.dept_id = md.id AND ms.is_active =TRUE
LEFT JOIN master_service_mapping msm ON msm.service_id = ms.id AND msm.is_active = TRUE
LEFT JOIN master_service_type mst ON mst.id = msm.service_type_id AND mst.is_active =TRUE
------------------------------------
--Authored by Anand on 31-10-2025.
--to remove all related departments.
delete from master_service_mapping where service_id in 
(select id from master_service where dept_id in 
(select id from master_department where id = 6));

delete from master_service where dept_id in 
(select id from master_department where id = 6);

delete from master_department where id=6;

