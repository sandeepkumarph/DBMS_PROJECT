This is a Database Management System project done by using mysql to  design and implement a real-world delivery management system, applying ER modeling, normalization, SQL queries, indexing, recovery, and SQl injection testing.
1.Queries  Implemented: 

Basic Queries 
1.	List all drivers who drive "Vans". 
2.	Find deliveries scheduled for "Zone 1". 
3.	Retrieve deliveries marked as "Failed Attempt". 
4.	List vehicles with a capacity greater than 500kg. 
5.	Find customers who have requested "Contactless Delivery". 

Joins & Subqueries 

6.	Display delivery details along with Driver Name and Vehicle Number. 
7.	Find drivers who have completed deliveries in "Downtown" today. 
8.	List routes that have more than 50 stops. 
9.	Identify deliveries that were reassigned to a different driver. 
10.	List customers who have provided a "Low Rating" for delivery experience. 

Aggregation & Reports 

11.	Top 5 drivers by delivery completion rate. 
12.	Total distance covered by the fleet today. 
13.	Identify the zone with the highest number of returns (RTO). 
14.	Average time spent per stop. 
15.	Count of deliveries per vehicle type. 

Advanced Queries 

16.	Generate a daily route manifest (Route ID, Driver, Total Stops). 
17.	List drivers who have worked more than 50 hours this week. 
18.	Identify deliveries where the actual time exceeded the estimated time by 30 mins. 
19.	Find addresses that have been marked "Incorrect Address" multiple times. 
20.	Create a view showing: Delivery ID, Customer, Address, Status, and Driver. 

 
2.	Indexing & Query Optimization 
2.1	Create indexes on route_id, driver_id, and delivery_status.
2.2 execution plans with indexes.
2.3 execution plans without indexes.


3. Apply RBAC with GRANT / REVOKE. 

4. TESTING  a vulnerable SQL Injection 

