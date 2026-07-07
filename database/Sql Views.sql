-- Module 7 : Sql Views
-- Query 61: Customer revenue view
CREATE VIEW vw_customer_revenue AS

SELECT
    c.Customer_ID,
    c.First_Name,
    c.Last_Name,
    c.City,
    c.State,
    c.Loyalty_Tier,
    SUM(ts.Total_Amount) AS Total_Spent,
    SUM(ts.Quantity) AS Tickets_Bought
FROM Customers c
JOIN Ticket_Sales ts
ON c.Customer_ID = ts.Customer_ID
WHERE ts.Booking_Status='Confirmed'
GROUP BY
    c.Customer_ID,
    c.First_Name,
    c.Last_Name,
    c.City,
    c.State,
    c.Loyalty_Tier;

-- To use 
SELECT *
FROM vw_customer_revenue;

-- Query 62: Match revenue view
CREATE VIEW vw_match_revenue AS

SELECT
    m.Match_ID,
    m.Match_Date,
    m.Home_Team,
    m.Away_Team,
    m.City,
    m.Venue,
    SUM(ts.Total_Amount) AS Revenue,
    SUM(ts.Quantity) AS Tickets_Sold
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID=ts.Match_ID
WHERE ts.Booking_Status='Confirmed'
GROUP BY
    m.Match_ID,
    m.Match_Date,
    m.Home_Team,
    m.Away_Team,
    m.City,
    m.Venue;
    
-- to use 
SELECT *
FROM vw_match_revenue;

-- Query 63: Booking summary view
CREATE VIEW vw_booking_summary AS

SELECT
    Booking_Date,
    Payment_Method,
    Seat_Category,
    Booking_Status,
    COUNT(*) AS Total_Bookings,
    SUM(Quantity) AS Tickets_Sold,
    SUM(Total_Amount) AS Revenue
FROM Ticket_Sales
GROUP BY
    Booking_Date,
    Payment_Method,
    Seat_Category,
    Booking_Status;
    
-- to use 
SELECT *
FROM vw_booking_summary;


-- Query 64: Team performance view
CREATE VIEW vw_team_performance AS

SELECT
    m.Home_Team,
    COUNT(DISTINCT m.Match_ID) AS Matches_Played,
    SUM(ts.Quantity) AS Tickets_Sold,
    SUM(ts.Total_Amount) AS Revenue
FROM Matches m
JOIN Ticket_Sales ts
ON m.Match_ID=ts.Match_ID
WHERE ts.Booking_Status='Confirmed'
GROUP BY
    m.Home_Team;
    
-- to use 
SELECT *
FROM vw_team_performance;


-- Query 65: Executive dashboard view
CREATE VIEW vw_executive_dashboard AS

SELECT

COUNT(DISTINCT Match_ID) AS Total_Matches,

COUNT(DISTINCT Customer_ID) AS Total_Customers,

COUNT(*) AS Total_Bookings,

SUM(Quantity) AS Tickets_Sold,

SUM(Total_Amount) AS Revenue,

ROUND(AVG(Ticket_Price),2) AS Avg_Ticket_Price

FROM Ticket_Sales

WHERE Booking_Status='Confirmed';

-- to use 
SELECT *
FROM vw_executive_dashboard;
