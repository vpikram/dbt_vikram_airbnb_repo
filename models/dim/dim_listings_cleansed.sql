with src_listings as (
    select *
    from {{ ref('src_listings') }}  //Jinja template syntax is used here to reference the 'src_listings' model in dbt. This allows for dynamic referencing of models and ensures that the correct version of the model is used during execution.
)

Select
    listing_id,
    listing_name,
    room_type,
    case
        when minimum_nights = 0 then 1
        else minimum_nights
    end as minimum_nights,
    host_id,
    replace(price_str, '$', '')::number(10, 2) as price,
    created_at,
    updated_at
from src_listings
