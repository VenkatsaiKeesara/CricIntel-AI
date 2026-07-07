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
