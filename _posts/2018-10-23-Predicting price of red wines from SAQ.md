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
import pandas as pd
import requests
import lxml
import time


headers = ({'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36'})


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
# Let's clean the data. First, let's check if there are any null values in the dataframe.
are_null_values = df.isnull().values.any()
num_nulls = df.isnull().sum()
print("Shape:\n",df.shape)
print("Columns with null values:\n",num_nulls)
print("Number of observations:\n",len(df))
```

```python
#  Descriptive statistics about red wines prices.
prices = df['Price']

minimum_price = np.min(prices)
maximum_price = np.max(prices)
mean_price = np.mean(prices)
median_price = prices.median()
std_price = np.std(prices)

# Show the calculated statistics
print("Statistics for Boston housing dataset:\n")
print("Minimum price: ${:,.2f}".format(minimum_price))
print("Maximum price: ${:,.2f}".format(maximum_price))
print("Mean price: ${:,.2f}".format(mean_price))
print("Median price ${:,.2f}".format(median_price))
print("Standard deviation of prices: ${:,.2f}".format(std_price))
```
<br>
Statistics SAQ red wines dataset:

* Minimum price: $4.30
* Maximum price: $989.50
* Mean price: $60.68
* Median price $28.90
* Standard deviation of prices: $96.52
<br>

```python
#  For Data Exploration details click here

# Drop duplicate descriptions
baseline = df.drop_duplicates("Name")

# Imputation 

```

<br>
<br>
<br>
<img height="670" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prices2.JPG" src="/public/saq_prices2.JPG">
<br>
<br>
<img height="570" width="950" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prices.JPG" src="/public/saq_prices.JPG">
<br>
<br>
<br>


### Baseline Model
<br>
We will calculate RSME and R-squared metric to jauge the improuvement Baseline vs our final Model.

```python
baseline = df.drop_duplicates("Name")
baseline = baseline.dropna()


baseline = baseline[['Country','Region','Designation','Producer','Alcohol','Size','Price']]

X = baseline.drop(['Price'], axis=1)
y = baseline['Price'].values

X_train, X_validation, y_train, y_validation = train_test_split(X, y, train_size=0.7, random_state= 42)


# Label encoder of all categorical features
for c in X_train.columns[X_train.dtypes == 'object']:
  X_train[c] = X_train[c].factorize()[0]

for c in X_validation.columns[X_validation.dtypes == 'object']:
  X_validation[c] = X_validation[c].factorize()[0]
  
rf = RandomForestRegressor()
rf.fit(X_train, y_train)

# Predict
predictions = rf.predict(X_validation)
print("--Mean squared error: %.2f" % mean_squared_error(y_validation, predictions))
print("--Root Mean squared error: %.2f" % np.sqrt(mean_squared_error(y_validation, predictions)))
print('--Coefficient of determination: %.2f' % r2_score(y_validation, predictions))
```
<br>

*--Mean squared error: 5105.17
*--Root Mean squared error: 71.45
*--Coefficient of determination: -0.20

<br>
We can also see most important features of our Baseline model
```python
# Feature Importance
plt.plot(rf.feature_importances_)
plt.xticks(np.arange(X.shape[1]), X_train.columns.tolist(), rotation =90)
```
<br>
<br>
<br>

### Feature Engineering
```python
# Mean Encoding on Producer
kf = model_selection.KFold(5, shuffle=False)
baseline['Producer_enc'] = np.nan

for tr_ind, val_ind in kf.split(baseline):
    X_tr, X_val = baseline.iloc[tr_ind], baseline.iloc[val_ind]
    baseline.loc[baseline.index[val_ind], 'Producer_enc'] = X_val['Producer'].map(X_tr.groupby('Producer').Price.mean())
baseline['Producer_enc'].fillna(46.580, inplace=True)



# Drop missing values (947)
baseline = baseline.dropna()

# Feature Generation: Country_Region
baseline['Country_Region'] = baseline['Country'] + baseline['Region']

# Feature Generation: Counts Producer
counts = baseline['Producer'].value_counts()
counts_dict = counts.to_dict() 
baseline['Counts_Producer'] = baseline['Producer'].map(counts_dict)

# Feature Generation: Counts Producer
val = baseline['Producer'].value_counts()
y = val[val == 1].index
baseline['New_Producer'] = baseline['Producer'].replace({x:'Other' for x in y})

#  Feature Engineering
baseline['Wine_year'] = baseline['Name'].str.extract('(20\d{2})', expand=True)                                                  
baseline['Wine_year'] = baseline['Wine_year'].replace(np.nan, 'Other', regex=True)

# Feature Generation: Producer Frequency
fe = baseline.groupby('Producer').size()/len(baseline)
baseline.loc[:, 'Freq_Producer'] = baseline['Producer'].map(fe)
```
<br>
<br>
<br>

## Modelling

```python



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
