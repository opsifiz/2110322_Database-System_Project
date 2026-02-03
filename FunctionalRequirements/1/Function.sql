CREATE OR REPLACE FUNCTION book_campground(
    p_user_id INTEGER,
    p_campground_id INTEGER,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS TEXT
AS $$
DECLARE
    v_booking_id INTEGER;
    v_nights INTEGER;
BEGIN
    -- validate dates
    IF p_end_date <= p_start_date THEN
        RAISE EXCEPTION 'End date must be after start date';
    END IF;

    -- calculate number of nights
    v_nights := p_end_date - p_start_date;

    IF v_nights > 3 THEN
        RAISE EXCEPTION 'Booking exceeds maximum of 3 nights';
    END IF;

    -- insert into booking_data
    INSERT INTO booking_data(start_date, end_date)
    VALUES (p_start_date, p_end_date)
    RETURNING booking_id INTO v_booking_id;

    -- link user, booking, and campground
    INSERT INTO booking(user_id, booking_id, campground_id)
    VALUES (p_user_id, v_booking_id, p_campground_id);

    RETURN 'Booking successful';
END;
$$ LANGUAGE plpgsql;