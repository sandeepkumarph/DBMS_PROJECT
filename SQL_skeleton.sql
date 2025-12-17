create database DeliveryManagementSystem;
use DeliveryManagementSystem;
CREATE TABLE driver (
    driver_id int PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    license_number VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(20),
    shift VARCHAR(20)
);
create TABLE vehicle (
    vehicle_id INt  PRIMaRY KEY,
    license_plate VARcHAR(20) NOT NULL UNIQUE,
    vehicle_type VARCHAR(20) NOT NULL,
    weight_capacity INT,
    volume_capacity INT 
);
CREATE TABLE zone (
    zone_id INT PRIMARY KEY,
    zone_name VARCHAR(50) ,
    description VARCHAR(255) not null unique
);
CREATE TABLE routes (
    route_id int PRIMARY KEY,
    route_date DATE NOT NULL,
    driver_id INT NOT NULL,
    vehicle_id INT,
    total_distance INT,
    CONSTRAINT fk_routes_driver FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    CONSTRAINT fk_routes_vehicle FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    zone_id INT,
    CONSTRAINT fk_customer_zone FOREIGN KEY (zone_id) REFERENCES Zone(zone_id)
);
CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    route_id INT NOT NULL,
    customer_id INT NOT NULL,
    zone_id INT NOT NULL,
    delivery_type VARCHAR(20),
    status VARCHAR(20),
    scheduled_time DATETIME,
    actual_time DATETIME,
    attempt_count INT ,
    is_returned BOOLEAN DEFAULT FALSE
);
CREATE TABLE proof_of_delivery (
    proof_id INT PRIMARY KEY,
    delivery_id INT UNIQUE,
    signature BLOB,
    photo BLOB,
    delivered_at DATETIME NOT NULL
);

#inserting values into driver table
Insert into driver values
(101, 'Ramesh', 'DL-12345', '1234567890', 'Morning'),
(102, 'Suresh', 'DL-54321', '5432167890', 'Evening'),
(103, 'Rajesh', 'DL-67890', '0987654321', 'Afternoon'),
(104, 'Sanjay', 'DL-11111', '0987354321', 'Evening');
#inserting values into vehicle table
INSERT INTO vehicle values 
(201, 'TN36AB1234', 'Bike', 150, 1),
(202, 'TN36CD5678', 'Van', 800, 6),
(203, 'TN33EF9012', 'Truck', 1000, 18),
(204, 'TN99GH3456', 'Van', 800, 5),
(205, 'TN99IJ7890', 'Bike', 200, 1);
#inserting values into zone table
INSERT into zone values
(1, 'Zone 1', 'Residential area'),
(2, 'Zone 2', 'Village area'),
(3, 'Zone3', 'City area'),
(4, 'Zone4', 'Rural area'),
(5, 'Zone5', 'Urban area');

#inserting values into routes table
INSERT INTO routes VALUES
(301, '2025-03-10', 101, 201, 45),
(302, '2025-03-10', 102, 202, 60),
(303, '2025-03-11', 103, 203, 120),
(304, '2025-03-11', 104, 204, 55),
(305, '2025-03-12', 101, 205, 40);
#inserting values into customer table
INSERT INTO customer values
(1, 'Ramesh raj', 'md colony', 'Chennai', 'TN', '600001', '9000011111', 'ramesh@gmail.com', 1),
(2, 'Suresh kumar', 'CS nagar', 'Chennai', 'TN', '600002', '9000022222', 'suresh@gmail.com', 2),
(3, 'Anitha', 'Eachanari', 'Coimbatore', 'TN', '641001', '9000033333', 'anitha@gmail.com', 3),
(4, 'Kumar', 'Yercaud', 'Salem', 'TN', '636001', '9000044444', 'kumar@gmail.com', 4),
(5, 'Divya', 'Anna Nagar', 'Madurai', 'TN', '625001', '9000055555', 'divya@gmail.com', 5);

#inserting values into DELIVRIES table

INSERT INTO deliveries VALUES
(1, 301, 1, 1, 'Drop','Delivered',  '2025-03-10', '2025-03-10', 1, FALSE),
(2, 302, 2, 2, 'Drop','Failed', '2025-03-10', NULL, 2, TRUE),
(3, 303, 3, 3, 'Pickup', 'Delivered','2025-03-11', '2025-03-11', 1, FALSE),
(4, 304, 4, 4, 'Drop', 'failed', '2025-03-11', NULL,0, FALSE),
(5, 305, 5, 5, 'Drop',  'Delivered','2025-03-12', '2025-03-12', 1, FALSE);

#INSERTING VALUES INTO PRROF OF DEIVERY TABLE

INSERT INTO proof_of_delivery VALUES
(1, 1, NULL, NULL, '2025-03-10'),
(2, 2, NULL, NULL, '2025-03-10'),
(3, 3, NULL, NULL, '2025-03-11'),
(4, 4, NULL, NULL, '2025-03-11'),
(5, 5, NULL, NULL, '2025-03-12');
