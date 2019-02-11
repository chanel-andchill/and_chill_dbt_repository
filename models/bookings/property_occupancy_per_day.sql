{{ config(materialized='view') }}

SELECT  calendar_view.day AS the_date,
        ba_bookings.ba_id_code AS ba_id_code,
        ba_bookings.ba_booking_id AS ba_booking_id,
        property_master_list.property_address AS property_address,
        property_master_list.property_owner AS property_owner,
        nights_occupied_per_booking.nights_occupied AS nights_occupied,
        EXTRACT(MONTH FROM calendar_view.day) AS month
FROM {{ref('calendar_view')}}
LEFT JOIN {{ref('ba_bookings')}}
  ON calendar_view.day BETWEEN ba_bookings.first_night AND ba_bookings.last_night
LEFT JOIN {{ref('property_master_list')}}
  ON property_master_list.ba_id_code = ba_bookings.ba_id_code
LEFT JOIN {{ref('nights_occupied_per_booking')}}
  ON nights_occupied_per_booking.ba_booking_id = ba_bookings.ba_booking_id
WHERE ba_bookings.booking_status = 'Confirmed' AND calendar_view.day <= CURRENT_DATE()
GROUP BY 1,2,3,4,5,6,7
