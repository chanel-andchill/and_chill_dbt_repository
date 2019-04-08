{{ config(materialized='view') }}

-- Want to find the last jira issue associated with the property for properties
-- that have been offboarded.

SELECT  jira_issues.ba_id_code AS ba_id_code,
        MAX(created_date_1) AS jira_date_offboarded
FROM {{ref('jira_issues')}}
LEFT JOIN {{ref('property_master_list')}}
  ON jira_issues.ba_id_code = property_master_list.ba_id_code
WHERE property_master_list.status = 'Offboarded'
GROUP BY 1
