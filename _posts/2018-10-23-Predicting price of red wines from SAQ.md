---
layout: post
title: Predicting prices of red wines from SAQ.com (Société des alcools du Québec)
---

<br>
<br>
In this post, we will build a regression model in order to predict the prices of red wines from data that we will get from SAQ website (Société des alcools du Québec). To do so, we will first extract the data from SAQ.com. Once we get the data that we need, we will build our regressor model to predict the prices of red wines.

In order to do this, we will :
* Extract the data
* Build our model
<br>
<br>
<br>

<img height="420" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prediction.JPG" src="/public/saq_prediction.JPG">
<br>
<br>



## 1. Get red wines data from SAQ.com
<br>
#### Scrapy vs Beautifulsoup 
Our project is small, the logic is not very complex and we want the job done quickly, so we will use BeautifulSoup to keep our project simple. If your project needs more customization such as proxy, data pipeline, then Scrapy might be a better choice.
<br>
```python
from bs4 import BeautifulSoup
from requests import get
import itertools
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import requests
import re
sns.set()
```
<br>
```python
"""
Created on October 2019
All the red wine data from saq.com is stored in csv

@author: Willems Louis
         louis.willems@outlook.com
"""


from bs4 import BeautifulSoup
from requests import get
import itertools
import requests
import pandas as pd
import re
import lxml
import time

# Some websites automatically block any kind of scraping, and that’s why I’ll define a header to pass along the get command
# which will basically make our queries to the website look like they are coming from an actual browser. When we run the program
# I’ll have a sleep command between pages, so we can mimic a “more human” behavior and don’t overload the site with several requests per second
# You will get blocked if you scrape too aggressively, so it’s a nice policy to be polite while scraping


headers = ({'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'})


# GET ALL RED WINES URLS

# How many urls we want ?
#pageSize


class AuthError(Exception):
    def __init__(self):
        self.msg = "auth error"

def saq_urls():
    headers = ({'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'})
    wine_list = ['https://www.saq.com/webapp/wcs/stores/servlet/SearchDisplay?searchType=&showOnly=product&langId=-1&catalogId=50000&storeId=20002&categoryIdentifier=06&pageSize=9900']


    for w in wine_list:
      source = requests.get(w, headers=headers).text
      soup = BeautifulSoup(requests.get(w).text, 'lxml')
      saq_containers = soup.find_all('div', class_="ColD affichageMozaique")
      first = saq_containers[0]
      #get all the links
      wine_list = [url.get('href') for url in first.find_all('a')[1:]]
      complet_list = list(dict.fromkeys(wine_list))

    return complet_list


def redwine_data():
    wines_list = saq_urls()
    name = []
    price = []
    producer = []
    wines_info = []

    for page in wines_list:
      # source = requests.get(page).text

      source = ''
      while source == '':
          try:
              source = requests.get(page).text
              break
          except:
              print("Connection refused by the server..")
              print("Sleep for 5 seconds")
              time.sleep(5)
              print("Continue...")
              continue
              
      soup = BeautifulSoup(source)
      w_name = soup.find_all("h1", {"class": "product-description-title"})
      w_price = soup.find_all("p", {"class": "price"})
      w_producer = soup.find_all("td", {"class": "product-detailsR"})[0]
      w_infos = soup.find_all("div", {"id": "details"})

      for info in w_name:
        nm = info.text
        name.append(nm)

      for info in w_price:
        pc = info.text
        pc1 = pc.replace('Regular price:  ','')
        pc2 = pc1.replace('$','')
        price.append(pc2)

      for info in w_producer:
        prod = info.text
        producer.append(prod)

      for info in w_infos:
        ac = info.text.strip()
        ac1 = ac.replace('\n','')
        ac2 = ac1.replace(' ','')
        ac3 = ac2.replace('\r',' ')
        wines_info.append(ac3)
        # len(wines_info)
        # wines_info

    def nextword(target, source):
        for i, w in enumerate(source):
            if w == target:
                return source[i+1]


    country = [nextword('DetailedinfoCountry', s.split()) for s in wines_info]
    # Region
    region = [nextword('Region', s.split()) for s in wines_info]
    # Designation of origin
    origin = [nextword('Designationoforigin', s.split()) for s in wines_info]
    # Regulateddesignation
    designation = [nextword('Regulateddesignation', s.split()) for s in wines_info]
    # Size
    size = [nextword('Size', s.split()) for s in wines_info]
    # Alcohol
    alcohol = [nextword('Degreeofalcohol', s.split()) for s in wines_info]
    # Sugar
    sg = [nextword('%', s.split()) for s in wines_info]
    sg1 = [s.rpartition('Sugarcontent')[2] for s in sg]
    sugar = [s[0:3] for s in sg1]

    cols = ['Name', 'Country', 'Region', 'Origin', 'Designation', 'Producer', 'Size','Alcohol', 'Sugar','Price']
    df = pd.DataFrame({'Name': name, 'Country': country, 'Region': region, 'Origin':origin, 'Designation':designation, 'Producer':producer, 'Size': size, 'Alcohol': alcohol, 'Sugar': sugar, 'Price': price})[cols]
    df['Price'] = df['Price'].apply(pd.to_numeric, errors='coerce')

    df.to_csv(r'C:\Users\Admin\Documents\Python\SAQ\saq_data.csv',  encoding='utf-8', index=False)





def main():
    print('Getting data from saq.com')
    redwine_data()
    print('Done')
    print('Your data is ready')

if __name__ == "__main__":
    main();

```
<br>
<br>
<img height="570" width="750" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_website1.JPG" src="/public/saq_website1.JPG">
<br>
<br>
<br>
<br>
<img height="570" width="750" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_website2.JPG" src="/public/saq_website2.JPG">
<br>


## 2. Exploratory Data Analysis & Cleaning
<br>
Before performing any data pre-processing, a general step is to explore the data to detect any outliers/missing values and other trends in the data.

Common steps to check the data:
* Check for missing data
* Check the skewness of the data, outlier detection
etc...
<br>

```python
df.describe()
```

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
Actually, there are some pretty expensive wines in the dataset. In fact, 90 % of the data come in below 100 dollars. So, we will remove these more expensive wines and predict red wine prices.
<br>
<br>
<br>
<img height="670" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prices2.JPG" src="/public/saq_prices2.JPG">
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
<img height="350" width="350" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_predictionsmodels.JPG" src="/public/saq_predictionsmodels.JPG">
<br>
## Conclusion
Lasso and Ridge regression seems to come out on top but the results are not the best. It seems that there is something going on in the data that the linear models have failed to capture.
Maybe with more data, like unstructured data, we could look into the relationship between text descriptions and prices and then identify certain words or characteristics associated with expensive and less expensive wines.

<br>
<br>
<br>
<br>

***

<br>
<br>
<br>
<br>
