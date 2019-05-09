---
layout: post
title: Content-based recommendation system using neural networks - Part 1
--- 
<br>
<br>
<br>
This post builds the data we will use for creating our content based model. We'll collect the data via a collection of SQL queries from a Google Analytics dataset in BigQuery.
Our goal is to recommend an article for a visitor (Client ID) to our site.

In this notebook we will illustrates
* how to pull data from BigQuery for our recommendation system
* how to create train and test sets

<br>
<br>

<img height="200" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="https://cdn-images-1.medium.com/max/1200/1*A8liBoeAwAZg7rDu394jYg.png" src="https://cdn-images-1.medium.com/max/1200/1*A8liBoeAwAZg7rDu394jYg.png">
<br>

```sql
import os
import tensorflow as tf
import numpy as np
import google.datalab.bigquery as bq

PROJECT = 'PROJECT' # REPLACE WITH YOUR PROJECT ID
BUCKET = 'BUCKET' # REPLACE WITH YOUR BUCKET NAME
REGION = 'us-central1' # REPLACE WITH YOUR BUCKET REGION e.g. us-central1

# do not change these
os.environ['PROJECT'] = PROJECT
os.environ['BUCKET'] = BUCKET
os.environ['REGION'] = REGION
os.environ['TFVERSION'] = '1.8'


gcloud  config  set project $PROJECT
gcloud config set compute/region $REGION
```

We will use this helper function to write lists containing article ids, categories, and authors for each article in our database to local file.

```sql
def write_list_to_disk(my_list, filename):
  with open(filename, 'w') as f:
    for item in my_list:
        line = "%s\n" % item
```
<br>
<br>
## 1. Pull data from BigQuery
<br>
### <strong>a) content_ids.txt</strong>

The cell below creates a local text file containing all the article ids (i.e. 'content ids') in the dataset which is basically a custom dimension in Google Analytics.


```sql
import google.datalab.bigquery as bq
sql="""
#standardSQL
SELECT
   (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS content_id
FROM `<PROJECT><DATASET><TABLE>`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND hits.page.pagePath IS NOT NULL
    AND
        hits.type = "PAGE"
      AND
      fullVisitorId IS NOT NULL
      AND
      hits.time != 0
      AND
      hits.time IS NOT NULL
  AND hits.page.pagePath NOT LIKE '%,%'
  AND hits.page.pagePath NOT LIKE '%?%'
  AND hits.page.pagePath != '/'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY
  content_id
"""
content_ids_list = bq.Query(sql).execute().result().to_dataframe()['content_id'].tolist()
write_list_to_disk(content_ids_list, "content_ids.txt")
print("Some sample content IDs {}".format(content_ids_list[:3]))
print("The total number of articles is {}".format(len(content_ids_list)))
```
<br>
### <strong>b) categories.txt</strong>
The cell below creates a local text file containing all categories which are a custom dimension in Google Analytics.

```sql
sql="""
SELECT  
  (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS category 
FROM `<PROJECT><DATASET><TABLE>`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
    AND
        hits.type = "PAGE"
      AND
      fullVisitorId IS NOT NULL
      AND
      hits.time != 0
      AND
      hits.time IS NOT NULL
  AND hits.page.pagePath IS NOT NULL
  AND hits.page.pagePath NOT LIKE '%,%'
  AND hits.page.pagePath NOT LIKE '%?%'
  AND hits.page.pagePath != '/'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY
  category
"""
categories_list = bq.Query(sql).execute().result().to_dataframe()['category'].tolist()
write_list_to_disk(categories_list, "categories.txt")
print(categories_list)

```
<br>

### <strong>c) authors_list.txt</strong>
The cell below creates a local text file containing all authors which are in a custom dimension too.

```sql
sql="""
#standardSQL
SELECT
  REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+")  AS first_author  
FROM `<PROJECT><DATASET><TABLE>`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
  AND
        hits.type = "PAGE"
      AND
      fullVisitorId IS NOT NULL
      AND
      hits.time != 0
      AND
      hits.time IS NOT NULL
  AND hits.page.pagePath IS NOT NULL
  AND hits.page.pagePath NOT LIKE '%,%'
  AND hits.page.pagePath NOT LIKE '%?%'
  AND hits.page.pagePath != '/'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY   
  first_author
"""
authors_list = bq.Query(sql).execute().result().to_dataframe()['first_author'].tolist()
write_list_to_disk(authors_list, "authors.txt")
print("Some sample authors {}".format(authors_list[:10]))
print("The total number of authors is {}".format(len(authors_list)))
```
<br>
### <strong>d) medium</strong>
The cell below creates a local text file containing all values for medium dimension in Google Analytics.

