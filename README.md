# Predicting E-commerce Visitor Purchases with BigQuery ML

## Project Overview

This project demonstrates the power of **Google BigQuery Machine Learning (BQML)** to predict whether a visitor to the Google Merchandise Store will make a purchase. By leveraging SQL-based machine learning directly within BigQuery, this project bypasses the need for complex data pipelines and allows for rapid model development and deployment.

The goal is to build, train, evaluate, and use a **logistic regression model** to classify visitors into two categories: "purchasers" and "non-purchasers," based on their session data.

---

## 🛠️ Technology Stack

* **Cloud Platform**: Google Cloud Platform (GCP)
* **Data Warehouse**: Google BigQuery
* **Machine Learning**: BigQuery ML (BML)
* **Language**: SQL

---

## 📈 Project Workflow

The project follows a standard machine learning workflow, executed entirely with SQL queries in BigQuery.

### Step 1: Data Exploration and Preparation

The first step was to explore the public Google Analytics sample dataset. I selected key features that could influence a visitor's purchasing behavior, such as their operating system, device type, geographic location, and the number of pageviews. A target variable, `label`, was created (`1` for a transaction, `0` for none). This prepared data was saved as a view named `training_data` for model training.

*(See query: `sql/01_data_preparation.sql`)*

### Step 2: Model Training

Using BQML's `CREATE MODEL` statement, I trained a **logistic regression** model. This type of model is ideal for binary classification tasks like predicting a purchase (yes/no). The model was trained directly on the `training_data` view created in the previous step.

*(See query: `sql/02_model_training.sql`)*

### Step 3: Model Evaluation

After training, I evaluated the model's performance using the `ML.EVALUATE` function. This function provides key classification metrics such as **precision**, **recall**, and **accuracy**, which help determine how well the model predicts outcomes on the training data.

*(See query: `sql/03_model_evaluation.sql`)*

### Step 4: Making Predictions

With a trained and evaluated model, the final step was to use it for inference on new data. Using the `ML.PREDICT` function, I ran predictions on a different time period (July 2017) to forecast purchasing behavior.

Two main predictions were made:
1.  **Top 10 Purchasing Countries**: Aggregating the predicted purchases by country to identify key markets.
2.  **Top 10 Purchasing Visitors**: Aggregating predictions by `fullVisitorId` to identify high-value users.

*(See queries: `sql/04_predict_by_country.sql` and `sql/05_predict_by_user.sql`)*

---

## 📊 Results

The model successfully generated predictions, and the final queries identified the top 10 countries with the highest number of predicted purchases. A sample of the output is below:

| country         | total_predicted_purchases |
|-----------------|---------------------------|
| United States   | 285                       |
| United Kingdom  | 25                        |
| Canada          | 22                        |
| Germany         | 15                        |
| Japan           | 14                        |
| ...             | ...                       |

This project showcases an end-to-end machine learning pipeline built and executed entirely within BigQuery, demonstrating a scalable and efficient approach to solving classification problems.
