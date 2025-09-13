-- Step 2: Model Training
-- Creates and trains a logistic regression model using the prepared training data.
-- The model aims to predict the 'label' column (whether a transaction occurred).

CREATE OR REPLACE MODEL `bqml_lab.sample_model`
OPTIONS(
  model_type='LOGISTIC_REG',
  input_label_cols=['label']
) AS
SELECT
  label,
  os,
  is_mobile,
  country,
  pageviews
FROM
  `bqml_lab.training_data`;
