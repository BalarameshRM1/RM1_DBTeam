--Authored by Anand A on 29-11-2025.
---- Tracks and stores previous profile details before user updates

create or replace function fn_pre_profile_history()
returns trigger 
LANGUAGE plpgsql
as $$
begin
INSERT INTO users_pre_profile_history (full_name,email,mobile,password,gender_id,dob,age,role_id,state_id,district_id,created_by,created_date,modified_by,is_active,profile_image,skill_id,experience_summary,experience_doc,government_id,first_name,last_name,unique_id) 
select old.full_name,old.email,old.mobile,old.password,old.gender_id,old.dob,old.age,old.role_id,old.state_id,old.district_id,old.created_by,old.created_date,old.modified_by,old.is_active,old.profile_image,old.skill_id,old.experience_summary,old.experience_doc,old.government_id,old.first_name,old.last_name,old.unique_id
from users; 
RETURN new;
END;
$$

CREATE TRIGGER tr_pre_profile_tracking 
AFTER UPDATE OF full_name,email,mobile,password,gender_id,dob,age,role_id,state_id,district_id,created_by,created_date,modified_by,is_active,profile_image,skill_id,experience_summary,experience_doc,government_id,first_name,last_name,unique_id
ON user_registration
FOR EACH ROW 
EXECUTE procedure fn_pre_profile_history()