{{ config(materialized='view') }}

-- Choosing the earliest date to be the date onboarded. I'm pretty sure we are

SELECT  property_master_list.ba_id_code AS ba_id_code,
        -- If no data exists in these areas, choose the earliest date of the other two options.
        CASE  WHEN first_booking_first_night.first_night IS NULL THEN LEAST(jira_date_onboarded.jira_date_onboarded, property_master_list.date_onboarded)
              WHEN jira_date_onboarded.jira_date_onboarded IS NULL THEN LEAST(first_booking_first_night.first_night,   property_master_list.date_onboarded)
              WHEN property_master_list.date_onboarded IS NULL THEN
              LEAST(jira_date_onboarded.jira_date_onboarded, first_booking_first_night.first_night)
              ELSE LEAST(jira_date_onboarded.jira_date_onboarded, first_booking_first_night.first_night, property_master_list.date_onboarded) END AS date_onboarded
FROM {{ref('property_master_list')}}
LEFT JOIN {{ref('first_booking_first_night')}}
  ON property_master_list.ba_id_code = first_booking_first_night.ba_id_code
LEFT JOIN {{ref('jira_date_onboarded')}}
  ON property_master_list.ba_id_code = jira_date_onboarded.ba_id_code
