{{ config(materialized='view') }}


select  cast(property as int64) as ba_id_code,
        reservation as reservation_code,
        ppe as ppe_name,
        name as guest_name,
        email as guest_email,
        Got_it____hidden_name____do_you_feel_that_your_space_is_clean_and_tidy_ as do_you_feel_the_space_is_clean_and_tidy,
        Oh_no__I_m_sorry_to_hear_that__What_s_wrong_ as what_is_wrong_clean_and_tidy,
        How_smoothly_did_check_in_go_for_you_ as how_smooth_was_check_in,
        Gosh__What_went_wrong__ as what_is_wrong_check_in,
        Final_question__how_has_your__strong_overall_experience__strong__with_this_reservation_been_so_far_ as how_has_your_overall_experience_been_so_far,
        I_m_sorry_things_aren_t_going_so_well_for_you_so_far___strong_What_could_I_do_to_help__strong__ as what_can_we_do_to_help,
        cast(How_effective_has_our_communication_with_you_been_ as int64) as how_effective_has_our_communication_been,
        cast(How_would_you_rate_the_comfort_and_condition_of_your_accommodation as int64) as rate_comfort_and_condition_of_accommodation,
        _Sorry_to_hear__What_s_not_looking_good_ as what_is_wrong_comfort_and_condition,
        Oh_dear__What_can_be_improved_ as what_can_be_improved,
        Submitted_At as time_submitted
    from `and-chill-database.google_sheets.guest_real_time_feedback`
    where email != 'callum.forbes@gmail.com'
