{{ config(
    materialized='table'
) }}

SELECT 
    DISTINCT person_id,
    country
FROM {{ ref('stg_health_data') }}
