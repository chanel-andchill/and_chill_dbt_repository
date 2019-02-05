{{ config(materialized='view') }}

select  ba_id_code as ba_id_code,
        property_address as property_address,
        property_owner as property_owner,
        --the_date as the_date,
        extract(month from the_date) as month
        from {{ref('property_occupancy_per_day')}}
        group by 1,2,3,4,5
