# SQL-advance-analytics-project

# 📊 Customer Analytics Report using SQL

## 📖 Overview

This project focuses on building a comprehensive **customer-level analytics report** using SQL. It consolidates transactional and customer data to generate meaningful insights around customer behavior, segmentation, and performance.

The final output is a reusable SQL **view** that can support business decisions in marketing, sales, and customer retention.

---

## 🎯 Objective

The goal of this project is to answer key business questions such as:

* Who are the most valuable customers?
* How are customers distributed across different age groups?
* Which customers are at risk based on inactivity?
* What is the average spending behavior of customers?

---

## 🛠️ Tools & Concepts Used

* SQL Server
* Joins (Fact & Dimension tables)
* CTEs (Common Table Expressions)
* Aggregations (`SUM`, `COUNT`, `MAX`, `MIN`)
* Window Functions
* Conditional Logic (`CASE WHEN`)
* Date Functions (`DATEDIFF`, `GETDATE`)

---

## 📊 Key Features

### 🔹 Customer Data Consolidation

* Combined transactional and customer data into a single dataset
* Extracted key fields like name, age, and order details

---

### 🔹 Customer Segmentation

Customers are classified into:

* **VIP** → Customers with ≥12 months history and sales > 5000
* **Regular** → Customers with ≥12 months history and sales ≤ 5000
* **New** → Customers with <12 months history

---

### 🔹 Age Group Classification

Customers are grouped into:

* Under 20
* 20–29
* 30–39
* 40–49
* 50 and above

---

### 🔹 Customer-Level Metrics

For each customer, the following metrics are calculated:

* Total Orders
* Total Sales
* Total Quantity Purchased
* Total Products Purchased
* Customer Lifespan (in months)
* Last Order Date

---

### 🔹 Key Performance Indicators (KPIs)

* **Recency** → Months since last purchase
* **Average Order Value (AOV)** → Sales per order
* **Average Monthly Spend** → Sales per month

---

## 🧠 Key Learnings

* Built multi-step queries using **CTEs for better readability**
* Applied **business logic using CASE statements**
* Handled **edge cases** like division by zero
* Used **date functions** to calculate recency and lifespan
* Transformed raw data into a **business-ready analytical dataset**

---

## 📂 Output

The final output is created as a SQL view:

```sql
gold.report_customers
```

This view can be directly used for:

* Dashboarding (Power BI / Tableau)
* Customer segmentation analysis
* Business decision-making

---

## 🚀 Business Impact

This report helps businesses:

* Identify high-value (VIP) customers
* Understand customer purchasing behavior
* Detect inactive customers (high recency)
* Improve targeting and retention strategies

---

## 📌 Conclusion

This project demonstrates how SQL can be used not just for querying data, but for building **end-to-end analytical solutions** that provide actionable business insights.


That will make this look like a **proper portfolio project**, not just SQL practice.

