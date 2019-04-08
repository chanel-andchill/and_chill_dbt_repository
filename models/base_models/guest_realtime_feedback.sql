{{ config(materialized='table') }}

-- Taking relevant feedback from guests.

SELECT  CAST(property AS INT64) AS ba_id_code,
        reservation AS reservation_code,
        ppe AS ppe_name,
        name AS guest_name,
        email AS guest_email,
        Got_it____hidden_name____do_you_feel_that_your_space_is_clean_and_tidy_ AS do_you_feel_the_space_is_clean_and_tidy,
        Oh_no__I_m_sorry_to_hear_that__What_s_wrong_ AS what_is_wrong_clean_and_tidy,
        How_smoothly_did_check_in_go_for_you_ AS how_smooth_was_check_in,
        Gosh__What_went_wrong__ AS what_is_wrong_check_in,
        Final_question__how_has_your__strong_overall_experience__strong__with_this_reservation_been_so_far_ AS how_has_your_overall_experience_been_so_far,
        I_m_sorry_things_aren_t_going_so_well_for_you_so_far___strong_What_could_I_do_to_help__strong__ AS what_can_we_do_to_help,
        CAST(How_effective_has_our_communication_with_you_been_ AS INT64) AS how_effective_has_our_communication_been,
        CAST(How_would_you_rate_the_comfort_and_condition_of_your_accommodation AS int64) AS rate_comfort_and_condition_of_accommodation,
        _Sorry_to_hear__What_s_not_looking_good_ AS what_is_wrong_comfort_and_condition,
        Oh_dear__What_can_be_improved_ AS what_can_be_improved,
        Submitted_At AS time_submitted
FROM `and-chill-database.google_sheets.guest_real_time_feedback`
-- I think callum did some test reviews, removing this fake data.
WHERE email != 'callum.forbes@gmail.com'
