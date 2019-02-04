{{ config(materialized='view') }}

-- We only have this data from 7/1/19

select  avg(guest_realtime_feedback.how_effective_has_our_communication_been) as average_communication_rating,
        count(guest_realtime_feedback.how_effective_has_our_communication_been) as number_of_ratings,
        ppe_name as ppe_name
from {{ref('guest_realtime_feedback')}}
where guest_realtime_feedback.how_effective_has_our_communication_been is not null
group by ppe_name
