{{ config(materialized='view') }}

WITH property_master_list AS (
  SELECT
  *
  FROM {{ref('property_master_list')}}
)
, booking_occupancy AS (
  SELECT
  *
  FROM {{ref('nights_occupied_per_booking')}}
)
, jira_issues AS (
  select * from {{ref('jira_issues')}}
)
,
nights_occupied_per_booking as (
  select * from {{ref('nights_occupied_per_booking')}}
)
,
days_onboard as (
  select * from {{ref('days_onboard')}}
)
,
date_onboarded as (
  select * from {{ref('date_onboarded')}}
)
,
date_offboarded as (
  select * from {{ref('date_offboarded')}}
)

, base as (select  property_master_list.ba_id_code as ba_id_code,
        property_master_list.property_address as property_address,
        property_master_list.property_owner as property_owner,
        days_onboard.days_onboard as days_onboard,
        property_master_list.status as status,
        -- Calculating nights occupied as a percentage of all nights
        sum(nights_occupied_per_booking.nights_occupied) as nights_occupied

    from property_master_list
    left join days_onboard
      on property_master_list.ba_id_code = days_onboard.ba_id_code
    left join nights_occupied_per_booking
      on property_master_list.ba_id_code = nights_occupied_per_booking.ba_id_code
      group by 1,2,3,4,5)

      select
              b.*,
              -- Calculate the earliest date
              date_onboarded.date_onboarded as date_onboarded,
              date_offboarded.date_offboarded as date_offboarded,
              case  when b.nights_occupied is null then 0
                    else b.nights_occupied/b.days_onboard * 100 end as percentage_occupied
              from base b
              left join date_onboarded
                on b.ba_id_code = date_onboarded.ba_id_code
              left join date_offboarded
                on b.ba_id_code = date_offboarded.ba_id_code
              where status = 'Active'
