{{ config(
    materialized='table'
) }}

SELECT 
    DISTINCT person_id,
    gender,
    age
FROM {{ ref('stg_health_data') }}
