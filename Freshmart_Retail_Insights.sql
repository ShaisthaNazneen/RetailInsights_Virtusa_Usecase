create database retail_insights;
use retail_insights;
-- Categories Table
create table categories(Category_Id int primary key,Category_Name varchar(80) not null);
-- Products Table
create table Products(Product_Id int primary key,Product_Name varchar(100) not null, Category_Id int,expiry_date_on date,
count_of_stock int,price decimal(10,2),supplier_name varchar(100),foreign key(Category_Id) references categories(Category_Id));
-- Sales Table
create table SalesTransactions(transaction_id int primary key,Product_Id int,quantity int,sale_date date,
foreign key (Product_Id) references Products(Product_Id));
INSERT INTO categories VALUES
(1001,'Frozen Foods'),
(1002,'Household Items'),
(1003,'Dairy'),
(1004,'Snacks'),
(1005,'Beauty Products'),
(1006,'Stationery'),
(1007,'Beverages'),
(1008,'Fruits & Vegetables'),
(1009,'Bakery'),
(1010,'Meat & Seafood');
INSERT INTO Products VALUES
(1,'Ice Cream',1001,'2026-04-25',120,150,'Arun'),
(2,'Frozen Peas',1001,'2026-04-29',80,90,'ITC'),
(3,'Milk',1003,'2026-04-26',100,30,'Amul'),
(4,'Curd',1003,'2026-04-28',70,40,'Amul'),
(5,'Paneer',1003,'2026-04-25',20,80,'Amul'),
(6,'Bread',1009,'2026-05-02',60,35,'Britannia'),
(7,'Cake',1009,'2026-05-06',80,250,'Monginis'),
(8,'Butter',1003,'2026-05-10',90,60,'Amul'),
(9,'Cold Drink',1007,'2026-06-15',200,90,'CocaCola'),
(10,'Juice',1007,'2026-06-20',150,70,'Real'),
(11,'Notebook',1006,'2027-12-01',300,50,'Classmate'),
(12,'Pen',1006,'2027-12-01',250,10,'Classmate'),
(13,'Chips',1004,'2026-05-20',180,20,'Lays'),
(14,'Biscuits',1004,'2026-06-01',140,25,'Britannia'),
(15,'Detergent',1002,'2027-05-01',200,280,'Surf Excel'),
(16,'Floor Cleaner',1002,'2026-10-20',90,180,'Lizol'),
(17,'Shampoo',1005,'2026-09-01',110,100,'Loreal'),
(18,'Face Wash',1005,'2026-08-15',95,120,'Himalaya'),
(19,'Apples',1008,'2026-04-27',60,120,'LocalFarm'),
(20,'Tomatoes',1008,'2026-04-23',70,40,'LocalFarm'),
(21,'Chicken',1010,'2026-04-24',80,220,'FreshMeat'),
(22,'Fish',1010,'2026-04-25',90,300,'FreshMeat'),
(23,'Eggs',1008,'2026-04-26',40,6,'LocalFarm'),
(24,'Cheese',1003,'2026-05-15',70,120,'Amul'),
(25,'Soft Drink',1007,'2026-06-25',160,85,'Pepsi'),
(26,'Energy Drink',1007,'2026-07-01',100,110,'RedBull'),
(27,'Soap',1002,'2027-01-01',150,35,'Lux'),
(28,'Toothpaste',1002,'2027-03-01',180,90,'Colgate'),
(29,'Perfume',1005,'2026-10-01',50,190,'BellaVita'),
(30,'Lipstick',1005,'2026-09-15',70,250,'Maybelline'),
(31,'Markers',1006,'2027-12-01',120,60,'Camlin'),
(32,'Glue',1006,'2027-12-01',90,30,'Fevicol'),
(33,'Cookies',1004,'2026-05-25',110,50,'Unibic'),
(34,'Namkeen',1004,'2026-06-10',130,45,'Haldiram'),
(35,'Orange Juice',1007,'2026-06-30',140,75,'Tropicana'),
(36,'Bananas',1008,'2026-04-23',80,30,'LocalFarm'),
(37,'Mutton',1010,'2026-04-26',60,500,'FreshMeat'),
(38,'Prawns',1010,'2026-04-27',70,450,'FreshMeat'),
(39,'Croissant',1009,'2026-05-08',50,60,'BakeryM'),
(40,'Muffin',1009,'2026-05-09',45,55,'BakeryM');
INSERT INTO SalesTransactions VALUES
(3001,1,10,'2026-03-05'),
(3002,3,15,'2026-03-10'),
(3003,7,5,'2026-03-15'),
(3004,13,20,'2026-03-20'),
(3005,21,8,'2026-03-25'),
(3006,15,6,'2026-03-18'),
(3007,9,12,'2026-03-22'),
(3008,1,8,'2026-04-05'),
(3009,2,10,'2026-04-07'),
(3010,4,12,'2026-04-10'),
(3011,6,6,'2026-04-12'),
(3012,13,15,'2026-04-15'),
(3013,17,5,'2026-04-18'),
(3014,22,7,'2026-04-20');
-- query to find all products where the ExpiryDate is within the next 7 days but StockCount is greater than 50
select Product_Name,expiry_date_on,count_of_stock
from Products
where expiry_date_on between CURDATE() and CURDATE() + interval 7 day
and count_of_stock>50;
-- Identify products that exist in the Products table but have zero entries in the SalesTransactions table for the last 2 months.
select p.Product_Name
from Products p
left join SalesTransactions s
on p.Product_Id = s.Product_Id
and s.sale_date >= CURDATE() - interval 60 day
where s.transaction_id IS NULL;
-- query using SUM and GROUP BY to show which Category generated the most revenue last month.
select c.Category_Name,
sum(p.price * s.quantity) as total_revenue
from SalesTransactions s
join Products p ON s.Product_Id = p.Product_Id
join Categories c ON p.Category_Id = c.Category_Id
where s.sale_date >= '2026-03-01'
and s.sale_date < '2026-04-01'
group by c.Category_Name
order by total_revenue desc limit 1;


