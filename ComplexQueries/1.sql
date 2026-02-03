SELECT 
    u.user_id,
    u.fname || ' ' || u.lname AS user_name,
    c.name AS campground_name,
    t.tent_id,
    t.size AS tent_size,
    t.zone,
    t.price,
    bd.start_date,
    bd.end_date,

    CASE
        WHEN bd.start_date - CURRENT_DATE >= 7
        THEN 'Editable'
        ELSE 'Not Editable'
    END AS booking_status

FROM booking b
JOIN users u 
    ON b.user_id = u.user_id
JOIN booking_data bd 
    ON b.booking_id = bd.booking_id
JOIN campground c 
    ON b.campground_id = c.campground_id
JOIN tent t 
    ON b.tent_id = t.tent_id

WHERE u.user_id = 5
ORDER BY bd.start_date;