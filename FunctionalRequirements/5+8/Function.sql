CREATE OR REPLACE FUNCTION editCampgroundBooking(
    p_request_user_id INT,
    p_role TEXT,
    p_campground_id INT,
    p_old_tent_id INT,
    p_new_tent_id INT,
    p_new_start_date DATE,
    p_new_end_date DATE
)
RETURNS VOID
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_role <> 'admin' THEN
        IF NOT EXISTS (
            SELECT 1
            FROM booking b
            WHERE b.user_id = p_request_user_id
              AND b.campground_id = p_campground_id
              AND b.tent_id = p_old_tent_id
        ) THEN
            RAISE EXCEPTION 'Not allowed to edit this booking';
        END IF;
    END IF;

    IF NOT canBook(
        p_request_user_id,
        p_campground_id,
        p_new_tent_id,
        p_new_start_date,
        p_new_end_date
    ) THEN
        RAISE EXCEPTION 'Tent is not available for the selected dates';
    END IF;

    UPDATE booking
    SET tent_id = p_new_tent_id,
        start_date = p_new_start_date,
        end_date = p_new_end_date
    WHERE user_id = p_request_user_id
      AND campground_id = p_campground_id
      AND tent_id = p_old_tent_id;
END;
$$;