{{ config(materialized='view') }}

-- Taking raw data from Jira Issues.

SELECT  stylingcontractorhsp AS styling_contractor_hsp,
        keyhandoverdate AS key_hand_over_date,
        propertystate AS property_state,
        created AS created,
        statuscategory AS status_category,
        development AS development,
        reporter AS reporter,
        constant1 AS constant_1,
        originalestimatehrs AS original_estimated_hours,
        timespenthrs AS time_spent_hours,
        priority AS priority,
        originalestimateinclsubtaskshrs AS original_estimate_including_subtasks_hours,
        bathrooms AS bathrooms,
        -- Check if this is the same across the board.
        reservation AS reservation_code,
        dateofkeyhandover AS date_of_key_handover,
        clientname AS client_name,
        referralpartner AS referral_partner,
        jiraissueid AS jira_issue_id,
        datecontractsigned AS date_contract_signed,
        apicallid AS api_call_id,
        key AS key,
        datepaymentreceived AS date_payment_received,
        clientemailaddress AS client_email,
        modifieddate AS modified_date,
        keypickupdetails AS key_pick_up_details,
        projectlead AS project_lead,
        andchilloverheadscosts AS and_chill_overhead_costs,
        -- Cast this as ddmmyy
        PARSE_DATE('%m%d%Y', created_mmddyyyy) AS created_date_1,
        bedrooms AS bedrooms,
        typicalcost AS typical_cost,
        `rank` AS `rank`,
        CASE  WHEN LENGTH(bookingautomationid) != 5 THEN NULL
              ELSE CAST(bookingautomationid as INT64)
              END AS ba_id_code,
        summary AS summary,
        linkedissues AS linked_issues,
        lastviewed AS last_viewed,
        creator AS creator,
        watchers AS watchers,
        created_2 AS created_2,
        furnitureremovalduedate AS furniture_removal_date,
        projecttype AS project_type,
        _sdc_table_version AS sdc_table_version,
        parentissuestatus AS parent_issue_status,
        remainingestimatehrs AS remaining_estimate_hours,
        referralpartnercommission AS referral_partner_commission,
        datepropertylisted AS date_property_listed,
        workratio AS work_ratio,
        typeofissue AS type_of_issue,
        chartdateoffirstresponse AS chart_date_of_first_response,
        dateofphotography AS photography_date,
        parentissuesummary AS parent_issues_summary,
        propertylistingdate AS property_listing_date,
        bdmcommission AS bdm_commission,
        projectcategory AS project_category,
        propertysettlementdate AS property_settlement_date,
        status AS status,
        subtasks AS subtasks,
        propertyaddress AS property_address,
        timespentinclsubtaskshrs AS time_spent_including_subtasks_hours,
        datehomesetupfeepaid AS date_home_setup_fee_paid,
        propertyparkinglocation AS property_parking_location,
        furnitureproductexpenses AS furniture_product_expenses,
        _sdc_received_at AS sdc_received_at,
        _sdc_sequence AS sdc_sequence,
        hostfullyurl AS hostfully_url,
        datepropertyavailable AS date_property_available,
        assignee AS ppe,
        endofleasecleanduedate AS end_of_lease_clean_due_date,
        dateofinteriorfitout AS date_of_interior_fit_out,
        projectdescription AS project_description,
        parentissuepriority AS parent_issue_priority,
        duedate AS due_date,
        propertymanagementcommission AS property_management_commission,
        updated AS updated,
        projectname AS project_name,
        charttimeinstatus AS chart_time_in_status,
        projectkey AS project_key,
        propertymanagementcommissiontype AS property_management_commission_type,
        parentissuetype AS parent_issue_type,
        parentissuekey AS parent_issue_key,
        homesetupfee AS home_setup_fee,
        _sdc_batched_at AS sdc_batched_at,
        issuetype AS issue_type,
        attachmentnames AS attachment_names,
        createddate AS created_date,
        remainingestimateinclsubtaskshrs AS remaining_estimate_including_subtasks_hours,
        propertyupcomingcheckouts AS property_upcoming_check_outs,
        description AS description,
        paymentterms AS payment_terms,
        transfertohomestyling AS transfer_to_home_styling,
        resolved AS resolved,
        resolution AS resolution
FROM `and-chill-database.sql_server.JiraIssues`
