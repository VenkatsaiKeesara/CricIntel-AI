-- MODULE 8 – Stored Procedures
-- Query 66: Customer booking history
DELIMITER $$

CREATE PROCEDURE sp_customer_booking_history(
    IN p_customer_id VARCHAR(10)
)
BEGIN

SELECT
    ts.Ticket_ID,
    ts.Booking_Date,
    m.Home_Team,
    m.Away_Team,
    m.Match_Date,
    ts.Seat_Category,
    ts.Quantity,
    ts.Total_Amount,
    ts.Booking_Status
FROM Ticket_Sales ts
JOIN Matches m
ON ts.Match_ID = m.Match_ID
WHERE ts.Customer_ID = p_customer_id
ORDER BY ts.Booking_Date DESC;

END $$

DELIMITER ;

-- to use 
CALL sp_customer_booking_history('C00001');

-- Query 67: Match revenue report
DELIMITER $$

CREATE PROCEDURE sp_match_revenue(
    IN p_match_id VARCHAR(5)
)
BEGIN

SELECT

m.Match_ID,

m.Home_Team,

m.Away_Team,

SUM(ts.Total_Amount) AS Revenue,

SUM(ts.Quantity) AS Tickets_Sold

FROM Matches m

JOIN Ticket_Sales ts

ON m.Match_ID=ts.Match_ID

WHERE m.Match_ID=p_match_id

AND ts.Booking_Status='Confirmed'

GROUP BY
m.Match_ID,
m.Home_Team,
m.Away_Team;

END $$

DELIMITER ;

-- to use 
CALL sp_match_revenue('M001');

-- Query 68: Stadium occupancy report
DELIMITER $$

CREATE PROCEDURE sp_stadium_occupancy(
    IN p_match_id VARCHAR(5)
)
BEGIN

SELECT

m.Match_ID,

m.Venue,

m.Stadium_Capacity,

SUM(ts.Quantity) AS Tickets_Sold,

ROUND(
SUM(ts.Quantity)*100.0/m.Stadium_Capacity,
2
) AS Occupancy_Percentage

FROM Matches m

JOIN Ticket_Sales ts

ON m.Match_ID=ts.Match_ID

WHERE m.Match_ID=p_match_id

AND ts.Booking_Status='Confirmed'

GROUP BY
m.Match_ID,
m.Venue,
m.Stadium_Capacity;

END $$

DELIMITER ;

-- to use 
CALL sp_stadium_occupancy('M001');

-- Query 69: Team performance report
DELIMITER $$

CREATE PROCEDURE sp_team_performance(
    IN p_team VARCHAR(10)
)
BEGIN

SELECT

Home_Team,

COUNT(DISTINCT Match_ID) AS Matches,

SUM(Quantity) AS Tickets_Sold,

SUM(Total_Amount) AS Revenue

FROM vw_match_revenue mr
JOIN Ticket_Sales ts
ON mr.Match_ID = ts.Match_ID

WHERE Home_Team=p_team

AND Booking_Status='Confirmed'

GROUP BY Home_Team;

END $$

DELIMITER ;

-- to use 
CALL sp_team_performance('CSK');

-- Query 70: Executive KPI summary
DELIMITER $$

CREATE PROCEDURE sp_executive_dashboard()
BEGIN

SELECT

COUNT(DISTINCT Match_ID) AS Total_Matches,

COUNT(DISTINCT Customer_ID) AS Total_Customers,

COUNT(*) AS Total_Bookings,

SUM(Quantity) AS Tickets_Sold,

SUM(Total_Amount) AS Revenue,

ROUND(AVG(Ticket_Price),2) AS Avg_Ticket_Price

FROM Ticket_Sales

WHERE Booking_Status='Confirmed';

END $$

DELIMITER ;

-- to use 
CALL sp_executive_dashboard();
