{{ config(materialized='view') }}

-- A view to join on to display every day there is a booking.

SELECT  day
FROM  UNNEST(
      GENERATE_DATE_ARRAY(DATE('2010-01-01'), DATE('2110-01-01'), INTERVAL 1 DAY)
      ) AS day
