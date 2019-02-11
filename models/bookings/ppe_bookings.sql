{{ config(materialized='view') }}

-- I want the ppe name to fill in for every booking

SELECT  ba_bookings.ba_id_code AS ba_id_code,
        reservation_code AS reservation_code,
        property_master_list.ppe_name AS ppe_name
FROM {{ref('ba_bookings')}}
LEFT JOIN {{ref('property_master_list')}}
  ON ba_bookings.ba_id_code = property_master_list.ba_id_code
