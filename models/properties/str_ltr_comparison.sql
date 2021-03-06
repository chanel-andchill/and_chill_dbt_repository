{{ config(materialized='view') }}

-- Comparing the short term versus long term rental revenue.

WITH  property_master_list AS ( SELECT * FROM {{ref('property_master_list')}} ),
      date_onboarded AS (SELECT * FROM {{ref('date_onboarded')}}),
      date_offboarded AS (SELECT * FROM {{ref('date_offboarded')}}),
      calendar_view AS (SELECT * FROM {{ref('calendar_view')}}),
      average_daily_rate_per_booking AS (SELECT * FROM {{ref('average_daily_rate_per_booking')}} )


SELECT  cv.day,
        pm.ba_id_code,
        adr.ba_booking_id,
        pm.long_term_rental_estimate_per_week/7 AS daily_ltr,
        IFNULL(adr.average_daily_rate, 0) AS daily_str,
        IFNULL(adr.average_daily_rate, 0) -  pm.long_term_rental_estimate_per_week/7 AS diff
FROM property_master_list pm
LEFT JOIN date_onboarded don
  ON pm.ba_id_code = don.ba_id_code
LEFT JOIN date_offboarded dof
  ON dof.ba_id_code = pm.ba_id_code
JOIN calendar_view cv
  ON cv.day >= don.date_onboarded AND cv.day <= IFNULL(dof.date_offboarded, CURRENT_DATE())
LEFT JOIN average_daily_rate_per_booking adr
  ON cv.day BETWEEN adr.first_night AND adr.last_night AND adr.ba_id_code = pm.ba_id_code
WHERE adr.booking_channel NOT LIKE '%Airbnb.com%' OR adr.booking_channel IS NULL
