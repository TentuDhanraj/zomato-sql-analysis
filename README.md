# 🍽️ Zomato SQL Analysis Project

> A comprehensive SQL project analyzing food delivery data to solve real business problems



## 📌 About This Project

This project demonstrates **SQL proficiency** by analyzing a simulated Zomato food delivery dataset. It covers **customer analytics**, **restaurant performance**, **delivery operations**, and **revenue trends** — solving 20 real-world business questions using advanced SQL techniques.

**Perfect for:** Data Analyst portfolios, SQL practice, interview preparation

---

## 📊 Dataset Overview

| **Entity** | **Records** | **Description** |
|------------|-------------|-----------------|
| 👥 Customers | 100 | User profiles with registration dates |
| 🏪 Restaurants | 50 | Restaurants across 25+ Indian cities |
| 📦 Orders | 1,000 | Order transactions with food items |
| 🛵 Deliveries | 1,000 | Delivery tracking and status |
| 🚴 Riders | 100 | Delivery partner information |
| ⭐ Ratings | 500 | Customer reviews and ratings |
| 💳 Payments | 1,000 | Payment transactions and methods |

**Total Records:** 3,750+ realistic data points

---

## 🗂️ Database Schema

### Visual Schema

```
                    ┌──────────────────┐
                    │    CUSTOMERS     │
                    ├──────────────────┤
                    │ • customer_id PK │
                    │ • customer_name  │
                    │ • reg_date       │
                    └────────┬─────────┘
                             │
                             │ 1:N
                             ▼
                    ┌──────────────────┐         ┌──────────────────┐
                    │      ORDERS      │ N:1     │   RESTAURANTS    │
                    ├──────────────────┤─────────┤──────────────────┤
                    │ • order_id PK    │         │ • restaurant_id PK│
                    │ • customer_id FK │         │ • restaurant_name │
                    │ • restaurant_id FK│        │ • city            │
                    │ • order_item     │         │ • opening_hours   │
                    │ • order_date     │         └─────────┬────────┘
                    │ • order_time     │                   │
                    │ • order_status   │                   │ 1:N
                    │ • total_amount   │                   │
                    └────┬─────────────┘                   ▼
                         │                        ┌──────────────────┐
                         │ 1:1                    │     RATINGS      │
                         ▼                        ├──────────────────┤
                ┌──────────────────┐              │ • rating_id PK   │
                │   DELIVERIES     │              │ • order_id FK    │
                ├──────────────────┤              │ • restaurant_id FK│
                │ • delivery_id PK │              │ • food_rating    │
                │ • order_id FK    │              │ • delivery_rating│
                │ • delivery_status│              │ • comment        │
                │ • delivery_time  │              └──────────────────┘
                │ • rider_id FK    │
                └────┬─────────────┘
                     │ N:1
                     ▼
            ┌──────────────────┐
            │      RIDERS      │
            ├──────────────────┤         ┌──────────────────┐
            │ • rider_id PK    │         │    PAYMENTS      │
            │ • rider_name     │         ├──────────────────┤
            │ • sign_up_date   │         │ • payment_id PK  │
            └──────────────────┘         │ • order_id FK    │
                                         │ • payment_method │
                                         │ • payment_status │
                                         │ • payment_date   │
                                         │ • amount         │
                                         └──────────────────┘
```

### Key Relationships
- 📌 One customer → Many orders
- 📌 One restaurant → Many orders
- 📌 One order → One delivery
- 📌 One order → One payment
- 📌 One rider → Many deliveries
- 📌 One restaurant → Many ratings

---

## 💼 Business Questions Solved

### 🟢 Foundational Analysis (Easy)

| # | Question | Business Value |
|---|----------|----------------|
| 1 | List customers registered after Jan 2022 | Identify new user cohorts |
| 2 | Find total orders placed | Platform activity metric |
| 3 | Get all restaurants in Mumbai | City-specific operations |
| 4 | Find all cancelled orders | Cancellation pattern analysis |
| 5 | Calculate total revenue from successful payments | Revenue reporting |

### 🟡 Operational Insights (Medium)

| # | Question | Business Value |
|---|----------|----------------|
| 6 | Most active customers by order count | Loyalty program targeting |
| 7 | Average delivery time per rider | Rider performance tracking |
| 8 | Most popular payment method | Payment infrastructure planning |
| 9 | Top 5 restaurants by revenue | Partner performance ranking |
| 10 | Monthly order trends for 2023 | Capacity planning |
| 11 | New riders with 10+ deliveries | Onboarding success rate |
| 12 | Food vs delivery ratings per restaurant | Quality monitoring |

