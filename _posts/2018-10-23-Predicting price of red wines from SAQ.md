---
layout: post
title: Predicting red wine price from SAQ.com (Société des alcools du Québec)
---

<br>

**Objective**: The goal of this machine learning project is to develop a model that can predict red wine's prices using SAQ data. We will also interpret the results to find the variables that are most predictive.

<br>

## Probleme definition

In this post, we will build a regression model in order to predict red wine's prices. We will get the data from SAQ website (Société des alcools du Québec). To do so, we will first extract the data from <a href="https://www.saq.com/content/SAQ/fr.html"> SAQ.com</a>. Once we get the data that we need, we will build our regressor model to predict red wine's prices.

In this machine learning pipeline, we will :
- Extract & uploading data
- Exploratory Data Analysis (EDA)
- Naive Baseline
- Feature Engineering & Model Selection
- Model Evaluation on test data
- Model Analysis (Interpretability)
- Conclusion

Note that the dataset has approximately 5000 rows. Our metric evaluation will be MAE. Feel free to see my repository on <a href="https://github.com/louiswillems/saq-price-predictions"> Github</a>.

*Important: For the purpose of our project, we will follow these steps in a linear fashion but machine learning pipeline is an iterative procedure.*


<br>
<br>
<br>
<br>

<img height="420" width="800" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/saq_prediction.JPG" src="/public/saq_prediction.JPG">
<br>
<br>



## Get red wines data from SAQ.com
<br>

Scrapy vs Beautifulsoup:

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


## Preparing environment & uploading data
<br>
Importing packages

<br>

```python
from sklearn.compose import ColumnTransformer
from sklearn.compose import TransformedTargetRegressor
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import StandardScaler, OneHotEncoder, KBinsDiscretizer
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score, cross_validate
from sklearn.preprocessing import FunctionTransformer
import category_encoders as ce
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
from sklearn import model_selection
from sklearn.model_selection import learning_curve

from sklearn.linear_model import SGDRegressor
from sklearn.svm import LinearSVR
from sklearn.ensemble import GradientBoostingRegressor, RandomForestRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.linear_model import LinearRegression
from catboost import CatBoostRegressor

import matplotlib.pyplot as plt 
import pandas as pd
import numpy as np
import re
import io
import time
import d6tpipe
import seaborn as sns
sns.set()

import warnings
warnings.filterwarnings('ignore')
warnings.filterwarnings(action='ignore',category=DeprecationWarning)
warnings.filterwarnings(action='ignore',category=FutureWarning)

%config InlineBackend.figure_format ='retina'

random_state= 42
scoring_metric = 'neg_mean_absolute_error'

api = d6tpipe.api.APIClient()
api.setToken('<Your Token>') # Your Token
api.list_pipes()
pipe = d6tpipe.Pipe(api, 'saqredwine2019')
pipe.pull() 

# Drop unnecessary column: Unnamed: 0
cols = list(pd.read_csv(pipe.dirpath/'saq_redwine_5000_GCP2.csv', nrows =1))
df = pd.read_csv(pipe.dirpath/'saq_redwine_5000_GCP2.csv', usecols =[i for i in cols if i != 'Unnamed: 0']).astype({'Size':object})
df

```
<br>
<img height="170" width="980" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/df.head.jpg" src="/public/df.head.jpg">
<br>
It's a clean, easy to understand set of data. Here's what all the features mean:

- **Country**: Country of origin
- **Region**: Region where the wine was made
- **Designation**: Product of a single vineyard with that vineyard's name appearing on the wine label.
- **Producer**: Wine-producer
- **Size**: Volume in mL or L (7500 mL, 1.5L)
- **Alcohol**: Degree of Alcohol (%)
<br>
<br>

```python
def prepare_data(data, target_name):
    """
    Separate X, y 
    Separate numerical and categorical columns.
    """
    # != 0 & NaN on Target
    data = data.loc[data[target_name] != 0]
    data.dropna(subset= [target_name], inplace=True)

    if target_name is not None:
        X = data.drop(target_name, axis=1)
        y = data[target_name]
        
        # get list of numerical & categorical columns in order to process these separately in the pipeline 
        num_cols = X.select_dtypes("number").columns
        cat_cols = X.select_dtypes("object").columns
    else:
        X = data
        y = None
    return X, y, num_cols, cat_cols

# retrieve X, y and separated columns names for numerical and categorical data
X, y, num_cols, cat_cols = prepare_data(df, 'Price')

# Split train & test
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=random_state)
```

<br>

## Exploratory Data Analysis

Steps we will check in this dataset:
- Check if data is intuitive 
- Missings values
- Outliers
- Linear Relationships
- Cross-Validation Startegy

