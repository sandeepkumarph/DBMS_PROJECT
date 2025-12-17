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

#1.	List all drivers who drive "Vans". 

select * from vehicle ;
select * from vehicle Where vehicle_type='Van';

#2.	Find deliveries scheduled for "Zone 1". 

select * from deliveries;
select * FROm deliveries where zone_id='1';

#3.	Retrieve deliveries marked as "Failed Attempt".
 
select * from deliveries;
select * from deliveries WHERE status ='failed';

#4.	List vehicles with a capacity greater than 500kg. 

select * from vehicle;
select * from vehicle where weight_capacity>500;

#5.	Find customers who have requested "Contactless Delivery". 

select * from deliveries;
insert into deliveries values
(6, 303, 3, 3, 'contactless_delivery', 'delivered', '2025-03-13', NULL, 1, FALSE);
select * from customer;
select * from customer c join deliveries d 
ON c.customer_id=d.customer_id 
where d.delivery_type='contactless_delivery';

#Joins & Subqueries 
#6.	Display delivery details along with Driver Name and Vehicle Number. 

select *from deliveries ;
select * from routes;
select * from driver;
alter table deliveries add driver_id int;
update deliveries 
set driver_id=102
where delivery_id in (2,11);
select dv.first_name as driver_name,v.license_plate AS vehicle_number,d.delivery_id,d.customer_id,d.status
from deliveries d
join driver dv
on d.driver_id=dv.driver_id
join routes r on
d.route_id=r.route_id
join vehicle v
on r.vehicle_id=v.vehicle_id;

#7.	Find drivers who have completed deliveries in "Downtown" today. 

select * from  deliveries;
select * from  zone;
select*from driver;
UPDATE zone
SET zone_name = 'Down-Town'
WHERE zone_id = 3;
insert into zone values (6,'down-town','city');
insert into zone values (7,'lighttown','city');
insert into zone values (8,'racecourse','city');
Select dv.driver_id, dv.first_name FROM deliveries d
JOIN driver dv
on d.driver_id = dv.driver_id
JOIN zone z
on d.zone_id = z.zone_id
WHERE z.zone_name = 'down-town' ;

#8.	List routes that have more than 50 stops. 

INSERT INTO deliveries
(delivery_id, route_id, customer_id, zone_id, delivery_type, status,
 scheduled_time, actual_time, attempt_count, is_returned)
VALUES
(21, 305, 11, 2, 'Drop', 'Delivered', '2025-03-16', '2025-03-16', 1, FALSE),
(22, 305, 12, 2, 'Drop', 'Delivered', '2025-03-16', '2025-03-16', 1, FALSE),
(23, 305, 13, 2, 'Pickup', 'Pending', '2025-03-16', NULL, 0, FALSE);

select * from customer;
SELECT route_id, COUNT(delivery_id)
FROM deliveries
GROUP BY route_id
HAVING COUNT(delivery_id) > 50;

#9.	Identify deliveries that were reassigned to a different driver. 

UPDATE deliveries
SET driver_id = 2
WHERE delivery_id = 101;

select *from deliveries ;
select * from routes;
UPDATE deliveries
SET driver_id = 101
WHERE delivery_id IN (5, 7, 21, 22, 23);
UPDATE deliveries
SET driver_id = 102
WHERE delivery_id = 21;
SELECT 
    d.delivery_id,
    d.route_id,
    r.driver_id AS original_driver,
    d.driver_id AS reassigned_driver
FROM deliveries d
JOIN routes r
ON d.route_id = r.route_id
WHERE d.driver_id <> r.driver_id;

#10.	List customers who have provided a "Low Rating" for delivery experience. 

alter table deliveries add rating varchar(50);
UPDATE deliveries
SET rating = 'Low'
WHERE delivery_id = 1;

UPDATE deliveries
SET rating ='good'
WHERE delivery_id = 6;

UPDATE deliveries
SET rating ='good'
WHERE delivery_id = 7;

UPDATE deliveries
SET
 rating ='avg'
WHERE delivery_id = 5;

UPDATE deliveries
SET rating ='avg'
WHERE delivery_id = 3;

UPDATE deliveries
SET rating ='good'
WHERE delivery_id = 4;
UPDATE deliveries
SET rating = null
WHERE delivery_id = 2;
SELECT * FROM customer;
SELECT * FROM deliveries;
SELECT customer_id, name FROM customer
WHERE customer_id in (
    SELECT customer_id
    FROM deliveries
    WHERE rating = 'Low'
);

UPDATE deliveries
SET driver_id = 103
WHERE delivery_id IN (3, 6);
#11.	Top 5 drivers by delivery completion rate. 
select * from driver;

SELECT  
dr.driver_id,
dr.first_name AS driver_name,COUNT(CASE WHEN d.status = 'Delivered' THEN 1 END) AS completed
FROM deliveries d
JOIN driver dr on  d.driver_id = dr.driver_id
GROUP BY dr.driver_id, dr.first_name
ORDER BY completed desc;

#12.	Total distance covered by the fleet today. 

