{{
config(
    materialized='incremental',
    on_schema_change='fail'
)
}}

with src_reviews as (
    select * from {{ ref('src_reviews') }}
)

Select * from src_reviews
Where
    review_text is not null
    {% if is_incremental() %}
        and review_date > (select max(review_date) from {{ this }})
    {% endif %}
