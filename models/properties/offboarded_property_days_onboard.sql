{{ config(materialized='view') }}

SELECT  days_onboard.ba_id_code,
        days_onboard.days_onboard,
        date_offboarded.date_offboarded
FROM {{ref('days_onboard')}}
LEFT JOIN {{ref('date_offboarded')}}
  ON date_offboarded.ba_id_code = days_onboard.ba_id_code
