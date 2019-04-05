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
        

