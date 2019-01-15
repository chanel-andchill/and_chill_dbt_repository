{{ config(materialized='table') }}

select  BA_ID_Code as ba_id_code,
        Property_Address as property_address,
        Region as region,
        Property_Type as property_type,
        Rental_Type as rental_type,
        Contractor as contractor,
        Security_Level_ID as security_level_id,
        Bedrooms as bedrooms,
        Bathrooms as bathrooms,
        King_Beds as king_beds,
        Queen_Beds as queen_beds,
        Double_Beds as double_beds,
        Single_Beds as single_beds,
        Sofa_Beds as sofa_beds,
        Preferred_Language as preferred_language,
        Lead_BDM as lead_bdm,
        Property_Owner as property_owner,
        case when Date_Onboarded = 'Unknown' then null
        else PARSE_DATE('%d/%m/%Y',  Date_Onboarded) end as date_onboarded,
        Status as status,
        case when Date_Offboarded = 'Unknown' then null
        when Date_Offboarded = 'Duplicate' then null
        else PARSE_DATE('%d/%m/%Y',  Date_Offboarded) end as date_offboarded,
        CONCAT(TRIM(cast(Long_Term_Rental_Estimate_per_Week as STRING),"$")) as long_term_rental_estimate_per_week,
        CONCAT(TRIM(cast(Maintenance_Threshold as STRING),"$")) as maintenance_threshold,
        Confluence_Profile_Link as confluence_profile_link,
        Portfolio as portfolio,
        PPE as ppe_name,
        Listing_Title as listing_title,
        PropKey as propkey,
        Commission_Type as commission_type,
        Commission as commission,
        Comments as comments,
        Jira_Task_Key as jira_task_key
from  `and-chill-database.google_sheets.property_master_list`
