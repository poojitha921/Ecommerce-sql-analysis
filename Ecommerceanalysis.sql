 -- 📊 E-Commerce Analytics SQL Mini Project
-- 🔹 Step 1: Table Creation

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 🔹 Step 2: Insert Sample Data

-- Customers
INSERT INTO Customers VALUES
(1, 'Asha', 'Mumbai'),
(2, 'Ravi', 'Delhi'),
(3, 'Meena', 'Bangalore');

-- Products
INSERT INTO Products VALUES
(101, 'Laptop', 55000.00),
(102, 'Mouse', 500.00),
(103, 'Keyboard', 1200.00),
(104, 'Monitor', 9000.00);

-- Orders
INSERT INTO Orders VALUES
(201, 1, '2025-07-01', 56500.00),
(202, 2, '2025-07-03', 9500.00),
(203, 1, '2025-07-05', 500.00),
(204, 3, '2025-07-06', 57000.00);

-- Order Details
INSERT INTO OrderDetails VALUES
(201, 101, 1),
(201, 102, 1),
(202, 104, 1),
(203, 102, 1),
(204, 101, 1),
(204, 103, 1);

-- 🔹 Step 3: Analytical Queries

-- 1. Top 3 Customers by Total Spending
SELECT c.Name, SUM(o.Amount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC
LIMIT 3;

-- 2. Most Sold Product
SELECT p.ProductName, SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY od.ProductID
ORDER BY TotalSold DESC
LIMIT 1;

-- 3. Customers Who Never Placed an Order
SELECT Name
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- 4. Total Revenue Per Product
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS Revenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID;
