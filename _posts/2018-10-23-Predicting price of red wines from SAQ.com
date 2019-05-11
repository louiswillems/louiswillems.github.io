---
layout: post
title: Predicting price of red wines from SAQ.com (Société des alcools du Québec)
---
<br>
<br>
In this post, we will build our content based model in the cloud. Train our model in the cloud will allow us to train on large amounts of data and without having to manage any infrastructure.
We will use Cloud ML Engine to train our content-based model DNN in TensorFlow.
In order to do this, we need to put our code into a Python package (i.e. add setup.py and __init__.py files) and we will organize our code into:
* model.py
* task.py.
<br>
<br>
<br>

<img height="220" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prediction.png" src="/public/saq_prediction.png">
<br>
<br>
## 1. Submitting a job to ML Engine
task.py will be executed by ML Engine and it references our content-based model logic located in model.py.
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
