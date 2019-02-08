{{ config(materialized='view') }}


select  property_master_list.ba_id_code as ba_id_code,
        case  when last_booking_last_night.last_night is null then greatest(jira_date_offboarded.jira_date_offboarded, property_master_list.date_offboarded)
              when jira_date_offboarded.jira_date_offboarded is null then greatest(last_booking_last_night.last_night, property_master_list.date_offboarded)
              when property_master_list.date_offboarded is null then greatest(jira_date_offboarded.jira_date_offboarded, last_booking_last_night.last_night)
              else greatest(jira_date_offboarded.jira_date_offboarded, last_booking_last_night.last_night, property_master_list.date_offboarded) end as date_offboarded
        from {{ref('property_master_list')}}
        left join {{ref('last_booking_last_night')}}
        on property_master_list.ba_id_code = last_booking_last_night.ba_id_code
        left join {{ref('jira_date_offboarded')}}
        on property_master_list.ba_id_code = jira_date_offboarded.ba_id_code
        where property_master_list.status = 'Offboarded'
