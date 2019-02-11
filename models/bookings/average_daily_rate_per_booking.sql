{{ config(materialized='view') }}

-- Joins the calendar view with ba_bookings to determine the average daily rate. Note this model does not consider Airbnb data as we do not have total paid.

SELECT  property_occupancy_per_day.the_date,
        property_occupancy_per_day.ba_id_code,
        property_occupancy_per_day.ba_booking_id,
        property_occupancy_per_day.property_address,
        property_occupancy_per_day.property_owner,
        ba_bookings.first_night,
        ba_bookings.last_night,
        ba_bookings.total_charges/property_occupancy_per_day.nights_occupied AS average_daily_rate
FROM {{ref('property_occupancy_per_day')}}
LEFT JOIN {{ref('ba_bookings')}}
ON ba_bookings.ba_booking_id = property_occupancy_per_day.ba_booking_id
WHERE ba_bookings.booking_status = 'Confirmed'
  AND ba_bookings.last_night < current_date()
ORDER BY 1


-- Removed this line AND ba_bookings.booking_channel NOT LIKE '%Airbnb%'
