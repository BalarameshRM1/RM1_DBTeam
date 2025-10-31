CREATE OR REPLACE FUNCTION fn_get_all_masters_data()
RETURNS JSON AS
$$
DECLARE
    result JSON;departments_data JSON;roles_data JSON;slots_data JSON;gender_data JSON;location_data JSON;status_data JSON;
BEGIN
SELECT json_agg(row_to_json(t)) INTO departments_data
FROM (SELECT md.id AS department_id,md.department_name,ms.id AS service_id,ms.service_name,mst.id AS service_type_id,mst.service_type,mst.price,mst.hours  
      FROM master_department md 
      LEFT JOIN master_service ms ON ms.dept_id = md.id AND ms.is_active =TRUE
      LEFT JOIN master_service_mapping msm ON msm.service_id = ms.id AND msm.is_active = TRUE
      LEFT JOIN master_service_type mst ON mst.id = msm.service_type_id AND mst.is_active =TRUE) t;

SELECT json_agg(row_to_json(r)) INTO roles_data FROM master_role r;

SELECT json_agg(row_to_json(ms)) INTO slots_data FROM master_slots ms;

SELECT json_agg(row_to_json(mg)) INTO gender_data FROM master_gender mg;

SELECT json_agg(row_to_json(ml)) INTO location_data FROM master_location ml;

SELECT json_agg(row_to_json(ms)) INTO status_data FROM master_status ms;

SELECT json_build_object(
'departments', COALESCE(departments_data, '[]'::json),
'roles', COALESCE(roles_data, '[]'::json),
'slots',COALESCE(slots_data,'[]'::json),
'gender',COALESCE(gender_data,'[]'::json),
'locations',COALESCE(location_data,'[]'::json),
'status',COALESCE(status_data,'[]'::json)) INTO result;

RETURN result;
END;
$$
LANGUAGE plpgsql;


SELECT fn_get_all_masters_data();
-----------------------------------------------------------
--Remodified by Anand A on 01-11-2025.
--DROP FUNCTION fn_get_all_masters_data;

CREATE OR REPLACE FUNCTION fn_get_all_masters_data()
RETURNS JSON AS
$$
DECLARE
    result JSON;
    departments_data JSON;
    roles_data JSON;
    slots_data JSON;
    gender_data JSON;
    location_data JSON;
    status_data JSON;
BEGIN
SELECT json_agg(row_to_json(d)) INTO departments_data
FROM (SELECT md.id AS department_id,md.department_name,
      COALESCE((SELECT json_agg(row_to_json(s))
      FROM (SELECT ms.id AS service_id,ms.service_name,
            COALESCE((SELECT json_agg(row_to_json(st))
            FROM (SELECT DISTINCT mst.id AS service_type_id,mst.service_type,mst.price,mst.hours
 	              FROM master_service_mapping msm
                  JOIN master_service_type mst ON mst.id = msm.service_type_id
                  WHERE msm.service_id = ms.id AND msm.is_active = TRUE AND mst.is_active = TRUE
                  ORDER BY mst.id) st), '[]'::json) AS service_types
                  FROM master_service ms
                  WHERE ms.dept_id = md.id AND ms.is_active = TRUE ORDER BY ms.id) s), '[]'::json) AS services
FROM master_department md
WHERE md.is_active = TRUE
ORDER BY md.id) d;

SELECT json_agg(row_to_json(r)) INTO roles_data 
FROM master_role r
WHERE r.is_active = TRUE;

SELECT json_agg(row_to_json(ms)) INTO slots_data 
FROM master_slots ms
WHERE ms.is_active = TRUE;

SELECT json_agg(row_to_json(mg)) INTO gender_data 
FROM master_gender mg
WHERE mg.is_active = TRUE;

SELECT json_agg(row_to_json(ml)) INTO location_data 
FROM master_location ml
WHERE ml.is_active = TRUE;

SELECT json_agg(row_to_json(ms)) INTO status_data 
FROM master_status ms
WHERE ms.is_active = TRUE;

SELECT json_build_object('departments', COALESCE(departments_data, '[]'::json),'roles',COALESCE(roles_data, '[]'::json),
'slots', COALESCE(slots_data, '[]'::json),'gender', COALESCE(gender_data, '[]'::json),'locations', COALESCE(location_data, '[]'::json),
'status', COALESCE(status_data, '[]'::json)) INTO result;

RETURN result;
END;
$$
LANGUAGE plpgsql;

SELECT fn_get_all_masters_data();
