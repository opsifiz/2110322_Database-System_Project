SELECT editCampgroundBooking(
    2,  -- request user (Alice)
    2,  -- target user (Alice)
    1,  -- booking_id (must match her (camp 1, tent 1) booking row)
    1,  -- old campground_id
    1,  -- new campground_id (same)
    1,  -- old tent_id
    3,  -- new tent_id
    DATE '2026-03-02',
    DATE '2026-03-03'
);