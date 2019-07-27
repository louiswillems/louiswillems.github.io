---
layout: post
title: Text Data Visualization with Google Analytics
---

<br>
<br>
In this post, we will build a scatter plot tool for text. For this, we'll collect the data from the publicly available Kurier.at dataset in BigQuery. Kurier.at is an Austrian newsite.

We will upload a sample of Google Analytics data from this news site, This sample contains page tracking events.

The goal of post is to create a text data visualization tool that is intended visualizing most frequents words of most and least reads news articles.

This notebook illustrates how to:

* Pull data from Bigquery
* Use a pre-trained statistical models in German with Spacy
* Visualize words frequency vs popularity of articles

<br>
<br>
<br>

<img height="500" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prediction.JPG" src="/public/scattertext_example.png">
<br>
<br>



## 1. Pull data from Bigquery
<br>
### Kurier.at Google Analytics sample dataset from BigQuery
The query contains 2 columns, first column “headline” shows the title of the articles news and the second column is the number of pagesviews for each article.
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
### Load Spacy Language Model
For this step you have to ensure that spacy is installed on your notebook and then you load the german language modelé
<br>

```python
pip install scattertext
python -m spacy download de_core_news_md

import spacy
import de_core_news_md
from spacy.lang.de import German

nlp = de_core_news_md.load()
```

<br>

## 3. Visualize words frequency vs popularity of articles
<br>
### Set a threshold
Before we plot our text data visualization tool, we need to set a threshold for our pageviews in order to split our data into most least reads news articles
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
<img height="370" width="650" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/most_least_reads.JPG" src="/public/most_least_reads.JPG">
<br>
<br>

### Parse Speech text using Spacy
You can see the parsed text column and the text is tokenized after lemmetization and stemming. While punctuation rules are usually pretty general, tokenizer exceptions strongly depend on the specifics of the individual language. This is why each available language has its own subclass like English or German, that loads in lists of hard-coded data and exception rules.
<br>

```python
data['headline_clean'] = data.headline.apply(lambda text: 
                                          " ".join(token.text for token in nlp(text) if not token.is_stop))

# Tokenization with pre-trained model with Spacy
data['parsed'] = data.headline_clean.apply(nlp)

# ScatterText
corpus = st.CorpusFromParsedDocuments(data, category_col='binned', parsed_col='parsed').build()
html = produce_scattertext_explorer(corpus,
                                    category='plus populaires',
                                    not_category_name='moins populaires',
                                    width_in_pixels=1000,
                                    minimum_term_frequency=10,
                                    pmi_filter_thresold=10,
                                    term_ranker=st.OncePerDocFrequencyRanker,
                                    sort_by_dist=False)

# Save file
import os
file_name = 'text_analytics.html'
open(file_name, 'wb').write(html.encode('utf-8'))
IFrame(src=file_name, width = 1300, height=700)
HTML(html)
```

<br>
<img height="670" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_predictionsmodels.JPG" src="/public/german_scattertext.JPG">
<br>
<br>

## Conclusion
You have seen how you can make good insight of your data using Scattertext in an easy and flexible without much of efforts. There are numerous other examples which can be found on their github page here. it provides a wide range of other ways to visualize your text data like Visualizing term association, Visualizing Empath topics and categories, Ordering Terms by Corpus Characteristictness, Document based scatter plots and many other advance usage of Text Data Visualization
