{{ config(
    materialized='table'
) }}

SELECT 
    DISTINCT person_id,
    has_diabetes,
    has_hypertension,
    has_heart_disease
FROM {{ ref('stg_health_data') }}
