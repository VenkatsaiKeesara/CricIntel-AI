# CricIntel AI - Dataset Mapping

## Overview

This document defines the relationships between the datasets used in the CricIntel AI project. These relationships will be implemented using Primary Keys and Foreign Keys in the MySQL database.

---

# Dataset Relationships

## Matches → Ticket Sales

Relationship

One Match can have many Ticket Bookings.

Primary Key

Match_ID

Foreign Key

Match_ID (Ticket Sales)

Cardinality

One-to-Many (1:M)

Business Reason

Each IPL match can have thousands of ticket bookings, but every ticket booking belongs to only one match.

---

## Customers → Ticket Sales

Relationship

One Customer can book multiple tickets.

Primary Key

Customer_ID

Foreign Key

Customer_ID (Ticket Sales)

Cardinality

One-to-Many (1:M)

Business Reason

A customer may purchase tickets for multiple matches throughout the IPL season.

---

# Entity Relationship Diagram (Conceptual)

                 Matches
                    │
                    │ 1
                    │
                    ▼
              Ticket Sales
                    ▲
                    │
                    │ 1
                    │
               Customers

---

# Mapping Summary

| Parent Dataset | Child Dataset | Key Used | Relationship |
|----------------|---------------|----------|--------------|
| Matches | Ticket Sales | Match_ID | One-to-Many |
| Customers | Ticket Sales | Customer_ID | One-to-Many |

---

# Future Database Implementation

These mappings will be implemented in MySQL using:

- Primary Keys
- Foreign Keys
- Referential Integrity
- SQL JOIN operations