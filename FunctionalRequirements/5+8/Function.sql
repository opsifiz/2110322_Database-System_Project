CREATE OR REPLACE FUNCTION editCampgroundBooking(
    p_request_user_id TEXT,
    p_role TEXT,
    p_booking_id TEXT,

    p_new_start_date DATE,
    p_new_end_date DATE,

    p_new_tent_id TEXT
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    -- 1) Permission: user can only edit their own booking (admin can edit any)
    IF p_role <> 'admin' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM Booking b
            WHERE b.booking_id = p_booking_id
              AND b.user_id = p_request_user_id
        ) THEN
            RAISE EXCEPTION 'Not allowed to edit this booking';
        END IF;
    END IF;

    UPDATE BookingData bd
    SET start_date = p_new_start_date,
        end_date = p_new_end_date
    WHERE bd.booking_id = p_booking_id;

    UPDATE Booking b
    SET tent_id = p_new_tent_id
    WHERE b.booking_id = p_booking_id;

END;
$$;