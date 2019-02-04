{{ config(materialized='view') }}

select  deal_id,
        deal_open_date,
        extract(day from deal_open_date) as deal_open_day,
        extract(month from deal_open_date) as deal_open_month,
        extract(year from deal_open_date) as deal_open_year,
        max(hubspot_deals.date_of_deal) as deal_close_date,
        extract(day from date_of_deal) as deal_close_day,
        extract(month from date_of_deal) as deal_close_month,
        extract(year from date_of_deal) as deal_close_year
        from {{ref('hubspot_deals')}}
        where hubspot_deals.deal_stage = 'closedwon' or hubspot_deals.deal_stage = 'closedlost'
        group by 1, 2, 3, 4, 5, 7, 8, 9
