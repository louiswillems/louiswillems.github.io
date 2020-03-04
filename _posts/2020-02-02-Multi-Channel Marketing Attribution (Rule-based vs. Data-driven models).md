---
layout: post
title: Multi-Channel Marketing Attribution (Rule-based vs. Data-driven models)
---


<img height="180" width="500" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/attribution_1.JPG">

In the context of Digital Marketing and Ecommerce, we know that users usually goes through a path of different channels before a conversion or purchase. As most of the channels are paid, it is vital to have a model for distributing conversions.
Multi-Channel attribution helps companies assign the value to each marketing channel in order to select the profitable ones.
In web analytics tools such as Google Analytics, there are several attribution models implemented in order to determine the merits of each marketing channels. These models are:

- Rule-based/Heuristic (e.g. "last non-direct click")
- Data-Driven (Google Analytics uses Shapley values)
- Custom model builder

<br>

Data-driven attribution models (algorithmic or probabilistic) determine how channels, and more importantly how different combinations of channels, interact with users to influence a desired conversion.
Rule-based models are still a kind of algorithms, but they use a set of relational rules that collectively represent the knowledge.
In this post we will explore Rule-based (First, Last and Linear touch) and Data-driven (Markov chain and Shapley values) attribution methods .

<br>

## 1. Download Data

The dataset comes from BigQuery Public Dataset Program and contains ~467 000 marketing touch-points for ~365 000 visitors which resulted in 6 646 conversions.

```python
%reload_ext autoreload
%autoreload 2
%matplotlib inline

import pandas as pd
import numpy as np
import itertools
import matplotlib.pylab as plt
plt.style.use("fivethirtyeight")

from google.colab import auth
auth.authenticate_user()

project_id = '<PROJECT_ID>'

data = pd.io.gbq.read_gbq(
'''
SELECT
    fullVisitorId,
    channelGrouping AS channels,
    date,
    visitStartTime,
    totals.transactions
  FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20170101' AND '20171231'
''', project_id=project_id, dialect='standard')
```
<br>
<br>

## 1. Conversion by Channel

```python
# Fill NAs, rename columns, datatypes
df = data.copy()
df['transactions'] = df['transactions'].fillna(0)
df = df.rename(columns = {'channels': 'channel', 'transactions': 'conversions', 'fullVisitorId': 'visitors'})
df['conversions'] = df['conversions'].astype(int)

# Conversion by channel
conv_channel = df.groupby('channel').agg({'conversions': 'sum', 'visitors': lambda x: x.nunique()}).sort_values('conversions', ascending=False).reset_index()
conv_channel['conversion_rate'] = (conv_channel['conversions'] / conv_channel['visitors'])*100
conv_channel['conversion_rate'] = conv_channel['conversion_rate'].map('{:,.1f}%'.format)
conv_channel
```
<img height="300" width="400" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/conv_by_channel.JPG">
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

## 3. Rule-based methods

