{{ config(materialized='view') }}

select  days_onboard.ba_id_code,
        days_onboard.days_onboard,
        date_offboarded.date_offboarded
    from {{ref('days_onboard')}}
    left join {{ref('date_offboarded')}}
    on date_offboarded.ba_id_code = days_onboard.ba_id_code
