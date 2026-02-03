CREATE OR REPLACE FUNCTION editCampgroundBooking(
    p_request_user_id INT,
    p_target_user_id INT,
    p_booking_id INT,
    p_old_campground_id INT,
    p_new_campground_id INT,
    p_old_tent_id INT,
    p_new_tent_id INT,
    p_new_start_date DATE,
    p_new_end_date DATE
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_role user_role;
    v_booked_at TIMESTAMP;
BEGIN
    SELECT u.role INTO v_role
    FROM users u
    WHERE u.user_id = p_request_user_id;

    IF v_role IS NULL THEN
        RAISE EXCEPTION 'Requesting user does not exist';
    END IF;

    IF v_role <> 'admin' AND p_request_user_id <> p_target_user_id THEN
        RAISE EXCEPTION 'Users may only edit their own bookings';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM booking b
        WHERE b.user_id = p_target_user_id
          AND b.booking_id = p_booking_id
          AND b.campground_id = p_old_campground_id
          AND b.tent_id = p_old_tent_id
    ) THEN
        RAISE EXCEPTION 'Booking not found (or mismatched old campground/tent)';
    END IF;

    IF (p_new_end_date - p_new_start_date + 1) > 3 THEN
        RAISE EXCEPTION 'Cannot book the tent more than 3 days';
    END IF;

    SELECT b.book_at INTO v_booked_at
    FROM booking b
    WHERE b.user_id = p_target_user_id
      AND b.booking_id = p_booking_id
    FOR UPDATE;

    IF CURRENT_TIMESTAMP >= v_booked_at + INTERVAL '7 days' THEN
        RAISE EXCEPTION 'Cannot edit booking after 7 days';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM tents t
        WHERE t.campground_id = p_new_campground_id
          AND t.tent_id = p_new_tent_id
    ) THEN
        RAISE EXCEPTION 'Tent % not found in campground %', p_new_tent_id, p_new_campground_id;
    END IF;

    IF NOT canBookEdit(
        p_target_user_id,
        p_booking_id,
        p_new_campground_id,
        p_new_tent_id,
        p_new_start_date,
        p_new_end_date
    ) THEN
        RAISE EXCEPTION 'Tent is not available for the selected dates';
    END IF;

    UPDATE booking
    SET campground_id = p_new_campground_id,
        tent_id = p_new_tent_id,
        start_date = p_new_start_date,
        end_date = p_new_end_date
    WHERE user_id = p_target_user_id
      AND booking_id = p_booking_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Update failed';
    END IF;
END;
$$;
