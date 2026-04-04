CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    registration_number VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    password VARCHAR(100),
    membership_status VARCHAR(20) DEFAULT 'inactive',
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    amount DECIMAL(10,2),
    payment_type VARCHAR(20),
    payment_method VARCHAR(20),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

CREATE TABLE GymSession (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    session_time VARCHAR(50),
    max_capacity INT
);

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    session_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    attendance_status VARCHAR(20),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (session_id) REFERENCES GymSession(session_id)
);

CREATE TABLE Equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(100),
    `condition` VARCHAR(50),
    last_maintenance_date DATE
);

CREATE TABLE EquipmentUsage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    equipment_id INT,
    usage_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipment(equipment_id)
);

CREATE TABLE Admin (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    username VARCHAR(50),
    password VARCHAR(100)
);
INSERT INTO GymSession (session_time, max_capacity) VALUES
('Morning', 20),
('Afternoon', 20);

INSERT INTO Admin (name, role, username, password) VALUES
('Gym Captain', 'captain', 'admin', 'admin123');