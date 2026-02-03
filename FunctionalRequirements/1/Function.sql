-- ข้อ 1
-- ฟังค์ชันสำหรับการ Register
CREATE OR REPLACE FUNCTION register_user(
    p_fname VARCHAR,
    p_mname VARCHAR, -- This can be passed as NULL
    p_lname VARCHAR,
    p_telephone VARCHAR,
    p_email VARCHAR,
    p_password VARCHAR,
    p_role user_role DEFAULT 'user'
) 
RETURNS BOOLEAN AS $$
BEGIN
    INSERT INTO users (fname, mname, lname, telephone, email, password, role)
    VALUES (p_fname, p_mname, p_lname, p_telephone, p_email, p_password, p_role);

    RETURN TRUE;

EXCEPTION 
    WHEN OTHERS THEN
        -- Returns false if any constraint is violated (e.g., duplicate email)
        RETURN FALSE;
END;
$$ LANGUAGE plpgsql;
