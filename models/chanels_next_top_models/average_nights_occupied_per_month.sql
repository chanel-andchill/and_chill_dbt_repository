select  ba_id_code as ba_id_code,
        extract(month from the_date) as occupied_month,
        count(distinct extract(month from the_date)) as nights_booked_per_month
        from {{ref('property_occupancy_per_day')}}
        group by 1,2
