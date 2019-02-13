{{ config(materialized='view') }}

SELECT  property_master_list.ba_id_code AS ba_id_code,
        property_master_list.property_address AS property_address,
        ba_bookings.ba_booking_id AS ba_booking_id,
        ba_bookings.first_night AS first_night,
        ba_bookings.last_night AS last_night,
        CASE WHEN ba_bookings.last_night >= CURRENT_DATE() THEN DATE_DIFF(CURRENT_DATE(), ba_bookings.first_night, DAY) + 1
        ELSE DATE_DIFF(ba_bookings.last_night, ba_bookings.first_night, DAY) + 1 END AS nights_occupied
FROM {{ref('ba_bookings')}}
LEFT JOIN {{ref('property_master_list')}}
  ON ba_bookings.ba_id_code = property_master_list.ba_id_code
WHERE ba_bookings.first_night <= CURRENT_DATE() AND ba_bookings.booking_status = 'Confirmed'
