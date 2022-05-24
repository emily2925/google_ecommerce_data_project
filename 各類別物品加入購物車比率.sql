--撈出各類別物品的add_to_cart相異人數/view_item相異人數
WITH cart_tab as (
  SELECT case when REGEXP_CONTAINS(unn_items.item_category, r'T-Shirts|Apparel|Hats|Men|Women|Unisex') then 'Apparel'
        when REGEXP_CONTAINS(unn_items.item_category, r'Bags|Backpacks') then 'Bag'
        when REGEXP_CONTAINS(unn_items.item_category, r'Sale') then 'Sale'
        when REGEXP_CONTAINS(unn_items.item_category, r'Drinkware|Water Bottles') then 'Drinkware'
        when REGEXP_CONTAINS(unn_items.item_category, r'Stationery') then 'Stationery'
        when REGEXP_CONTAINS(unn_items.item_category, r'Notebooks') then 'Notebooks'
        when REGEXP_CONTAINS(unn_items.item_category, r'Campus Collection') then 'Campus Collection'
        when REGEXP_CONTAINS(unn_items.item_category, r'Eco-Friendly') then 'Eco-Friendly'
        when REGEXP_CONTAINS(unn_items.item_category, r'New') then 'New'
        when REGEXP_CONTAINS(unn_items.item_category, r'Youtube') then 'Youtube'
        when REGEXP_CONTAINS(unn_items.item_category, r'Kids') then 'Kids'
        when REGEXP_CONTAINS(unn_items.item_category, r'Google') then 'Google'
        ELSE 'Others' end as item_category_clean,
        count(distinct user_pseudo_id) as user_num
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS unn_items
  WHERE event_name in ("add_to_cart")
  GROUP BY 1
),
view_tab as (
  SELECT case when REGEXP_CONTAINS(unn_items.item_category, r'T-Shirts|Apparel|Hats|Men|Women|Unisex') then 'Apparel'
        when REGEXP_CONTAINS(unn_items.item_category, r'Bags|Backpacks') then 'Bag'
        when REGEXP_CONTAINS(unn_items.item_category, r'Sale') then 'Sale'
        when REGEXP_CONTAINS(unn_items.item_category, r'Drinkware|Water Bottles') then 'Drinkware'
        when REGEXP_CONTAINS(unn_items.item_category, r'Stationery') then 'Stationery'
        when REGEXP_CONTAINS(unn_items.item_category, r'Notebooks') then 'Notebooks'
        when REGEXP_CONTAINS(unn_items.item_category, r'Campus Collection') then 'Campus Collection'
        when REGEXP_CONTAINS(unn_items.item_category, r'Eco-Friendly') then 'Eco-Friendly'
        when REGEXP_CONTAINS(unn_items.item_category, r'New') then 'New'
        when REGEXP_CONTAINS(unn_items.item_category, r'Youtube') then 'Youtube'
        when REGEXP_CONTAINS(unn_items.item_category, r'Kids') then 'Kids'
        when REGEXP_CONTAINS(unn_items.item_category, r'Google') then 'Google'
        ELSE 'Others' end as item_category_clean,
        count(distinct user_pseudo_id) as user_num
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS unn_items
  WHERE event_name in ("view_item")
  GROUP BY 1
)

select v.item_category_clean, c.user_num/v.user_num as cart_view_ratio
from view_tab v
left join cart_tab c
on v.item_category_clean = c.item_category_clean
order by 2 DESC
