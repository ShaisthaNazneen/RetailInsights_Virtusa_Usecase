# RetailInsights_Virtusa_Usecase
## Project Overview

The project is designed to help a supermarket chain optimize inventory and improve business decisions using data analytics.
This system analyzes product stock, expiry trends, and sales performance to identify key business insights.
---

## Problem Statement
A supermarket chain is facing losses due to:
* Overstocking unsold items
* Running out of fast-selling products
The goal is to generate a Stock Health Report to:
* Identify products nearing expiry
* Detect dead stock (unsold items)
* Analyze revenue contribution by category
---
##  Database Schema

### Categories Table
Stores product categories.
* `Category_Id` (Primary Key)
* `Category_Name`

### Products Table
Stores product details.
* `Product_Id` (Primary Key)
* `Product_Name`
* `Category_Id` (Foreign Key)
* `expiry_date_on`
* `count_of_stock`
* `price`
* `supplier_name`

### SalesTransactions Table
Stores sales data.
* `transaction_id` (Primary Key)
* `Product_Id` (Foreign Key)
* `quantity`
* `sale_date`
---
## Technologies Used
* SQL (MySQL)
* Relational Database Concepts
* Joins, Aggregation, Grouping
---
## Key Features/Queries

### 1. Expiring Soon Products
Identifies products that will expire within the next 7 days and have high stock.
```sql
SELECT Product_Name, expiry_date_on, count_of_stock
FROM Products
WHERE expiry_date_on BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY
AND count_of_stock > 50;
```
---

### 🔹 2. Dead Stock Analysis

Finds products that have not been sold in the last 60 days.

```sql
SELECT p.Product_Name
FROM Products p
LEFT JOIN SalesTransactions s
ON p.Product_Id = s.Product_Id
AND s.sale_date >= CURDATE() - INTERVAL 60 DAY
WHERE s.transaction_id IS NULL;
```
---
###  3. Revenue Contribution (Top Category)
Calculates which category generated the highest revenue in the last month.
```sql
SELECT c.Category_Name,
SUM(p.price * s.quantity) AS total_revenue
FROM SalesTransactions s
JOIN Products p ON s.Product_Id = p.Product_Id
JOIN Categories c ON p.Category_Id = c.Category_Id
WHERE s.sale_date >= '2026-03-01'
AND s.sale_date < '2026-04-01'
GROUP BY c.Category_Name
ORDER BY total_revenue DESC
LIMIT 1;
```
---
##  Key Concepts Demonstrated

* SQL Joins (INNER JOIN, LEFT JOIN)
* Aggregate Functions (`SUM`)
* Grouping (`GROUP BY`)
* Date Filtering
* Handling NULL values
* Business Data Analysis

---
##  How to Run the Project

1. Create the database:

   ```sql
   CREATE DATABASE retail_insights;
   USE retail_insights;
   ```
2. Run table creation scripts
3. Insert sample data
4. Execute the queries to generate insights
---

## Author

**Shaistha Nazneen**
B.Tech CSE

---

##  Conclusion

This project demonstrates how SQL can be used to solve real-world retail problems by analyzing inventory and sales data efficiently.

---
