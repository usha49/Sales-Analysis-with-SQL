# 📊 Superstore Sales Analysis - SQL Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sql&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Data_Analysis-2E77BC?style=for-the-badge)

A comprehensive SQL analysis of retail sales data from a superstore, demonstrating data cleaning, exploration, and business intelligence insights using PostgreSQL.

## 📋 Project Overview

This project analyzes 4 years of retail sales data (2014-2017) to uncover key business insights, customer behavior patterns, and operational metrics. The analysis includes full data quality assessment and provides actionable recommendations for business optimization.

## 🎯 Key Insights

### 📈 Performance Metrics
- **Total Revenue**: $2.30M
- **Total Profit**: $286K
- **Profit Margin**: 12.5%
- **Average Shipping Time**: 4 days

### 🏆 Top Performers
| Category | Rank |
|----------|------|
| **Sales Leader** | Technology |
| **Profit Leader** | West Region |
| **Top State** | California |
| **Best Customer** | Sean Miller ($25K) |

### ⚠️ Critical Finding
**Discounts above 20% eliminate profitability** - a crucial insight for pricing strategy.

## 🗂️ Dataset Information

- **Records**: 9,994 sales transactions
- **Period**: 2014-2017 (4 years)
- **Geography**: United States
- **Segments**: Consumer, Corporate, Home Office
- **Categories**: Technology, Furniture, Office Supplies

## 🛠️ Technical Skills Demonstrated

### Database Management
- ✅ Data Import & Validation
- ✅ Data Cleaning & Deduplication
- ✅ Schema Design
- ✅ Primary Key Management

### SQL Proficiency
- ✅ Complex Queries & Aggregations
- ✅ Window Functions
- ✅ Date/Time Operations
- ✅ Data Quality Checks
- ✅ Business Logic Implementation

### Data Analysis
- ✅ Trend Analysis
- ✅ Customer Segmentation
- ✅ Profitability Analysis
- ✅ Operational Metrics
- ✅ Statistical Summaries

## 📊 Analysis Highlights

### 1. Data Quality & Preparation
```sql
-- Comprehensive data validation
SELECT COUNT(*) AS total_rows FROM superstore_sales; -- 9,994 records
-- Zero null values in critical fields
-- Single duplicate identified and removed
```

### 2. Business Intelligence Queries
- Sales performance by category and region
- Customer lifetime value analysis
- Discount impact on profitability
- Shipping efficiency metrics
- Seasonal sales trends

### 3. Key Findings
- **Technology** category drives highest sales
- **West region** generates maximum profit
- **20% discount threshold** for profitability
- **4-day average** order-to-ship time

## 🚀 Getting Started

### Prerequisites
- PostgreSQL
- Sample Superstore dataset

### Installation
1. Clone the repository
2. Import the CSV data into PostgreSQL
3. Execute the SQL analysis scripts
4. Review the insights and recommendations

### Sample Query
```sql
-- Profit by region
SELECT region, ROUND(SUM(profit),2) as profits
FROM superstore_sales 
GROUP BY region 
ORDER BY profits DESC;
```

## 📈 Business Recommendations

1. **Pricing Strategy**: Limit discounts to 20% to maintain profitability
2. **Regional Focus**: Increase investment in West and East regions
3. **Inventory Management**: Stock more Technology products
4. **Customer Retention**: Develop loyalty programs for top customers
5. **Operational Excellence**: Maintain 4-day shipping standard

## 🎓 Learning Outcomes

This project demonstrates:
- End-to-end data analysis workflow
- SQL best practices for business intelligence
- Data quality assessment techniques
- Actionable insight generation
- Professional documentation skills

## 🤝 Contributing

Feel free to fork this project and submit pull requests for any improvements.

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**⭐ If you found this project helpful, please give it a star!**

---
*This project showcases SQL skills relevant for data analyst, business intelligence, and database management roles.*
