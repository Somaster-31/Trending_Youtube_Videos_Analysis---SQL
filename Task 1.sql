-- FINAL EVALUATION PROJECT - SQL
-- TOPIC : TRENDING YOUTUBE VIDEOS ANALYSIS

-- INITIAL QUERY

create table trending_videos_data(y_id int, ch_id varchar,ch_title varchar,v_id varchar, 
published_datetime timestamp,v_title varchar,v_desc varchar,
v_category_id int,v_category_label varchar,v_duration varchar,v_duration_sec int,
v_definition varchar,is_caption varchar,view_count int,
like_count int,dislike_count int,comment_count int);

copy trending_videos_data(y_id, ch_id, ch_title, v_id, published_datetime, 
v_title, v_desc, v_category_id, 
v_category_label, v_duration, v_duration_sec, v_definition, is_caption, 
view_count, like_count, dislike_count, comment_count) 
from 'F:\Data_Science_Cuvette_Course_Materials\PROJECTS_AddGITHUB\CAPSTONE_PROJECT\TrendingYTVideos.csv' delimiter ',' csv header;

-- QUESTIONS
-- ● Data Cleaning And Preprocessing 
-- ○ Convert publishedAt into DATE and TIME using SQL date functions.
select date(published_datetime) as DATE,
published_datetime:: timestamp:: time as TIME from trending_videos_data;

-- ○ Replace missing values in likeCount, dislikeCount, and commentCount with 0 or filter them out. 
update trending_videos_data set like_count = 0 where like_count is null;
update trending_videos_data set dislike_count = 0 where dislike_count is null;
update trending_videos_data set comment_count = 0 where comment_count is null;

-- ○ Remove videos with null or missing videoId, viewCount, or durationSec. 
delete from trending_videos_data
where v_id is null or view_count is null or v_duration_sec is null;

-- ● Video Engagement And Popularity Analysis 
-- ○ Top 10 Most Viewed Videos: Based on viewCount.
select *, view_count from trending_videos_data
order by view_count desc
limit 10;

-- ○ Top 5 Most Liked Videos: Based on likeCount.
select *, like_count from trending_videos_data
order by like_count desc
limit 5;

-- ○ Engagement Rate: Calculate likes + dislikes + comments per 1000 views.
select *, like_count + dislike_count + comment_count 
as engagement_rate
from trending_videos_data
where view_count>=1000;

-- ○ Average Views By Category: Group by videoCategoryLabel and calculate average viewCount. 
select v_category_label, round(avg(view_count),2) from trending_videos_data
group by v_category_label;

-- ○ Short VS Long Video Views: Compare average views for: 
-- ■ Short videos (durationSec < 300) 
-- ■ Long videos (durationSec > 900) 
select
    avg(case when v_duration_sec < 300 then view_count end) as avg_views_short_videos,
    avg(case when v_duration_sec > 900 then view_count end) as avg_views_long_videos
from trending_videos_data;

-- ● Content And Category Trends 
-- ○ Most Common Video Category: Category with the highest number of videos.
select v_category_label as common_video_category, count(*) as video_counts 
from trending_videos_data
group by v_category_label
order by 2 desc limit 1;

-- ○ View Distribution By Definition: Compare views between HD and SD videos. 
select v_definition, sum(view_count) as total_views, count(*) as video_count
from trending_videos_data
where v_definition in ('hd', 'sd')
group by v_definition
order by total_views desc;

-- ○ Top Categories By Total Engagement: Sum of likes + comments grouped by category.
select v_category_label, sum(like_count + comment_count) 
as total_engagement
from trending_videos_data
group by 1;

-- ○ Daily Uploads Trend: Extract upload day from publishedAt and count uploads per day.
select date(published_datetime) as upload_day,
count(*) as uploads_count
from trending_videos_data
group by date(published_datetime)
order by upload_day;

-- ● Advanced SQL Queries 
-- ○ Engagement Leaders: Use window functions (RANK() or DENSE_RANK()) 
-- to find the top video per category by engagement. 
select *,rank() over (partition by v_category_label 
order by view_count+like_count+dislike_count+comment_count desc) 
as top_video_by_engagement
from trending_videos_data;

-- ○ Trending Time Analysis: Extract upload hour and find the peak time range for video uploads. 
select extract(hour from published_datetime) as upload_hour,
count(*) as uploads_count
from trending_videos_data
group by 1
order by uploads_count desc
limit 1;

-- ○ Performance Outliers: Find videos with a likeCount significantly higher than 
-- the average for their category. 
select v_id, v_title, v_category_label, like_count,avg_likes
from (select v_id, v_title, v_category_label, like_count,
round(avg (like_count) over (partition by v_category_label)) as avg_likes
from trending_videos_data) sub
where like_count > avg_likes;

-- ○ Boolean Flag: Create a flag for videos where viewCount > 10000 AND 
-- likeCount/viewCount > 0.1 → “High Engagement”.
select v_id, v_title, view_count, like_count, 
case when view_count>10000 and view_count/like_count>0.1
then 'High Engagement'
else 'Low Engagement'
end as flag_column
from trending_videos_data;

