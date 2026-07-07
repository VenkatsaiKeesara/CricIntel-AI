USE CricIntel_AI;

-- Query 1: Verify total matches
SELECT COUNT(*) AS Total_Matches
FROM Matches;

-- Query 2: Verify total customers
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- Query 3: Verify total ticket bookings
SELECT COUNT(*) AS Total_Ticket_Sales
FROM Ticket_Sales;

-- Query 4: Find unique customer cities
SELECT COUNT(DISTINCT City) AS Total_Cities
FROM Customers;

-- Query 5: Find unique favorite teams
SELECT COUNT(DISTINCT Favorite_Team) AS Total_Teams
FROM Customers;

-- Query 6: Check duplicate Match IDs
SELECT Match_ID, COUNT(*) AS Duplicate_Count
FROM Matches
GROUP BY Match_ID
HAVING COUNT(*) > 1;

-- Query 7: Check duplicate Customer IDs
SELECT Customer_ID, COUNT(*) AS Duplicate_Count
FROM Customers
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Query 8: Check duplicate Ticket IDs
SELECT Ticket_ID, COUNT(*) AS Duplicate_Count
FROM Ticket_Sales
GROUP BY Ticket_ID
HAVING COUNT(*) > 1;

-- Query 9: Check NULL values
SELECT
COUNT(*) AS Null_Records
FROM Customers
WHERE Customer_ID IS NULL
   OR First_Name IS NULL
   OR Last_Name IS NULL
   OR Gender IS NULL
   OR City IS NULL;
   
   
-- Query 10: Validate Customer foreign key
SELECT COUNT(*) AS Invalid_Customers
FROM Ticket_Sales ts
LEFT JOIN Customers c
ON ts.Customer_ID = c.Customer_ID
WHERE c.Customer_ID IS NULL;

-- MODULE 2 – Business KPI Queries
-- Query 11: Calculate total revenue
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Ticket_Sales
WHERE Booking_Status = 'Confirmed';

-- Query 12: Calculate total tickets sold
SELECT SUM(Quantity) AS Total_Tickets_Sold
FROM Ticket_Sales
WHERE Booking_Status='Confirmed';

-- Query 13: Calculate average ticket price
SELECT ROUND(AVG(Ticket_Price),2) AS Avg_Ticket_Price
FROM Ticket_Sales
WHERE Booking_Status='Confirmed';

-- Query 14: Calculate average booking value
SELECT ROUND(AVG(Total_Amount),2) AS Avg_Booking_Value
FROM Ticket_Sales
WHERE Booking_Status='Confirmed';

-- Query 15: Booking status summary
SELECT
Booking_Status,
COUNT(*) AS Total_Bookings
FROM Ticket_Sales
GROUP BY Booking_Status;

-- Query 16: Revenue by seat category
SELECT
    Seat_Category,
    SUM(Total_Amount) AS Total_Revenue
FROM Ticket_Sales
WHERE Booking_Status = 'Confirmed'
GROUP BY Seat_Category
ORDER BY Total_Revenue DESC;

-- Query 17: Tickets sold by seat category
SELECT
    Seat_Category,
    SUM(Quantity) AS Tickets_Sold
FROM Ticket_Sales
WHERE Booking_Status = 'Confirmed'
GROUP BY Seat_Category
ORDER BY Tickets_Sold DESC;

-- Query 18: Revenue by payment method
SELECT
    Payment_Method,
    SUM(Total_Amount) AS Total_Revenue
FROM Ticket_Sales
WHERE Booking_Status = 'Confirmed'
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- Query 19: Average tickets per booking
SELECT
    ROUND(AVG(Quantity),2) AS Avg_Tickets_Per_Booking
FROM Ticket_Sales
WHERE Booking_Status = 'Confirmed';

-- Query 20: Booking status percentage
SELECT
    Booking_Status,
    COUNT(*) AS Total_Bookings,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Ticket_Sales),2) AS Percentage
FROM Ticket_Sales
GROUP BY Booking_Status;

