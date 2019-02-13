{{ config(materialized='view') }}

-- Joins the calendar view with ba_bookings to determine the average daily rate. Note this model does not consider Airbnb data as we do not have total paid.

SELECT  ba_bookings.ba_id_code,
        ba_bookings.ba_booking_id,
        ba_bookings.first_night,
        ba_bookings.last_night,
        ba_bookings.total_charges/nights_occupied_per_booking.nights_occupied AS average_daily_rate
FROM {{ref('ba_bookings')}}
LEFT JOIN {{ref('nights_occupied_per_booking')}}
  ON nights_occupied_per_booking.ba_booking_id = ba_bookings.ba_booking_id
WHERE ba_bookings.booking_status = 'Confirmed'
  AND ba_bookings.last_night < current_date()
ORDER BY 1


-- Removed this line AND ba_bookings.booking_channel NOT LIKE '%Airbnb%'
-- Need to join nights_occupied_per_booking instead?
