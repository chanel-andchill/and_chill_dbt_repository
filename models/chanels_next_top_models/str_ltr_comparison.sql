{{ config(materialized='view') }}

select  property_master_list.ba_id_code as ba_id_code,
        property_master_list.property_address as property_address,
        property_master_list.property_owner as property_owner,
        case when extract(month from average_daily_rate_per_booking.first_night) = 1 then 'January'
        when extract(month from average_daily_rate_per_booking.first_night) = 2 then 'February'
        when extract(month from average_daily_rate_per_booking.first_night) = 3 then 'March'
        when extract(month from average_daily_rate_per_booking.first_night) = 4 then 'April'
        when extract(month from average_daily_rate_per_booking.first_night) = 5 then 'May'
        when extract(month from average_daily_rate_per_booking.first_night) = 6 then 'June'
        when extract(month from average_daily_rate_per_booking.first_night) = 7 then 'July'
        when extract(month from average_daily_rate_per_booking.first_night) = 8 then 'August'
        when extract(month from average_daily_rate_per_booking.first_night) = 9 then 'September'
        when extract(month from average_daily_rate_per_booking.first_night) = 10 then 'October'
        when extract(month from average_daily_rate_per_booking.first_night) = 11 then 'November'
        when extract(month from average_daily_rate_per_booking.first_night) = 12 then 'December' end as booking_month,
        average_daily_rate_per_booking.average_daily_rate * 7 as short_term_rental_estimate_per_week,
        property_master_list.long_term_rental_estimate_per_week as long_term_rental_estimate
        from {{ref('property_master_list')}}
        left join {{ref('ba_bookings')}}
        on property_master_list.ba_id_code = ba_bookings.ba_id_code
        left join {{ref('average_daily_rate_per_booking')}}
        on property_master_list.ba_id_code = average_daily_rate_per_booking.ba_id_code
        group by 1,2,3,4,5,6
