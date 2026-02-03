-- ข้อ 1
SELECT register_user('Alice', 'Marie', 'Smith', '0891112222', 'alice.smith@test.com', 'alicepass123');
SELECT register_user('Bob', 'James', 'Johnson', '0863334444', 'bob.johnson@test.com', 'bobpass456');
SELECT register_user('Charlie', 'Lee', 'Brown', '0825556666', 'charlie.brown@test.com', 'charliepass789');
SELECT register_user('Admin', 'Super', 'User', '0801234567', 'admin@campground.com', 'admin123456', 'admin'); -- Admin User (Passing the optional 'admin' role)