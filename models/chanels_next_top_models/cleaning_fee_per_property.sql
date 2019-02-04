{{ config(materialized='view') }}

select  ba_id_code as ba_id_code,
        bedrooms + bathrooms as rooms,
        90 + (20 * (bedrooms + bathrooms)) as cleaning_fee
        from {{ref('property_master_list')}}
