CREATE DATABASE hotel_data;

USE hotel_data;

-- 1. INFRASTRUCTURE & ROOMS -- 
CREATE TABLE building (
    building_id INT PRIMARY KEY,
    building_name VARCHAR(100) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE wing (
    wing_id INT PRIMARY KEY,
    building_id INT NOT NULL,
    wing_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (building_id) REFERENCES building(building_id)
);

CREATE TABLE bed_info (
    bed_info_id INT PRIMARY KEY,
    bed_number INT DEFAULT 1,
    is_king BIT DEFAULT 0,       -- Boolean flag for King size
    is_queen BIT DEFAULT 0,      -- Boolean flag for Queen size
    is_regular BIT DEFAULT 0,    -- Boolean flag for Regular size
    is_extra_long BIT DEFAULT 0  -- Boolean flag for Extra Long
);

CREATE TABLE room (
    room_id INT PRIMARY KEY,
    building_id INT NOT NULL,
    wing_id INT NOT NULL,
    bed_info_id INT,
    room_number VARCHAR(20) NOT NULL,
    room_type VARCHAR(50), -- e.g., 'Sleeping', 'Suite', 'Meeting'
    floor INT,
    is_smoking BIT DEFAULT 0,
    status VARCHAR(50), -- e.g., 'Available', 'Occupied', 'Cleaning', 'Renovation'
    base_rate DECIMAL(10, 2),
    capacity INT,
    FOREIGN KEY (building_id) REFERENCES building(building_id),
    FOREIGN KEY (wing_id) REFERENCES wing(wing_id),
    FOREIGN KEY (bed_info_id) REFERENCES bed_info(bed_info_id)
);

CREATE TABLE room_adjacency (
    room_id_a INT NOT NULL,
    room_id_b INT NOT NULL,
    door_between BIT DEFAULT 0,
    PRIMARY KEY (room_id_a, room_id_b),
    FOREIGN KEY (room_id_a) REFERENCES room(room_id),
    FOREIGN KEY (room_id_b) REFERENCES room(room_id),
    CHECK (room_id_a <> room_id_b) -- A room cannot be adjacent to itself
);

CREATE TABLE facility (
    facility_id INT PRIMARY KEY,
    building_id INT NOT NULL,
    wing_id INT,
    floor INT,
    capacity INT,
    status VARCHAR(50),
    FOREIGN KEY (building_id) REFERENCES building(building_id),
    FOREIGN KEY (wing_id) REFERENCES wing(wing_id)
);

-- 2. PEOPLE & ORGANIZATIONS

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(150),
    phone_number VARCHAR(20)
);

CREATE TABLE organization (
    organization_id INT PRIMARY KEY,
    organization_name VARCHAR(150) NOT NULL,
    main_contact_person VARCHAR(150),
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE party (
    party_id INT PRIMARY KEY,
    party_type VARCHAR(20) NOT NULL, -- 'Customer' or 'Organization'
    customer_id INT,
    organization_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (organization_id) REFERENCES organization(organization_id)
);

CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    pay_rate DECIMAL(10, 2),
    position VARCHAR(100)
);

-- 3. ACCESS