select * from route;
select * from deliveries;

Select r.route_id, r.driver_id, count(d.delivery_id) total_stops from routes r
join deliveries d on r.route_id = d.route_id
where r.route_date = current_date()
GROUP BY r.route_id, r.driver_id;



update routes set route_date = '2025-12-16';
SELECT SUM(total_distance)
FROM routes
WHERE route_date = current_date;

#13.	Identify the zone with the highest number of returns (RTO). 

SELECT zone_id,COUNT(*) AS total_returns from deliveries
WHERE is_returned = 1
group by zone_id ORDER BY total_returns DESC;

#14.	Average time spent per stop. 

select * from deliveries;
update deliveries set scheduled_time='2025-03-08';
SELECT 
    AVG(DATEDIFF(actual_time, scheduled_time)) 
        AS avg_days_per_stop
FROM deliveries
WHERE actual_time IS NOT NULL;

#15.	Count of deliveries per vehicle type. 

select * FROM deliveries ;
select * FROM vehicle;
select * FROM routes;

SElect v.vehicle_type, COUNT(d.delivery_id) AS totaldelivery
FROM deliveries d
Join routes r ON d.route_id = r.route_id
JOIN vehicle v ON r.vehicle_id = v.vehicle_id
GROUP BY v.vehicle_type;

#16.	Generate a daily route manifest (Route ID, Driver, Total Stops). 

select r.route_id, r.driver_id, count(d.delivery_id) total_stops
from routes r
join deliveries d on r.route_id = d.route_id
WHERE r.route_date = '2025-12-16'
group by r.route_id, r.driver_id;

#17.	List drivers who have worked more than 50 hours this week. 

select * from routes;
sELECt driver_id from routes
group by driver_id
having sum(total_distance) > 50;

#18.	Identify deliveries where the actual time exceeded the estimated time by 30 mins. 

select * from deliveries;
select delivery_id, status , scheduled_time,actual_time
from deliveries
where actual_time is not NULL
and timestampdiff(minute, scheduled_time, actual_time) > 30;

#19.	Find addresses that have been marked "Incorrect Address" multiple times. 

select * from deliveries;
select * from routes;
select * from customer;
select c.address, count(*) as attempts from deliveries d
join customer c on d.customer_id = c.customer_id
where lower(d.status) = 'failed'
group by c.address;

#20.	Create a view showing: Delivery ID, Customer, Address, Status, and Driver. 

select d.delivery_id,
       c.name,
       c.address,
       d.status,
       d.driver_id
from deliveries d
join customer c on d.customer_id = c.customer_id;

#3.	Indexing & Query Optimization
#Create indexes on route_id, driver_id, and delivery_status. 

CREATE INDEX idx_routes_route_id
ON routes(route_id);

CReate index idx_routes_driver_id
ON routes(driver_id);

CREATE INDEX idx_deliveries_status
ON deliveries(status);

#inserting only required rows 

INSERT INTO vehicle
(vehicle_id, license_plate, vehicle_type, weight_capacity, volume_capacity)
VALUES
(305, 'TN01AB1234', 'Truck', 2000, 100),
(307, 'TN02CD5678', 'Van', 1500, 80);
INSERT INTO driver
(driver_id, first_name, license_number, phone, shift)
VALUES
(101, 'Ravi', 'LIC12345', '9876543210', 'Morning'),
(102, 'Kumar', 'LIC67890', '9123456780', 'Evening');
INSERT INTO routes
(route_id, route_date, driver_id, vehicle_id, total_distance)
VALUES
(1, '2025-12-01', 101, 201, 120),
(2, '2025-12-02', 102, 202, 90);


#WITHOUT INDEXING:
DROP INDEX idx_deliveries_status ON deliveries;

EXPLAIN
SELECT *FROM deliveries
WHERE status = 'Delivered';

#WITH INDEXING:

CREATE INDEX idx_deliveries_status
ON deliveries(status);

EXPLAIN
SELECT *FROM deliveries
WHERE status = 'Delivered';

# TO Apply RBAC with GRANT / REVOKE. 

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'dispatcher_user'@'localhost' IDENTIFIED BY 'dispatch123';
CREATE USER 'driver_user'@'localhost' IDENTIFIED BY 'driver123';
GRANT ALL PRIVILEGES ON deliverymanagementsystem.*
TO 'admin_user'@'localhost';
GRANT select on deliverymanagementsystem.deliveries
TO 'dispatcher_user'@'localhost';
grant update(route_id, status) ON deliverymanagementsystem.deliveries
TO 'dispatcher_user'@'localhost';
GRANT SELECT ON deliverymanagementsystem.routes
TO 'driver_user'@'localhost';
GRANT SELECT ON deliverymanagementsystem.deliveries
TO 'driver_user'@'localhost';
FLUSH PRIVILEGES;
UPDATE deliveries
SET status = 'Out for Delivery'
WHERE delivery_id = 701;

#vulnerable SQL Injection 

SELECT * FROM driver
WHERE license_number = '' OR '1'='1';






 

