{{ config(materialized='view') }}

select  ba_bookings.ba_id_code as ba_id_code,
        ba_bookings.ba_booking_id as ba_booking_id,
        ba_bookings.first_night as first_night,
        ba_bookings.last_night as last_night,
        nights_occupied_per_booking.nights_occupied as nights,
        ba_bookings.total_charges as total_charges,
        ba_bookings.total_charges/nights_occupied_per_booking.nights_occupied as average_daily_rate
       from {{ref('ba_bookings')}}
left join {{ref('nights_occupied_per_booking')}}
on ba_bookings.ba_booking_id = nights_occupied_per_booking.ba_booking_id
where ba_bookings.booking_status = 'Confirmed' and ba_bookings.last_night < current_date() and ba_bookings.booking_channel not like '%Airbnb%'
group by 1,2,3,4,5, 6
