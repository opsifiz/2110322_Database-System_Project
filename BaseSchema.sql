CREATE TABLE IF NOT EXISTS users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    fname VARCHAR(50) NOT NULL,
    mname VARCHAR(50),
    lname VARCHAR(50) NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    password VARCHAR(255) NOT NULL,
    role user_role DEFAULT 'user'
);

CREATE TABLE IF NOT EXISTS campgrounds (
    campground_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    house_no VARCHAR(20),
    street VARCHAR(100),
    subdistrict VARCHAR(100),
    district VARCHAR(100) NOT NULL,
    province VARCHAR(100) NOT NULL,
    postal_code VARCHAR(10),
    name VARCHAR(100) NOT NULL,
    map VARCHAR(512),
    email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS campground_phone_number (
    campground_id INT,
    phone_number VARCHAR(20),
    PRIMARY KEY (campground_id, phone_number),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tents (
    campground_id INT,
    tent_id INT,
    size VARCHAR(20),
    zone VARCHAR(50),
    price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (campground_id, tent_id),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS facilities (
    campground_id INT,
    facility_id INT,
    facility_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (campground_id, facility_id),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS manages_tent (
    user_id INT,
    campground_id INT,
    tent_id INT,
    log_changes TEXT,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, campground_id, tent_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id, tent_id) REFERENCES tents(campground_id, tent_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS manages_facility (
    user_id INT,
    campground_id INT,
    facility_id INT,
    log_changes TEXT,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, campground_id, facility_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id, facility_id) REFERENCES facilities(campground_id, facility_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS manages_campground (
    user_id INT,
    campground_id INT,
    log_changes TEXT,
    modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, campground_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id) REFERENCES campgrounds(campground_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS booking (
    user_id INT,
    booking_id INT GENERATED ALWAYS AS IDENTITY,
    campground_id INT NOT NULL,
    tent_id INT NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
	book_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk PRIMARY KEY (booking_id),
    CONSTRAINT check_dates CHECK (end_date > start_date),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (campground_id, tent_id) REFERENCES tents(campground_id, tent_id)
);