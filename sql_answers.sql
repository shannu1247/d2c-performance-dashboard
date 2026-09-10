-- BI Intern Assignment - SQL tasks
-- Tables are the 4 sheets from the workbook. orders.MRP is the per unit list price.


-- QS1

select c.customer_segment,
       count(*) as total_orders,
       round(avg(o.MRP), 2) as avg_MRP
from orders o
join customers c on o.customer_id = c.customer_id
group by c.customer_segment
order by total_orders desc;


-- QS2
-- discount changes by channel, so join on product_name AND channel

select o.product_name,
       round(sum(o.quantity * o.MRP * (1 - p.discount_pct/100.0)), 2) as total_revenue
from orders o
join product_pricing p
  on o.product_name = p.product_name
 and o.channel = p.channel
group by o.product_name
order by total_revenue desc;


-- QS3
-- only the product/channel combos that were actually ordered

select o.channel,
       count(*) as total_orders,
       round(avg(p.discount_pct), 2) as avg_discount_pct,
       round(sum(o.quantity * o.MRP * p.discount_pct/100.0), 2) as discount_given
from orders o
join product_pricing p
  on o.product_name = p.product_name
 and o.channel = p.channel
group by o.channel
order by avg_discount_pct desc;

-- Amazon, 17.43% avg discount across 7 orders (App is lowest at 5.53%). Same answer by value.
