{{ config(materialized='table') }}

-- Want to find the first night of the first booking per property

select  ba_bookings.ba_id_code as ba_id_code,
        min(ba_bookings.first_night) as first_night
        from {{ref('ba_bookings')}}
        where ba_bookings.booking_status = 'Confirmed'
        group by 1
