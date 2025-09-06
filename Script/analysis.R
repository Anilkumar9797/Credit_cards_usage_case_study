# Load libraries
library(tidyverse)
library(ggplot2)
library(broom)
library(readr)

# Step 1: Simulate Synthetic Credit Data
set.seed(123)
n <- 5000

customer_data <- data.frame(
  customer_id = paste0("C", sprintf("%04d", 1:n)),
  age = sample(18:75, n, replace = TRUE),
  income = round(runif(n, 1000, 10000), 0),
  credit_score = round(rnorm(n, mean = 650, sd = 100)),
  card_type = sample(c("Standard", "Gold", "Platinum"), n, replace = TRUE, prob = c(0.6, 0.3, 0.1)),
  monthly_spend = round(rnorm(n, mean = 1200, sd = 500)),
  repayment_rate = round(runif(n, 0.3, 1.0), 2),
  interest_flag = sample(c(TRUE, FALSE), n, replace = TRUE, prob = c(0.45, 0.55)),
  channel_preference = sample(c("Contactless", "Online", "In-store"), n, replace = TRUE),
  default_flag = rbinom(n, 1, prob = ifelse(runif(n) < 0.1, 0.3, 0.05)),
  account_status = sample(c("Active", "Dormant", "Closed"), n, replace = TRUE, prob = c(0.7, 0.2, 0.1))
)

# Step 2: Add Credit Card Features
customer_data <- customer_data %>%
  mutate(
    annual_fee = case_when(
      card_type == "Standard" ~ 0,
      card_type == "Gold" ~ 25,
      card_type == "Platinum" ~ 195
    ),
    cashback_rate = case_when(
      card_type == "Standard" ~ 0.005,
      card_type == "Gold" ~ 0.01,
      card_type == "Platinum" ~ 0.0125
    ),
    cashback_earned = round(monthly_spend * cashback_rate, 2),
    balance_transfer_flag = sample(c(TRUE, FALSE), n, replace = TRUE, prob = c(0.2, 0.8)),
    transfer_fee = ifelse(balance_transfer_flag, round(runif(n, 0.01, 0.05) * monthly_spend, 2), 0)
  )

# Step 3: Add Installment-Based Repayment Logic
customer_data <- customer_data %>%
  mutate(
    installments_chosen = sample(1:6, n, replace = TRUE, prob = c(0.2, 0.25, 0.25, 0.15, 0.1, 0.05)),
    interest_rate_monthly = 0.015,
    interest_due = ifelse(installments_chosen > 3,
                          round(monthly_spend * interest_rate_monthly * (installments_chosen - 3), 2),
                          0)
  )

# Step 4: Add Soft vs. Hard Credit Checks
customer_data <- customer_data %>%
  mutate(
    soft_check_flag = sample(c(TRUE, FALSE), n, replace = TRUE, prob = c(0.6, 0.4)),
    hard_check_flag = sample(c(TRUE, FALSE), n, replace = TRUE, prob = c(0.3, 0.7)),
    hard_check_count = ifelse(hard_check_flag, sample(1:4, n, replace = TRUE), 0)
  )

# Step 5: Export to CSV
write.csv(customer_data, "synthetic_credit_data.csv", row.names = FALSE)
# copy the file directly from RStudio to your Documents folder with this command
file.copy("synthetic_credit_data.csv", "~/Documents/synthetic_credit_data.csv")

# Step 6: Load and Explore Data
credit_data <- read_csv("synthetic_credit_data.csv")
glimpse(credit_data)
summary(credit_data)

# Step 7: UK Credit Score Band Mapping
credit_data <- credit_data %>%
  mutate(uk_score_band = case_when(
    credit_score < 580 ~ "Poor",
    credit_score >= 580 & credit_score < 670 ~ "Fair",
    credit_score >= 670 & credit_score < 740 ~ "Good",
    credit_score >= 740 & credit_score < 800 ~ "Very Good",
    credit_score >= 800 ~ "Excellent"
  ))

