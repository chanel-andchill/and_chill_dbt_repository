with cohort_items as (
  select
    date_trunc('month', U.timestamp)::date as cohort_month,
    id as user_id
  from users U
  order by 1, 2
)
