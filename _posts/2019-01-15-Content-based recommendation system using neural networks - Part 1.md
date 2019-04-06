---
layout: post
title: Content-based recommendation system using neural networks - Part 1
---

This post builds the data we will use for creating our content based model. We'll collect the data via a collection of SQL queries from a Google Analytics dataset in BigQuery.
Our goal is to recommend an article for a visitor (Client ID) to our site.

In this notebook we will illustrates
* how to pull data from BigQuery for our recommendation system
* how to create train and test sets

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

We will use this helper funciton to write lists containing article ids, categories, and authors for each article in our database to local file.

```sql
def write_list_to_disk(my_list, filename):
  with open(filename, 'w') as f:
    for item in my_list:
        line = "%s\n" % item
```

## Pull data from BigQuery
<br>
### create content_ids.txt
The cell below creates a local text file containing all the article ids (i.e. 'content ids') in the dataset.


```sql
import google.datalab.bigquery as bq
sql="""
#standardSQL
SELECT
   (SELECT MAX(IF(index=15, value, NULL)) FROM UNNEST(hits.customDimensions)) AS content_id
FROM `quebecor-numerique.94833147.ga_sessions_20190328`,   
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
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
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
### create categories.txt
The cell below creates a local text file containing all categories

```sql
sql="""
SELECT  
  (SELECT MAX(IF(index=15, value, NULL)) FROM UNNEST(hits.customDimensions)) AS category 
FROM `quebecor-numerique.94833147.ga_sessions_20190328`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND (SELECT MAX(IF(index=15, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
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
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY
  category
"""
categories_list = bq.Query(sql).execute().result().to_dataframe()['category'].tolist()
write_list_to_disk(categories_list, "categories.txt")
print(categories_list)

```
<br>

### create authors_list.txt
The cell below creates a local text file containing all authors

```sql
sql="""
#standardSQL
SELECT
  REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+")  AS first_author  
FROM `quebecor-numerique.94833147.ga_sessions_20190328`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND (SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
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
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY   
  first_author
"""
authors_list = bq.Query(sql).execute().result().to_dataframe()['first_author'].tolist()
write_list_to_disk(authors_list, "authors.txt")
print("Some sample authors {}".format(authors_list[:10]))
print("The total number of authors is {}".format(len(authors_list)))
```

### authors_list
The cell below creates a local text file containing all authors

```sql
sql="""
#standardSQL
SELECT
  REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+")  AS first_author  
FROM `quebecor-numerique.94833147.ga_sessions_20190328`,   
  UNNEST(hits) AS hits
WHERE 
  # only include hits on pages
  hits.type = "PAGE"
  AND (SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
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
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%;%'
  AND REGEXP_EXTRACT((SELECT MAX(IF(index=11, value, NULL)) FROM UNNEST(hits.customDimensions)), r"^[^,|\/|;]+") NOT LIKE '%&nbsp%'
  AND hits.page.pagePath LIKE '%2019%'
GROUP BY   
  first_author
"""
authors_list = bq.Query(sql).execute().result().to_dataframe()['first_author'].tolist()
write_list_to_disk(authors_list, "authors.txt")
print("Some sample authors {}".format(authors_list[:10]))
print("The total number of authors is {}".format(len(authors_list)))
```
