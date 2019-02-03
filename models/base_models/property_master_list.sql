{{ config(materialized='table') }}

select  BA_ID_Code as ba_id_code,
        Property_Address as property_address,
        -- Converting Date_Onboarded to a date format
        case  when Date_Onboarded = 'Unknown' then null
              else parse_date('%d/%m/%Y', Date_Onboarded) end as date_onboarded,
        Status as status,
              -- Converting Date_Offboarded to a date format
        case when Date_Offboarded = 'Unknown' then null
              when Date_Offboarded = 'Duplicate' then null
              else parse_date('%d/%m/%Y', Date_Offboarded) end as date_offboarded,
        Property_Owner as property_owner,
        Preferred_Language as preferred_language,
        Listing_Title as listing_title,
        cast(TRIM(cast(Long_Term_Rental_Estimate_per_Week as STRING),"$")as INT64) as long_term_rental_estimate_per_week,
        Property_Type as property_type,
        Rental_Type as rental_type,
        -- Eliminating $ character from maintenance threshold and casting as an integer
        case when Maintenance_Threshold = '(Contact CS)' then null
        else cast(CONCAT(TRIM(Maintenance_Threshold,"$"))as INT64) end as maintenance_threshold,
        Contractor as contractor,
        Security_Level_ID as security_level_id,
        Bedrooms as bedrooms,
        Bathrooms as bathrooms,
        King_Beds as king_beds,
        Queen_Beds as queen_beds,
        Double_Beds as double_beds,
        Single_Beds as single_beds,
        Sofa_Beds as sofa_beds,
        PPE as ppe_name,
        Portfolio as portfolio,
        Lead_BDM as lead_bdm,
        Commission_Type as commission_type,
        Commission as commission,
        Comments as comments,
        PropKey as propkey,
        Jira_Task_Key as jira_task_key
from  `and-chill-database.google_sheets.property_master_list`
