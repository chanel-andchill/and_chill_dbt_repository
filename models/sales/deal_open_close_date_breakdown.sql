{{ config(materialized='view') }}

SELECT  deal_id,
        deal_open_date,
        EXTRACT(day FROM deal_open_date) AS deal_open_day,
        EXTRACT(month FROM  deal_open_date) AS deal_open_month,
        EXTRACT(year FROM deal_open_date) AS deal_open_year,
        MAX(hubspot_deals.date_of_deal) AS deal_close_date,
        EXTRACT(day FROM date_of_deal) AS deal_close_day,
        EXTRACT(month FROM date_of_deal) AS deal_close_month,
        EXTRACT(year FROM date_of_deal) AS deal_close_year
FROM {{ref('hubspot_deals')}}
WHERE hubspot_deals.deal_stage = 'closedwon' OR hubspot_deals.deal_stage = 'closedlost'
GROUP BY 1, 2, 3, 4, 5, 7, 8, 9
