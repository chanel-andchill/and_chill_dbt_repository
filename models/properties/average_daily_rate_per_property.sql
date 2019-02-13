{{ config(materialized='view') }}


SELECT  ba_bookings.ba_id_code AS ba_id_code,
        ba_bookings.first_night AS first_night,
        ba_bookings.last_night AS last_night,
        nights_occupied_per_booking.nights_occupied AS nights,
        ba_bookings.total_charges AS total_charges,
        ba_bookings.total_charges/nights_occupied_per_booking.nights_occupied AS average_daily_rate
FROM {{ref('ba_bookings')}}
LEFT JOIN {{ref('nights_occupied_per_booking')}}
  ON ba_bookings.ba_id_code = nights_occupied_per_booking.ba_id_code
WHERE ba_bookings.booking_status = 'Confirmed'
GROUP BY 1,2,3,4,5