-- Query 21: Top 10 customers by spending
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent
FROM Ticket_Sales
WHERE Booking_Status = 'Confirmed'
GROUP BY Customer_ID
ORDER BY Total_Spent DESC
LIMIT 10;

-- Query 22: Revenue by loyalty tier
SELECT
    c.Loyalty_Tier,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Customers c
JOIN Ticket_Sales ts
ON c.Customer_ID = ts.Customer_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY c.Loyalty_Tier
ORDER BY Total_Revenue DESC;

-- Query 23: Customer distribution by gender
SELECT
    Gender,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY Gender
ORDER BY Total_Customers DESC;

-- Query 24: Revenue by city
SELECT
    c.City,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Customers c
JOIN Ticket_Sales ts
ON c.Customer_ID = ts.Customer_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY c.City
ORDER BY Total_Revenue DESC;

-- Query 25: Revenue by state
SELECT
    c.State,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Customers c
JOIN Ticket_Sales ts
ON c.Customer_ID = ts.Customer_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY c.State
ORDER BY Total_Revenue DESC;

-- MODULE 3 – Customer Analytics
-- Query 26: Revenue by favorite team
SELECT
    c.Favorite_Team,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Customers c
JOIN Ticket_Sales ts
ON c.Customer_ID = ts.Customer_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY c.Favorite_Team
ORDER BY Total_Revenue DESC;

-- Query 27: Revenue by occupation
SELECT
    c.Occupation,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Customers c
JOIN Ticket_Sales ts
ON c.Customer_ID = ts.Customer_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY c.Occupation
ORDER BY Total_Revenue DESC;

-- Query 28: Average spending per customer
SELECT
    ROUND(AVG(Customer_Spending),2) AS Avg_Customer_Spending
FROM
(
    SELECT
        Customer_ID,
        SUM(Total_Amount) AS Customer_Spending
    FROM Ticket_Sales
    WHERE Booking_Status='Confirmed'
    GROUP BY Customer_ID
) AS CustomerRevenue;

-- Query 29: Top cities by customers
SELECT
    City,
    COUNT(*) AS Total_Customers
FROM Customers
GROUP BY City
ORDER BY Total_Customers DESC
LIMIT 10;

-- Query 30: Monthly customer registrations
SELECT
    DATE_FORMAT(Registration_Date,'%Y-%m') AS Registration_Month,
    COUNT(*) AS New_Customers
FROM Customers
GROUP BY Registration_Month
ORDER BY Registration_Month;

-- MODULE 4 – Match Analytics
-- Query 31: Top 10 matches by revenue
SELECT
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    m.Match_Date,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    m.Match_Date
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Query 32: Lowest revenue matches
SELECT
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status='Confirmed'
GROUP BY
    m.Match_ID,
    m.Home_Team,
    m.Away_Team
ORDER BY Total_Revenue ASC
LIMIT 10;

-- Query 33: Revenue by home team
SELECT
    m.Home_Team,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status='Confirmed'
GROUP BY m.Home_Team
ORDER BY Total_Revenue DESC;

-- Query 34: Tickets sold per match
SELECT
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    SUM(ts.Quantity) AS Tickets_Sold
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status='Confirmed'
GROUP BY
    m.Match_ID,
    m.Home_Team,
    m.Away_Team
ORDER BY Tickets_Sold DESC;


-- Query 35: Average revenue per match
SELECT
    ROUND(AVG(Match_Revenue),2) AS Avg_Revenue_Per_Match
FROM
(
    SELECT
        Match_ID,
        SUM(Total_Amount) AS Match_Revenue
    FROM Ticket_Sales
    WHERE Booking_Status='Confirmed'
    GROUP BY Match_ID
) AS MatchRevenue;

-- Query 36: Revenue by match type
SELECT
    m.Match_Type,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY m.Match_Type
ORDER BY Total_Revenue DESC;

-- Query 37: Revenue by venue
SELECT
    m.Venue,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY m.Venue
ORDER BY Total_Revenue DESC;

-- Query 38: Revenue by match city
SELECT
    m.City,
    SUM(ts.Total_Amount) AS Total_Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY m.City
