{{ config(materialized='view') }}

-- I want the ppe name to fill in for every booking

select  ba_bookings.ba_id_code as ba_id_code,
        reservation_code as reservation_code,
        property_master_list.ppe_name as ppe_name
        from {{ref('ba_bookings')}}
        left join {{ref('property_master_list')}}
        on ba_bookings.ba_id_code = property_master_list.ba_id_code
