-- ข้อ 2
-- Login Function
SELECT * FROM login('alice.smith@test.com', 'alicepass123'); -- Login Succeed
SELECT * FROM login('bob.johnson@test.com', 'bobpass456'); -- Login Succeed
SELECT * FROM login('charlie.brown@test.com', 'charliepass789'); -- Login Succeed
SELECT * FROM login('admin@campground.com', 'admin123456'); -- Login Succeed
SELECT * FROM login('alice.smith@test.com', 'wrongpassword'); -- Login Unsucceed

-- Log Out Function ไม่จำเป็นต้องมี เพราะเป็นส่วนของตัว Application