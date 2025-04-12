-- 10 Questions
-- 1 Find number of business in each category
with cte as (
select business_id, A.value as category from tbl_yelp_businesses, lateral split_to_table(categories, ',') A 
)

select category, count(*) no_of_business
from cte
group by 1
order by 2 desc;

-- 2. Find the top 10 users who have reviewed the most business in the Restuarants category
select * from tbl_yelp_reviews limit 100;

select r.user_id, count(distinct r.business_id)  as business 
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
where b.categories ilike '%restaurants%'
group by 1
order by 2 desc
limit 10;

-- 3. Find the most popular categories of business (based on the number of reviews)
with cte as (
select business_id, A.value as category from tbl_yelp_businesses, lateral split_to_table(categories, ',') A 
)
select category, count(*) as no_of_reviews from cte 
inner join tbl_yelp_reviews r on cte.business_id=r.business_id
group by 1
order by 2 desc;

-- 4. find the top 3 most recent reviews for each business
with cte as (
select r.*, b.name,
row_number() over(partition by r.business_id order by review_date desc) as rn 
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
)
select * from cte 
where rn<=3;

-- 5. find the month with the highest number of reviews
select month(review_date) as review_month, count(*) as no_of_reviews
from tbl_yelp_reviews 
group by 1
order by 2 desc;

-- 6. Find the percentage of 5-star reviews for each business
select b.business_id, b.name, count(*) as total_reviews,
sum(case when r.review_stars = 5 then 1 else 0 end ) as star5_reviews,
star5_reviews*100/total_reviews as percent_5_star
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
group by 1,2
limit 100

-- 7. find the top 5 most reviewed businesses in each city
with cte as (
select b.city, b.business_id, b.name, count(*) as total_reviews,

from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
group by 1,2, 3)

select *
from cte
qualify row_number() over(partition by city order by total_reviews) <= 5

-- 8. Find the average rating of business that have at least 100 reviews
select b.business_id, b.name, count(*) as total_reviews,
avg(review_stars) as avg_rating
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
group by 1, 2
having count(*) >= 100

-- 9. list the top 10 users who have written the most reviews, along the business they reviewed
select r.user_id, count(*) as total_reviews
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
group by 1
order by 2 desc
limit 10

-- 10.find the top 10 business with highest positive sentiment reviews
select r.user_id, count(*) as total_reviews
from tbl_yelp_reviews r
inner join tbl_yelp_businesses b on r.business_id = b.business_id
where sentments = 'Positive'
group by 1
order by 2 desc
