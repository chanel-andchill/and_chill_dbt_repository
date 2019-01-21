{{ config(materialized='table') }}

select  property_master_list.ba_id_code as ba_id_code,
        property_master_list.property_address as property_address,
        ba_bookings.booking_channel as referrer,
        ba_bookings.paid_status as paid_status,
        ba_bookings.first_night as first_night,
        ba_bookings.last_night as last_night,
        case when ba_bookings.last_night >= current_date() then DATE_DIFF(current_date(), ba_bookings.first_night, DAY) + 1
        else DATE_DIFF(ba_bookings.last_night, ba_bookings.first_night, DAY) + 1 end as nights_occupied
    from `and-chill-database.dbt_chanel.ba_bookings` ba_bookings
    join `and-chill-database.dbt_chanel.property_master_list` property_master_list
      on ba_bookings.ba_id_code = property_master_list.ba_id_code
      where ba_bookings.first_night <= current_date() and ba_bookings.booking_status = 'Confirmed'