CREATE TABLE access_card (
    card_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    issued_date DATETIME,
    expire_date DATETIME,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

CREATE TABLE card_activity (
    card_activity_id INT PRIMARY KEY,
    card_id INT NOT NULL,
    room_id INT NOT NULL,
    access_time DATETIME,
    FOREIGN KEY (card_id) REFERENCES access_card(card_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);

-- 4. RESERVATIONS

CREATE TABLE billing_account (
    billing_account_id INT PRIMARY KEY,
    party_id INT NOT NULL,
    open_date DATETIME,
    close_date DATETIME,
    status VARCHAR(50),
    currency VARCHAR(10) DEFAULT 'USD',
    FOREIGN KEY (party_id) REFERENCES party(party_id)
);

CREATE TABLE reservation_request (
    reservation_id INT PRIMARY KEY,
    party_id INT NOT NULL, -- The party making the reservation
    bed_info_preferences VARCHAR(255),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(50),
    num_guest INT,
    num_room INT,
    is_smoking_pref BIT,
    FOREIGN KEY (party_id) REFERENCES party(party_id)
);

CREATE TABLE room_assignment (
    room_assignment_id INT PRIMARY KEY,
    reservation_id INT NOT NULL,
    room_id INT NOT NULL,
    assign_date DATETIME,
    check_in_date DATETIME,
    check_out_date DATETIME,
    FOREIGN KEY (reservation_id) REFERENCES reservation_request(reservation_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id)
);

CREATE TABLE timeslot (
    timeslot_id INT PRIMARY KEY,
    name VARCHAR(50), -- e.g., 'Breakfast', 'Morning', 'Lunch'
    start_time TIME,
    end_time TIME,
    is_eating_slot BIT DEFAULT 0
);

CREATE TABLE event (
    event_id INT PRIMARY KEY,
    host_party_id INT NOT NULL,
    billing_account_id INT,
    event_name VARCHAR(150),
    event_duration Decimal, -- Duration in hours
    est_attendance INT,
    est_guest_count INT,
    FOREIGN KEY (host_party_id) REFERENCES party(party_id),
    FOREIGN KEY (billing_account_id) REFERENCES billing_account(billing_account_id)
);

CREATE TABLE event_room_use (
    event_room_use_id INT PRIMARY KEY,
    event_id INT NOT NULL,
    room_id INT NOT NULL,
    timeslot_id INT,
    date DATE,
    FOREIGN KEY (event_id) REFERENCES event(event_id),
    FOREIGN KEY (room_id) REFERENCES room(room_id),
    FOREIGN KEY (timeslot_id) REFERENCES timeslot(timeslot_id)
);

CREATE TABLE event_facility_use (
    event_facility_use_id INT PRIMARY KEY,
    event_id INT NOT NULL,
    facility_id INT NOT NULL,
    timeslot_id INT,
    date DATE,
    FOREIGN KEY (event_id) REFERENCES event(event_id),
    FOREIGN KEY (facility_id) REFERENCES facility(facility_id),
    FOREIGN KEY (timeslot_id) REFERENCES timeslot(timeslot_id)
);

-- 5. SERVICES & CHARGES
CREATE TABLE service_type (
    service_id INT PRIMARY KEY,
    description VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE service_usage (
    service_usage_id INT PRIMARY KEY,
    service_id INT NOT NULL,
    customer_id INT, -- The specific person using the service
    employee_id INT, -- Employee facilitating the service
    billing_account_id INT, -- Account to be billed
    usage_time DATETIME,
    quantity INT DEFAULT 1,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (service_id) REFERENCES service_type(service_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (billing_account_id) REFERENCES billing_account(billing_account_id)
);
-- Line items of Charges
CREATE TABLE charge (
    charge_id INT PRIMARY KEY,
    reservation_id INT,    -- Link if charge is related to a reservation, null otherwise
    customer_id INT,       -- Link if charge is related to a specific customer
    service_usage_id INT,  -- Link if charge is from a service
    facility_id INT,       -- Link if charge is for facility use
    total_amount DECIMAL(10, 2) NOT NULL,
    posted_at DATETIME,
    FOREIGN KEY (reservation_id) REFERENCES reservation_request(reservation_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (service_usage_id) REFERENCES service_usage(service_usage_id),
    FOREIGN KEY (facility_id) REFERENCES facility(facility_id)
);

-- For payment split.
CREATE TABLE charge_allocation (
    allocation_id INT PRIMARY KEY,
    charge_id INT NOT NULL,
    billing_account_id INT NOT NULL,
    responsible_percent DECIMAL(5, 2) DEFAULT 100.00,
    amount DECIMAL(10, 2),
    FOREIGN KEY (charge_id) REFERENCES charge(charge_id),
    FOREIGN KEY (billing_account_id) REFERENCES billing_account(billing_account_id)
);

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    billing_account_id INT NOT NULL,
    payment_method VARCHAR(50), -- Credit Card, Cash, etc.
    amount DECIMAL(10, 2),
    paid_at DATETIME,
    FOREIGN KEY (billing_account_id) REFERENCES billing_account(billing_account_id)
);


-- Data Sample Generated by Ai

INSERT INTO building (building_id, building_name, address) VALUES 
(1, 'Ocean Summit Tower', '101 Coastal Hwy, Beachside'),
(2, 'Garden Pavilion', '102 Coastal Hwy, Beachside'),
(3, 'Seaside Villas', '105 Coastal Hwy, Private Beach');

INSERT INTO wing (wing_id, building_id, wing_name) VALUES 
(1, 1, 'East Wing - Sunrise'),
(2, 1, 'West Wing - Sunset'),
(3, 1, 'North Wing - Views'),
(4, 2, 'Main Hall'),
(5, 3, 'Villa Cluster A');

INSERT INTO bed_info (bed_info_id, bed_number, is_king, is_queen, is_regular, is_extra_long) VALUES 
(1, 1, 1, 0, 0, 0), -- King
(2, 2, 0, 1, 0, 0), -- Two Queens
(3, 1, 0, 0, 1, 0), -- Single Regular
(4, 1, 0, 1, 0, 0); -- Single Queen

INSERT INTO room (room_id, building_id, wing_id, bed_info_id, room_number, room_type, floor, is_smoking, status, base_rate, capacity) VALUES 
(1, 1, 1, 1, '101', 'Suite', 1, 0, 'Available', 350.00, 2),
(2, 1, 1, 2, '102', 'Double', 1, 0, 'Occupied', 200.00, 4),
(3, 1, 1, 4, '103', 'Standard', 1, 0, 'Occupied', 180.00, 2),
(4, 1, 1, 4, '104', 'Standard', 1, 0, 'Occupied', 180.00, 2),
(5, 1, 2, 1, '201', 'Penthouse', 2, 1, 'Available', 600.00, 2),
(6, 1, 2, 1, '202', 'Suite', 2, 0, 'Cleaning', 350.00, 2),
(7, 1, 2, 2, '203', 'Double', 2, 0, 'Renovation', 200.00, 4),
(8, 1, 3, 1, '301', 'Standard', 3, 0, 'Available', 180.00, 2),
(9, 1, 3, 1, '302', 'Standard', 3, 0, 'Available', 180.00, 2),
(10, 2, 4, NULL, 'Conf A', 'Meeting', 1, 0, 'Available', 150.00, 50),
(11, 2, 4, NULL, 'Grand Ballrm', 'Banquet', 1, 0, 'Reserved', 1000.00, 300),
(12, 3, 5, 1, 'V-01', 'Villa', 1, 1, 'Occupied', 800.00, 6);

INSERT INTO room_adjacency (room_id_a, room_id_b, door_between) VALUES 
(1, 2, 1), -- 101 & 102
(3, 4, 1); -- 103 & 104

INSERT INTO facility (facility_id, building_id, wing_id, floor, capacity, status) VALUES 
(1, 1, 1, 1, 200, 'Open'),-- Lobby Restaurant
(2, 1, 2, 5, 50, 'Open'),-- Rooftop Pool
(3, 1, 1, 1, 20, 'Closed'), -- Business Center (Under Repair)
(4, 2, 4, 1, 300, 'Open'); -- Wedding Garden


INSERT INTO customer (customer_id, first_name, last_name, email_address, phone_number) VALUES 
(1, 'John', 'Doe', 'john.doe@email.com', '555-0101'),
(2, 'Alice', 'Wonderland', 'alice@email.com', '555-0102'),
(3, 'Bob', 'Builder', 'bob@construct.com', '555-0103'),
(4, 'Mike', 'Smith', 'mike.smith@fam.com', '555-0201'),
(5, 'Sarah', 'Smith', 'sarah.smith@fam.com', '555-0202'),
(6, 'Robert', 'Consultant', 'rob@audit.com', '555-0300'),
(7, 'Emily', 'Bride', 'emily@wedding.com', '555-0400'),
(8, 'Daniel', 'Groom', 'dan@wedding.com', '555-0401');

INSERT INTO organization (organization_id, organization_name, main_contact_person, phone, address) VALUES 
(1, 'TechGlobal Inc', 'Sarah Connor', '555-9000', '123 Silicon Valley'),
(2, 'Johnson-Bride Wedding', 'Emily Bride', '555-9100', '10 Church St'),
(3, 'Audit Corp', 'Boss Man', '555-9200', '500 Wall St');

INSERT INTO employee (employee_id, first_name, last_name, pay_rate, position) VALUES 
(1, 'James', 'Hotelier', 25.00, 'Concierge'),
(2, 'Mary', 'Cleaner', 18.00, 'Housekeeping'),
(3, 'David', 'Chef', 30.00, 'Head Chef'),
(4, 'Steve', 'Security', 22.00, 'Security Guard'),
(5, 'Linda', 'Manager', 45.00, 'General Manager');

INSERT INTO party (party_id, party_type, customer_id, organization_id) VALUES 
(1, 'Customer', 1, NULL),     -- John Doe
(2, 'Customer', 2, NULL),     -- Alice Wonderland
(3, 'Organization', NULL, 1), -- TechGlobal
(4, 'Customer', 4, NULL),     -- Mike Smith
(5, 'Customer', 6, NULL),     -- Robert Consultant
(6, 'Organization', NULL, 2), -- Johnson Wedding
(7, 'Customer', 7, NULL),     -- Emily Bride
(8, 'Customer', 8, NULL);     -- Daniel Groom


INSERT INTO access_card (card_id, customer_id, employee_id, issued_date, expire_date, status) VALUES 
(1, 1, NULL, '2024-06-13 14:00:00', '2024-06-20 12:00:00', 'Active'), -- John
(2, 6, NULL, '2024-06-10 09:00:00', '2024-06-24 12:00:00', 'Active'), -- Consultant
(3, NULL, 2, '2023-01-01 08:00:00', NULL, 'Active'), -- Mary
(4, NULL, 4, '2023-01-01 08:00:00', NULL, 'Active'); -- Steve


INSERT INTO billing_account (billing_account_id, party_id, open_date, status, currency) VALUES 
(1, 1, '2024-06-13 14:00:00', 'Open', 'USD'), -- John Doe
(2, 3, '2024-05-15 10:00:00', 'Open', 'USD'), -- TechGlobal (Opened a month ago)
(3, 4, '2024-06-10 15:00:00', 'Open', 'USD'), -- Mike Smith
(4, 5, '2024-06-05 11:00:00', 'Open', 'USD'), -- Robert Consultant
(5, 6, '2024-03-01 09:00:00', 'Open', 'USD'), -- Wedding Master
(6, 2, '2024-06-14 08:00:00', 'Open', 'USD'); -- Alice


INSERT INTO reservation_request (reservation_id, party_id, bed_info_preferences, start_date, end_date, status, num_guest, num_room, is_smoking_pref) VALUES 
(1, 1, 'King Bed', '2024-06-13', '2024-06-16', 'Checked In', 2, 1, 0), -- John
(2, 3, 'Conference', '2024-06-15', '2024-06-17', 'Confirmed', 50, 1, 0), -- TechGlobal
(3, 4, 'Adjoining Rooms', '2024-06-14', '2024-06-18', 'Checked In', 4, 2, 0), -- Smith
(4, 5, 'Quiet, High Floor', '2024-06-10', '2024-06-24', 'Checked In', 1, 1, 1), -- Consultant
(5, 6, 'Bridal Suite + Guests', '2024-06-25', '2024-06-27', 'Future', 100, 20, 0); -- Wedding


INSERT INTO room_assignment (room_assignment_id, reservation_id, room_id, assign_date, check_in_date) VALUES 
(1, 1, 2, '2024-06-13 14:05:00', '2024-06-13 14:15:00'), -- John
(2, 2, 10, '2024-06-14 09:00:00', NULL),                 -- TechGlobal
(3, 3, 3, '2024-06-14 16:00:00', '2024-06-14 16:30:00'), -- Smith 1
(4, 3, 4, '2024-06-14 16:00:00', '2024-06-14 16:30:00'), -- Smith 2
(5, 4, 12, '2024-06-10 11:00:00', '2024-06-10 11:30:00'); -- Consultant


-- Service Types
INSERT INTO service_type (service_id, description, price) VALUES 
(1, 'Room Service - Breakfast', 25.00),
(2, 'Spa - Full Massage', 120.00),
(3, 'Dry Cleaning', 15.00),
(4, 'Conference Catering Per Head', 30.00),
(5, 'Valet Parking (Daily)', 35.00),
(6, 'In-Room Movie', 12.99),
(7, 'Wedding Cake', 500.00);


INSERT INTO service_usage (service_usage_id, service_id, customer_id, employee_id, billing_account_id, quantity, total_amount) VALUES 
(1, 6, 4, NULL, 3, 2, 25.98), -- Smiths Movies
(2, 3, 6, 2, 4, 3, 45.00),     -- Consultant Dry Cleaning
(3, 2, 2, 3, 6, 1, 120.00);    -- Alice Spa (Split Scenario)

INSERT INTO charge (charge_id, reservation_id, customer_id, service_usage_id, facility_id, total_amount) VALUES 
(1, 3, 4, NULL, NULL, 720.00),   -- Smith Room Charge
(2, 4, 6, NULL, NULL, 4000.00),  -- Consultant Villa Charge
(3, NULL, 2, NULL, NULL, 1000.00), -- payment_idAlice Room Charge (Split)
(4, NULL, 2, 3, NULL, 120.00);     -- Alice Spa Charge

INSERT INTO charge_allocation (allocation_id, charge_id, billing_account_id, responsible_percent, amount) VALUES 
(1, 1, 3, 100.00, 720.00),  -- Smith pays 100%
(2, 2, 4, 100.00, 4000.00), -- Consultant pays 100%
(3, 3, 2, 80.00, 800.00),   -- TechGlobal pays 80% of Alice's Room
(4, 3, 6, 20.00, 200.00),   -- Alice pays 20% of Alice's Room
(5, 4, 6, 100.00, 120.00);  -- Alice pays 100% of Spa


INSERT INTO payment (payment_id, billing_account_id, payment_method, amount, paid_at) VALUES 
(1, 3, 'Credit Card', 360.00,'2024-06-30'),     -- Smith partial pay
(2, 4, 'Corporate Amex', 4000.00, '2024-07-15'); -- Consultant full pay

INSERT INTO timeslot (timeslot_id, name, start_time, end_time, is_eating_slot) VALUES 
(1, 'Breakfast', '07:00:00', '09:00:00', 1),
(2, 'Morning Session', '09:00:00', '12:00:00', 0),
(3, 'Lunch', '12:00:00', '13:30:00', 1),
(4, 'Afternoon Session', '13:30:00', '17:00:00', 0),
(5, 'Evening', '18:00:00', '22:00:00', 1),
(6, 'All Day Access', '08:00:00', '20:00:00', 0);

INSERT INTO event (event_id, host_party_id, billing_account_id, event_name, event_duration, est_attendance, est_guest_count) VALUES 
(1, 3, 2, 'TechGlobal Q3 Summit', 3, 50, 45), -- 3 Days, 50 attendees
(2, 6, 5, 'Johnson Rehearsal Dinner', 4, 30, 0), -- Just the family
(3, 6, 5, 'Johnson Wedding Reception', 6, 150, 100); -- Big party

INSERT INTO event_room_use (event_room_use_id, event_id, room_id, timeslot_id, date) VALUES 
(1, 1, 10, 2, '2024-06-15'), -- Morning Session
(2, 1, 10, 4, '2024-06-15'), -- Afternoon Session
(3, 1, 10, 2, '2024-06-16'), -- Morning Session (Day 2)
(4, 1, 10, 4, '2024-06-16'); -- Afternoon Session (Day 2)

-- Wedding Reception uses 'Grand Ballrm' (Room ID 11) on June 25th
INSERT INTO event_room_use (event_room_use_id, event_id, room_id, timeslot_id, date) VALUES 
(5, 3, 11, 5, '2024-06-25'); -- Evening Banquet

INSERT INTO event_facility_use (event_facility_use_id, event_id, facility_id, timeslot_id, date) VALUES 
(1, 1, 1, 3, '2024-06-15'), -- Business Lunch
(2, 1, 1, 3, '2024-06-16'); -- Business Lunch Day 2

INSERT INTO event_facility_use (event_facility_use_id, event_id, facility_id, timeslot_id, date) VALUES 
(3, 2, 4, 4, '2024-06-24'); -- Afternoon Rehearsal

INSERT INTO card_activity (card_activity_id, card_id, room_id, access_time) VALUES 
-- John Doe (Card 1) entering his Room 102
(1, 1, 2, '2024-06-13 14:20:00'),
(2, 1, 2, '2024-06-13 19:30:00'), -- Coming back from dinner
-- Robert Consultant (Card 2) is attending the TechGlobal Summit
-- Entering Conf Room A (Room 10)
(3, 2, 10, '2024-06-15 08:55:00'), -- Arrive for morning session
(4, 2, 12, '2024-06-15 18:00:00'),
-- Mary the Cleaner (Card 3) cleaning rooms
(5, 3, 2, '2024-06-14 10:00:00'), -- Cleaning John's room
(6, 3, 2, '2024-06-15 11:00:00'); -- Cleaning John's room again