```sql
sql="""
#standardSQL
SELECT
  trafficSource.medium  AS medium
FROM `<PROJECT><DATASET><TABLE>`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND (SELECT MAX(IF(<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
  AND
        hits.type = "PAGE"
      AND
      fullVisitorId IS NOT NULL
      AND
      hits.time != 0
      AND
      hits.time IS NOT NULL
  AND hits.page.pagePath IS NOT NULL
  AND hits.page.pagePath NOT LIKE '%,%'
  AND hits.page.pagePath NOT LIKE '%?%'
  AND hits.page.pagePath != '/'
  AND REGEXP_EXTRACT((SELECT MAX(IF(<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY   
  medium
"""
medium_list = bq.Query(sql).execute().result().to_dataframe()['medium'].tolist()
write_list_to_disk(medium_list, "medium.txt")
print("Some sample authors {}".format(medium_list[:10]))
print("The total number of authors is {}".format(len(medium_list)))
```
<br>
<br>
## 2. Create train and test sets.
<br>
### <strong>Training set</strong>
In this section, we will create the train/test sdatasets for training and test our model. We will concatenate values for visitor_id (fullVisitorId in Google Analytics) and content_id to create a farm fingerprint, taking 90% of the data for the training set. This request will return, for each visitor_id, the content_id, category, author, medium but also the next_content_id. 

```sql
sql="""
WITH site_history as (
SELECT
      fullVisitorId as visitor_id,
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS content_id,
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS title,
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS author_list,
      SPLIT(RPAD((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), 7), '-') as year_month_array,
      LEAD((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), 1) OVER (PARTITION BY fullVisitorId ORDER BY hits.time ASC) as nextCustomDimensions,
      trafficSource.medium AS medium,
  FROM 
    `<PROJECT><DATASET><TABLE>`,   
     UNNEST(hits) AS hits
   WHERE 
     # only include hits on pages
      hits.type = "PAGE"
      AND
      fullVisitorId IS NOT NULL
      AND
      hits.time != 0
      AND
      hits.time IS NOT NULL
      AND
      hits.page.pagePath IS NOT NULL
      AND
      hits.page.pagePath NOT LIKE '%,%'
     AND hits.page.pagePath NOT LIKE '%?%'
     AND hits.page.pagePath != '/'
      AND
      SPLIT(RPAD((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), 7), '-') IS NOT NULL
      AND
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
      AND
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL

  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
      
)
SELECT
  visitor_id,
  content_id,
  medium,
  REGEXP_REPLACE(title, r",", "") as title,
  REGEXP_EXTRACT(author_list, r"^[^,]+") as author,
  DATE_DIFF(DATE(CAST(year_month_array[OFFSET(0)] AS INT64), CAST(year_month_array[OFFSET(1)] AS INT64), 1), DATE(1970,1,1), MONTH) as months_since_epoch,
  nextCustomDimensions as next_content_id
FROM
  site_history
WHERE nextCustomDimensions IS NOT NULL AND
MOD(ABS(FARM_FINGERPRINT(CONCAT(visitor_id, content_id))), 10 ) < 9

"""

training_set_df = bq.Query(sql).execute().result().to_dataframe()
training_set_df.to_csv('training_set.csv', header=False, index=False, encoding='utf-8')
training_set_df.head()
```
<br>
### <strong>Test set</strong>
We will repeat the query as above but change outcome of the farm fingerprint hash to collect the remaining 10% of the data for the test set. 

```sql
sql="""
WITH site_history as (
SELECT
      fullVisitorId as visitor_id,
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS content_id,
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS title,
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) AS author_list,
      SPLIT(RPAD((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), 7), '-') as year_month_array,
      LEAD((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), 1) OVER (PARTITION BY fullVisitorId ORDER BY hits.time ASC) as nextCustomDimensions,  
      trafficSource.medium AS medium,
  FROM 
    `<PROJECT><DATASET><TABLE>`,   
     UNNEST(hits) AS hits
   WHERE 
     # only include hits on pages
      hits.type = "PAGE"
      AND
      fullVisitorId IS NOT NULL
      AND
      hits.time != 0
      AND
      hits.time IS NOT NULL
      AND
      hits.page.pagePath IS NOT NULL
      AND
      hits.page.pagePath NOT LIKE '%,%'
      AND hits.page.pagePath NOT LIKE '%?%'
      AND hits.page.pagePath != '/'
      AND
      SPLIT(RPAD((SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)), 7), '-') IS NOT NULL
      AND
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
      AND
      (SELECT MAX(IF(index=<YOUR INDEX>, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
      
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
)
SELECT
  visitor_id,
  content_id,
  medium,
  REGEXP_REPLACE(title, r",", "") as title,
  REGEXP_EXTRACT(author_list, r"^[^,]+") as author,
  DATE_DIFF(DATE(CAST(year_month_array[OFFSET(0)] AS INT64), CAST(year_month_array[OFFSET(1)] AS INT64), 1), DATE(1970,1,1), MONTH) as months_since_epoch,
  nextCustomDimensions as next_content_id
FROM
  site_history
WHERE nextCustomDimensions IS NOT NULL
AND MOD(ABS(FARM_FINGERPRINT(CONCAT(visitor_id, content_id))), 10) >= 9
"""

test_set_df = bq.Query(sql).execute().result().to_dataframe()
test_set_df.to_csv('test_set.csv', header=False, index=False, encoding='utf-8')
```
