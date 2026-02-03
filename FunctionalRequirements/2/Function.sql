-- ข้อ 2
-- ฟังค์ชันสำหรับการ Login
CREATE OR REPLACE FUNCTION login(
    p_email text,
    p_password text
)
RETURNS TABLE(user_name text, user_telephone varchar(10))
AS $$
BEGIN
    RETURN QUERY
    SELECT concat(u.fname, ' ', u.lname) as user_name, u.telephone as user_telephone
    FROM users u
    WHERE u.email = p_email
    AND u.password = p_password;

    RAISE NOTICE 'Login attempt for %', p_email;
END $$ LANGUAGE plpgsql;

-- ไม่จำเป็นต้องมีฟังค์ชันสำหรับการ Log Out