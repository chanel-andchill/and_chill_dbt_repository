{{ config(materialized='view') }}

select  property_occupancy_per_day.the_date,
        property_occupancy_per_day.ba_id_code,
        property_occupancy_per_day.ba_booking_id,
        property_occupancy_per_day.property_address,
        property_occupancy_per_day.property_owner,
        ba_bookings.first_night,
        ba_bookings.last_night,
        ba_bookings.total_charges/property_occupancy_per_day.nights_occupied as average_daily_rate
        from {{ref('property_occupancy_per_day')}}
        left join {{ref('ba_bookings')}}
        on ba_bookings.ba_booking_id = property_occupancy_per_day.ba_booking_id
        where ba_bookings.booking_status = 'Confirmed' and ba_bookings.last_night < current_date() and ba_bookings.booking_channel not like '%Airbnb%'
        order by 1


        --date_trunc(the_date, MONTH) as month, ba_id_code, sum(average_daily_rate) as adr
