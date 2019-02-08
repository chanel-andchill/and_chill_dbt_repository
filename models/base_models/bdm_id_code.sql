{{ config(materialized='table') }}

-- Associating BDMs with their Hubspot ID's.

SELECT  CAST(bdm_id_code AS STRING) AS bdm_id_code,
        bdm_first_name,
        bdm_last_name,
        bdm_email
FROM `and-chill-database.google_sheets.bdm_ids`
