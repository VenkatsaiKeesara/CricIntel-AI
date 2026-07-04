"""CricIntel AI Match Generator"""

import pandas as pd
import random
from datetime import datetime,timedelta
from pathlib import Path

random.seed(42)
SEASON="IPL 2026"
START_DATE=datetime(2026,3,28)
teams={
"CSK":("Chennai","M. A. Chidambaram Stadium"),
"MI":("Mumbai","Wankhede Stadium"),
"RCB":("Bengaluru","M. Chinnaswamy Stadium"),
"KKR":("Kolkata","Eden Gardens"),
"SRH":("Hyderabad","Rajiv Gandhi International Stadium"),
"RR":("Jaipur","Sawai Mansingh Stadium"),
"DC":("Delhi","Arun Jaitley Stadium"),
"PBKS":("Mohali","Punjab Cricket Association Stadium"),
"GT":("Ahmedabad","Narendra Modi Stadium"),
"LSG":("Lucknow","BRSABV Ekana Stadium")}
capacities={
"M. A. Chidambaram Stadium":(38000,2000,8000,28000),
"Wankhede Stadium":(33000,1800,7000,24200),
"M. Chinnaswamy Stadium":(40000,2500,9000,28500),
"Eden Gardens":(68000,3500,15000,49500),
"Rajiv Gandhi International Stadium":(55000,3000,12000,40000),
"Sawai Mansingh Stadium":(30000,1500,6000,22500),
"Arun Jaitley Stadium":(41000,2200,9000,29800),
"Punjab Cricket Association Stadium":(27000,1200,5000,20800),
"Narendra Modi Stadium":(132000,6000,26000,100000),
"BRSABV Ekana Stadium":(50000,2500,10000,37500)}

team_codes=list(teams.keys())
fixtures=[(h,a) for h in team_codes for a in team_codes if h!=a]
random.shuffle(fixtures)
league=fixtures[:70]
matches=[]
current=START_DATE
for i,(home,away) in enumerate(league,1):
    city,venue=teams[home]
    cap,vip,prem,eco=capacities[venue]
    matches.append({"Match_ID":f"M{i:03}","Match_Date":current.strftime("%Y-%m-%d"),"Season":SEASON,
    "Home_Team":home,"Away_Team":away,"Venue":venue,"City":city,"Match_Type":"League",
    "Stadium_Capacity":cap,"VIP_Capacity":vip,"Premium_Capacity":prem,"Economy_Capacity":eco})
    current+=timedelta(days=1)
playoffs=[("Qualifier 1","GT","CSK"),("Eliminator","MI","RCB"),("Qualifier 2","CSK","MI"),("Final","GT","CSK")]
for stage,home,away in playoffs:
    city,venue=teams[home]
    cap,vip,prem,eco=capacities[venue]
    matches.append({"Match_ID":f"M{len(matches)+1:03}","Match_Date":current.strftime("%Y-%m-%d"),"Season":SEASON,
    "Home_Team":home,"Away_Team":away,"Venue":venue,"City":city,"Match_Type":stage,
    "Stadium_Capacity":cap,"VIP_Capacity":vip,"Premium_Capacity":prem,"Economy_Capacity":eco})
    current+=timedelta(days=2)
df=pd.DataFrame(matches)
output_path = Path(__file__).resolve().parent.parent / "data" / "raw" / "Matches.csv"

output_path.parent.mkdir(parents=True, exist_ok=True)

df.to_csv(output_path, index=False)

print(f"Saved to: {output_path}")
print(df.head())
print(len(df))
