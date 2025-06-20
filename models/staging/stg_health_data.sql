-- models/staging/stg_health_data.sql

SELECT
    person_id,
    gender,
    age,
    INITCAP(country) AS country,
    sleep_hours,
    exercise_minutes,
    junk_food_freq,
    has_diabetes,
    has_hypertension,
    has_heart_disease,
    record_date
FROM {{ source('raw', 'raw_health_data') }}
