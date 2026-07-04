import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta
from pathlib import Path

fake = Faker("en_IN")

random.seed(42)

TOTAL_CUSTOMERS = 12000

# ==========================================================
# BUSINESS RULES & CONFIGURATION
# ==========================================================

teams = [
    "CSK",
    "MI",
    "RCB",
    "KKR",
    "SRH",
    "RR",
    "DC",
    "PBKS",
    "GT",
    "LSG"
]

cities = {
    "Bengaluru": "Karnataka",
    "Chennai": "Tamil Nadu",
    "Mumbai": "Maharashtra",
    "Hyderabad": "Telangana",
    "Kolkata": "West Bengal",
    "Delhi": "Delhi",
    "Ahmedabad": "Gujarat",
    "Jaipur": "Rajasthan",
    "Lucknow": "Uttar Pradesh",
    "Mohali": "Punjab"
}

occupations = [
    "Software Engineer",
    "Data Analyst",
    "Data Scientist",
    "Student",
    "Doctor",
    "Teacher",
    "Business Owner",
    "Chartered Accountant",
    "Government Employee",
    "Marketing Executive",
    "Sales Executive",
    "Banker",
    "Lawyer",
    "Nurse",
    "Police Officer",
    "Freelancer",
    "Graphic Designer",
    "Civil Engineer",
    "Mechanical Engineer",
    "Entrepreneur"
]

loyalty_tiers = [
    "Bronze",
    "Silver",
    "Gold",
    "Platinum"
]

team_weights = [
    14,   # CSK
    14,   # MI
    14,   # RCB
    12,   # KKR
    10,   # SRH
    8,    # RR
    8,    # DC
    6,    # PBKS
    7,    # GT
    7     # LSG
]

loyalty_weights = [
    50,   # Bronze
    30,   # Silver
    15,   # Gold
    5     # Platinum
]

email_domains = [
    "gmail.com",
    "outlook.com",
    "yahoo.com",
    "hotmail.com"
]

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking"
]

genders = [
    "Male",
    "Female"
]

gender_weights = [
    65,
    35
]

age_groups = [
    (18, 24),
    (25, 34),
    (35, 44),
    (45, 60)
]

age_group_weights = [
    25,
    35,
    25,
    15
]

start_registration = datetime(2024, 1, 1)
end_registration = datetime(2026, 3, 27)

# ==========================================================
# HELPER FUNCTIONS
# ==========================================================

def generate_age():
    """Generate age based on weighted age groups."""
    age_range = random.choices(age_groups, weights=age_group_weights, k=1)[0]
    return random.randint(age_range[0], age_range[1])


def generate_dob(age):
    """Generate date of birth based on age."""
    current_year = 2026
    birth_year = current_year - age

    month = random.randint(1, 12)
    day = random.randint(1, 28)

    return datetime(birth_year, month, day).strftime("%Y-%m-%d")


def generate_registration_date():
    """Generate random registration date before IPL 2026."""
    days = (end_registration - start_registration).days

    random_days = random.randint(0, days)

    return (
        start_registration + timedelta(days=random_days)
    ).strftime("%Y-%m-%d")


def generate_phone():
    """Generate Indian mobile number."""

    first_digit = random.choice(["9", "8", "7", "6"])

    remaining = "".join(random.choices("0123456789", k=9))

    return first_digit + remaining


def generate_email(first_name, last_name):
    """Generate realistic email."""

    domain = random.choice(email_domains)

    number = random.randint(1, 999)

    email = (
        f"{first_name.lower()}."
        f"{last_name.lower()}"
        f"{number}@{domain}"
    )

    return email


def generate_income(occupation):
    """Generate annual income based on occupation."""

    income_ranges = {
        "Student": (0, 300000),
        "Software Engineer": (600000, 1800000),
        "Data Analyst": (500000, 1200000),
        "Data Scientist": (700000, 2200000),
        "Doctor": (800000, 3000000),
        "Teacher": (300000, 900000),
        "Business Owner": (600000, 5000000),
        "Chartered Accountant": (700000, 2500000),
        "Government Employee": (400000, 1200000),
        "Marketing Executive": (350000, 1000000),
        "Sales Executive": (300000, 900000),
        "Banker": (500000, 1800000),
        "Lawyer": (600000, 2500000),
        "Nurse": (300000, 700000),
        "Police Officer": (350000, 900000),
        "Freelancer": (250000, 1500000),
        "Graphic Designer": (300000, 900000),
        "Civil Engineer": (500000, 1500000),
        "Mechanical Engineer": (500000, 1500000),
        "Entrepreneur": (500000, 5000000)
    }

    low, high = income_ranges.get(occupation, (300000, 1000000))

    return random.randint(low, high)


def generate_customer_id(index):
    """Generate Customer ID."""

    return f"C{index:05d}"

# ==========================================================
# GENERATE CUSTOMERS
# ==========================================================

customers = []

city_list = list(cities.keys())

for i in range(1, TOTAL_CUSTOMERS + 1):

    customer_id = generate_customer_id(i)

    gender = random.choices(
        genders,
        weights=gender_weights,
        k=1
    )[0]

    if gender == "Male":
        first_name = fake.first_name_male()
    else:
        first_name = fake.first_name_female()

    last_name = fake.last_name()

    age = generate_age()

    dob = generate_dob(age)

    city = random.choice(city_list)

    state = cities[city]

    favourite_team = random.choices(
        teams,
        weights=team_weights,
        k=1
    )[0]

    occupation = random.choice(occupations)

    annual_income = generate_income(occupation)

    loyalty = random.choices(
        loyalty_tiers,
        weights=loyalty_weights,
        k=1
    )[0]

    email = generate_email(first_name, last_name)

    phone = generate_phone()

    registration_date = generate_registration_date()

    customers.append({

        "Customer_ID": customer_id,

        "First_Name": first_name,

        "Last_Name": last_name,

        "Gender": gender,

        "Age": age,

        "Date_of_Birth": dob,

        "City": city,

        "State": state,

        "Favorite_Team": favourite_team,

        "Occupation": occupation,

        "Annual_Income": annual_income,

        "Loyalty_Tier": loyalty,

        "Email": email,

        "Phone": phone,

        "Registration_Date": registration_date

    })

# ==========================================================
# CREATE DATAFRAME
# ==========================================================

df = pd.DataFrame(customers)

# ==========================================================
# SAVE CSV
# ==========================================================

output_path = (
    Path(__file__).resolve().parent.parent
    / "data"
    / "raw"
    / "Customers.csv"
)

output_path.parent.mkdir(parents=True, exist_ok=True)

df.to_csv(output_path, index=False)

print("=" * 60)
print("Customers Dataset Generated Successfully")
print("=" * 60)
print(df.head())
print()
print(f"Total Customers : {len(df)}")
print(f"Saved To         : {output_path}")