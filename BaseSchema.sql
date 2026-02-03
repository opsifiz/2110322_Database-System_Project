CREATE TYPE user_role AS ENUM ('user', 'admin');

CREATE TABLE IF NOT EXISTS users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fname VARCHAR(20) NOT NULL,
    mname VARCHAR(20) NOT NULL,
    lname VARCHAR(20) NOT NULL,
    telephone VARCHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    role user_role DEFAULT 'user'
);

CREATE TABLE IF NOT EXISTS booking_data (
    booking_id INT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS campgrounds (
    campground_id INT PRIMARY KEY,
    house_no VARCHAR(20),
    street VARCHAR(50),
    subdistrict VARCHAR(50),
    district VARCHAR(50),
    province VARCHAR(50),
    postal_code VARCHAR(5),
    name VARCHAR(50) NOT NULL,
    map VARCHAR(100),
    email VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS campground_phone_number (
    campground_id INT,
    phone_number VARCHAR(10),
    PRIMARY KEY (campground_id, phone_number),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id)
);

CREATE TABLE IF NOT EXISTS tents (
    campground_id INT,
    tent_id INT,
    size VARCHAR(10),
    zone VARCHAR(50),
    price DECIMAL(5,2),
    PRIMARY KEY (campground_id, tent_id),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id)
);

CREATE TABLE IF NOT EXISTS facilities (
    campground_id INT,
    facility_id INT,
    facility_type VARCHAR(20),
    PRIMARY KEY (campground_id, facility_id),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id)
);



CREATE TABLE IF NOT EXISTS manages_tent (
    user_id INT,
    campground_id INT,
    tent_id INT,
    log_changes TEXT,
    PRIMARY KEY (user_id, campground_id, tent_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id, tent_id) REFERENCES tents(campground_id, tent_id)
);

CREATE TABLE IF NOT EXISTS manages_facility (
    user_id INT,
    campground_id INT,
    facility_id INT,
    log_changes TEXT,
    PRIMARY KEY (user_id, campground_id, facility_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id, facility_id) REFERENCES facilities(campground_id, facility_id)
);

CREATE TABLE IF NOT EXISTS manages_campground (
    user_id INT,
    campground_id INT,
    log_changes TEXT,
    PRIMARY KEY (user_id, campground_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id)
);

CREATE TABLE IF NOT EXISTS booking (
    user_id INT,
    booking_id INT,
    campground_id INT,
    tent_id INT,
    PRIMARY KEY (user_id, booking_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES booking_data(booking_id),
    FOREIGN KEY (campground_id, tent_id) REFERENCES tents(campground_id, tent_id)
);