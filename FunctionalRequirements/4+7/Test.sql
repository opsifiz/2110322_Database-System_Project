-- ฝาก Mock Dataset หน่อย
-- ข้อ 4

-- Ordinary User
select * from show_campground_bookings(1);
select * from show_campground_bookings(2);
select * from show_campground_bookings(3);

-- ข้อ 7
-- Admin User, 4 is Admin's id
select * from show_campground_bookings(4);