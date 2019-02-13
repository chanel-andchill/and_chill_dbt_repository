{{ config(materialized='view') }}

SELECT  date_onboarded.ba_id_code AS ba_id_code,
        CASE  WHEN property_master_list.status = 'Offboarded' THEN date_diff(date_offboarded.date_offboarded, date_onboarded.date_onboarded, day)
              ELSE date_diff(current_date, date_onboarded.date_onboarded, day)
              END AS days_onboard
        FROM {{ref('date_onboarded')}}
        LEFT JOIN {{ref('property_master_list')}}
          ON property_master_list.ba_id_code = date_onboarded.ba_id_code
        LEFT JOIN {{ref('date_offboarded')}}
          ON date_onboarded.ba_id_code = date_offboarded.ba_id_code
