create or replace function fn_check_customer_role()
returns trigger as $$
begin

IF NOT EXISTS (SELECT 1 FROM user_registration where id = NEW.user_id and role_id=3)

THEN RAISE EXCEPTION 'User (id=%) is not allowed in customer table because role_id is not 3 (Customer)',NEW.user_id;    

END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create or replace trigger tr_ck_customer_role
BEFORE INSERT OR UPDATE ON customer
FOR EACH ROW 
EXECUTE FUNCTION fn_check_customer_role();