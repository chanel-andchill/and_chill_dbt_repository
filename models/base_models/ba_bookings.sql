{{ config(materialized='view') }}

-- Taking raw Booking Automation data from BA_Bookings in SQL Server.

SELECT  propID AS ba_id_code,
        bookId AS ba_booking_id,
        bookid AS reservation_code,
        -- For linking charge automation with booking automation
        propKey AS propkey,
        guestFirstName AS guest_first_name,
        guestName AS guest_last_name,
        guestAddress AS guest_address,
        guestPostcode AS guest_postcode,
        guestCity AS guest_city,
        guestCountry AS guest_country,
        lang AS guest_language,
        guestmobile AS guest_mobile,
        guestPhone AS guest_phone,
        guestComments AS guest_comments,
        CAST(bookingTime AS DATE) AS booking_time,
        createddate AS date_created,
        referer AS booking_channel,
        status AS status_code,
        -- Ignore USD currency, ask Shubes
        CASE  WHEN referer LIKE '%Airbnb%' AND status != 0 THEN 'Confirmed'
              WHEN referer = 'Booking.com' AND status != 0 AND (flagtext = 'PAID+VERIFIED' OR flagtext = 'PAID + VERIFIED') THEN 'Confirmed'
              WHEN referer = 'Booking.com' AND CAST(bookingtime as DATE) < CAST('2018-12-01' AS DATE) AND status != 0 AND (flagtext = 'Paid') THEN 'Confirmed'
              WHEN referer NOT LIKE 'Booking.com' AND status != 0 AND flagtext LIKE 'Paid' THEN 'Confirmed'
              WHEN status = 0 THEN 'Cancelled'
              WHEN CAST(firstNight AS DATE) <= CURRENT_DATE() and status = 1 THEN 'Cancelled'
              ELSE 'Unconfirmed' END AS booking_status,
        currency AS currency,
        flagtext AS paid_status,
        price AS total_charges,
        CAST(firstNight AS DATE) AS first_night,
        CAST(lastNight AS DATE) AS last_night,
        CAST(numAdult AS INT64) AS number_of_adults,
        CAST(numChild AS INT64) AS number_of_children,
        isdeleted AS is_deleted
FROM `and-chill-database.sql_server.BABookings`
