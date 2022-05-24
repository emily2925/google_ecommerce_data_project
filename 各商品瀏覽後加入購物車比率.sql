WITH cart_tab as (
      select unn_items.item_name,
      count(distinct user_pseudo_id) as user_num
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS unn_items
  WHERE event_name in ("add_to_cart")
  and unn_items.item_name not in ("(not set)", "Google 5K Run 2020 Unisex Tee")
  GROUP BY 1
),
view_tab as (
  SELECT unn_items.item_name,
        count(distinct user_pseudo_id) as user_num
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(items) AS unn_items
  WHERE event_name in ("view_item")
  and unn_items.item_name not in ("(not set)", "Google 5K Run 2020 Unisex Tee")
  GROUP BY 1
)

select v.item_name, c.user_num/v.user_num as cart_view_ratio
from view_tab v
left join cart_tab c
on v.item_name = c.item_name
order by 2 DESC
