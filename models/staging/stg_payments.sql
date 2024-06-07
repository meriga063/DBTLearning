{{config
   ( materialized = 'table')
}}
with source as (
    select * from raw.stripe.payment
),
renamed as (
    select id as payment_d, 
    orderid,
    amount/100 as amount
    from source
)
select * from renamed
