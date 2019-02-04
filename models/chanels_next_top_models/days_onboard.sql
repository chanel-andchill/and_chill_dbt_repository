{{ config(materialized='view') }}

select  date_onboarded.ba_id_code as ba_id_code,
        case when property_master_list.status = 'Offboarded' then date_diff(date_offboarded.date_offboarded, date_onboarded.date_onboarded, day)
        else date_diff(current_date, date_onboarded.date_onboarded, day) end as days_onboard
        from {{ref('date_onboarded')}}
        left join {{ref('property_master_list')}}
        on property_master_list.ba_id_code = date_onboarded.ba_id_code
        left join {{ref('date_offboarded')}}
        on date_onboarded.ba_id_code = date_offboarded.ba_id_code
