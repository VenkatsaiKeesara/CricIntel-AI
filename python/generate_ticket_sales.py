import pandas as pd
import random
from datetime import datetime, timedelta
from pathlib import Path

# ==========================================================
# CONFIGURATION
# ==========================================================

random.seed(42)

TOTAL_BOOKINGS = 150000

BASE_DIR = Path(__file__).resolve().parent.parent

CUSTOMERS_FILE = BASE_DIR / "data" / "raw" / "Customers.csv"
MATCHES_FILE = BASE_DIR / "data" / "raw" / "Matches.csv"
OUTPUT_FILE = BASE_DIR / "data" / "raw" / "Ticket_Sales.csv"

# ==========================================================
# LOAD DATASETS
# ==========================================================

customers = pd.read_csv(CUSTOMERS_FILE)
matches = pd.read_csv(MATCHES_FILE)

print("Customers Loaded :", len(customers))
print("Matches Loaded   :", len(matches))

# ==========================================================
# BUSINESS RULES
# ==========================================================

seat_categories = [
    "Economy",
    "Premium",
    "VIP"
]

seat_weights = [
    60,
    30,
    10
]

seat_prices = {
    "Economy": 800,
    "Premium": 2000,
    "VIP": 5000
}

quantity_options = [
    1,
    2,
    3,
    4
]

quantity_weights = [
    50,
    35,
    10,
    5
]

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking"
]

payment_weights = [
    45,
    25,
    20,
    10
]

booking_status = [
    "Confirmed",
    "Cancelled"
]

booking_status_weights = [
    95,
    5
]


# ==========================================================
# HELPER FUNCTIONS
# ==========================================================

def generate_ticket_id(index):
    return f"T{index:06d}"


def generate_booking_date(match_date):

    match_date = datetime.strptime(match_date, "%Y-%m-%d")

    days_before = random.randint(1, 60)

    booking_date = match_date - timedelta(days=days_before)

    return booking_date.strftime("%Y-%m-%d")

# ==========================================================
# GENERATE TICKET SALES
# ==========================================================

ticket_sales = []

customer_ids = customers["Customer_ID"].tolist()

for i in range(1, TOTAL_BOOKINGS + 1):

    ticket_id = generate_ticket_id(i)

    customer_id = random.choice(customer_ids)

    match = matches.sample(1).iloc[0]

    match_id = match["Match_ID"]

    match_date = match["Match_Date"]

    booking_date = generate_booking_date(match_date)

    seat_category = random.choices(
        seat_categories,
        weights=seat_weights,
        k=1
    )[0]

    ticket_price = seat_prices[seat_category]

    quantity = random.choices(
        quantity_options,
        weights=quantity_weights,
        k=1
    )[0]

    total_amount = ticket_price * quantity

    payment_method = random.choices(
        payment_methods,
        weights=payment_weights,
        k=1
    )[0]

    status = random.choices(
        booking_status,
        weights=booking_status_weights,
        k=1
    )[0]

    ticket_sales.append({

        "Ticket_ID": ticket_id,

        "Customer_ID": customer_id,

        "Match_ID": match_id,

        "Booking_Date": booking_date,

        "Seat_Category": seat_category,

        "Ticket_Price": ticket_price,

        "Quantity": quantity,

        "Total_Amount": total_amount,

        "Payment_Method": payment_method,

        "Booking_Status": status

    })

# ==========================================================
# CREATE DATAFRAME
# ==========================================================

ticket_sales_df = pd.DataFrame(ticket_sales)

# ==========================================================
# SAVE CSV
# ==========================================================

OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)

ticket_sales_df.to_csv(
    OUTPUT_FILE,
    index=False
)

print("=" * 60)
print("Ticket Sales Dataset Generated Successfully")
print("=" * 60)
print(ticket_sales_df.head())
print()
print(f"Total Ticket Sales : {len(ticket_sales_df)}")
print(f"Saved To           : {OUTPUT_FILE}")