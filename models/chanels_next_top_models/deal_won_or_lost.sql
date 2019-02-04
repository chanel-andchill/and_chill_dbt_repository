{{ config(materialized='view') }}

select  hubspot_deals.deal_id,
        case  when hubspot_deals.deal_stage = 'closedwon' then 'closed_won'
              when hubspot_deals.deal_stage = 'closedlost' then 'closed_lost'
              end as result
        from {{ref('hubspot_deals')}}
        where deal_stage = 'closedwon' or deal_stage = 'closed_lost'
        group by 1, 2
