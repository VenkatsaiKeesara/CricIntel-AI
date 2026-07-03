# CricIntel AI - Data Dictionary

## Purpose

The Data Dictionary defines every column used in the CricIntel AI project. It acts as the blueprint for our database, synthetic datasets, SQL queries, Python scripts, and Power BI dashboard.

---

## Why is this important?

Before creating any dataset or database table, we need to define:

- What each column stores.
- The data type of each column.
- Whether the value can be empty.
- The business meaning of each column.
- Example values.

This document ensures consistency throughout the project.

---

## Datasets

The CricIntel AI project contains three datasets:

1. Matches
2. Customers
3. Ticket Sales

Each dataset will be documented in detail below.



# Dataset 1 – Matches

# Dataset 1 – Matches

| Column Name | Data Type | Description | Example | NULL Allowed |
|-------------|-----------|-------------|---------|--------------|
| Match_ID | INT | Unique identifier for each IPL match | 1001 | No |
| Match_Date | DATE | Date on which the match is played | 2025-04-15 | No |
| Season | VARCHAR(10) | IPL season | 2025 | No |
| Home_Team | VARCHAR(50) | Home team playing the match | CSK | No |
| Away_Team | VARCHAR(50) | Away team playing the match | RCB | No |
| Venue | VARCHAR(100) | Stadium where the match is played | M. A. Chidambaram Stadium | No |
| City | VARCHAR(50) | City where the stadium is located | Chennai | No |
| Match_Type | VARCHAR(20) | League or Playoff match | League | No |
| Stadium_Capacity | INT | Total seating capacity of the stadium | 38000 | No |
| VIP_Capacity | INT | Total number of VIP seats available | 2000 | No |
| Premium_Capacity | INT | Total number of Premium seats available | 8000 | No |
| Economy_Capacity | INT | Total number of Economy seats available | 28000 | No |



# Dataset 2 – Customers

| Column Name | Data Type | Description | Example | NULL Allowed |
|-------------|-----------|-------------|---------|--------------|
| Customer_ID | VARCHAR(10) | Unique identifier for each customer | C10001 | No |
| Gender | VARCHAR(10) | Gender of the customer | Male | No |
| Age_Group | VARCHAR(20) | Age category of the customer | 18-25 | No |
| City | VARCHAR(50) | Customer's city | Hyderabad | No |
| State | VARCHAR(50) | Customer's state | Telangana | No |
| Registration_Date | DATE | Date the customer registered | 2025-01-15 | No |



# Dataset 3 – Ticket Sales

| Column Name | Data Type | Description | Example | NULL Allowed |
|-------------|-----------|-------------|---------|--------------|
| Ticket_ID | VARCHAR(10) | Unique identifier for each booking | T100001 | No |
| Match_ID | INT | Match associated with the booking | 1001 | No |
| Customer_ID | VARCHAR(10) | Customer who made the booking | C10001 | No |
| Seat_Category | VARCHAR(20) | Type of seat booked | VIP | No |
| Quantity | INT | Number of tickets booked | 2 | No |
| Ticket_Price | DECIMAL(10,2) | Price of one ticket | 2500.00 | No |
| Total_Amount | DECIMAL(10,2) | Total amount paid | 5000.00 | No |
| Booking_Date | DATE | Date when the booking was made | 2025-04-10 | No |
| Payment_Method | VARCHAR(20) | Mode of payment | UPI | No |
| Booking_Status | VARCHAR(20) | Booking status | Confirmed | No |