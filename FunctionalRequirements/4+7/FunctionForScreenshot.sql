-- ข้อ 4 + 7: Campground Bookings
CREATE OR REPLACE FUNCTION show_campground_bookings(p_user_id INT)
RETURNS TABLE(
    user_name TEXT, start_date DATE, end_date DATE,
    camp_id INT, house_no VARCHAR, street VARCHAR, 
    sub_dist VARCHAR, dist VARCHAR, prov VARCHAR, 
    post_code VARCHAR, name VARCHAR, map VARCHAR, 
    email VARCHAR, phone_number VARCHAR
) AS $$
DECLARE v_role user_role;
BEGIN
    SELECT role INTO v_role FROM users WHERE user_id = p_user_id;
    IF NOT FOUND THEN RETURN; END IF;

    RETURN QUERY
    SELECT
        CONCAT(u.fname, ' ', u.mname, ' ', u.lname), 
        b.start_date, b.end_date, cg.campground_id, 
        cg.house_no, cg.street, cg.subdistrict, 
        cg.district, cg.province, cg.postal_code, 
        cg.name, cg.map, cg.email, cpn.phone_number
    FROM booking b
    JOIN users u ON b.user_id = u.user_id
    JOIN campgrounds cg ON b.campground_id = cg.campground_id
    LEFT JOIN campground_phone_number cpn 
        ON cg.campground_id = cpn.campground_id
    WHERE (v_role = 'admin') 
       OR (v_role = 'user' AND u.user_id = p_user_id);
END;
$$ LANGUAGE plpgsql;