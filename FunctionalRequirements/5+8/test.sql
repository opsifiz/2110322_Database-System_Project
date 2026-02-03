SELECT editCampgroundBooking(
    2,  -- request user = Alice
    2,  -- target user  = Alice
    1,  -- p_booking_id
    1,  -- campground_id
    1,  -- old_tent_id
    2,  -- new_tent_id
    DATE '2026-03-05',  --start date
    DATE '2026-03-08'  --end date
);