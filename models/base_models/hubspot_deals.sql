{{ config(materialized='view') }}

-- Taking raw data from hubspot deals.

SELECT  dealid AS deal_id,
        properties.booking_automation_id.value AS ba_id_code,
        properties.property_address.`value` AS property_address,
        properties.property_state.value AS property_state,
        properties.property_suburb.value AS property_suburb,
        properties.property_type.value AS property_type,
        properties.property_bedrooms.value AS property_bedrooms,
        properties.bedrooms.value AS property_bedrooms_2,
        properties.bathrooms.value AS property_bathrooms,
        properties.property_bathrooms.value AS property_bathrooms_2,
        properties.property_living_rooms.value AS living_rooms,
        properties.furnishing_option.value AS furnishing_option,
        properties.setup_package_option.value AS setup_package,
        properties.setup_package_fee.value AS setup_package_fee_value,
        properties.amount.value AS property_amount,
        properties.amount_in_home_currency.value AS amount_in_home_currency,
        properties.long_term_rental_estimate_weekly_.value AS long_term_rental_estimate_per_week,
        properties.property_management_fee_.value AS property_management_fee,
        properties.referral_partner_email.value AS referral_partner_email,
        properties.hubspot_owner_id.sourceid AS hubspot_owner,
        properties.hubspot_owner_id.sourceid AS hubspot_owner_email,
        properties.lead_bdm.value AS lead_bdm,
        bdm_id_code.bdm_first_name AS bdm_first_name,
        bdm_id_code.bdm_last_name AS bdm_last_name,
        properties.dealstage.sourceid AS dealstage_id,
        properties.dealstage.value AS deal_stage,
        CAST(properties.createdate.value AS DATE) AS deal_open_date,
        CAST(properties.dealstage.`timestamp` AS DATE) AS date_of_deal,
        properties.closedate.value AS close_date
FROM `and-chill-database.hubspot.deals`
LEFT JOIN {{ref('bdm_id_code')}}
  ON bdm_id_code.bdm_id_code = `and-chill-database.hubspot.deals`.properties.lead_bdm.value
