# customer-payments-analysis-sql
A comprehensive SQL project for analyzing customer orders and payment data using MySQL. Includes insights into sales trends, customer retention, repeat purchases, and payment status tracking with structured queries and reports.

# 💳 Customer & Payments SQL Analysis

![SQL](https://img.shields.io/badge/SQL-MySQL-blue?logo=mysql)
![Status](https://img.shields.io/badge/status-active-success)
![License](https://img.shields.io/badge/license-MIT-green)

This project provides SQL scripts to create, manage, and analyze customer order and payment data using MySQL. It includes sales trend analysis, customer behavior tracking, payment status summaries, and customer retention reports.

---

## 📂 File

- `customerandpayments.sql`: Contains SQL queries to:
  - Create `customer_orders` and `payments` tables
  - Perform analytics on order and payment data
  - Generate reports like Monthly Sales, Repeat Customers, Failed Payments, etc.

---

## 🔍 Features

### 1. Sales & Order Analytics
- 📈 Monthly sales trends (from completed payments)
- 📊 Order volume per month
- 📦 Orders grouped by status

### 2. Customer Insights
- 👤 Orders per customer
- 🔁 Repeat customer identification
- 📅 New vs Repeat orders (monthly)

### 3. Payment Status Monitoring
- ✅ Total payments by status (completed, failed, etc.)
- ❌ Failed payment trends by month

### 4. Detailed Reporting
- 🔗 Order + Payment details report
- 📉 Customer retention tracking (cohort analysis)

---

## 🛠️ Setup Instructions

1. Open MySQL Workbench or any SQL IDE.
2. Make sure the database `bank_db` exists:
   ```sql
   CREATE DATABASE bank_db;
   USE bank_db;
