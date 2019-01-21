{{ config(materialized='table') }}

select
        lang as guest_language,
        bookid as reservation_code,
        guestcountry as guest_country,
        guestcomments as guest_comments,
        -- Ignore USD currency, ask Shubes
        currency as currency,
        -- CHANGE IN OTEHR MODELS
        propid as ba_id_code,
        guestname as guest_last_name,
        guestemail as guest_email,
        guestfirstname as guest_first_name,
        cast(numchild as int64) as number_of_children,
        -- For linking charge automation with booking automation
        propkey as propkey,
        babookingid as ba_booking_id,
        cast(firstnight as DATE) as first_night,
        referer as booking_channel,
        guestcity as guest_city,
        status as status_code,
        flagtext as paid_status,
        guestphone as guest_phone,
        cast(lastnight as DATE) as last_night,
        cast(numadult as INT64) as number_of_adults,
        guestaddress as guest_address,
        guestmobile as guest_mobile,
        guestpostcode as guest_postcode,
        -- What is this field?!
        price as total_charges,
        bookingtime as booking_time,
        createddate as date_created,
        isdeleted as is_deleted,
        case when referer like '%Airbnb%' and status != 0 then 'Confirmed'
              when referer = 'Booking.com' and status != 0 and (flagtext = 'PAID+VERIFIED' or flagtext = 'PAID + VERIFIED') then 'Confirmed'
              when referer not like 'Booking.com' and status != 0 and flagtext like 'Paid' then 'Confirmed'
              else 'Unconfirmed' end as booking_status
    from `and-chill-database.sql_server.BABookings`
