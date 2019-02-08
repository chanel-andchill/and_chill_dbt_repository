{{ config(materialized='view') }}

-- Want to find the last night of the last booking per property if property has been offboarded

select  ba_bookings.ba_id_code as ba_id_code,
        max(ba_bookings.last_night) as last_night
        from {{ref('ba_bookings')}}
        left join {{ref('property_master_list')}}
        on ba_bookings.ba_id_code = property_master_list.ba_id_code
        where ba_bookings.booking_status = 'Confirmed' and property_master_list.status = 'Offboarded'
        group by 1
