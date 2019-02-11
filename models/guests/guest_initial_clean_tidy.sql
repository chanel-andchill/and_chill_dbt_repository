{{ config(materialized='view') }}

-- We only have this data from 7/1/19

SELECT  AVG(guest_realtime_feedback.do_you_feel_the_space_is_clean_and_tidy) AS average_clean_and_tidy_rating,
        COUNT(guest_realtime_feedback.do_you_feel_the_space_is_clean_and_tidy) AS cleans_completed,
        property_master_list.cleaner AS cleaner
FROM {{ref('guest_realtime_feedback')}}
JOIN {{ref('property_master_list')}}
  ON guest_realtime_feedback.ba_id_code = property_master_list.ba_id_code
GROUP BY cleaner
