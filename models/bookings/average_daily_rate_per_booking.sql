{{ config(materialized='view') }}

-- Joins the calendar view with ba_bookings to determine the average daily rate.
-- Note this model does not consider Airbnb data as we do not have total paid.

WITH  ba_bookings AS (SELECT * FROM {{ref('ba_bookings')}}),
      nights_occupied_per_booking AS (SELECT * FROM {{ref('nights_occupied_per_booking')}})

SELECT  ba_bookings.ba_id_code,
        ba_bookings.ba_booking_id,
        ba_bookings.booking_channel,
        ba_bookings.first_night,
        ba_bookings.last_night,
        ba_bookings.total_charges/nights_occupied_per_booking.nights_occupied AS average_daily_rate
FROM ba_bookings
LEFT JOIN nights_occupied_per_booking
  ON nights_occupied_per_booking.ba_booking_id = ba_bookings.ba_booking_id
WHERE ba_bookings.booking_status = 'Confirmed' and ba_bookings.booking_channel not like '%Airbnb.com%'
  AND ba_bookings.last_night < current_date()
ORDER BY 1
