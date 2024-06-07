with customers as (
    select * from {{ref('stg_customers')}}
),
orders as (
    select * from {{ ref('stg_orders')}}
),

customer_orders as (
    select cust_id,
    min(ORDER_DATE) as first_order,
    max(ORDER_DATE) as recent_order,
    count(order_id) as no_of_orders
    from orders
    group by 1
),
final as (
    select customers.CUST_ID,
    customers.FIRST_NAME,
    customers.LAST_NAME,
    customer_orders.first_order,
    customer_orders.recent_order,
    case 
        when recent_order <= '2018-01-15' then 'Churned' 
        when recent_order <= '2018-03-01' then 'Chun Risk'
        else 'Healty'
    end as customer_status,
    customer_orders.no_of_orders
    from customers
    left join customer_orders
        on customers.cust_id = customer_orders.cust_id
)
select * from final