{{ config(materialized='view') }}

SELECT  *
  FROM {{ref('ba_bookings')}}
WHERE ba_bookings.booking_status = 'Cancelled'
