WITH source AS (
    SELECT 
        id AS customer_id,
        json_data:name::STRING AS customer_name,
        json_data:age::INTEGER AS customer_age,
        orders.value:id::INTEGER AS order_id,
        orders.value:total::FLOAT AS order_total
    FROM {{ source('source_db', 'raw') }},

    LATERAL FLATTEN(input => json_data:orders) orders
)
SELECT * FROM source