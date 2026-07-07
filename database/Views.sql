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