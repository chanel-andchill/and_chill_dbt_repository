{{ config(materialized='view') }}

-- This model determines how long a property was onboard before it was Offboarded
-- i.e. how long we had the property for. This could help us determine what factors
-- cause a property to churn.

SELECT  days_onboard.ba_id_code,
        days_onboard.days_onboard,
        date_offboarded.date_offboarded
FROM {{ref('days_onboard')}}
LEFT JOIN {{ref('date_offboarded')}}
  ON date_offboarded.ba_id_code = days_onboard.ba_id_code
