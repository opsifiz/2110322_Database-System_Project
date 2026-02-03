INSERT INTO users (fname, lname, telephone, email, password, role)
VALUES
('Admin', 'User', '0000000000', 'admin@test.com', 'hashed_pw', 'admin'),
('Normal', 'User', '1111111111', 'user@test.com', 'hashed_pw', 'user');

INSERT INTO campgrounds (district, province, name)
VALUES ('Test District', 'Test Province', 'Test Camp');

INSERT INTO tents (campground_id, tent_id, size, price)
VALUES (1, 1, 'Medium', 500.00);

INSERT INTO booking (user_id,campground_id,tent_id,start_date, end_date)
VALUES (2,1,1,'2026-03-01','2026-03-03');

INSERT INTO booking (user_id,campground_id,tent_id,start_date, end_date)
VALUES (1,1,1,'2026-07-01','2026-07-03');

--admin delete user's booking (deleted successfully)
select * from delete_booking(2,1)

--user try deleting other's booking (not deleted)
select * from delete_booking(1,2)