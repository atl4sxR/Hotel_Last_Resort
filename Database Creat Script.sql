CREATE DATABASE hotel_data;

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

-- 4. RESERVATIONS & EVENTS

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