{{ config(materialized='view') }}

SELECT  cv.day,
        pm.ba_id_code,
        ba.ba_booking_id,
        pm.long_term_rental_estimate_per_week/7 AS daily_ltr,
        IFNULL(adr.average_daily_rate, 0) AS daily_str,
        IFNULL(adr.average_daily_rate, 0) -  pm.long_term_rental_estimate_per_week/7 AS diff
FROM {{ref('property_master_list')}} pm
JOIN {{ref('date_onboarded')}} don
  ON pm.ba_id_code = don.ba_id_code
JOIN {{ref('date_offboarded')}} dof
  ON dof.ba_id_code = pm.ba_id_code
JOIN {{ref('calendar_view')}} cv
  ON cv.day >= don.date_onboarded AND cv.day <=  dof.date_offboarded OR cv.day <= CURRENT_DATE()
LEFT JOIN {{ref('ba_bookings')}} ba
  ON pm.ba_id_code = ba.ba_id_code

-- Need to create a join between cv and average daily rate only when there is a booking on that date
