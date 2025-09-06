# 💳 Credit Cards Usage Case Study

## 📌 Objective
This case study analyzes customer credit card behavior, interest cost structures, utilization patterns, and default risk trends to uncover actionable insights for financial institutions. The goal is to optimize product offerings, assess risk exposure, and improve channel performance.

## 🧰 Tools Used
- R: Data cleaning, feature engineering, and exploratory analysis
- Tableau: Dashboarding and KPI visualization
- Excel: Initial data exploration
- GitHub: Version control and documentation

## 📊 Key Insights & Business Impact

### 🔹 Executive Summary & Risk Overview
- **Customer Credit Profile**:
  - Majority of customers fall into the **Fair** score band, followed by **Poor**, indicating moderate to high risk exposure.
- **Default Risk Distribution**:
  - **93%** of customers have not defaulted (Default Flag = 0)
  - **7%** of customers have defaulted (Default Flag = 1)
- **Score Band vs. Default Rate**:
  - Default rate increases as credit score decreases, with the **Poor** band showing the highest risk.
- **Portfolio Health**:
  - Average default rate across all customers: **8.43%**
  - Insight: Credit score segmentation is critical for risk mitigation and targeted credit policy design.

---

### 🔹 Interest & Utilisation Overview
- **Installment-Based Interest Structure**:
  - Customers choosing **1 to 3 installments** pay **zero interest**.
  - From the **4th installment onward**, interest charges begin and **increase gradually**.
  - Interestingly, **default flag decreases** from installment 4 to 6, suggesting longer-term payers may be more financially stable.
- **Portfolio Metrics**:
  - **Average Monthly Interest Rate**: **1.50%**
  - **Total Interest Due**: **£45,562**
- **Utilization Rate by Credit Limit**:
  - **Higher credit limits** (e.g., £10K) show **lower average utilization rates**
  - **Lower credit limits** (e.g., £2K) show **higher utilization rates**
- **Business Insight**:
  - The zero-interest window for early installments can be leveraged as a **marketing incentive**.
  - Utilization trends suggest that low-limit customers may be over-leveraged and require closer monitoring.

---

### 🔹 Customer Behaviour & Product Performance
- **Monthly Spend by Card Type**:
  - **Platinum**: £1,248.01 (508 customers)
  - **Gold**: £1,199.56 (1,575 customers)
  - **Standard**: £1,169.58 (2,917 customers)
- **Cashback Earned by Card Type**:
  - **Gold**: £18,893
  - **Standard**: £17,060
  - **Platinum**: £7,925
- **Balance Transfer Behavior**:
  - Customers using balance transfers incur an average fee of **£36.03**
- **Repayment Patterns**:
  - Most customers maintain repayment rates between **40% and 100%**, with higher spenders showing stronger repayment discipline.
- **Business Insight**:
  - Gold cardholders offer the best combination of **spend volume** and **reward efficiency**.
  - Standard cards dominate in customer count, making them ideal for **mass-market strategies**.
  - Platinum users, while fewer, show **premium behavior**—ideal for loyalty and upsell campaigns.

---

### 🔹 Channel Performance & Risk Link
- **Customer Acquisition Volume**:
  - **In-store** channel has the highest customer count, followed by **Online**, then **Contactless**.
- **Approval Efficiency**:
  - All channels show high approval volumes, with In-store leading in approval rate.
- **Credit Score vs. Default Rate**:
  - Strong inverse correlation: **lower scores → higher default rates**
  - Visual trend shows default rate approaching **100%** at the lowest score range, and near **0%** at the highest.
- 📌 *Insight*: In-store remains the dominant acquisition channel and should be prioritized for retention and upsell. Online acquisition is efficient and scalable. Contactless applicants may require **stricter screening** due to elevated risk indicators.

---

## 📂 Project Structure (with descriptions)

Credit_cards_usage_case_study/
├── Cleaned_data/ → Contains the cleaned CSV file used for Tableau dashboarding and analysis  
│   └── Synthetic_credit_data.csv  
├── Dashboard/ → Uploaded dashboard link from Tableau Public  
│   └── dashboard_link.txt  
├── Script/ → Uploaded R script for data cleaning and feature engineering  
│   └── analysis.R  
├── LICENSE → MIT license for open-source sharing    
└── README.md → Project overview, insights, and strategy recommendations

## Recommended Section
## 📬 Connect With Me

- 🔗 [LinkedIn](www.linkedin.com/in/anil-kumar-bakkashetti-7a4139266) → Professional profile and career updates  
- 📝 [Medium](medium.com/@Anilkumarbakkashetti) → Case studies, analytics write-ups, and project breakdowns  
- 📊 [Tableau Public](https://public.tableau.com/app/profile/anil.kumar.bakkashetti) → Interactive dashboards and visual storytelling  



