---
layout: post
title: Comparing Information of Nearby venues from Neighborhoods in Montreal - Foursquare API vs. Google API
---



# Table of Contents

For this final assignment, we will  explore and cluster the neighborhoods in Montréal.
We will compare the data from Foursquare API with data of nearby venues from Google Maps API. For that, we will analyse  both datasets.

1. Download Datasets
2. Coordinates from Google Maps Geocoding API
3. Merging Datasets
4. Venues for all Neighborhoods (Foursquare API)
5. Analyze, Cluster and Mapping Neighborhoods (Foursquare API) 
6. Venues for all Neighborhoods (Google Places API)
7. Analyze, Cluster and Mapping Neighborhoods (Google Places API)  
8. Conclusion  


Before we get the data and start exploring it, let's download all the dependencies that we will need:

```python
pip install beautifulsoup4
pip install lxml
pip install requests
pip install folium==0.5.0
pip install geopy
```

#### 1. Download and Clean Montreal postal codes data (Wikipedia)
We will build a code to scrape the following Wikipedia page, https://en.wikipedia.org/wiki/List_of_postal_codes_of_Canada:_H, in order to obtain the data that is in the table of postal codes in Montréal and to transform the data into a pandas dataframe.

```python
from bs4 import BeautifulSoup
import numpy as np
import lxml

import pandas as pd
pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)

import json # library to handle JSON files

from geopy.geocoders import Nominatim # convert an address into latitude and longitude values

import requests
from pandas.io.json import json_normalize # tranform JSON file into a pandas dataframe

# Matplotlib and associated plotting modules
import matplotlib.cm as cm
import matplotlib.colors as colors

# import k-means from clustering stage
from sklearn.cluster import KMeans

import folium


source = requests.get('https://en.wikipedia.org/wiki/List_of_postal_codes_of_Canada:_H').text
soup = BeautifulSoup(source)


table = soup.find('table')
table_rows = table.find_all('tr')

res = []
for tr in table_rows:
    td = tr.find_all('td')
    row = [tr.text.strip() for tr in td if tr.text.strip()]
    if row:
        res.append(row)

## Data Cleaninng: We will clean our data extract from Wikipedia

df = pd.DataFrame(res, columns=["column1", "column2", "column3", "column4", "column5", "column6", "column7", "column8", "column9"])

df = df.replace(r'^H\d+[A-Z](Not) assigned$', np.nan, regex=True)

df1 = df['column1'].str.split('(H\d+[A-Z])(.*)', expand=True)
df1 = df1.loc[:,[1,2]]
df1.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)


df2 = df['column2'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df2 = df2.loc[:,[1,2]]
df2.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)


df3 = df['column3'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df3 = df3.loc[:,[1,2]]
df3.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)


df4 = df['column4'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df4 = df4.loc[:,[1,2]]
df4.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)
df4

df5 = df['column5'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df5 = df5.loc[:,[1,2]]
df5.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)

df6 = df['column6'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df6 = df6.loc[:,[1,2]]
df6.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)

df7 = df['column7'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df7 = df7.loc[:,[1,2]]
df7.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)


df8 = df['column8'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df8 = df8.loc[:,[1,2]]
df8.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)


df9 = df['column9'].str.split('(H\d+[A-Z])(.*)('')', expand=True)
df9 = df9.loc[:,[1,2]]
df9.rename(columns={1:'Postcode', 2:'Neighborhood'}, inplace=True)
df9


frames = [df1, df2, df3, df4, df5, df6, df7, df8, df9]

result = pd.concat(frames)
df_final = result.dropna(axis=0).reset_index(drop = True)

# remove non-informative data
df_final = df_final[df_final.Postcode != 'H0P']
df_final = df_final[df_final.Postcode != 'H0M']
df_final = df_final[df_final.Postcode != 'H0H']
df_final.head(10)
```

#### PHOTO 

#### 2. Coordinates from Google Maps Geocoding API
Now, we need to get the latitude and the longitude coordinates of each postal code in Montréal from Google Maps Geocoding API

