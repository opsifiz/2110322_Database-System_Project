-- ข้อ 4 + 7
-- แสดงข้อมูลการจอง Campground กรณี User, Admin และ Null หรือหาไม่เจอ
CREATE OR REPLACE FUNCTION show_campground_bookings(
    p_user_id INT
)
RETURNS TABLE(
    user_name TEXT,
    start_date DATE,
    end_date DATE,

    campground_id INT,
    house_no VARCHAR,
    street VARCHAR,
    subdistrict VARCHAR,
    district VARCHAR,
    province VARCHAR,
    postal_code VARCHAR,
    name VARCHAR,
    map VARCHAR,
    email VARCHAR,

    phone_number VARCHAR
)
AS $$
DECLARE
    v_role user_role;
BEGIN
    -- ตรวจสอบ role ของผู้เรียก
    SELECT role
    INTO v_role
    FROM users
    WHERE user_id = p_user_id;

    -- ไม่พบ user
    IF NOT FOUND THEN
        RETURN;
    END IF;

    -- admin → เห็นทุก booking
    IF v_role = 'admin' THEN
        RETURN QUERY
        SELECT
            CONCAT(u.fname, ' ', u.mname, ' ', u.lname) AS user_name,
            b.start_date,
            b.end_date,

            cg.campground_id,
            cg.house_no,
            cg.street,
            cg.subdistrict,
            cg.district,
            cg.province,
            cg.postal_code,
            cg.name,
            cg.map,
            cg.email,

            cpn.phone_number
        FROM booking b
        JOIN users u
            ON b.user_id = u.user_id
        JOIN campgrounds cg
            ON b.campground_id = cg.campground_id
        LEFT JOIN campground_phone_number cpn
            ON cg.campground_id = cpn.campground_id;

    -- user ธรรมดา → เห็นเฉพาะของตัวเอง
    ELSIF v_role = 'user' THEN
        RETURN QUERY
        SELECT
            CONCAT(u.fname, ' ', u.mname, ' ', u.lname) AS user_name,
            b.start_date,
            b.end_date,

            cg.campground_id,
            cg.house_no,
            cg.street,
            cg.subdistrict,
            cg.district,
            cg.province,
            cg.postal_code,
            cg.name,
            cg.map,
            cg.email,

            cpn.phone_number
        FROM booking b
        JOIN users u
            ON b.user_id = u.user_id
        JOIN campgrounds cg
            ON b.campground_id = cg.campground_id
        LEFT JOIN campground_phone_number cpn
            ON cg.campground_id = cpn.campground_id
        WHERE u.user_id = p_user_id;
    END IF;
END;
$$ LANGUAGE plpgsql;