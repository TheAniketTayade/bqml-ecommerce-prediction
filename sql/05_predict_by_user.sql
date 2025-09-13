-- Step 4b: Make Predictions by User (Challenge)
-- Uses the trained model to predict the likelihood of transactions for each individual user
-- on a new dataset (July 2017) and returns the top 10 users with the most predicted purchases.

SELECT
  fullVisitorId,
  SUM(predicted_label) AS total_predicted_purchases
FROM
  ML.PREDICT(MODEL `bqml_lab.sample_model`,
    (
      SELECT
        IF(totals.transactions IS NULL, 0, 1) AS label,
        IFNULL(device.operatingSystem, "") AS os,
        device.isMobile AS is_mobile,
        IFNULL(geoNetwork.country, "") AS country,
        IFNULL(totals.pageviews, 0) AS pageviews,
        fullVisitorId
      FROM
        `bigquery-public-data.google_analytics_sample.ga_sessions_*`
      WHERE
        _TABLE_SUFFIX BETWEEN '20170701' AND '20170801'
    ))
GROUP BY
  fullVisitorId
ORDER BY
  total_predicted_purchases DESC
LIMIT 10;