```python
def getGoogleMapCoord(postcode):

    api_key = '<<HERE YOUR KEY>>'
    key = '&key={}'.format(api_key)

    venues_list=[]
    for postcode in postcode:
#         print(postcode)

        # make the GET request
        results = requests.get('https://maps.googleapis.com/maps/api/geocode/json?address={},Montreal,QC,Canada'.format(postcode)+key).json()
        final = results['results']
        venues_list.append([(
            postcode,
            v['geometry']['location']['lat'],
            v['geometry']['location']['lng']) for v in final])

    nearby_venues = pd.DataFrame([item for venue_list in venues_list for item in venue_list])
    nearby_venues.columns = ['Postcode','Lat', 'Long']

    return nearby_venues
    
geo = getGoogleMapCoord(postcode=df_final['Postcode'])
geo.head()
```
#### PHOTO 


#### 3. Merging Wikipedia data & Coordinates of Montréal
We will now join our data from Wikipedia (df_final ) and our coordinates in Montréal (geo)

```python
def getGoogleMapCoord(postcode):

    api_key = '<<HERE YOUR KEY>>'
    key = '&key={}'.format(api_key)

    venues_list=[]
    for postcode in postcode:
#         print(postcode)

        # make the GET request
        results = requests.get('https://maps.googleapis.com/maps/api/geocode/json?address={},Montreal,QC,Canada'.format(postcode)+key).json()
        final = results['results']
        venues_list.append([(
            postcode,
            v['geometry']['location']['lat'],
            v['geometry']['location']['lng']) for v in final])

    nearby_venues = pd.DataFrame([item for venue_list in venues_list for item in venue_list])
    nearby_venues.columns = ['Postcode','Lat', 'Long']

    return nearby_venues
    
geo = getGoogleMapCoord(postcode=df_final['Postcode'])
geo.head()
```

### Sidebar overlay instead of push

Make the sidebar overlap the viewport content with a single class:

```html
<body class="sidebar-overlay">
  ...
</body>
```

This will keep the content stationary and slide in the sidebar over the side content. It also adds a `box-shadow` based outline to the toggle for contrast against backgrounds, as well as a `box-shadow` on the sidebar for depth.

It's also available for a reversed layout when you add both classes:

```html
<body class="layout-reverse sidebar-overlay">
  ...
</body>
```

### Sidebar open on page load

Show an open sidebar on page load by modifying the `<input>` tag within the `sidebar.html` layout to add the `checked` boolean attribute:

```html
<input type="checkbox" class="sidebar-checkbox" id="sidebar-checkbox" checked>
```

Using Liquid you can also conditionally show the sidebar open on a per-page basis. For example, here's how you could have it open on the homepage only:

```html
<input type="checkbox" class="sidebar-checkbox" id="sidebar-checkbox" {% if page.title =="Home" %}checked{% endif %}>
```

## Development

Lanyon has two branches, but only one is used for active development.

- `master` for development.  **All pull requests should be to submitted against `master`.**
- `gh-pages` for our hosted site, which includes our analytics tracking code. **Please avoid using this branch.**



## Contents

- [Usage](#usage)
- [Options](#options)
  - [Sidebar menu](#sidebar-menu)
  - [Themes](#themes)
  - [Reverse layout](#reverse-layout)
- [Development](#development)
- [Author](#author)
- [License](#license)


## Usage

Lanyon is a theme built on top of [Poole](https://github.com/poole/poole), which provides a fully furnished Jekyll setup—just download and start the Jekyll server. See [the Poole usage guidelines](https://github.com/poole/poole#usage) for how to install and use Jekyll.


## Options

Lanyon includes some customizable options, typically applied via classes on the `<body>` element.


### Sidebar menu

Create a list of nav links in the sidebar by assigning each Jekyll page the correct layout in the page's [front-matter](http://jekyllrb.com/docs/frontmatter/).


# Lanyon

Lanyon is an unassuming [Jekyll](http://jekyllrb.com) theme that places content first by tucking away navigation in a hidden drawer. It's based on [Poole](http://getpoole.com), the Jekyll butler.

![Lanyon](https://f.cloud.github.com/assets/98681/1825266/be03f014-71b0-11e3-9539-876e61530e24.png)
## Author

**Mark Otto**
- <https://github.com/mdo>
- <https://twitter.com/mdo>


## License

Open sourced under the [MIT license](LICENSE.md).

<3
