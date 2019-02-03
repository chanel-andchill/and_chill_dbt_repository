{{ config(materialized='table') }}

-- Want to find the earliest issue associated with a property. Find the date of that issue and set as jira_date_onboarded

select  jira_issues.ba_id_code as ba_id_code,
        min(created_date_1) as jira_date_onboarded
        from {{ref('jira_issues')}}
        group by 1
