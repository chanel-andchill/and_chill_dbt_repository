{{ config(materialized='view') }}

-- Take into consideration that AirBNB bookings do not come into this model as we don't have total_paid data

SELECT  cv.day,
        pm.ba_id_code,
        adr.ba_booking_id,
        pm.long_term_rental_estimate_per_week/7 AS daily_ltr,
        IFNULL(adr.average_daily_rate,0) AS daily_str,
        IFNULL(adr.average_daily_rate, 0) -  pm.long_term_rental_estimate_per_week/7 AS diff
        FROM {{ref('property_master_list')}} pm
  join {{ref('date_onboarded')}} don
  on pm.ba_id_code = don.ba_id_code
  join {{ref('date_offboarded')}} dof
  on dof.ba_id_code = pm.ba_id_code
  join {{ref('calendar_view')}} cv
on cv.day >= don.date_onboarded and cv.day <=  dof.date_offboarded and cv.day <= current_date()
left join {{ref('average_daily_rate_per_booking')}} adr
on cv.day = adr.the_date and adr.ba_id_code  = pm.ba_id_code
