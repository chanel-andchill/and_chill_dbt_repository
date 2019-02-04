{{ config(materialized='view') }}

SELECT day
FROM UNNEST(
    GENERATE_DATE_ARRAY(DATE('2010-01-01'), DATE('2110-01-01'), INTERVAL 1 DAY)
) AS day
