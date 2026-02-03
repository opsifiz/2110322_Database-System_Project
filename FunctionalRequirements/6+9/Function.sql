CREATE OR REPLACE FUNCTION delete_booking(
    p_booking_id INT,
    p_user_id INT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_role user_role;
    v_booking_owner INT;
BEGIN
    -- Get role of caller
    SELECT role
    INTO v_role
    FROM users
    WHERE id = p_user_id;

    -- User does not exist
    IF NOT FOUND THEN
        RETURN;
    END IF;

    -- Get booking owner
    SELECT user_id
    INTO v_booking_owner
    FROM booking_data
    WHERE booking_id = p_booking_id;

    -- Booking does not exist
    IF NOT FOUND THEN
        RETURN;
    END IF;

    -- Admin can delete any booking
    IF v_role = 'admin' THEN
        DELETE FROM booking_data
        WHERE booking_id = p_booking_id;

    -- User can delete only own booking
    ELSIF v_role = 'user' AND v_booking_owner = p_user_id THEN
        DELETE FROM booking_data
        WHERE booking_id = p_booking_id;
    END IF;

END;
$$;