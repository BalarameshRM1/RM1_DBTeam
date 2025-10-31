--DROP FUNCTION fn_create_master_departments;
CREATE OR REPLACE FUNCTION fn_create_master_departments(
    p_department_id INT DEFAULT NULL,
    p_department_name VARCHAR DEFAULT NULL,
    p_service_id INT DEFAULT NULL,
    p_service_name VARCHAR DEFAULT NULL,
    p_service_type_id INT DEFAULT NULL,
    p_service_type VARCHAR DEFAULT NULL,
    p_price NUMERIC DEFAULT NULL
)
RETURNS TABLE (
    department_id INT,
    service_id INT,
    service_type_id INT
) AS $$
DECLARE
    v_department_id INT;
    v_service_id INT;
    v_service_type_id INT;

    v_inserted_department BOOLEAN := FALSE;
    v_inserted_service BOOLEAN := FALSE;
    v_inserted_service_type BOOLEAN := FALSE;
BEGIN
    -- Department
    IF p_department_id IS NOT NULL THEN
        UPDATE master_department d
        SET department_name = COALESCE(p_department_name, d.department_name)
        WHERE d.id = p_department_id;
        v_department_id := p_department_id;

    ELSIF p_department_name IS NOT NULL THEN
        PERFORM setval(pg_get_serial_sequence('master_department', 'id'),
                       COALESCE((SELECT MAX(id) + 1 FROM master_department), 1),
                       FALSE);

        BEGIN
            INSERT INTO master_department (department_name, is_active)
            VALUES (p_department_name, TRUE)
            ON CONFLICT (department_name)
            DO UPDATE SET department_name = EXCLUDED.department_name
            RETURNING id INTO v_department_id;
        EXCEPTION WHEN others THEN
            INSERT INTO master_department (department_name, is_active)
            VALUES (p_department_name, TRUE)
            RETURNING id INTO v_department_id;
        END;
        v_inserted_department := TRUE;
    END IF;

    -- Service
    IF p_service_id IS NOT NULL THEN
        UPDATE master_service s
        SET service_name = COALESCE(p_service_name, s.service_name),
            dept_id = COALESCE(p_department_id, v_department_id, s.dept_id)
        WHERE s.id = p_service_id;
        v_service_id := p_service_id;

    ELSIF p_service_name IS NOT NULL THEN
        IF COALESCE(p_department_id, v_department_id) IS NULL THEN
            RAISE EXCEPTION 'Department ID required for new service';
        END IF;

        PERFORM setval(pg_get_serial_sequence('master_service', 'id'),
                       COALESCE((SELECT MAX(id) FROM master_service), 0) + 1,
                       FALSE);

        BEGIN
            INSERT INTO master_service (service_name, dept_id, is_active)
            VALUES (p_service_name, COALESCE(p_department_id, v_department_id), TRUE)
            ON CONFLICT (service_name, dept_id)
            DO UPDATE SET service_name = EXCLUDED.service_name
            RETURNING id INTO v_service_id;
        EXCEPTION WHEN others THEN
            INSERT INTO master_service (service_name, dept_id, is_active)
            VALUES (p_service_name, COALESCE(p_department_id, v_department_id), TRUE)
            RETURNING id INTO v_service_id;
        END;
        v_inserted_service := TRUE;
    END IF;

    --  Service Type
    IF p_service_type_id IS NOT NULL THEN
        UPDATE master_service_type st
        SET service_type = COALESCE(p_service_type, st.service_type),
            price = COALESCE(p_price, st.price)
        WHERE st.id = p_service_type_id;
        v_service_type_id := p_service_type_id;

    ELSIF p_service_type IS NOT NULL THEN
        PERFORM setval(pg_get_serial_sequence('master_service_type', 'id'),
                       COALESCE((SELECT MAX(id) FROM master_service_type), 0) + 1,
                       FALSE);

        BEGIN
            INSERT INTO master_service_type (service_type, price, is_active)
            VALUES (p_service_type, p_price, TRUE)
            ON CONFLICT (service_type)
            DO UPDATE SET price = EXCLUDED.price
            RETURNING id INTO v_service_type_id;
        EXCEPTION WHEN others THEN
            SELECT id INTO v_service_type_id
            FROM master_service_type st
            WHERE st.service_type = p_service_type
            LIMIT 1;

            IF v_service_type_id IS NULL THEN
                INSERT INTO master_service_type (service_type, price, is_active)
                VALUES (p_service_type, p_price, TRUE)
                RETURNING id INTO v_service_type_id;
            ELSE
                UPDATE master_service_type st
                SET price = COALESCE(p_price, st.price)
                WHERE st.id = v_service_type_id;
            END IF;
        END;

        v_inserted_service_type := TRUE;
    END IF;

    -- Mapping
    IF COALESCE(p_service_id, v_service_id) IS NOT NULL 
       AND COALESCE(p_service_type_id, v_service_type_id) IS NOT NULL THEN
        PERFORM setval(pg_get_serial_sequence('master_service_mapping', 'id'),
                       COALESCE((SELECT MAX(id) FROM master_service_mapping), 0) + 1,
                       FALSE);

        BEGIN
            INSERT INTO master_service_mapping (service_id, service_type_id, is_active)
            VALUES (COALESCE(p_service_id, v_service_id),
                    COALESCE(p_service_type_id, v_service_type_id),
                    TRUE)
            ON CONFLICT (service_id, service_type_id)
            DO UPDATE SET is_active = TRUE;
        EXCEPTION WHEN others THEN
            IF NOT EXISTS (
                SELECT 1 FROM master_service_mapping m
                WHERE m.service_id = COALESCE(p_service_id, v_service_id)
                  AND m.service_type_id = COALESCE(p_service_type_id, v_service_type_id)
            ) THEN
                INSERT INTO master_service_mapping (service_id, service_type_id, is_active)
                VALUES (COALESCE(p_service_id, v_service_id),
                        COALESCE(p_service_type_id, v_service_type_id),
                        TRUE);
            ELSE
                UPDATE master_service_mapping m
                SET is_active = TRUE
                WHERE m.service_id = COALESCE(p_service_id, v_service_id)
                  AND m.service_type_id = COALESCE(p_service_type_id, v_service_type_id);
            END IF;
        END;
    END IF;

    --Sequence sync after inserts
    IF v_inserted_department THEN
        PERFORM setval(pg_get_serial_sequence('master_department', 'id'),
                       COALESCE((SELECT MAX(id) FROM master_department), 0) + 1,
                       FALSE);
    END IF;

    IF v_inserted_service THEN
        PERFORM setval(pg_get_serial_sequence('master_service', 'id'),
                       COALESCE((SELECT MAX(id) FROM master_service), 0) + 1,
                       FALSE);
    END IF;

    IF v_inserted_service_type THEN
        PERFORM setval(pg_get_serial_sequence('master_service_type', 'id'),
                       COALESCE((SELECT MAX(id) FROM master_service_type), 0) + 1,
                       FALSE);
    END IF;

    PERFORM setval(pg_get_serial_sequence('master_service_mapping', 'id'),
                   COALESCE((SELECT MAX(id) FROM master_service_mapping), 0) + 1,
                   FALSE);

    --------------------------------------------------------------------
    RETURN QUERY SELECT v_department_id, v_service_id, v_service_type_id;
END;
$$ LANGUAGE plpgsql;