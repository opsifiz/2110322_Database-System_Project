-- ข้อ 3
CREATE OR REPLACE FUNCTION book_campground(
    p_user_id INT,
    p_campground_id INT,
    p_tent_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS TEXT
AS $$
DECLARE
    v_booking_id INT;
    v_nights INT;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM users WHERE user_id = p_user_id
    ) THEN
        RAISE EXCEPTION 'User is not a registered user';
    END IF;

    IF p_end_date <= p_start_date THEN
        RAISE EXCEPTION 'End date must be after start date';
    END IF;

    v_nights := p_end_date - p_start_date;

    IF v_nights > 3 THEN
        RAISE EXCEPTION 'Booking exceeds maximum of 3 nights';
    END IF;

    INSERT INTO booking (user_id, campground_id, tent_id, start_date, end_date)
    VALUES (p_user_id, p_campground_id, p_tent_id, p_start_date, p_end_date);

    RETURN 'Booking successful';
END;
$$ LANGUAGE plpgsql;
