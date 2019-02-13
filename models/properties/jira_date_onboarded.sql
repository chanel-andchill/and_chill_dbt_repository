{{ config(materialized='view') }}

-- Want to find the earliest issue associated with a property. Find the date of that issue and set as jira_date_onboarded

SELECT  jira_issues.ba_id_code AS ba_id_code,
        MIN(created_date_1) AS jira_date_onboarded
FROM {{ref('jira_issues')}}
GROUP BY 1