ORDER BY Total_Revenue DESC;

-- Query 39: Highest occupancy matches
SELECT
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    SUM(ts.Quantity) AS Tickets_Sold,
    m.Stadium_Capacity,
    ROUND((SUM(ts.Quantity) * 100.0) / m.Stadium_Capacity,2) AS Occupancy_Percentage
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    m.Stadium_Capacity
ORDER BY Occupancy_Percentage DESC
LIMIT 10;

-- Query 40: Lowest occupancy matches
SELECT
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    SUM(ts.Quantity) AS Tickets_Sold,
    m.Stadium_Capacity,
    ROUND((SUM(ts.Quantity) * 100.0) / m.Stadium_Capacity,2) AS Occupancy_Percentage
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID = ts.Match_ID
WHERE ts.Booking_Status = 'Confirmed'
GROUP BY
    m.Match_ID,
    m.Home_Team,
    m.Away_Team,
    m.Stadium_Capacity
ORDER BY Occupancy_Percentage ASC
LIMIT 10;

-- MODULE 5 – Booking Analytics
-- Query 41: Revenue by payment method
SELECT
    Payment_Method,
    SUM(Total_Amount) AS Total_Revenue
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- Query 42: Bookings by payment method
SELECT
    Payment_Method,
    COUNT(*) AS Total_Bookings
FROM Ticket_Sales
GROUP BY Payment_Method
ORDER BY Total_Bookings DESC;

-- Query 43: Seat category preference
SELECT
    Seat_Category,
    SUM(Quantity) AS Tickets_Sold
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Seat_Category
ORDER BY Tickets_Sold DESC;

-- Query 44: Average tickets by seat category
SELECT
    Seat_Category,
    ROUND(AVG(Quantity),2) AS Avg_Tickets
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Seat_Category
ORDER BY Avg_Tickets DESC;

-- Query 45: Booking status summary
SELECT
    Booking_Status,
    COUNT(*) AS Total_Bookings
FROM Ticket_Sales
GROUP BY Booking_Status;

-- Query 46: Monthly booking trend
SELECT
    DATE_FORMAT(Booking_Date,'%Y-%m') AS Booking_Month,
    COUNT(*) AS Total_Bookings
FROM Ticket_Sales
GROUP BY Booking_Month
ORDER BY Booking_Month;

-- Query 47: Daily booking trend
SELECT
    Booking_Date,
    COUNT(*) AS Total_Bookings
FROM Ticket_Sales
GROUP BY Booking_Date
ORDER BY Booking_Date;

-- Query 48: Peak booking dates
SELECT
    Booking_Date,
    COUNT(*) AS Total_Bookings
FROM Ticket_Sales
GROUP BY Booking_Date
ORDER BY Total_Bookings DESC
LIMIT 10;

-- Query 49: Cancellation rate
SELECT
    ROUND(
        SUM(CASE WHEN Booking_Status='Cancelled' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),2
    ) AS Cancellation_Rate
FROM Ticket_Sales;


-- MODULE 6 – Advanced SQL Analytics
-- Query 51: Rank customers by spending
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent,
    RANK() OVER(
        ORDER BY SUM(Total_Amount) DESC
    ) AS Customer_Rank
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Customer_ID;

-- Query 52: Dense rank customers
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent,
    DENSE_RANK() OVER(
        ORDER BY SUM(Total_Amount) DESC
    ) AS Customer_Rank
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Customer_ID;

-- Query 53: Customer row number
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent,
    ROW_NUMBER() OVER(
        ORDER BY SUM(Total_Amount) DESC
    ) AS Row_Num
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Customer_ID;

-- Query 54: Top customer from each city
WITH CustomerRevenue AS (
    SELECT
        c.City,
        c.Customer_ID,
        SUM(ts.Total_Amount) AS Total_Spent,
        ROW_NUMBER() OVER(
            PARTITION BY c.City
            ORDER BY SUM(ts.Total_Amount) DESC
        ) AS rn
    FROM Customers c
    JOIN Ticket_Sales ts
        ON c.Customer_ID = ts.Customer_ID
    WHERE ts.Booking_Status='Confirmed'
    GROUP BY c.City, c.Customer_ID
)

