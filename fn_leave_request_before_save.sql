-- DROP FUNCTION fn_leave_request_before_save() cascade;
CREATE OR REPLACE FUNCTION public.fn_leave_request_before_save()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_days numeric := 0;
    v_start numeric;
    v_end numeric;
BEGIN
	--Authored by Anand A on 23-12-2025
    IF NEW.start_date IS NOT NULL AND NEW.end_date IS NOT NULL THEN

        -- session value mapping
        v_start := CASE NEW.from_date_session
                        WHEN 1 THEN 0.5  -- Half Day
                        WHEN 2 THEN 1.0  -- Full Day
                   END;

        v_end := CASE NEW.to_date_session
                      WHEN 1 THEN 0.5
                      WHEN 2 THEN 1.0
                 END;

        IF NEW.start_date = NEW.end_date THEN
            -- same day leave
            v_days := GREATEST(v_start, v_end);

        ELSE
            -- multiple days
            v_days :=
                -- first day
                v_start
                -- last day
                + v_end
                -- middle full days
                + GREATEST((NEW.end_date - NEW.start_date - 1), 0);
        END IF;

        NEW.total_days := v_days;
    END IF;

    IF (NEW.approver_id <> OLD.approver_id) OR (OLD.approver_id IS NULL AND NEW.approver_id IS NOT NULL) OR (OLD.approver_id IS NOT NULL AND NEW.approver_id IS NULL) THEN
         NEW.approved_on := NOW();
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER tr_leave_request_total_days
BEFORE INSERT OR UPDATE
ON leave_request
FOR EACH ROW
EXECUTE FUNCTION public.fn_leave_request_before_save();
