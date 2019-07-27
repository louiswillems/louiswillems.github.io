---
layout: post
title: Text Data Visualization with Google Analytics
---

<br>
<br>
In this post, we will build a scatterplot tool for text. For this, we'll collect the data from the publicly available Kurier.at dataset in BigQuery. Kurier.at is an Austrian newsite.

We will upload a sample of Google Analytics data from this news site, This sample contains page tracking events.

The goal of post is to create a text data visualization tool that is intended visualizing most frequents words of most and least reads news articles.

This notebook illustrates how to:

* Pull data from Bigquery
* Use a pre-trained statistical models in German with Spacy
* Visualize words frequency vs popularity of articles

<br>
<br>
<br>

<img height="460" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prediction.JPG" src="/public/scattertext_example.png">
<br>
<br>



## 1. Pull data from Bigquery
<br>
#### Kurier.at Google Analytics sample dataset from BigQuery
The query contains 2 columns, first column “headline” shows the title of the articles news and the second column is the number of Pagesviews for each article
<br>
```python
%matplotlib inline
import matplotlib.pyplot as plt
import scattertext as st
import re, io
from pprint import pprint
import pandas as pd
import numpy as np
from scipy.stats import rankdata, hmean, norm
import spacy
import os, pkgutil, json, urllib
from urllib.request import urlopen
from IPython.display import IFrame
from IPython.core.display import display, HTML
from scattertext import CorpusFromPandas, produce_scattertext_explorer
```
<br>
```python
project_id = <YOUR PROJECT FROM GCP>

df_bq = pd.io.gbq.read_gbq('''
#standardSQL
SELECT
(SELECT MAX(IF(index=6, value, NULL)) FROM UNNEST(hits.customDimensions)) AS headline,
  SUM(totals.pageviews) AS Pageviews
FROM
  `cloud-training-demos.GA360_test.ga_sessions_sample`,
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
      (SELECT MAX(IF(index=10, value, NULL)) FROM UNNEST(hits.customDimensions)) IS NOT NULL
GROUP BY
  headline
ORDER BY
  Pageviews DESC
''', project_id=project_id, verbose=False, dialect='standard')
print(df_bq.shape)
```
<br>
## 2. NLP with Spacy
<br>
#### Load Spacy Language Model
For this step you have to ensure that spacy is installed on your notebook and then you load the german language model
```python
!pip install scattertext
!python -m spacy download de_core_news_md

import spacy
import de_core_news_md
from spacy.lang.de import German

nlp = de_core_news_md.load()
```

<br>

## 3. Visualize words frequency vs popularity of articles
<br>
#### Set a threshold
Before we plot our text data visualization tool, we need to set a threshold for our pageviews in order to split our data into most pupular and less populars news articles
<br>

```python

threshold = 100

# Copy
data = df_bq.copy()

# Max Pageviews
max = data['pageviews'].max()

# binned
custom_bucket_array= [0, threshold, max]
labels = ['least reads','most reads']

data['binned'] = pd.cut(data['pageviews'], bins=custom_bucket_array, labels=labels)
data['binned'].apply(pd.to_numeric, errors='coerce')

# drop NA
data.dropna(inplace=True)

fig = plt.figure(figsize=(8,6))
data.groupby('binned').headline.count().plot(kind='barh', zorder=2, width=0.85)
plt.show()
```
<br>
<br>
<img height="570" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/most_least_reads.JPG" src="/public/saq_prices.JPG">
<br>
<br>




```python
# Let's clean the data. First, let's check if there are any null values in the dataframe.
are_null_values = df.isnull().values.any()
num_nulls = df.isnull().sum()
print("Shape:\n",df.shape)
print("Columns with null values:\n",num_nulls)
print("Number of observations:\n",len(df))
```

