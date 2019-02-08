{{ config(materialized='view') }}

select  calendar_view.day as the_date,
        ba_bookings.ba_id_code as ba_id_code,
        ba_bookings.ba_booking_id as ba_booking_id,
        property_master_list.property_address as property_address,
        property_master_list.property_owner as property_owner,
        nights_occupied_per_booking.nights_occupied as nights_occupied,
        extract(month from calendar_view.day) as month
    from {{ref('calendar_view')}}
    left join {{ref('ba_bookings')}}
    on calendar_view.day between ba_bookings.first_night and ba_bookings.last_night
    left join {{ref('property_master_list')}}
    on property_master_list.ba_id_code = ba_bookings.ba_id_code
    left join {{ref('nights_occupied_per_booking')}}
    on nights_occupied_per_booking.ba_booking_id = ba_bookings.ba_booking_id
    where ba_bookings.booking_status = 'Confirmed' and calendar_view.day <= current_date()
