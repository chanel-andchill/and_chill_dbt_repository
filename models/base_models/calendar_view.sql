{{ config(materialized='view') }}

-- A view to join on other tables to display every day there is data recorded.
-- E.g. Join on ba_bookings to get every day someone stayed in a property

SELECT  day
FROM  UNNEST(
      GENERATE_DATE_ARRAY(DATE('2010-01-01'), DATE('2110-01-01'), INTERVAL 1 DAY)
      ) AS day