```python
# Stats
stats = pd.DataFrame(columns = ['Columns','Types','Values', 'Uniques', 'Uniques(no nulls)', 'Missing(n)', 'Missing(%)'])
eda = pd.DataFrame()

for c in X_train.columns:
    eda['Columns'] = [c]
    eda['Types'] = X_train[c].dtypes
    eda['Values'] = [X_train[c].unique()]
    eda['Uniques'] = len(list(X_train[c].unique()))
    eda['Uniques(no nulls)'] = int(X_train[c].nunique())
    eda['Missing(n)'] = X_train[c].isnull().sum()
    eda['Missing(%)'] = (X_train[c].isnull().sum()/ len(X_train)).round(3)*100
    stats = stats.append(eda)
    
stats
```
<br>
### Price Distribution
```python
from scipy import stats
from scipy.stats import norm, skew

# Target describe()
print(y_train.describe())
         
plt.figure(figsize=(22,6))

plt.subplot(1,3,1)
sns.distplot(y_train, bins=50)
(mu, sigma) = norm.fit(y_train)
print( '\n mu = {:.2f} and sigma = {:.2f}\n'.format(mu, sigma))
plt.legend(['Normal dist. ($\mu=$ {:.2f} and $\sigma=$ {:.2f} )'.format(mu, sigma)],loc='best')
plt.ylabel('Frequency')
plt.title('Price Distribution')

plt.subplot(1,3,2)
stats.probplot(y_train, plot=plt)

plt.subplot(1,3,3)
sns.boxplot(y_train)
plt.title('Price Boxplot')
plt.show()
stats.skew(y_train)
# save jpeg
# bplot.figure.savefig('price_boxplot.jpg', format='jpeg') 
```
<br>
<PHOTO>
<br>
So, with 5.0 of positive kurtosis `Price` are definitely heavy-tailed and has some outliers that we need take care. In this case of positive skewness, log transformations usually works well.

<br>
<br>

<br>
### Log Transformed Price Distribution
```python
# Log transformation on Price
ylog_train = np.log1p(y_train)

# Plot
plt.figure(figsize=(22,6))

plt.subplot(1,3,1)
sns.distplot(ylog_train, bins=50, fit=norm)
(mu, sigma) = norm.fit(ylog_train)
print( '\n mu = {:.2f} and sigma = {:.2f}\n'.format(mu, sigma))
plt.legend(['Normal dist. ($\mu=$ {:.2f} and $\sigma=$ {:.2f} )'.format(mu, sigma)],loc='best')
plt.ylabel('Frequency')
plt.title('LogSalePrice Distribution')

plt.subplot(1,3,2)
stats.probplot(ylog_train, plot=plt)

plt.subplot(1,3,3)
sns.boxplot(ylog_train)
plt.title('Price Boxplot')
plt.show()
stats.skew(ylog_train)
```

<br>
<PHOTO>
<br>

### Categorical & Numerical Features: Linear Relationships
```python
# Select the numeric columns
numeric_subset = X_train.select_dtypes('number')

# Create columns with square root and log of numeric columns
for col in numeric_subset.columns:
    # Skip the Energy Star Score column
    if col == 'Price':
        next
    else:
        numeric_subset['sqrt_' + col] = np.sqrt(numeric_subset[col])
        numeric_subset['log_' + col] = np.log(numeric_subset[col])

# Select the categorical columns
categorical_subset = X_train[['Country', 'Region', 'Designation', 'Producer', 'Size']]
# # One hot encode
categorical_subset = pd.get_dummies(categorical_subset)

features = pd.concat([numeric_subset, categorical_subset, y_train], axis = 1)
# Find corr
correlations = features.corr()['Price'].sort_values()

# Top 10 negative correlations
correlations.head(10)
# Top 10 positive correlations
correlations.tail(10)
```
<br>
There are no strong positive linear relationships although we do see that `Producer` is slightly positively correlated with target `Price`.

<br>

**EDA Conclusions:**
- Almost all features are categoricals
- `Region`, `Designation`, `Alcohol` and our target `Price` have missing values
- `Alcohol` have more than 16% missing values
- `Name` act as an ID column but have some interesting values as text feature
- High number of uniques categorical values: `Producer` and `Region`
- Target `Price` distribution varies by `Producer`
<br>
<br>


## Naive Baseline
<br>

For our naive baseline, we will use the median value of `Price` on the training set for all observations on the test set. We will then calculate MAE to jauge the improuvement of our final model. So, our model will need to beat our naive baseline performance.

<br>

### Mean Absolute Error (MAE)


```python
def mae(y_true, y_pred):
    return np.mean(abs(y_true - y_pred))

print("Naive Baseline Performance on the test set: MAE = %0.4f" % mae(y_test, np.median(y_train)))
```

