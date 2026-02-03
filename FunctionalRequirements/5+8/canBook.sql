CREATE OR REPLACE FUNCTION canBookEdit(
    p_user_id INT,
    p_booking_id INT,
    p_campground_id INT,
    p_tent_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_end_date < p_start_date THEN
        RETURN FALSE;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM booking b
        WHERE b.campground_id = p_campground_id
          AND b.tent_id = p_tent_id
          AND NOT (b.user_id = p_user_id AND b.booking_id = p_booking_id)
          AND b.start_date <= p_end_date
          AND b.end_date >= p_start_date
    ) THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;
END;
$$;
