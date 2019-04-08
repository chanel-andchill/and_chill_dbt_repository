{{ config(materialized='view') }}

-- Want to find the first night of the first booking per property.

SELECT  ba_bookings.ba_id_code AS ba_id_code,
        MIN(ba_bookings.first_night) AS first_night
FROM {{ref('ba_bookings')}}
WHERE ba_bookings.booking_status = 'Confirmed'
GROUP BY 1