<br>

```python
# Numeric: Alcohol
numeric_transformer = Pipeline([
    ('imput', SimpleImputer(strategy='mean'))])


# Categorical: Country, Region, Designation, Producer, Size
categorical_transformer = Pipeline([
    ('imputer', SimpleImputer(strategy='constant', fill_value='missing')),
    ('onehot', OneHotEncoder(handle_unknown='ignore'))]) # use OneHotEncoder(handle_unknown='ignore') to ignore new categories in test set
    

# ColumnTransformer
cat_feat = ['Country', 'Region', 'Designation', 'Producer', 'Size']
num_feat = ['Alcohol']


column_trans = ColumnTransformer(
    transformers=[
        ('num', numeric_transformer, num_feat),
        ('cat', categorical_transformer, cat_feat)])


lr = Pipeline([('column_trans', column_trans),
               ('LinearRegression', LinearRegression())])

rf = Pipeline([('column_trans', column_trans),
               ('RandomForestRegressor', RandomForestRegressor(random_state=random_state))])

sdg = Pipeline([('column_trans', column_trans),
               ('SGDRegressor', SGDRegressor(loss='squared_loss', random_state=random_state))])

gbr = Pipeline([('column_trans', column_trans),
               ('GradientBoostingRegressor', GradientBoostingRegressor(random_state=random_state))])

lsvr = Pipeline([('column_trans', column_trans),
               ('LinearSVR', LinearSVR(random_state=random_state))])

cat = Pipeline([('column_trans', column_trans),
               ('CatBoostRegressor', CatBoostRegressor(verbose=1000, random_seed=random_state))])



# Setting up Cross-Validation
scores = []
results = []
names = []

cv = KFold(n_splits=5, shuffle=True, random_state=5)

for est, name in zip((lr, rf, sdg, gbr, lsrv, cat),
                     ('LinearRegression', 'RandomForestRegressor', 'SGDRegressor', 'GradientBoostingRegressor', 'LinearSVR', 'CatBoostRegressor')):

    start_time = time.time()         


    # crossvalidate classifiers on training data
    cv_score = cross_val_score(est, X=X_train, y=y_train, cv=cv, scoring=scoring_metric)

    # cross_validate vs cross_val_score

    scores.append([name.strip(), -1*cv_score.mean(), cv_score.std(), (time.time() - start_time)])
    results.append(cv_score)
    names.append(name)

scores = pd.DataFrame(scores, columns=["Regressor", 'MAE', '+/-', 'Time(s)']).sort_values('MAE', ascending=True)
# scores.style.highlight_min()
scores
```
<br>
Although, most of our models outperform our naive baseline this is not the most fair comparison because we are using mostly the default hyperparameters.

*Important: Scikit-Learn version is generally slower than the XGBoost version, but here we'll stick to Scikit-Learn because the syntax is more familiar.*
<br>
<br>


```python
# Feature Importance
plt.plot(rf.feature_importances_)
plt.xticks(np.arange(X.shape[1]), X_train.columns.tolist(), rotation =90)
```
<br>
<br>

<img height="350" width="450" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/Feature_importance_R2.jpg" src="/public/Feature_importance_R2.jpg">

<br>
<br>
<br>

## Feature Engineering & Selection
```python
# Mean Encoding on Producer
kf = model_selection.KFold(5, shuffle=False)
df_clean['Producer_enc'] = np.nan

for tr_ind, val_ind in kf.split(df_clean):
    X_tr, X_val = df_clean.iloc[tr_ind], df_clean.iloc[val_ind]
    df_clean.loc[df_clean.index[val_ind], 'Producer_enc'] = X_val['Producer'].map(X_tr.groupby('Producer').Price.mean())
df_clean['Producer_enc'].fillna(46.580, inplace=True)


# Feature Generation: Country_Region
df_clean['Country_Region'] = df_clean['Country'] + df_clean['Region']

# Feature Generation: Counts Producer
counts = df_clean['Producer'].value_counts()
counts_dict = counts.to_dict() 
df_clean['Counts_Producer'] = df_clean['Producer'].map(counts_dict)

# Feature Generation: Counts Producer
val = df_clean['Producer'].value_counts()
y = val[val == 1].index
df_clean['New_Producer'] = df_clean['Producer'].replace({x:'Other' for x in y})

#  Feature Engineering
df_clean['Wine_year'] = df_clean['Name'].str.extract('(20\d{2})', expand=True)                                                  
df_clean['Wine_year'] = df_clean['Wine_year'].replace(np.nan, 'Other', regex=True)

# Feature Generation: Producer Frequency
fe = df_clean.groupby('Producer').size()/len(df_clean)
df_clean.loc[:, 'Freq_Producer'] = df_clean['Producer'].map(fe)
```
<br>
<br>
<br>

