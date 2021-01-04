---
layout: post
title: Predict Visitor Purchases with Google Analytics
---

<br>

“The future depends on what we do in the present.” ― Mahatma Gandhi

<br>

**Objective:** The goal of this machine learning project is to develop a model that can predict whether or not a subset of visitors who returned to a website are likely to purchase.

For our task, we will use an ecommerce dataset that has millions of Google Analytics records for the Google Merchandise Store loaded into BigQuery. Using this data on each visitor session, we will build a model to get the probability of future purchase based on the data about their first session. Our binary classification model will be evaluated on ROC AUC, which is a number between 0 and 1, where 0 means 100% of the predictions are wrong and 1 means 100% of the predictions are correct. Randomly guessing should give a score of 0.5. With this model marketing teams could target those visitors with special promotions and ad campaigns.

Content ([Notebook here](https://colab.research.google.com/drive/1Pj1xLpA9S0NL0I6x623GnikCFxAV0mxc?usp=sharing)):

- Data Loading & Preparation
- Data Exploration
- Training and test dataset for batch prediction
- Baseline & Model Evaluation
- Model Training
- Predictions
- Model Analysis


The field definitions for the data-to-insights ecommerce dataset are [here](https://support.google.com/analytics/answer/3437719?hl=en).

*Important: For the purpose of our project, we will follow these steps in a linear fashion but machine learning pipeline is an iterative procedure.*

<br>
<br>

## Data Loading & Preparation

```python
# BigQuery Query
from google.colab import auth
auth.authenticate_user()

project_id = 'testlouis-187422' # To remove

data = pd.io.gbq.read_gbq(
'''
SELECT
    fullVisitorId,
    IFNULL(totals.bounces, 0) AS bounces,
    IFNULL(totals.timeOnSite, 0) AS time_on_site,
    IFNULL(totals.newVisits, 0) AS newVisits,
    IFNULL(totals.transactions, 0) AS transactions,
    IFNULL(totals.totalTransactionRevenue, 0) AS totalTransactionRevenue,
    date,
    visitStartTime,
    IFNULL(totals.pageviews, 0) AS pageviews,
    trafficSource.source,
    trafficSource.medium,
    channelGrouping,
    device.deviceCategory,
    geoNetwork.country
  FROM
    `data-to-insights.ecommerce.web_analytics` 

''', project_id=project_id, dialect='standard')
```

<img height="500" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/Revenue&Growth.JPG" src="/public/Revenue&Growth.JPG">

<br>

### Processing & Description

```python
# Copy
df = data.copy()

# Total transaction revenue were multiplied by 10^6
df['totalTransactionRevenue'] = df['totalTransactionRevenue']/1000000

# Adding Datetime features
df['date'] = pd.to_datetime(df['date'], format='%Y%m%d', errors='coerce')
df['visitStartTime_UTC'] = pd.to_datetime(df['visitStartTime'])
df["weekday"] = df['date'].dt.weekday
df["day"] = df['date'].dt.day
df["month"] = df['date'].dt.month
df["year"] = df['date'].dt.year
df['visitHour'] = (df['visitStartTime'].apply(lambda x: str(datetime.fromtimestamp(x).hour))).astype(int)
df['DayTime'] = pd.cut(df['visitHour'],[0,6,12,18,24],labels=['Night','Morning','Afternoon','Evening']).astype(object)
df['DayTime'] = df['DayTime'].fillna('Other')
print(df.shape)

# Exploratory Data Analysis
EDA = pd.DataFrame(columns = ['Columns','Types','Values', 'Uniques', 'Uniques(no nulls)', 'Missing(n)', 'Missing(%)'])
eda = pd.DataFrame()

for c in df.columns:
    eda['Columns'] = [c]
    eda['Types'] = df[c].dtypes
    eda['Values'] = [df[c].unique()]
    eda['Uniques'] = len(list(df[c].unique()))
    eda['Uniques(no nulls)'] = int(df[c].nunique())
    eda['Missing(n)'] = df[c].isnull().sum()
    eda['Missing(%)'] = (df[c].isnull().sum()/ len(df)).round(3)*100
    EDA = EDA.append(eda)
EDA
```

<br>

### Target column

Note that when working with binary classification problems, especially imbalanced problems, it is important that the majority class is assigned to class 0 and the minority class is assigned to class 1. This is because many evaluation metrics will assume this relationship.

```python
df['NextPurchase'] = 0
df.loc[(df['transactions'] > 0) & (df['newVisits'] == 0 ) ,'NextPurchase'] = 1

# summarize the class distribution
target = df['NextPurchase'].values
counter = Counter(target)
for k,v in counter.items():
  per = v / len(target) * 100
  print('Class=%d, Count=%d, Percentage=%.1f%%' % (k, v, per))
```

<br>

## Data Exploration

### What % of the total visitors made a purchase?

```python
purcharsers = df.loc[df['transactions'] > 0]
purchasers = purcharsers.groupby('fullVisitorId').transactions.sum().reset_index()
result = purchasers.fullVisitorId.nunique()/ df.fullVisitorId.nunique()*100
print('{:.1f}% of the total visitors made a purchase'.format(result))

```

### How many visitors bought on subsequent visits to the website?

```python
result = df.groupby('NextPurchase').fullVisitorId.nunique()[1]/df.groupby('NextPurchase').fullVisitorId.nunique()[0]*100
print('{:.1f}% of the total visitors will return and purchase from website'.format(result))

```

<br>

## Training & test dataset for batch prediction


- Training on 11 months of session data
- 1 month for test

```python


```

