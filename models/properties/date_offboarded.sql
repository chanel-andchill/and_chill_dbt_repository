{{ config(materialized='view') }}

-- The date offboarded in the property master list is not always accurate (sometimes
-- it's even missing) so we are estimating an offboarded date based on the last
-- event recorded for that property.

SELECT  property_master_list.ba_id_code AS ba_id_code,
        -- Taking the most recent date from three different sources.
        CASE  WHEN last_booking_last_night.last_night IS NULL THEN GREATEST(jira_date_offboarded.jira_date_offboarded, property_master_list.date_offboarded)
              WHEN jira_date_offboarded.jira_date_offboarded IS NULL THEN GREATEST(last_booking_last_night.last_night, property_master_list.date_offboarded)
              WHEN property_master_list.date_offboarded IS NULL THEN GREATEST(jira_date_offboarded.jira_date_offboarded, last_booking_last_night.last_night)
              ELSE greatest(jira_date_offboarded.jira_date_offboarded, last_booking_last_night.last_night, property_master_list.date_offboarded) END AS date_offboarded
FROM {{ref('property_master_list')}}
LEFT JOIN {{ref('last_booking_last_night')}}
  ON property_master_list.ba_id_code = last_booking_last_night.ba_id_code
LEFT JOIN {{ref('jira_date_offboarded')}}
  ON property_master_list.ba_id_code = jira_date_offboarded.ba_id_code
WHERE property_master_list.status = 'Offboarded'
