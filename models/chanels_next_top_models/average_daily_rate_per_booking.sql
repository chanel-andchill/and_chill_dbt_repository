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
<<<<<<< HEAD
group by 1,2,3,4,5,6
=======
<<<<<<< HEAD:models/chanels_next_top_models/average_daily_rate_per_booking.sql
group by 1,2,3,4,5,6
=======
group by 1,2,3,4,5, 6
>>>>>>> 5b0ada4ae7e9d125e3b435dc77092f3c8eeba166:models/chanels_next_top_models/average_daily_rate_per_booking.sql
>>>>>>> master
