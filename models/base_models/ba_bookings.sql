{{ config(materialized='table') }}

select
        propid as ba_id_code,
        babookingid as ba_booking_id,
        bookid as reservation_code,
        -- For linking charge automation with booking automation
        propkey as propkey,
        guestfirstname as guest_first_name,
        guestname as guest_last_name,
        guestemail as guest_email,
        guestaddress as guest_address,
        guestpostcode as guest_postcode,
        guestcity as guest_city,
        guestcountry as guest_country,
        lang as guest_language,
        guestmobile as guest_mobile,
        guestphone as guest_phone,
        guestcomments as guest_comments,
        bookingtime as booking_time,
        createddate as date_created,
        referer as booking_channel,
        status as status_code,
        -- Ignore USD currency, ask Shubes
        case when referer like '%Airbnb%' and status != 0 then 'Confirmed'
              when referer = 'Booking.com' and status != 0 and (flagtext = 'PAID+VERIFIED' or flagtext = 'PAID + VERIFIED') then 'Confirmed'
              when referer = 'Booking.com' and cast(bookingtime as DATE) < cast('2018-12-01' as DATE) and status != 0 and (flagtext = 'Paid') then 'Confirmed'
              when referer not like 'Booking.com' and status != 0 and flagtext like 'Paid' then 'Confirmed'
              else 'Unconfirmed' end as booking_status,
        currency as currency,
        flagtext as paid_status,
        -- What is this field?!
        price as total_charges,
        cast(firstnight as DATE) as first_night,
        cast(lastnight as DATE) as last_night,
        cast(numadult as INT64) as number_of_adults,
        cast(numchild as int64) as number_of_children,
        isdeleted as is_deleted
    from `and-chill-database.sql_server.BABookings`
