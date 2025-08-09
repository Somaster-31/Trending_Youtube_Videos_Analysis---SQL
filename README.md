
# 📊 Trending YouTube Videos Analysis – SQL Project

## 📌 Overview

This project focuses on analyzing **YouTube trending videos** using SQL. It demonstrates skills in **data cleaning**, **preprocessing**, and **insight generation** through SQL queries. The dataset includes metadata such as video details, engagement metrics, and category information.

## 📂 Dataset

* **Source:** `TrendingYTVideos.csv`
* **Columns:**

  * Video ID, Channel ID & Title
  * Publish Date & Time
  * Video Title & Description
  * Category ID & Label
  * Duration (string & seconds)
  * Definition (HD/SD)
  * Engagement Metrics: Views, Likes, Dislikes, Comments

## 🛠️ Steps Performed

### 1️⃣ Data Cleaning & Preprocessing

* Converted **published\_datetime** into separate `DATE` and `TIME`.
* Replaced `NULL` in likes, dislikes, and comments with **0**.
* Removed rows with missing `videoId`, `viewCount`, or `durationSec`.

### 2️⃣ Video Engagement & Popularity Analysis

* Top 10 most viewed videos.
* Top 5 most liked videos.
* Engagement Rate: `(likes + dislikes + comments) per 1000 views`.
* Average views by category.
* Comparison of views between **short** (<5 min) and **long** (>15 min) videos.

### 3️⃣ Content & Category Trends

* Most common video category.
* View distribution between HD & SD videos.
* Top categories by total engagement.
* Daily uploads trend.

### 4️⃣ Advanced SQL Queries

* **Engagement Leaders**: Top video per category using `RANK()`.
* **Peak Upload Time**: Most common upload hour.
* **Performance Outliers**: Videos with unusually high likes per category.
* **High Engagement Flag**: Videos with high view-to-like ratios.

## 📈 Skills Demonstrated

* Data Cleaning & Transformation in SQL
* Aggregations & Grouping
* Window Functions (`RANK()`, `DENSE_RANK()`)
* Conditional Logic with `CASE`
* Date & Time Manipulation
* Analytical Query Writing

## 🚀 How to Run

1. Load the dataset into your SQL database.
2. Execute the provided SQL script (`Task 1.sql`).
3. Explore the generated insights.

