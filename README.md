👟 Shoe Store KSA — Sales Performance Dashboard
An end-to-end data analytics project analyzing sales performance for a shoe retail business operating across three branches in Saudi Arabia (Riyadh, Jeddah, and Khobar).
---
📊 Dashboard Pages
<img width="1322" height="745" alt="Screenshot" src="https://github.com/user-attachments/assets/95c0667e-a29c-42b0-8099-51d6d9c19341" />
<img width="1322" height="743" alt="Screenshot 2" src="https://github.com/user-attachments/assets/8fff870a-8170-4485-bcc8-55e90330c9d5" />
<img width="1321" height="742" alt="Screenshot 3" src="https://github.com/user-attachments/assets/827ef7b9-2c06-4b05-9e72-8845cb25ed42" />

1. Sales Overview
Total Revenue, Orders, Avg Order Value, Units Sold, Top Month
Monthly revenue trend
Revenue by product category (Treemap)
Revenue by branch
Top 5 products by revenue
Monthly breakdown table
2. Product Performance
Top Category, Top Color, Top Size
Revenue by color
Units sold by size
Product details matrix
Units sold by category (Donut Chart)
3. Sales vs Target
Achievement %, Total Revenue vs Sales Target
Monthly revenue trend
Revenue & target by branch
Revenue vs target gauge
---
🛠️ Tools & Technologies
Tool	Usage
MySQL	Data storage & SQL Views
Python	Data loading & transformation
Power BI	Dashboard & visualizations
DAX	Calculated measures
---
🗄️ Data Model (Star Schema)
<img width="1903" height="892" alt="Schema" src="https://github.com/user-attachments/assets/33130add-3707-447d-b208-c135ef3df225" />

```
vw_dim_branches ──┐
vw_dim_shoes    ──┼──► vw_fact_sales
vw_dim_targets  ──┘
```
Fact Table: `vw_fact_sales`
sale_id, branch_id, shoe_id, sale_date, quantity_sold, total_price
Dimension Tables:
`vw_dim_branches` — branch_id, branch_name, city, manager_name
`vw_dim_shoes` — shoe_id, category, color, size, price
`vw_dim_targets` — branch_id, month, sales_target, units_target
---
📁 Project Structure
```
├── data/
│   ├── branches_clean.csv
│   ├── shoes_clean.csv
│   ├── sales_clean.csv
│   └── sales_targets_clean.csv
├── sql/
│   ├── 01_create_tables_mysql.sql
│   └── 02_views_mysql.sql
├── scripts/
│   └── load_data.py
├── ShoeStoreKSA_Dashboard.pbix
└── README.md
```
---
🔑 Key Insights
Riyadh branch leads with 2.27M SAR in total revenue
Boots is the top-selling category with 1.13M SAR
Black is the most popular color across all branches
June recorded the highest monthly revenue at 0.54M SAR
Overall achievement rate: 129.97% vs annual target
---
⚙️ How to Run
Install MySQL and run `01_create_tables_mysql.sql`
Install Python dependencies: `pip install mysql-connector-python pandas`
Run `load_data.py` to load data into MySQL
Run `02_views_mysql.sql` to create all views
Open `ShoeStoreKSA_Dashboard.pbix` in Power BI Desktop
Refresh data connections
---
👤 Author
Ahmed Elnagar
Data Analyst | Power BI | SQL | Python
🔗 LinkedIn
🔗 GitHub
