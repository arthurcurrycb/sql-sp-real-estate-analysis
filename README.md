# 🏙️ SQL Analysis – Real Estate Market in São Paulo (Zap Imóveis)

## 📌 Objective

This project aims to perform an exploratory data analysis (EDA) of São Paulo’s real estate market using **pure SQL**, with a focus on:
- Understanding price patterns;
- Identifying seasonal variations;
- Investigating the impact of features such as area, bedrooms, and parking spaces; and
- Mapping the most expensive and most affordable neighborhoods.

The goal is to extract **actionable insights** from a **real-world** dataset from the Zap Imóveis platform, demonstrating how SQL can be used to support business decisions.

---

## 🧠 Why this project?

- ⚡ **Real-world, practical analysis**: I chose a public, real dataset because I believe data analysis should drive action and real-world impact. This is a relevant topic for professionals working in BI, marketing, pricing, or territorial expansion.
- 🎯 **SQL focus for quick decision-making**: This is a more direct EDA, aligned with SQL’s strengths — quick querying, preprocessing, and business-focused calculations. For deeper explorations, I usually prefer Python (see my complementary Python EDA project [here](https://github.com/arthurcurrycb/mba-admissions-eda/)).
- 🧱 **Technical coverage**: I used CTEs, Window Functions, and created a `VIEW` to filter outliers using percentiles. This makes the analysis cleaner and enhances the statistical representativeness of the metrics.
- 🗣️ **Commented code and results**: I added comments throughout the SQL script to explain the logic and findings. This improves async communication, knowledge sharing, and supports my own analytical process.

---

## 🗃️ Data source

- Platform: [Zap Imóveis](https://www.zapimoveis.com.br/)
- Dataset: [Kaggle - Discover São Paulo Apartment Prices Insights](https://www.kaggle.com/datasets/marcelobatalhah/discover-so-paulo-apartment-prices-insights) (public source, anonymized data of 27k apartments for sale in São Paulo)

---

## 🔍 Project steps

1. **Initial inspection and data understanding**  
2. **Null value checking**  
3. **Outlier detection and removal using percentiles**  
4. **`VIEW` creation for reusability**  
5. **Univariate and bivariate exploration**  
6. **Bucketing (area) and ranking (price by neighborhood)**  
7. **Aggregations by year, month, and neighborhood**  
8. **Conclusion**

---

## 📈 Key findings

- Average price and price per square meter peaked in **2021** and have been declining since.
- In **2024**, prices dropped by around **18%** compared to the peak.
- There is **seasonality in pricing**, with lower prices in **April** and higher ones in **February, November, and December**.
- The **most expensive neighborhoods** were: Ibirapuera, Jardim América, and Jardim Panorama.
- The **most affordable neighborhoods** included Guapira, Jardim Patente, and Jaraguá.
- Small apartments (< 50m²) had an average price of **R$ 587k**, with some reaching over **R$ 2 million**.
- Area, number of bedrooms, bathrooms, and parking spaces showed a direct relationship with price — confirming common assumptions with data.

---

## 🚀 Next steps

- Calculate the **Pearson correlation coefficient** between numerical features and price.  
- Build a **price prediction model** using Python and regression.  
- Enrich with external data (e.g. income per neighborhood, mobility, safety) and additional platforms to enable more robust analyses.

---

## 🧩 Tools and technologies

- PostgreSQL (via DBeaver)  
- SQL (CTEs, Window Functions, Views, percentiles, aggregations)  
- GitHub for version control and documentation

---

## 🧑‍💻 Author

**Arthur Curry**  
Data Analyst with a background in Growth and RevOps  
[LinkedIn](https://www.linkedin.com/in/arthurcurrycb) • [GitHub](https://github.com/arthurcurrycb)
