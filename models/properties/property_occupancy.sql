{{ config(materialized='view') }}

WITH  property_master_list AS (SELECT * FROM {{ref('property_master_list')}}),
      booking_occupancy AS (SELECT * FROM {{ref('nights_occupied_per_booking')}}),
      jira_issues AS (SELECT * FROM {{ref('jira_issues')}}),
      nights_occupied_per_booking AS (SELECT * FROM {{ref('nights_occupied_per_booking')}}),
      days_onboard AS (SELECT * FROM {{ref('days_onboard')}}),
      date_onboarded AS (SELECT * FROM {{ref('date_onboarded')}}),
      date_offboarded AS (SELECT * FROM {{ref('date_offboarded')}}),
      base AS (SELECT property_master_list.ba_id_code AS ba_id_code,
                      property_master_list.property_address AS property_address,
                      property_master_list.property_owner AS property_owner,
                      days_onboard.days_onboard AS days_onboard,
                      property_master_list.status AS status,
                      SUM(nights_occupied_per_booking.nights_occupied) AS nights_occupied
              FROM    property_master_list
              LEFT JOIN days_onboard
                ON property_master_list.ba_id_code = days_onboard.ba_id_code
              LEFT JOIN nights_occupied_per_booking
                ON property_master_list.ba_id_code = nights_occupied_per_booking.ba_id_code
              GROUP BY 1,2,3,4,5)

SELECT  b.*,
        date_onboarded.date_onboarded AS date_onboarded,
        date_offboarded.date_offboarded AS date_offboarded,
        CASE  WHEN b.nights_occupied IS NULL THEN 0
              ELSE b.nights_occupied/b.days_onboard * 100 END AS percentage_occupied
FROM base b
LEFT JOIN date_onboarded
  ON b.ba_id_code = date_onboarded.ba_id_code
LEFT JOIN date_offboarded
  ON b.ba_id_code = date_offboarded.ba_id_code
WHERE status = 'Active'
