CREATE OR REPLACE FUNCTION canBook(
    p_user_id INT,
    p_campground_id INT,
    p_tent_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS BOOLEAN
AS $$
BEGIN
    IF p_end_date <= p_start_date THEN
        RETURN FALSE;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM booking b
        JOIN booking_data bd ON b.booking_id = bd.booking_id
        WHERE b.campground_id = p_campground_id
          AND b.tent_id = p_tent_id
          AND b.user_id = p_user_id
          AND bd.start_date < p_end_date
          AND bd.end_date > p_start_date
    ) THEN
        RETURN FALSE;
    END IF;

    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;
