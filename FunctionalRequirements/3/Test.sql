-- ข้อ 3
-- Campground Dataset
INSERT INTO campgrounds (
    house_no,
    street,
    subdistrict,
    district,
    province,
    postal_code,
    name,
    map,
    email
) VALUES
(
    '123/4',
    'ถนนภูเขา',
    'ช้างเผือก',
    'เมือง',
    'เชียงใหม่',
    '50300',
    'Doi Mountain Camp',
    'https://maps.google.com/?q=Doi+Mountain+Camp',
    'contact@doimountaincamp.com'
),
(
    '89',
    'ถนนเลียบคลอง',
    'คลองหนึ่ง',
    'คลองหลวง',
    'ปทุมธานี',
    '12120',
    'คลองหลวง Riverside Camp',
    'https://maps.google.com/?q=Khlong+Luang+Riverside+Camp',
    'info@riversidecamp.co.th'
);

-- Tent Dataset
INSERT INTO tents (
    campground_id,
    tent_id,
    size,
    zone,
    price
) VALUES
-- Campground 1
(1, 1, 'S', 'Hill Zone', 500.00),
(1, 2, 'M', 'Hill Zone', 800.00),
(1, 3, 'L', 'Forest Zone', 1200.00),

-- Campground 2
(2, 1, 'S', 'River Zone', 600.00),
(2, 2, 'M', 'River Zone', 900.00),
(2, 3, 'L', 'Garden Zone', 1300.00);

-- ใช้งาน Function
SELECT book_campground(
    1,          -- user_id
    2,          -- campground_id
    1,          -- tent_id
    '2026-02-10',
    '2026-02-13' -- 3 nights
);

SELECT book_campground(
    1,          -- Alice
    1,          -- Doi Mountain Camp
    2,          -- Tent M, Hill Zone
    '2026-02-10',
    '2026-02-12'
);

SELECT book_campground(
    2,          -- Bob
    2,          -- Riverside Camp
    1,          -- Tent S, River Zone
    '2026-02-15',
    '2026-02-18'
);

SELECT book_campground(
    4,          -- Admin จองไม่ได้
    1,
    1,
    '2026-02-20',
    '2026-02-22'
);

SELECT book_campground( -- เกิน 3 คืน
    3,
    1,
    3,
    '2026-02-01',
    '2026-02-06'
);

SELECT book_campground( -- end_date มาก่อน start_date
    1,
    1,
    1,
    '2026-02-10',
    '2026-02-09'
);

SELECT book_campground( -- User Not Found
    99,
    1,
    1,
    '2026-02-10',
    '2026-02-12'
);