```python
#Remove duplicates & Missing values 
data = df.drop_duplicates("Name") # drop duplicate descriptions
data = data[['Country', 'Region','Designation','Price', 'Producer','Alcohol']]
df_clean = data.dropna()
```
```python
data_less_outliers = data[df_clean["Price"] < 1000]
data_less_outliers.Price.plot(kind = 'hist', bins = 100, color = "#3F5D7D", fontsize=12)
```
<br>
Actually, there are some pretty expensive wines in the dataset. In fact, 90 % of the data comes in below 100 dollars. So, we will remove these more expensive wines and predict red wine prices.
<br>
<br>
<br>
<img height="570" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_country_price.jpg" src="/public/saq_country_price.jpg">
<br>
<br>
<img height="570" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prices.JPG" src="/public/saq_prices.JPG">
<br>
<br>
```python
# Outliers with price
# > 100$ represent less than 10%
df_ml = df_ml[df_ml.Price < 100]
```
### One Hot Encoding Categorical Features
```python
df_ml = pd.get_dummies(df_ml, columns=['Country','Region','Producer','Designation'], prefix = 'category')
```
<br>
## 4. Modelling

```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn import linear_model
from sklearn.model_selection import train_test_split
from sklearn import preprocessing
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from sklearn.metrics import mean_squared_error, r2_score
%matplotlib inline
import re 


def try_linear_models(X_, y_, model_name, standardize = True):
    if standardize == True:
        X = preprocessing.scale(X_)
    else:
        X = X_
    X_train, X_test, y_train, y_test = train_test_split(X, y_, random_state = 42)
    if model_name == "linear":
        model = linear_model.LinearRegression().fit(X_train, y_train)
    if model_name == "ridge":
        model = linear_model.Ridge(alpha = 0.1).fit(X_train, y_train)
    if model_name == "lasso":
        model = linear_model.Lasso(alpha = 0.5).fit(X_train, y_train)
    if model_name == "XGBR":
       model = xgb.XGBRegressor(objective ='reg:linear', colsample_bytree = 0.3, learning_rate = 1, max_depth = 6, alpha = 10, n_estimators = 50).fit(X_train,y_train) 

    predictions = model.predict(X_test)
    return predictions, y_test
  
  
def error_metrics(model, predictions, y_test):
    print("Model: ", model)
    # The root mean squared error
    print("--Root Mean squared error: %.2f" % np.sqrt(mean_squared_error(y_test, predictions)))
    # Explained variance score: 1 is perfect prediction
    print('--Variance score: %.2f' % r2_score(y_test, predictions))
    

X = df_ml.drop(['Price'], axis=1).values
y = df_ml['Price'].values


# With standardizing
ridge_pred_st, y_test = try_linear_models(X, y, "ridge", standardize=True)
lasso_pred_st, y_test = try_linear_models(X, y, "lasso", standardize=True)
lasso_pred_st, y_test = try_linear_models(X, y, "lasso", standardize=True)

# Without standardizing
ridge_pred, y_test = try_linear_models(X, y, "ridge", standardize=False)
lasso_pred, y_test = try_linear_models(X, y, "lasso", standardize=False)
lasso_pred_st, y_test = try_linear_models(X, y, "lasso", standardize=True)


# # Error metrics
error_metrics("Ridge with standardizing", ridge_pred_st, y_test)
error_metrics("Lasso with standardizing", lasso_pred_st, y_test)
error_metrics("XGBRegressor without standardizing", lasso_pred, y_test)


error_metrics("Ridge without standardizing", ridge_pred, y_test)
error_metrics("Lasso without standardizing", lasso_pred, y_test)
error_metrics("XGBRegressor without standardizing", lasso_pred, y_test)
```
<br>
<img height="570" width="550" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_predictionsmodels.JPG" src="/public/saq_predictionsmodels.JPG">
<br>
<br>

## Conclusion
Lasso regression seems to come out on top but the results is not the best. It seems that there is something going on in the data that the linear models have failed to capture. Wiht more data like the description of each red wine and feature engineering, we could maybe get better results. Indeed, with text descriptions, we can look into the relationship between description and price and identify certain words or characteristics of a description associated with expensive and less expensive wines.
