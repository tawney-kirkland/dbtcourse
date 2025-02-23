{{ config( 
    materialized='view'
) }}

WITH src_listings AS (
    SELECT * FROM {{ ref("src_listings") }}
)

SELECT
    listing_id,
    listing_name,
    listing_url,
    room_type,
    CASE
        WHEN minimum_nights = 0 THEN 1
        ELSE minimum_nights
    END AS minimum_nights,
    host_id,
    REPLACE(price_str, '$'
    ):: NUMBER (
        10,
        2
    ) AS price,
    price_str,
    created_at,
    updated_at
FROM
    src_listings