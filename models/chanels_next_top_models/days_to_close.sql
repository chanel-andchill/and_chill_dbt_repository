{{ config(materialized='view') }}

select  hubspot_deals.deal_id as deal_id,
        hubspot_deals.ba_id_code as ba_id_code,
        hubspot_deals.bdm_first_name as bdm_first_name,
        hubspot_deals.bdm_last_name as bdm_last_name,
        deal_open_close_date_breakdown.deal_open_date as deal_open_date,
        deal_open_close_date_breakdown.deal_close_date as deal_close_date,
        deal_won_or_lost.result as result,
        date_diff(deal_open_close_date_breakdown.deal_close_date, hubspot_deals.deal_open_date, day) + 1 as days_to_close
        from {{ref('hubspot_deals')}}
        join {{ref('deal_won_or_lost')}}
        on deal_won_or_lost.deal_id = hubspot_deals.deal_id
        join {{ref('deal_open_close_date_breakdown')}}
        on deal_open_close_date_breakdown.deal_id = hubspot_deals.deal_id
        where deal_open_close_date_breakdown.deal_open_year >= 2019
        group by 1,2,3,4,5,6,7,8
