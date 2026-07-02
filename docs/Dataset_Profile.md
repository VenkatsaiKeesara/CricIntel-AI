# CricIntel AI - Dataset Profile

## Overview

This document describes the datasets that will be used in the CricIntel AI project. Since real IPL ticket booking data is not publicly available, realistic synthetic datasets will be generated based on actual business scenarios.

---

# Dataset 1: Matches

Purpose

Stores information about every IPL match conducted during the IPL season.

Estimated Rows

100

Primary Key

Match_ID

Important Columns

- Match_ID
- Match_Date
- Season
- Venue
- City
- Home_Team
- Away_Team

Expected Data Quality

- No duplicate Match_ID
- No missing Match_Date
- Valid team names
- Valid venue names

---

# Dataset 2: Customers

Purpose

Stores customer demographic information.

Estimated Rows

50,000

Primary Key

Customer_ID

Important Columns

- Customer_ID
- Gender
- Age_Group
- City

Expected Data Quality

- Unique Customer_ID
- No missing Gender
- Valid age groups
- Standardized city names

---

# Dataset 3: Ticket Sales

Purpose

Stores every ticket booking transaction.

Estimated Rows

100,000

Primary Key

Ticket_ID

Foreign Keys

- Match_ID
- Customer_ID

Important Columns

- Ticket_ID
- Match_ID
- Customer_ID
- Booking_Date
- Seat_Category
- Ticket_Price
- Quantity
- Total_Amount
- Payment_Method
- Booking_Channel
- Booking_Status

Expected Data Quality

- Unique Ticket_ID
- No negative ticket prices
- Quantity greater than zero
- Booking date before match date
- Total_Amount = Ticket_Price × Quantity