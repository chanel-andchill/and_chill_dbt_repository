{{ config(materialized='view') }}

-- Taking raw data from Jira Issues.

SELECT  projecttype AS project_type,
        key AS key,
        jiraissueid AS jira_issue_id,
        created AS created,
        statuscategory AS status_category,
        reporter AS reporter,
        priority AS priority,
        CASE  WHEN LENGTH(bookingautomationid) != 5 THEN NULL
              ELSE CAST(bookingautomationid as INT64)
              END AS ba_id_code,
        propertyaddress AS property_address,
        datecontractsigned AS date_contract_signed,
        reservation AS reservation_code,
        keyhandoverdate AS key_hand_over_date,
        datepaymentreceived AS date_payment_received,
        projectlead AS project_lead,
        PARSE_DATE('%m%d%Y', created_mmddyyyy) AS created_date_1,
        summary AS summary,
        datepropertylisted AS date_property_listed,
        typeofissue AS type_of_issue,
        parentissuesummary AS parent_issues_summary,
        propertylistingdate AS property_listing_date,
        projectcategory AS project_category,
        status AS status,
        assignee AS ppe,
        projectname AS project_name,
        projectkey AS project_key,
        homesetupfee AS home_setup_fee,
        issuetype AS issue_type,
        createddate AS created_date,
        description AS description,
        resolved AS timestamp_resolved
FROM `and-chill-database.sql_server.JiraIssues`