### 🔴 Strategic Analytics (Hard)

| # | Question | Business Value |
|---|----------|----------------|
| 13 | Customers who never ordered | Inactive user identification |
| 14 | Most popular dish per city | Regional menu optimization |
| 15 | Top 3 riders by cancellation rate | Quality management |
| 16 | Retained customers (ordered in both 2023 & 2024) | Retention analysis |
| 17 | Month-over-month revenue growth | Executive reporting |
| 18 | Restaurant rankings by city | Featured listings strategy |
| 19 | Churned customers (6+ months inactive) | Win-back campaigns |
| 20 | Cancellation percentage per restaurant | Operational health |

---

## 🛠️ SQL Techniques Used

<table>
<tr>
<td width="50%">

**Core SQL**
- ✅ SELECT, WHERE, ORDER BY
- ✅ Aggregate Functions
- ✅ GROUP BY & HAVING
- ✅ JOINs (INNER, LEFT)
- ✅ Subqueries

</td>
<td width="50%">

**Advanced SQL**
- ✅ Window Functions (RANK, LAG)
- ✅ Common Table Expressions (CTEs)
- ✅ PARTITION BY
- ✅ CASE WHEN Logic
- ✅ Date Arithmetic

</td>
</tr>
</table>

---

## 🚀 Quick Start

### Prerequisites
```bash
PostgreSQL 12+
pgAdmin / DBeaver / psql
```

### Installation

**1. Clone the repository**
```bash
git clone https://github.com/Tentudhanraj/zomato-sql-analysis.git
cd zomato-sql-analysis
```

**2. Create database**
```sql
CREATE DATABASE zomato_db;
\c zomato_db
```

**3. Load data tables** (in order)
```bash
psql -U postgres -d zomato_db -f data/customers.sql
psql -U postgres -d zomato_db -f data/restaurants.sql
psql -U postgres -d zomato_db -f data/riders.sql
psql -U postgres -d zomato_db -f data/orders.sql
psql -U postgres -d zomato_db -f data/deliveries.sql
psql -U postgres -d zomato_db -f data/ratings.sql
psql -U postgres -d zomato_db -f data/payments.sql
```

**4. Run analysis queries**
```bash
psql -U postgres -d zomato_db -f queries/zomato_analysis_queries.sql
```

📖 See [SETUP_GUIDE.md](SETUP_GUIDE.md) for detailed instructions

---

## 📁 Repository Structure

```
zomato-sql-analysis/
│
├── 📄 README.md                  ← You are here
├── 📄 SETUP_GUIDE.md             ← Installation instructions
├── 📄 PROJECT_SUMMARY.md         ← Project overview
│
├── 📂 data/                      ← Database SQL files
│   ├── customers.sql
│   ├── restaurants.sql
│   ├── riders.sql
│   ├── orders.sql
│   ├── deliveries.sql
│   ├── ratings.sql
│   └── payments.sql
│
├── 📂 queries/                   ← Analysis queries
│   └── zomato_analysis_queries.sql
│
└── 📂 outputs/                   ← Query results (optional)
    └── screenshots/
```

---

## 📈 Sample Insights

> *Run the queries to generate your own insights and add them here!*

**Example findings:**
- 🏆 Top restaurant generated ₹XX,XXX in revenue
- 📊 UPI is the most popular payment method (XX%)
- 🚴 Average delivery time: XX minutes
- 📉 XX% of customers are at risk of churn
- 📈 Month-over-month revenue growth: +X%

---

## 🎯 Skills Demonstrated

This project showcases skills essential for **Data Analyst** roles:

- ✅ **SQL Proficiency**: Complex queries, joins, window functions
- ✅ **Business Acumen**: Translating questions into analytical solutions
- ✅ **Database Design**: Normalized schema with proper relationships
- ✅ **Data Analysis**: Customer retention, churn, revenue trends
- ✅ **Documentation**: Clean, professional code with comments

---

## 👨‍💻 About Me

**Dhanraj Tentu**  
Aspiring Data Analyst | SQL | Python | Data Visualization

📧 tentudhanraj@gmail.com  
💼 [LinkedIn Profile](www.linkedin.com/in/dhanraj-tentu/)   
📂 [More Projects](https://github.com/TentuDhanraj)

---

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- Dataset inspired by real-world Zomato operations
- Built to demonstrate SQL proficiency for job applications
- Thanks to the data analytics community for inspiration

---

