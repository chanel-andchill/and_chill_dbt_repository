{{ config(materialized='view') }}

-- Take into consideration that AirBNB bookings do not come into this model as we don't have total_paid data

SELECT  cv.day,
        pm.ba_id_code,
        adr.ba_booking_id,
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
LEFT JOIN {{ref('average_daily_rate_per_booking')}} adr
  ON cv.day = adr.the_date

-- Need to create a join between cv and average daily rate only when there is a booking on that date
