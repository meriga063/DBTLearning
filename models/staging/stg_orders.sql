
with source as (
    select * from raw.jaffle_shop.orders
),
renamed as (
    select id as order_id,
    user_id as cust_id,
    status,
    ORDER_DATE 
    from source
)
select * from renamed