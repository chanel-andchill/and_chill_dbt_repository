{{ config(materialized='view') }}

SELECT  hubspot_deals.deal_id,
        CASE  WHEN hubspot_deals.deal_stage = 'closedwon' THEN 'closed_won'
              WHEN hubspot_deals.deal_stage = 'closedlost' THEN 'closed_lost'
              END AS result
FROM {{ref('hubspot_deals')}}
WHERE deal_stage = 'closedwon' OR deal_stage = 'closed_lost'
GROUP BY 1, 2