## Modelling

```python
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestRegressor
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.ensemble import ExtraTreesRegressor
from sklearn.ensemble import AdaBoostRegressor
from sklearn.metrics import mean_squared_error
from catboost import CatBoostRegressor

# Test options and evaluation metric
num_folds = 10
seed = 7
scoring = 'r2'


X = df_clean.drop(['Price'], axis=1)
y = df_clean['Price'].values

X_train, X_validation, y_train, y_validation = train_test_split(X, y, train_size=0.7, random_state= 42)

# Label encoder
for c in X_train.columns[X_train.dtypes == 'object']:
  X_train[c] = X_train[c].factorize()[0]


# ensembles
ensembles = []
# ensembles.append(('AB', AdaBoostRegressor()))
ensembles.append(('GBM', GradientBoostingRegressor()))
ensembles.append(('RF',RandomForestRegressor()))
ensembles.append(('ET', ExtraTreesRegressor()))
ensembles.append(('CAT', CatBoostRegressor()))


results = []
names = []
for name, model in ensembles:
  kfold = KFold(n_splits=num_folds, random_state=seed)
  cv_results = cross_val_score(model, X_train, y_train, cv=kfold, scoring=scoring)
  results.append(cv_results)
  names.append(name)
  msg = "%s: %f (%f)" % (name, cv_results.mean(), cv_results.std())
  print(msg)
```
<br>

```python
# Model Selection
fig = pyplot.figure()
fig.suptitle('Ensemble Algorithm Comparison')
ax = fig.add_subplot(111)
pyplot.boxplot(results)
ax.set_xticklabels(names)
pyplot.show()
```
<br>
<img height="350" width="450" class="center" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/ModelSelection.jpg" src="/public/ModelSelection.jpg">

<br>
<br>

We can see that..........

For hyperparameter tuning, GridSearch and Random search require long run times because they waste time evaluating unpromising areas of the search space. So, we will use an automated method that aim to find optimal hyperparameters in less time using an informed search with no manual effort necessary beyond the initial set-up.

Though Catboost performs well with default parameters, there are several parameters that drive a significant improvement in results when tuned. The most importants parameters for CatBoost are: cat_features, one_hot_max_size, learning_rate & n_estimators and max_depth.

<br>

```python
# Hyperparameter optimization
param_grid = dict(n_estimators=numpy.array([400,600,700,800,900,1000,1200]))
model = CatBoostRegressor(random_state=seed)
kfold = KFold(n_splits=num_folds, random_state=seed)
grid = GridSearchCV(estimator=model, param_grid=param_grid, scoring=scoring, cv=kfold)
grid_result = grid.fit(X_train, y_train)

print("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))
means = grid_result.cv_results_['mean_test_score']
stds = grid_result.cv_results_['std_test_score']
params = grid_result.cv_results_['params']
for mean, stdev, param in zip(means, stds, params):
    print("%f (%f) with: %r" % (mean, stdev, param))
```
<br>
<br>
-------------------------------------------------------------------------------------
|   iter    |  target   | baggin... |   depth   | iterat... | learni... | subsample |
-------------------------------------------------------------------------------------
|  1        |  0.3611   |  3.534    |  7.34     |  487.7    |  0.08617  |  0.989    |
|  *2*        |  0.3712   |  6.769    |  6.503    |  414.4    |  0.06342  |  0.7499   |
|  3        |  0.3629   |  7.755    |  7.411    |  476.2    |  0.0533   |  0.6441   |
|  4        |  0.3587   |  3.024    |  7.543    |  400.1    |  0.05501  |  0.8838   |
|  5        |  0.3666   |  10.0     |  5.0      |  600.0    |  0.1      |  1.0      |
|  6        |  0.367    |  9.925    |  5.009    |  546.9    |  0.09322  |  0.7739   |
|  7        |  0.3633   |  3.189    |  5.004    |  441.3    |  0.09411  |  0.9115   |
|  8        |  0.3604   |  3.074    |  7.972    |  588.2    |  0.08115  |  0.6328   |
|  9        |  0.3694   |  9.987    |  5.135    |  400.4    |  0.07652  |  0.9288   |
|  10       |  0.3587   |  9.936    |  7.714    |  426.6    |  0.07037  |  0.9835   |
=====================================================================================
<br>


## Conclusion
Since CatBoost is a great model for tabular data, it seems to be the best model for our regression problem.
Maybe with more data, like text (unstructured data), we could look into the relationship between text descriptions and prices and then identify certain words or characteristics associated with expensive and less expensive wines.

<br>
<br>
<br>
<br>

***

<br>
<br>
<br>
<br>
