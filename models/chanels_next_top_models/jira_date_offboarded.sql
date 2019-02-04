{{ config(materialized='view') }}

-- Want to find the last jira issue associated with the property for properties that have been offboarded.

select  jira_issues.ba_id_code as ba_id_code,
        max(created_date_1) as jira_date_offboarded
        from {{ref('jira_issues')}}
        left join {{ref('property_master_list')}}
        on jira_issues.ba_id_code = property_master_list.ba_id_code
        where property_master_list.status = 'Offboarded'
        group by 1