Rule-based methods (e.g. "last non-direct click") are used for solve problems in a quick way and delivers results that are sufficient enough to be useful given time constraints.
In this section, I will use a Python implementation based on the ChannelAttribution package in R developed by Davide Altomare and David Loris. You can find more information [here](https://github.com/jmwoloso/pychattr).

```python
import pandas as pd
from pychattr.channel_attribution import HeuristicModel


path_feature="channel"
conversion_feature="conversions"
null_feature=None
# revenue_feature="revenue"
# cost_feature="cost"
separator=","
first_touch=True
last_touch=True
linear_touch=True
ensemble_results=False

# instantiate the model
hm = HeuristicModel(path_feature=path_feature,
                    conversion_feature=conversion_feature,
                    null_feature=null_feature,
                    # revenue_feature=revenue_feature,
                    # cost_feature=cost_feature,
                    separator=separator,
                    first_touch=first_touch,
                    last_touch=last_touch,
                    linear_touch=linear_touch,
                    ensemble_results=ensemble_results)

# fit the model
hm.fit(conv_model)

# simulation results
df_heuristic = hm.attribution_model_
```

<br>
<br>

## 4. Markov chains

Markov chains allow us to switch from rule-based/heuristic methods to probabilistic ones. We can represent every customer journey (sequence of channels/touchpoints) as a chain in a directed Markov graph.

The algorithm for Markov chains can be summarized in 2 steps:
- Calculate transition probabilities between all states in our state-space
- Calculate removal effects

I will use again the Python implementation based on the ChannelAttribution package in R developed by Davide Altomare and David Loris. You can find more information [here](https://github.com/jmwoloso/pychattr).

```python
import pandas as pd
from pychattr.channel_attribution import MarkovModel

path_feature="channel"
conversion_feature="conversions"
null_feature=None
# revenue_feature="revenue"
# cost_feature="cost"
separator=","
k_order=1
n_simulations=1000
max_steps=None
return_transition_probs=True
random_state=26

# instantiate the model
mm = MarkovModel(path_feature=path_feature,
                 conversion_feature=conversion_feature,
                 null_feature=null_feature,
                #  revenue_feature=revenue_feature,
                #  cost_feature=cost_feature,
                 separator=separator,
                 k_order=k_order,
                 n_simulations=n_simulations,
                 max_steps=max_steps,
                 return_transition_probs=return_transition_probs,
                 random_state=random_state)

# fit the model
mm.fit(conv_model)

# simulation results
# df_re = mm.removal_effects_
df_markov = mm.attribution_model_
```

<br>
<br>

## 5. Shapley values


Shapley value method relies on the marginal contribution of each marketing channel to weight its contribution to overall conversion. Cooperative game theory and the Shapley value provide a stable way to measure channel influence and fairly divide the credit for conversions between the channels, based on their individual contribution to the total payoff.

```python
import itertools
from math import factorial
from collections import defaultdict

# Shap dataframe
data_shap = df_paths.copy()
data_shap['channel_str'] = [",".join(i) for i in data_shap['channel']]
data_shap = pd.DataFrame(data_shap.groupby('channel_str')['conversions'].sum()


def subsets(s):
    '''
    This function returns all the possible subsets of a set of channels.
    input : - s: a set of channels.
    '''
    if len(s)==1:
        return s
    else:
        sub_channels=[]
        for i in range(1,len(s)+1):
            sub_channels.extend(map(list,itertools.combinations(s, i)))
    return map(",".join,map(sorted,sub_channels))

def attribution(A,C_values):
    '''
    This function computes the worth of each coalition.
    inputs:
    - A : a coalition of channels.
    - C_values : A dictionnary containing the number of conversions that each subset of channels has yielded.
    '''
    subsets_of_A = subsets(A.split(","))
    worth_of_A=0
    for subset in subsets_of_A:
        if subset in C_values:
            worth_of_A += C_values[subset]
    return worth_of_A

# Channel list
channels = conv_channel['channel'].tolist()

# Shapley values
C_values = data_shap.to_dict()['conversions']

v_values = {}
for A in subsets(channels):
    v_values[A] = attribution(A,C_values)

n=len(channels)
shapley_values = defaultdict(int)

for channel in channels:
    for A in v_values.keys():
        if channel not in A.split(","):
            cardinal_A=len(A.split(","))
            A_with_channel = A.split(",")
            A_with_channel.append(channel)            
            A_with_channel=",".join(sorted(A_with_channel))
            shapley_values[channel] += (v_values[A_with_channel]-v_values[A])*(factorial(cardinal_A)*factorial(n-cardinal_A-1)/factorial(n))
    # Add the term corresponding to the empty set
    shapley_values[channel]+= v_values[channel]/n 

df_shap = pd.DataFrame.from_dict(shapley_values, orient = 'index').reset_index()
df_shap = df_shap.rename(columns = {0 : 'shap_conversions', 'index' : 'channel'})
df_shap['conversion_rate'] = (df_shap['shap_conversions']/df_shap['shap_conversions'].sum())*100
```
<br>
<br>

## 6. Results

Here, we will compare our Rule-based (First, Last and Linear touchs) and Data-driven models (Markov chain and Shapley values) for each channel.

```python
# Cleaning dataframes
df_markov = df_markov.rename(columns = {'channel_name': 'channel', 'total_conversions': 'markov_conversions'})
df_markov['channel'] = df_markov['channel'].str.replace('\W','')
df_heuristic['channel'] = df_heuristic['channel'].str.replace('\W','')
df_markov['channel'] = df_markov['channel'].str.replace('OrganicSearch', 'Organic Search')
df_markov['channel'] = df_markov['channel'].str.replace('PaidSearch', 'Paid Search')
df_heuristic['channel'] = df_heuristic['channel'].str.replace('OrganicSearch', 'Organic Search')
df_heuristic['channel'] = df_heuristic['channel'].str.replace('PaidSearch', 'Paid Search')

# Merge Data driven & Rule-based/Heuristic models
df_all = pd.merge(df_markov, df_heuristic, how='left', on=['channel'])
df_all['markov_conversions'] = df_all['markov_conversions'].astype(float)
df_all = df_all.sort_values(by=['markov_conversions'], ascending=False)
df_all = pd.merge(df_all, df_shap, how='left', on=['channel']).fillna(0)

# Conversion rate (%)
cols = ['first_touch_conversions', 'last_touch_conversions', 'linear_touch_conversions', 'markov_conversions', 'shap_conversions']
df_all[cols] = df_all[cols].div(df_all[cols].sum(axis=0), axis=1).multiply(100).round(1)
df_all = df_all.loc[:, df_all.columns != 'conversion_rate']
models = df_all.set_index('channel')
models = models[cols].applymap("{:,.1f}%".format)
models
```
<img height="350" width="900" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/fast-colab.JPG" src="/public/final_results.JPG">
<br>
<br>

## 6. Conclusion

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
