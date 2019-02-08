{{ config(materialized='view') }}

-- Choosing the earliest date to be the date onboarded

select  property_master_list.ba_id_code as ba_id_code,
        case  when first_booking_first_night.first_night is null then least(jira_date_onboarded.jira_date_onboarded, property_master_list.date_onboarded)
              when jira_date_onboarded.jira_date_onboarded is null then least(first_booking_first_night.first_night,   property_master_list.date_onboarded)
              when property_master_list.date_onboarded is null then
              least(jira_date_onboarded.jira_date_onboarded, first_booking_first_night.first_night)
              else least(jira_date_onboarded.jira_date_onboarded, first_booking_first_night.first_night, property_master_list.date_onboarded)end as date_onboarded
        from {{ref('property_master_list')}}
        left join {{ref('first_booking_first_night')}}
        on property_master_list.ba_id_code = first_booking_first_night.ba_id_code
        left join {{ref('jira_date_onboarded')}}
        on property_master_list.ba_id_code = jira_date_onboarded.ba_id_code
