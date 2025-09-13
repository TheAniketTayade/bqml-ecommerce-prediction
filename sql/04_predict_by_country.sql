-- Step 4a: Make Predictions by Country
-- Uses the trained model to predict the total number of transactions for each country
-- on a new dataset (July 2017) and returns the top 10 countries.

SELECT
  country,
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
  country
ORDER BY
  total_predicted_purchases DESC
LIMIT 10;
