# sql_sales_data
# 🛍️ Retail Sales Analysis - SQL Project

## 📌 Project Overview
This project focuses on analyzing **retail sales data** using SQL.  
The objective is to clean the dataset, explore sales trends, and answer key **business questions** such as customer behavior, category performance, revenue insights, and time-based sales analysis.

The project is structured into:
1. **Database & Table Creation**
2. **Data Cleaning**
3. **Exploratory Data Analysis**
4. **Business Questions & Insights**

---

## 🗄️ Database Structure

**Database:** `sql_project_1`  
**Table:** `retail_sale`

| Column Name     | Data Type    | Description                           |
|-----------------|-------------|---------------------------------------|
| transactions_id | INT (PK)    | Unique ID for each transaction        |
| sale_date       | DATE        | Date of the transaction               |
| sale_time       | TIME        | Time of the transaction               |
| customer_id     | INT         | Unique customer ID                    |
| gender          | VARCHAR(20) | Gender of the customer                |
| age             | INT         | Age of the customer                   |
| category        | VARCHAR(20) | Product category                      |
| quantiy         | INT         | Quantity purchased                    |
| price_per_unit  | FLOAT       | Price per unit of product             |
| cogs            | FLOAT       | Cost of goods sold                    |
| total_sale      | FLOAT       | Total sales value (Revenue)           |

---

## 🧹 Data Cleaning
- Removed rows with `NULL` values in critical fields.  
- Verified transaction counts after cleaning.

---

## 📊 Business Questions & Queries

### 1. Transactions made on `2022-11-05`  
### 2. Sales of **Clothing** category with quantity ≥ 4 in November 2022  
### 3. Total sales and number of orders by category  
### 4. Average age of customers who purchased **Beauty** category items  
### 5. Transactions where `total_sale > 1000`  
### 6. Number of transactions by **gender and category**  
### 7. Best-selling month (highest average sales) in each year  
### 8. Top 5 customers by **highest total sales**  
### 9. Unique customers who purchased from each category  
### 10. Customers who purchased from **all three categories** (Clothing, Electronics, Grocery)  
### 11. Total number of customers who purchased from all three categories  
### 12. Categorize transactions into **shifts** (Morning, Afternoon, Evening)  
### 13. Number of orders in each shift  
### 14. Total revenue generated per day  
### 15. Category that generated the **highest revenue**  
### 16. Total unique customers in **November 2022**  
### 17. Top 5 customers by total spending  
### 18. Divide customers into age groups: **18-25, 26-30, 31+**  
### 19. Age group that generates the **most revenue**  
### 20. Shift (Morning, Afternoon, Evening) with the highest sales  

---

## 🔑 Key Insights
- Identified **peak sales periods** (best months & shifts).  
- Found **top-spending customers** and their behavior.  
- Determined **which product categories drive the most revenue**.  
- Analyzed **customer demographics** (age groups, gender patterns).  
- Detected **cross-category buyers** who purchase from multiple segments.  

---

## 🚀 How to Use
1. Clone the repository  
   ```bash
   git clone https://github.com/your-username/sql_project_1.git
   cd sql_project_1
