{{ config(materialized='table') }}

-- Taking the raw data from the Property Master List.

SELECT  BA_ID_Code AS ba_id_code,
        Property_Address AS property_address,
        -- Converting Date_Onboarded to a date format
        CASE  WHEN Date_Onboarded = 'Unknown' THEN NULL
              ELSE PARSE_DATE('%d/%m/%Y', Date_Onboarded)
              END AS date_onboarded,
        Status AS status,
              -- Converting Date_Offboarded to a date format
        CASE  WHEN Date_Offboarded = 'Unknown' THEN NULL
              WHEN Date_Offboarded = 'Duplicate' THEN NULL
              ELSE PARSE_DATE('%d/%m/%Y', Date_Offboarded)
              END AS date_offboarded,
        Property_Owner AS property_owner,
        Preferred_Language AS preferred_language,
        Listing_Title AS listing_title,
        CAST(TRIM(CAST(Long_Term_Rental_Estimate_per_Week AS STRING),"$") AS INT64) AS long_term_rental_estimate_per_week,
        Property_Type AS property_type,
        Rental_Type AS rental_type,
        -- Eliminating $ character from maintenance threshold and casting as an integer
        CASE  WHEN Maintenance_Threshold = '(Contact CS)' THEN NULL
              ELSE CAST(CONCAT(TRIM(Maintenance_Threshold,"$")) AS INT64)
              END AS maintenance_threshold,
        Contractor AS cleaner,
        90 + (20 * (bedrooms + bathrooms)) AS cleaning_fee,
        Security_Level_ID AS security_level_id,
        Bedrooms AS bedrooms,
        Bathrooms AS bathrooms,
        King_Beds AS king_beds,
        Queen_Beds AS queen_beds,
        Double_Beds AS double_beds,
        Single_Beds AS single_beds,
        Sofa_Beds AS sofa_beds,
        PPE AS ppe_name,
        Portfolio AS portfolio,
        Lead_BDM AS lead_bdm,
        Commission_Type AS commission_type,
        Commission AS commission,
        Comments AS comments,
        PropKey AS propkey,
        Jira_Task_Key AS jira_task_key,
        client_email AS client_email
FROM `and-chill-database.google_sheets.property_master_list`
