---
layout: post
title: Predicting price of red wines from SAQ.com (Société des alcools du Québec)
---

<br>
<br>
In this post, we will build a regression model in roder to predict the price of red wine from data that we will get from the SAQ website (Société des alcools du Québec). For this, we will first extract the data from SAQ.com. After we get the data that we need, we will built our regressor model to predict the price of red wines.

In order to do this, we will :
* Extract the data
* Built our model
<br>
<br>
<br>

<img height="420" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prediction.JPG" src="/public/saq_prediction.JPG">
<br>
<br>



## 1. Get red wines URLs from SAQ.com
<br>
#### Scrapy vs Beautifulsoup 
Our project is small, the logic is not very complex and we want job done quickly, so we will use use BeautifulSoup to keep our project simple. If your project needs more customization such as proxy, data pipeline, then the Scrapy might be a best choice.
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
# Some websites automatically block any kind of scraping, and that’s why I’ll define a header to pass along the get command
# which will basically make our queries to the website look like they are coming from an actual browser. When we run the program
# I’ll have a sleep command between pages, so we can mimic a “more human” behavior and don’t overload the site with several requests per second
# You will get blocked if you scrape too aggressively, so it’s a nice policy to be polite while scraping

def saq_urls():
    headers = ({'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'})
    wine_list = ['https://www.saq.com/webapp/wcs/stores/servlet/SearchDisplay?storeId=20002&catalogId=50000&langId=-1&categoryIdentifier=0602&pageSize=500']
    for w in wine_list:
      source = requests.get(w, headers=headers).text
      soup = BeautifulSoup(requests.get(w).text)
      saq_containers = soup.find_all('div', class_="ColD affichageMozaique")
      first = saq_containers[0]
      #get all the links
      wine_list = [url.get('href') for url in first.find_all('a')[1:]]
      complet_list = list(dict.fromkeys(wine_list))
    return complet_list
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
## 2. Get data from URLS
```python
name = []
price = []
producer = []
wines_info = []

for page in wines_list:
  source = requests.get(page).text
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
    pd = info.text
    producer.append(pd)
    
    
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
        

# Country  
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

print('Number of lines for Country: {} '.format(len(country)))
print('Number of lines for Region: {} '.format(len(region)))
print('Number of lines for Origin: {} '.format(len(origin)))
print('Number of lines for Designation: {} '.format(len(designation)))
print('Number of lines for Producer: {} '.format(len(producer)))
print('Number of lines for Size: {} '.format(len(size)))
print('Number of lines for Alcohol: {} '.format(len(alcohol)))
print('Number of lines for Sugar: {} '.format(len(sugar)))


#Create dataframe
import pandas as pd
cols = ['Name', 'Country', 'Region', 'Origin', 'Designation', 'Producer', 'Size','Alcohol', 'Sugar','Price']
df['Price'] = df['Price'].apply(pd.to_numeric, errors='coerce')
df = pd.DataFrame({'Name': name, 'Country': country, 'Region': region, 'Origin':origin, 'Designation':designation, 'Producer':producer, 'Size': size, 'Alcohol': alcohol, 'Sugar': sugar, 'Price': price})[cols]
df.head()
```

<br>

## 3. Exploratory Data Anlysis & Cleaning
<br>
Before performing any data pre-processing, a general step is to explore the data to detect any outliers/missing values and other trends in the data.

Common steps to check the health of the data:
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
Actually, there are some pretty expensive wines in the dataset. In fact, 90 % of the data comes in below 100 dollars. So, we will remove these more expensive wines and predict red wine prices.
<br>
<br>
<br>
<img height="570" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_country_price.jpg" src="/public/saq_country_price.jpg">
<br>
<br>
<img height="570" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prices2.JPG" src="/public/saq_prices2.JPG">
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
<img height="270" width="250" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_predictionsmodels.JPG" src="/public/saq_predictionsmodels.JPG">
<br>
<br>

## Conclusion
Lasso regression seems to come out on top but the results is not the best. It seems that there is something going on in the data that the linear models have failed to capture. Wiht more data like the description of each red wine and feature engineering, we could maybe get better results. Indeed, with text descriptions, we can look into the relationship between description and price and identify certain words or characteristics of a description associated with expensive and less expensive wines.
