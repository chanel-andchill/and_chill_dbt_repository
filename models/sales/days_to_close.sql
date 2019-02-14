{{ config(materialized='view') }}

SELECT  hubspot_deals.deal_id AS deal_id,
        hubspot_deals.ba_id_code AS ba_id_code,
        hubspot_deals.bdm_first_name AS bdm_first_name,
        hubspot_deals.bdm_last_name AS bdm_last_name,
        deal_open_close_date_breakdown.deal_open_date AS deal_open_date,
        deal_open_close_date_breakdown.deal_close_date AS deal_close_date,
        deal_won_or_lost.result AS result,
        date_diff(deal_open_close_date_breakdown.deal_close_date, hubspot_deals.deal_open_date, day) + 1 AS days_to_close
FROM {{ref('hubspot_deals')}}
LEFT JOIN {{ref('deal_won_or_lost')}}
  ON deal_won_or_lost.deal_id = hubspot_deals.deal_id
LEFT JOIN {{ref('deal_open_close_date_breakdown')}}
  ON deal_open_close_date_breakdown.deal_id = hubspot_deals.deal_id
WHERE deal_open_close_date_breakdown.deal_open_year >= 2019
GROUP BY 1,2,3,4,5,6,7,8
