{{ config(materialized='view') }}

-- We only have this data from 7/1/19

select         avg(guest_realtime_feedback.do_you_feel_the_space_is_clean_and_tidy) as average_clean_and_tidy_rating,
count(guest_realtime_feedback.do_you_feel_the_space_is_clean_and_tidy) as cleans_completed,
property_master_list.contractor as contractor
from {{ref('guest_realtime_feedback')}}
join {{ref('property_master_list')}}
on guest_realtime_feedback.ba_id_code = property_master_list.ba_id_code
group by contractor
