---
layout: post
title: Applying Data Science to E-commerce
---

<br>

"*Science is a powerful tool. Whether it benefits or brings disasters to mankind depends on humain being themselves rather than the tool.*" ― Albert Einstein

<br>

In this post, I will try to apply Data Science methods to an eCommerce business. To do so, we will extract the dataset of an online retail from [Kaggle](https://www.kaggle.com/vijayuv/onlineretail) then we will analyse the data.
Here, I did my best to follow a comprehensive, but not exhaustive, analysis of E-commerce data. I'm far from reporting a rigorous analysis in this post, but I hope that it can be useful.

Content:

- E-commerce Data Analysis
- Customer Segmentation
- Predicting Next Purchase Day
- Forecasting Revenue

([Notebook here](https://colab.research.google.com/drive/1C0DbCQ9T36FIx0JQ8JPt7Jy0lj-2MNmA))

<br>

## 1. Preparing environment & uploading data

```python
!pip install jenkspy
!pip install catboost
!pip install shap

%reload_ext autoreload
%autoreload 2
%matplotlib inline

import pandas as pd
import numpy as np
import itertools
import matplotlib.pyplot as plt
import plotly.express as px
import seaborn as sns

from scipy import stats
from scipy.stats import norm, skew

import jenkspy
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
import xgboost as xgb
from sklearn.model_selection import KFold, cross_val_score, train_test_split
from fbprophet import Prophet
from catboost import CatBoostClassifier, Pool, cv
from sklearn.metrics import accuracy_score

import warnings
warnings.filterwarnings("ignore")

# Importing date from Google Drive
from google.colab import drive
drive.mount('/content/drive')

csv_data = r'/content/drive/My Drive/Data/onlineretail.csv'
data = pd.read_csv(csv_data, engine='python')


# Do not include data from December 2011 (incomplete)
data['InvoiceDate'] = pd.to_datetime(data['InvoiceDate'])
data['date'] = data['InvoiceDate'].dt.normalize()
df = data.copy
df = data[data.date.between('12-01-2010', '11-30-2011')]

df['YearMonth'] = df['InvoiceDate'].map(lambda date: 100*date.year + date.month)
df['Revenue'] = df['UnitPrice'] * df['Quantity']

print(df.shape)
print('Customers: {:,}'.format(df.CustomerID.nunique()))
print('Orders: {:,}'.format(df.InvoiceNo.nunique()))
```
<br>
<br>

## 2. E-commerce Data Analysis

### Revenue & Growth Rate

```python
# Monthly data
df_monthly = df.copy()
df_monthly = df_monthly.groupby('YearMonth').agg({'CustomerID': lambda x: x.nunique(), 'Quantity': 'sum', 'Revenue': 'sum', }).reset_index()
df_monthly['YearMonth'] = df_monthly['YearMonth'].astype(str)
df_monthly['YearMonth']= df_monthly['YearMonth'].str.split('(\d{4})(\d{2})').str.join('-').str.strip('-')
df_monthly['YearMonth'] = df_monthly['YearMonth'].astype('category')

# Monthly Growth %
df_monthly['MonthlyGrowth'] = df_monthly['Revenue'].pct_change()
# df_monthly['MonthlyGrowth'] = df_monthly['MonthlyGrowth'].apply("{:,.1f}%".format)
df_monthly.columns = ['YearMonth', 'Customers', 'Quantity', 'Revenue', 'MonthlyGrowth']
df_monthly['Customers'] = df_monthly['Customers'].astype(int)


sns.set_style("whitegrid")
sns.catplot(x="YearMonth", y="Revenue", data=df_monthly, kind="point", aspect=2.5, color="#95a5a6")
plt.ylabel('Revenue')
plt.xlabel('')
sns.despine(left=True, bottom=True)

df_monthly.style.format({"Customers": "{:.0f}", 
                             "Quantity": "{:.0f}", 
                             "Revenue": "${:20,.0f}"})\
                    .hide_index()\
                    .bar(subset=["Revenue",], color='lightgreen')\
                    .bar(subset=["Customers"], color='#FFA07A')
```
<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">

<br>
<br>

### Retention Rate
```python
# Monthly Retention rate
df_customer_monthly_revenue = df.groupby(['CustomerID','YearMonth'])['Revenue'].sum().reset_index()

df_retention = pd.crosstab(df_customer_monthly_revenue['CustomerID'], df_customer_monthly_revenue['YearMonth']).reset_index()

months = df_retention.columns[1:]
retention_array = []
for i in range(len(months)-1):
    retention_data = {}
    selected_month = months[i+1]
    prev_month = months[i]
    retention_data['YearMonth'] = int(selected_month)
    retention_data['Customers'] = df_retention[selected_month].sum()
    retention_data['RetainedCustomers'] = df_retention[(df_retention[selected_month]>0) & (df_retention[prev_month]>0)][selected_month].sum()
    retention_array.append(retention_data)

df_retention = pd.DataFrame(retention_array)
df_retention['RetentionRate'] = df_retention['RetainedCustomers']/df_retention['Customers']

g = sns.catplot(x="YearMonth", y="RetentionRate", data=df_retention, kind="point", aspect=2.5, color="#95a5a6").set(title = "Monthly Retention rate")
g.set_axis_labels("", "Retention Rate").set(ylim=(0, 0.6)).despine(left=True);
```
<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">

<br>
<br>

### Cohort Based Analysis

A cohort analysis is the process of analyzing the behavior of groups of users who share a common characteristic. Here, the common characteristic is identified by the first purchase in each month.

```python
df_cohort = pd.crosstab(df_customer_monthly_revenue['CustomerID'], df_customer_monthly_revenue['YearMonth']).reset_index()

new_column_names = [ 'm_' + str(column) for column in df_cohort.columns]
df_cohort.columns = new_column_names

#Retained customers for each cohort monthly
retention_array = []
for i in range(len(months)):
    retention_data = {}
    selected_month = months[i]
    prev_months = months[:i]
    next_months = months[i+1:]
    for prev_month in prev_months:
        retention_data[prev_month] = np.nan
        
    total_user_count =  retention_data['Customers'] = df_cohort['m_' + str(selected_month)].sum()
    retention_data[selected_month] = 1 
    
    query = "{} > 0".format('m_' + str(selected_month))
    
    for next_month in next_months:
        query = query + " and {} > 0".format(str('m_' + str(next_month)))
        retention_data[next_month] = np.round(df_cohort.query(query)['m_' + str(next_month)].sum()/total_user_count,2)
    retention_array.append(retention_data)
    
df_cohort = pd.DataFrame(retention_array)
df_cohort.index = months
df_cohort
```
<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">

<br>
<br>

## 2. Customer Segmentation (RFM Clustering)

In order to create our customer segments, we will use the method RFM. We will calculate Recency, Frequency and Monetary and apply unsupervised machine learning to identify our different segments:
- Not Engaged
- Engaged
- Best

For RFM clustering, instead of using kmeans, we will use Fisher-Jenks algorithm (Jenks optimization or natural breaks) that is a little more intuitive. For the purposes of this article, I will use jenkspy from Matthieu Viry.

### Recency (Inactive days)

<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">

### Frequency (Number of orders)

<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">


### Monetary (Revenue)

<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">

### RFM Score

<br>

## 3. Predicting Next Purchase

In this section, we will try to predict if a customer is likely to make a new purchase.
For this, we will use 9 months of data to predict if a customer will make another order in the next 40 days.

<br>
<br>





































## 2. Conversion by Path

```python
# Channels to list
df_paths = df.groupby(['visitors', 'date'])['channel'].aggregate(lambda x: x.unique().tolist()).reset_index()
df_last_interaction = df.groupby(['visitors', 'date'])['conversions'].sum().reset_index()
df_paths = pd.merge(df_paths, df_last_interaction, how='left', on=['visitors', 'date'])

# df for models
conv_model = df_paths.copy()
conv_model['channel'] = conv_model['channel'].astype(str)
conv_model['channel'] = conv_model['channel'].replace(to_replace ='\[|]', value = '', regex = True)

# Conversion by path
conv_path = conv_model.groupby(['channel']).agg({'conversions': 'sum', 'visitors': 'count'}).sort_values('conversions', ascending=False).reset_index()
conv_path['conversion_rate'] = (conv_path['conversions'] / conv_path['visitors'])*100
conv_path['conversion_rate'] = conv_path['conversion_rate'].map('{:,.1f}%'.format)
conv_path['channel'] = conv_path['channel'].str.replace('\'|\'','')
conv_path.head(10)
```
<img height="350" width="450" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_path.JPG">
<br>
<br>

## 8. Conclusion

To summarize, the results are surprisingly consistent across all of the approaches.
The rank order is the same across all results. Even in the case of the Markov chain and Shapley values methods the differences in the conversion rates are very low.

So which method should we use?... It depends! :)

Shapley value method:
- Broader industry adoption
- Nobel Prize winning research.
- More straightforward approach to the attribution problem in which sequence doesn’t matter.

Markov chain method:
- It considers channel sequence as a fundamental part of the algorithm which is more closely aligned to a user’s journey.

<br>

Others recommendations:

- Split paths by conversion and compute the model for first-time buyers and n-times buyers separately.
- Split unique channels and multi-channel paths. We definitely know the channel that brought a conversion and we don’t need to distribute that value into other channels.
- Replace (with previous channel) or remove "Direct" channel
- Change order of Markov chain to compute transition probabilities based on the previous two, three or more channels.
- Model paths that haven't led to converion in order to look at the complete “picture” of the business, not just conversions.
- The pychattr package allows distributing revenue and cost through channels. For this, we need to add the parameter “revenue_feature” and “cost_feature” with columns of revenues and cost into MarkovModel() and HeuristicModel() functions. 

<em>
<br>
<br>