# Step 8: Credit Utilization Calculation
credit_data <- credit_data %>%
  mutate(credit_limit = case_when(
    card_type == "Standard" ~ 3000,
    card_type == "Gold" ~ 6000,
    card_type == "Platinum" ~ 10000
  ),
  utilization_rate = round(monthly_spend / credit_limit, 2))

# Step 9: Lending Criteria Simulation
credit_data <- credit_data %>%
  mutate(approved_flag = ifelse(
    credit_score >= 650 & repayment_rate >= 0.5 & utilization_rate < 0.3 & hard_check_count <= 2, TRUE, FALSE
  ))

# Step 10: Visualizations

# Credit Score Distribution
ggplot(credit_data, aes(x = credit_score)) +
  geom_histogram(binwidth = 25, fill = "steelblue", color = "white") +
  labs(title = "Distribution of Credit Scores", x = "Credit Score", y = "Count")

# Monthly Spend vs Income
ggplot(credit_data, aes(x = income, y = monthly_spend)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred") +
  labs(title = "Monthly Spend vs. Income", x = "Income (£)", y = "Monthly Spend (£)")

# Default Rate by UK Score Band
credit_data %>%
  group_by(uk_score_band) %>%
  summarise(default_rate = mean(default_flag)) %>%
  ggplot(aes(x = uk_score_band, y = default_rate)) +
  geom_col(fill = "tomato") +
  labs(title = "Default Rate by UK Credit Score Band", x = "Score Band", y = "Default Rate")

# Credit Utilization vs Default Risk
ggplot(credit_data, aes(x = utilization_rate, fill = factor(default_flag))) +
  geom_histogram(binwidth = 0.05, position = "stack") +
  labs(title = "Credit Utilization vs. Default Risk", x = "Utilization Rate", y = "Count")

# Simulated Approval Rate by Score Band
credit_data %>%
  group_by(uk_score_band) %>%
  summarise(approval_rate = mean(approved_flag)) %>%
  ggplot(aes(x = uk_score_band, y = approval_rate)) +
  geom_col(fill = "darkgreen") +
  labs(title = "Simulated Approval Rate by Score Band", x = "Score Band", y = "Approval Rate")

# Channel Preference by Account Status
ggplot(credit_data, aes(x = channel_preference, fill = account_status)) +
  geom_bar(position = "dodge") +
  labs(title = "Channel Preference by Account Status", x = "Channel", y = "Count")

# Cashback Earned by Card Type
ggplot(credit_data, aes(x = card_type, y = cashback_earned)) +
  geom_boxplot(fill = "gold") +
  labs(title = "Cashback Earned by Card Type", x = "Card Type", y = "Monthly Cashback (£)")

# Balance Transfer Fee Distribution
ggplot(credit_data, aes(x = transfer_fee)) +
  geom_histogram(binwidth = 5, fill = "purple", color = "white") +
  labs(title = "Balance Transfer Fee Distribution", x = "Transfer Fee (£)", y = "Count")

# Installments Chosen
ggplot(credit_data, aes(x = factor(installments_chosen))) +
  geom_bar(fill = "skyblue") +
  labs(title = "Installments Chosen to Repay Statement Balance", x = "Number of Installments", y = "Customer Count")

# Interest Charged Based on Installments
ggplot(credit_data, aes(x = installments_chosen, y = interest_due)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Interest Charged Based on Installments", x = "Installments Chosen", y = "Interest Due (£)")

# Hard Check Frequency
ggplot(credit_data, aes(x = factor(hard_check_count))) +
  geom_bar(fill = "firebrick") +
  labs(title = "Hard Credit Checks per Customer", x = "Hard Check Count", y = "Customer Count")

# Step 11: Logistic Regression Model
model <- glm(default_flag ~ credit_score + income + repayment_rate + utilization_rate + hard_check_count,
             data = credit_data, family = "binomial")

summary(model)
View(model)
exp(coef(model))  # Odds ratios
# Export data into my folder
write.csv(credit_data, "~/Documents/synthetic_credit_data.csv", row.names = FALSE)
View(credit_data)

