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
    v_nights INT;
BEGIN
    -- validate user
    IF NOT EXISTS (
        SELECT 1
        FROM users
        WHERE user_id = p_user_id
          AND role = 'user'
    ) THEN
        RAISE EXCEPTION 'Only registered users can make bookings';
    END IF;

    -- validate date
    IF p_end_date <= p_start_date THEN
        RAISE EXCEPTION 'End date must be after start date';
    END IF;

    v_nights := p_end_date - p_start_date;

    IF v_nights > 3 THEN
        RAISE EXCEPTION 'Booking exceeds maximum of 3 nights';
    END IF;

    -- exist tent
    IF NOT EXISTS (
        SELECT 1
        FROM tents
        WHERE campground_id = p_campground_id
          AND tent_id = p_tent_id
    ) THEN
        RAISE EXCEPTION 'Tent not found in this campground';
    END IF;

    -- overlap booking
    IF EXISTS (
        SELECT 1
        FROM booking
        WHERE campground_id = p_campground_id
          AND tent_id = p_tent_id
          AND p_start_date < end_date
          AND p_end_date > start_date
    ) THEN
        RAISE EXCEPTION 'Tent is already booked for selected dates';
    END IF;

    -- save
    INSERT INTO booking (
        user_id,
        campground_id,
        tent_id,
        start_date,
        end_date
    )
    VALUES (
        p_user_id,
        p_campground_id,
        p_tent_id,
        p_start_date,
        p_end_date
    );

    RETURN 'Booking successful';
END;
$$ LANGUAGE plpgsql;
