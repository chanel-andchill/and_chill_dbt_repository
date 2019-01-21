{{ config(materialized='table') }}
--select  case when Date_Offboarded = 'Unknown' then null
      --  when Date_Offboarded = 'Duplicate' then null
      --  else parse_date('%d/%m/%Y', Date_Offboarded) end as date_offboarded,
      --  case when Date_Onboarded = 'Unknown' then null
      --  else parse_date('%d/%m/%Y', Date_Onboarded) end as date_onboarded
      --  from `and-chill-database.google_sheets.property_master_list`


select  BA_ID_Code as ba_id_code,
        Property_Address as property_address,
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
        -- Converting Date_Onboarded to a date format
        case  when Date_Onboarded = 'Unknown' then null
              else parse_date('%d/%m/%Y', Date_Onboarded) end as date_onboarded,
        Status as status,
        -- Converting Date_Offboarded to a date format
        case when Date_Offboarded = 'Unknown' then null
             when Date_Offboarded = 'Duplicate' then null
             else parse_date('%d/%m/%Y', Date_Offboarded) end as date_offboarded,
        -- Finding how long the property has been onboard
        --case when date_offboarded is not null then date_diff(date_offboarded, date_onboarded, DAY)
        --else date_diff(current_date(), date_onboarded, DAY) end as days_onboard,
        -- Eliminating $ character from long term rental estimate and casting as an integer
        cast(TRIM(cast(Long_Term_Rental_Estimate_per_Week as STRING),"$")as INT64) as long_term_rental_estimate_per_week,
        -- Eliminating $ character from maintenance threshold and casting as an integer
        case when Maintenance_Threshold = '(Contact CS)' then null
        else cast(CONCAT(TRIM(Maintenance_Threshold,"$"))as INT64) end as maintenance_threshold,
        Portfolio as portfolio,
        PPE as ppe_name,
        Listing_Title as listing_title,
        PropKey as propkey,
        Commission_Type as commission_type,
        Commission as commission,
        Comments as comments,
        Jira_Task_Key as jira_task_key
from  `and-chill-database.google_sheets.property_master_list`