SELECT
    City,
    Customer_ID,
    Total_Spent
FROM CustomerRevenue
WHERE rn = 1;

-- Query 55: Customer revenue contribution
SELECT
    Customer_ID,
    SUM(Total_Amount) AS Total_Spent,
    ROUND(
        SUM(Total_Amount) * 100.0 /
        (
            SELECT SUM(Total_Amount)
            FROM Ticket_Sales
            WHERE Booking_Status='Confirmed'
        ),
        2
    ) AS Revenue_Percentage
FROM Ticket_Sales
WHERE Booking_Status='Confirmed'
GROUP BY Customer_ID
ORDER BY Revenue_Percentage DESC;

-- Query 56: Running revenue trend
WITH DailyRevenue AS (
    SELECT
        Booking_Date,
        SUM(Total_Amount) AS Daily_Revenue
    FROM Ticket_Sales
    WHERE Booking_Status = 'Confirmed'
    GROUP BY Booking_Date
)

SELECT
    Booking_Date,
    Daily_Revenue,
    SUM(Daily_Revenue) OVER(
        ORDER BY Booking_Date
    ) AS Running_Revenue
FROM DailyRevenue;

-- Query 57: Compare with previous day revenue
WITH DailyRevenue AS (
    SELECT
        Booking_Date,
        SUM(Total_Amount) AS Daily_Revenue
    FROM Ticket_Sales
    WHERE Booking_Status = 'Confirmed'
    GROUP BY Booking_Date
)

SELECT
    Booking_Date,
    Daily_Revenue,
    LAG(Daily_Revenue) OVER(
        ORDER BY Booking_Date
    ) AS Previous_Day_Revenue
FROM DailyRevenue;

-- Query 58: Daily revenue change
WITH DailyRevenue AS (
    SELECT
        Booking_Date,
        SUM(Total_Amount) AS Daily_Revenue
    FROM Ticket_Sales
    WHERE Booking_Status = 'Confirmed'
    GROUP BY Booking_Date
)

SELECT
    Booking_Date,
    Daily_Revenue,
    Daily_Revenue -
    LAG(Daily_Revenue) OVER(
        ORDER BY Booking_Date
    ) AS Revenue_Change
FROM DailyRevenue;

-- Query 59: Top revenue match in each city
WITH MatchRevenue AS (
    SELECT
        m.City,
        m.Match_ID,
        m.Home_Team,
        m.Away_Team,
        SUM(ts.Total_Amount) AS Total_Revenue,
        ROW_NUMBER() OVER(
            PARTITION BY m.City
            ORDER BY SUM(ts.Total_Amount) DESC
        ) AS rn
    FROM Matches m
    JOIN Ticket_Sales ts
        ON m.Match_ID = ts.Match_ID
    WHERE ts.Booking_Status = 'Confirmed'
    GROUP BY
        m.City,
        m.Match_ID,
        m.Home_Team,
        m.Away_Team
)

SELECT
    City,
    Match_ID,
    Home_Team,
    Away_Team,
    Total_Revenue
FROM MatchRevenue
WHERE rn = 1;

-- Query 60: Best home match for each team
WITH TeamRevenue AS (
    SELECT
        m.Home_Team,
        m.Match_ID,
        m.Away_Team,
        SUM(ts.Total_Amount) AS Total_Revenue,
        ROW_NUMBER() OVER(
            PARTITION BY m.Home_Team
            ORDER BY SUM(ts.Total_Amount) DESC
        ) AS rn
    FROM Matches m
    JOIN Ticket_Sales ts
        ON m.Match_ID = ts.Match_ID
    WHERE ts.Booking_Status = 'Confirmed'
    GROUP BY
        m.Home_Team,
        m.Match_ID,
        m.Away_Team
)

SELECT
    Home_Team,
    Match_ID,
    Away_Team,
    Total_Revenue
FROM TeamRevenue
WHERE rn = 1;