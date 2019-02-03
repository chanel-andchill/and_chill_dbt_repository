{{ config(materialized='table') }}

select  dealid as deal_id,
        properties.booking_automation_id.value as ba_id_code,
        properties.property_address.`value` as property_address,
        properties.property_state.value as property_state,
        properties.property_suburb.value as property_suburb,
        properties.property_type.value as property_type,
        properties.property_bedrooms.value as property_bedrooms,
        properties.bedrooms.value as property_bedrooms_2,
        properties.bathrooms.value as property_bathrooms,
        properties.property_bathrooms.value as property_bathrooms_2,
        properties.property_living_rooms.value as living_rooms,
        properties.furnishing_option.value as furnishing_option,
        properties.setup_package_option.value as setup_package,
        properties.setup_package_fee.value as setup_package_fee_value,
        properties.amount.value as property_amount,
        properties.amount_in_home_currency.value as amount_in_home_currency,
        properties.long_term_rental_estimate_weekly_.value as long_term_rental_estimate_per_week,
        properties.property_management_fee_.value as property_management_fee,
        properties.referral_partner_email.value as referral_partner_email,
        properties.hubspot_owner_id.sourceid as hubspot_owner,
        properties.hubspot_owner_id.sourceid as hubspot_owner_email,
        properties.lead_bdm.value as lead_bdm,
        bdm_id_code.bdm_first_name as bdm_first_name,
        bdm_id_code.bdm_last_name as bdm_last_name,
        properties.dealstage.sourceid as dealstage_id,
        properties.dealstage.value as deal_stage,
        cast(properties.createdate.value as date) as deal_open_date,
        cast(properties.dealstage.`timestamp` as date) as date_of_deal,
        properties.closedate.value as close_date
        from hubspot.deals hd
        left join {{ref('bdm_id_code')}}
        on bdm_id_code.bdm_id_code = hd.properties.lead_bdm.value
