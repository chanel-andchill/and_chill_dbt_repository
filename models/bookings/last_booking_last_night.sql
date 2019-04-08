{{ config(materialized='view') }}

-- Want to find the last night of the last booking per property if property has
-- been offboarded. To be used later to define true offboarded date.

SELECT  ba_bookings.ba_id_code AS ba_id_code,
        MAX(ba_bookings.last_night) AS last_night
FROM {{ref('ba_bookings')}}
LEFT JOIN {{ref('property_master_list')}}
  ON ba_bookings.ba_id_code = property_master_list.ba_id_code
WHERE ba_bookings.booking_status = 'Confirmed' AND property_master_list.status = 'Offboarded'
GROUP BY 1
