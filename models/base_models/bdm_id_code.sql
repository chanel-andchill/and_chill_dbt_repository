{{ config(materialized='table') }}

select  cast(bdm_id_code as string) as bdm_id_code,
        bdm_first_name,
        bdm_last_name,
        bdm_email
        from `and-chill-database.google_sheets.bdm_ids`
