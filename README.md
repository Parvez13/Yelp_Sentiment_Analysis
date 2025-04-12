# 🧠 Yelp Reviews Analysis using Snowflake, Python, AWS S3

## 📌 Objective
To analyze Yelp review data using cloud-native architecture, perform sentiment analysis, and derive insights with SQL.
![Project_workflow](https://github.com/user-attachments/assets/25dc0535-bd70-4572-9609-57081e72a2a3)


## 🔧 Tech Stack
- Python (data processing, TextBlob for sentiment)
- Snowflake (data warehousing, analytics)
- AWS S3 (external staging for Snowflake)
- SQL (business insights)

## 📁 Process Overview
1. Downloaded and extracted `review.json` from the Yelp dataset.
2. Split into 40 smaller JSON files using Python.
3. Uploaded all parts to AWS S3.
4. Created external stage and loaded data into Snowflake.
5. Performed sentiment analysis using TextBlob.
6. Ran 10 analytical SQL queries to extract business insights.

## 📊 Sample Queries
- Top 10 rated businesses by review count
- Monthly trend of positive vs. negative reviews
- Cities with highest average star ratings
- Most active users by review count

## 📈 Sentiment Analysis
Classified reviews into Positive, Neutral, and Negative categories using Python’s TextBlob.

## 📎 Folder Structure
- `scripts/`: All Python scripts for splitting and sentiment analysis
- `sql_queries/`: SQL scripts used in Snowflake
