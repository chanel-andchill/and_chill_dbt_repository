{{ config(materialized='view') }}

-- Taking raw Booking Automation data from BA_Bookings in SQL Server.

SELECT  propid AS ba_id_code,
        babookingid AS ba_booking_id,
        bookid AS reservation_code,
        -- For linking charge automation with booking automation
        propkey AS propkey,
        guestfirstname AS guest_first_name,
        guestname AS guest_last_name,
        guestemail AS guest_email,
        guestaddress AS guest_address,
        guestpostcode AS guest_postcode,
        guestcity AS guest_city,
        guestcountry AS guest_country,
        lang AS guest_language,
        guestmobile AS guest_mobile,
        guestphone AS guest_phone,
        guestcomments AS guest_comments,
        CAST(bookingtime AS DATE) AS booking_time,
        createddate AS date_created,
        referer AS booking_channel,
        status AS status_code,
        -- Ignore USD currency, ask Shubes
        CASE  WHEN referer LIKE '%Airbnb%' AND status != 0 THEN 'Confirmed'
              WHEN referer = 'Booking.com' AND status != 0 AND (flagtext = 'PAID+VERIFIED' OR flagtext = 'PAID + VERIFIED') THEN 'Confirmed'
              WHEN referer = 'Booking.com' AND CAST(bookingtime as DATE) < CAST('2018-12-01' AS DATE) and status != 0 AND (flagtext = 'Paid') THEN 'Confirmed'
              WHEN referer NOT LIKE 'Booking.com' AND status != 0 AND flagtext LIKE 'Paid' THEN 'Confirmed'
              ELSE 'Unconfirmed' END AS booking_status,
        currency AS currency,
        flagtext AS paid_status,
        price AS total_charges,
        CAST(firstnight AS DATE) AS first_night,
        CAST(lastnight AS DATE) AS last_night,
        CAST(numadult AS INT64) AS number_of_adults,
        CAST(numchild AS INT64) AS number_of_children,
        isdeleted AS is_deleted
FROM `and-chill-database.sql_server.BABookings`
