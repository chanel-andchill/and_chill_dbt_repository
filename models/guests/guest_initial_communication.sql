{{ config(materialized='view') }}

-- We only have this data from 7/1/19

SELECT  avg(guest_realtime_feedback.how_effective_has_our_communication_been) AS average_communication_rating,
        count(guest_realtime_feedback.how_effective_has_our_communication_been) AS number_of_ratings,
        ppe_name AS ppe_name
FROM {{ref('guest_realtime_feedback')}}
WHERE guest_realtime_feedback.how_effective_has_our_communication_been IS NOT NULL
GROUP BY ppe_name
