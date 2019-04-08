{{ config(materialized='view') }}

-- Tbh don't know why this exists.

SELECT  *
  FROM {{ref('ba_bookings')}}
WHERE ba_bookings.booking_status = 'Cancelled'
