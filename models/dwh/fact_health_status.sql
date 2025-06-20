{{ config(
    materialized='table'
) }}

WITH base AS (
    SELECT
        s.person_id,
        s.record_date,

        CASE WHEN s.sleep_hours < 6 THEN 1 ELSE 0 END AS low_sleep_flag,
        CASE WHEN s.exercise_minutes < 30 THEN 1 ELSE 0 END AS low_exercise_flag,
        CASE WHEN s.junk_food_freq > 4 THEN 1 ELSE 0 END AS high_junk_food_flag,
        CASE WHEN s.age > 60 THEN 1 ELSE 0 END AS old_age_flag,
        (
            CASE WHEN s.sleep_hours < 6 THEN 1 ELSE 0 END +
            CASE WHEN s.exercise_minutes < 30 THEN 1 ELSE 0 END +
            CASE WHEN s.junk_food_freq > 4 THEN 1 ELSE 0 END +
            CASE WHEN s.age > 60 THEN 1 ELSE 0 END
        ) AS risk_score
    FROM {{ ref('stg_health_data') }} s
),

joined AS (
    SELECT 
        b.person_id,
        dp.gender,
        dp.age,
        dl.country,
        dd.has_diabetes,
        dd.has_hypertension,
        dd.has_heart_disease,
        b.record_date,
        b.low_sleep_flag,
        b.low_exercise_flag,
        b.high_junk_food_flag,
        b.old_age_flag,
        b.risk_score
    FROM base b
    LEFT JOIN {{ ref('dim_person') }} dp ON b.person_id = dp.person_id
    LEFT JOIN {{ ref('dim_location') }} dl ON b.person_id = dl.person_id
    LEFT JOIN {{ ref('dim_disease') }} dd ON b.person_id = dd.person_id
)

SELECT * FROM joined

