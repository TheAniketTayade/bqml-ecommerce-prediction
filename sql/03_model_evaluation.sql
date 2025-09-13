-- Step 3: Model Evaluation
-- Evaluates the trained model's performance using key classification metrics.

SELECT
  *
FROM
  ML.EVALUATE(MODEL `bqml_lab.sample_model`);
