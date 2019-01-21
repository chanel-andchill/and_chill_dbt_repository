{{ config(materialized='table') }}

WITH property_master_list AS (
  SELECT
  *
  FROM {{ref('property_master_list')}}
)

, booking_occupancy AS (
  SELECT
  *
  FROM {{ref('booking_occupancy')}}
)


, base as (select  property_master_list.ba_id_code as ba_id_code,
        property_master_list.property_address as property_address,
        property_master_list.property_owner as property_owner,
        property_master_list.date_onboarded as date_onboarded,
        property_master_list.date_offboarded as date_offboarded,
        -- Calculating days_onboard
        case when property_master_list.date_offboarded is not null then date_diff(property_master_list.date_offboarded ,property_master_list.date_onboarded, DAY)
        else date_diff(current_date(), property_master_list.date_onboarded, DAY) end as days_onboard,
        -- Calculating nights occupied as a percentage of all nights
        sum(booking_occupancy.nights_occupied) as nights_occupied

    from property_master_list
    join  booking_occupancy
      on property_master_list.ba_id_code = booking_occupancy.ba_id_code
      group by (1,2,3,4,5,6

      select *, b.nights_occupied/b.days_onboard * 100 as percentage_occupied from base b
        order by percentage_occupied desc),
