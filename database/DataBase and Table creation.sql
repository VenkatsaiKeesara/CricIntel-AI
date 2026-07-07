CREATE DATABASE CricIntel_AI;
USE CricIntel_AI;
SHOW DATABASES;

-- Matches Table 
CREATE TABLE Matches (

    Match_ID VARCHAR(5) PRIMARY KEY,

    Match_Date DATE NOT NULL,

    Season VARCHAR(20) NOT NULL,

    Home_Team VARCHAR(10) NOT NULL,

    Away_Team VARCHAR(10) NOT NULL,

    Venue VARCHAR(100) NOT NULL,

    City VARCHAR(50) NOT NULL,

    Match_Type VARCHAR(20) NOT NULL,

    Stadium_Capacity INT NOT NULL,

    VIP_Capacity INT NOT NULL,

    Premium_Capacity INT NOT NULL,

    Economy_Capacity INT NOT NULL

);

SHOW TABLES;
DESCRIBE Matches;


-- Customer table
CREATE TABLE Customers (

    Customer_ID VARCHAR(10) PRIMARY KEY,

    First_Name VARCHAR(50) NOT NULL,

    Last_Name VARCHAR(50) NOT NULL,

    Gender VARCHAR(10) NOT NULL,

    Age INT NOT NULL,

    Date_of_Birth DATE NOT NULL,

    City VARCHAR(50) NOT NULL,

    State VARCHAR(50) NOT NULL,

    Favorite_Team VARCHAR(10) NOT NULL,

    Occupation VARCHAR(100) NOT NULL,

    Annual_Income INT NOT NULL,

    Loyalty_Tier VARCHAR(20) NOT NULL,

    Email VARCHAR(100) NOT NULL,

    Phone VARCHAR(15) NOT NULL,

    Registration_Date DATE NOT NULL

);

SHOW TABLES;
DESCRIBE Customers;

-- Ticketss table 
CREATE TABLE Ticket_Sales (

    Ticket_ID VARCHAR(10) PRIMARY KEY,

    Customer_ID VARCHAR(10) NOT NULL,

    Match_ID VARCHAR(5) NOT NULL,

    Booking_Date DATE NOT NULL,

    Seat_Category VARCHAR(20) NOT NULL,

    Ticket_Price INT NOT NULL,

    Quantity INT NOT NULL,

    Total_Amount INT NOT NULL,

    Payment_Method VARCHAR(30) NOT NULL,

    Booking_Status VARCHAR(20) NOT NULL,

    CONSTRAINT FK_Customer
        FOREIGN KEY (Customer_ID)
        REFERENCES Customers(Customer_ID),

    CONSTRAINT FK_Match
        FOREIGN KEY (Match_ID)
        REFERENCES Matches(Match_ID)

);

SHOW TABLES;
DESCRIBE Ticket_Sales;


SELECT DATABASE();

SELECT COUNT(*)
FROM Matches;

SELECT COUNT(*) AS Total_Customers
FROM Customers;

SELECT *
FROM Customers
LIMIT 5;

SELECT COUNT(*)
FROM Customers
WHERE Customer_ID IS NULL;

SELECT COUNT(*) AS Total_Tickets
FROM Ticket_Sales;

SELECT COUNT(*)
FROM Ticket_Sales ts
LEFT JOIN Customers c
ON ts.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;


SELECT COUNT(*)
FROM Ticket_Sales ts
LEFT JOIN Matches m
ON ts.Match_ID = m.Match_ID
WHERE m.Match_ID IS NULL;

SELECT COUNT(*) FROM Matches;
SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Ticket_Sales;
