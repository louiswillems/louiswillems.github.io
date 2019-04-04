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
montreal_merged = pd.merge(df_final, geo, how='left', left_on='Postcode', right_on='Postcode')
```

Next, we use geopy library to get the latitude and longitude values of Montréal

```python
address = 'Montreal, QC'

geolocator = Nominatim()
location = geolocator.geocode(address)
latitude = location.latitude
longitude = location.longitude
print('The geograpical coordinate of Montreal {}, {}.'.format(latitude, longitude))
```

#### 4. Venues for all Neighborhoods in Montréal with the Foursquare API
Next, we are going to start utilizing the Foursquare API to get venues for all neighborhoods in Montréal.

```python
def getNearbyVenuesFoursquare(names, latitudes, longitudes, radius=500):
    
    venues_list=[]
    for name, lat, lng in zip(names, latitudes, longitudes):
            
        # create the API request URL
        url = 'https://api.foursquare.com/v2/venues/explore?&client_id={}&client_secret={}&v={}&ll={},{}&radius={}&limit={}'.format(
            CLIENT_ID, 
            CLIENT_SECRET, 
            VERSION, 
            lat, 
            lng, 
            radius, 
            LIMIT)
            
        # make the GET request
        results = requests.get(url).json()["response"]['groups'][0]['items']
        
        # return only relevant information for each nearby venue
        venues_list.append([(
            name, 
            lat, 
            lng, 
            v['venue']['name'], 
            v['venue']['location']['lat'], 
            v['venue']['location']['lng'],  
            v['venue']['categories'][0]['name']) for v in results])

    nearby_venues = pd.DataFrame([item for venue_list in venues_list for item in venue_list])
    nearby_venues.columns = ['Neighborhood', 
                  'Neighborhood Latitude', 
                  'Neighborhood Longitude', 
                  'Venue', 
                  'Venue Latitude', 
                  'Venue Longitude', 
                  'Venue Category']
    
    return(nearby_venues)
    
montreal_foursquare = getNearbyVenuesFoursquare(names=montreal_merged['Neighborhood'],
                                   latitudes=montreal_merged['Lat'],
                                   longitudes=montreal_merged['Long']
                                  )
```

#### 5. Analyze, Cluster and Mapping Neighborhoods with Foursquare API
Run k-means to cluster the neighborhood into 5 clusters.

```python
# one hot encoding
montreal_onehot = pd.get_dummies(montreal_foursquare[['Venue Category']], prefix="", prefix_sep="")

# add neighborhood column back to dataframe
montreal_onehot['Neighborhood'] = montreal_foursquare['Neighborhood'] 

# move neighborhood column to the first column
fixed_columns = [montreal_onehot.columns[-1]] + list(montreal_onehot.columns[:-1])
montreal_onehot = montreal_onehot[fixed_columns]


# Merging
montreal_grouped = montreal_onehot.groupby('Neighborhood').mean().reset_index()
montreal_final = pd.merge(montreal_merged, montreal_grouped, how='left', left_on='Neighborhood', right_on='Neighborhood')
montreal_final.dropna(axis=0, inplace=True)


def return_most_common_venues(row, num_top_venues):
    row_categories = row.iloc[1:]
    row_categories_sorted = row_categories.sort_values(ascending=False)
    
    return row_categories_sorted.index.values[0:num_top_venues]
  
num_top_venues = 10

indicators = ['st', 'nd', 'rd']

# create columns according to number of top venues
columns = ['Neighborhood']
for ind in np.arange(num_top_venues):
    try:
        columns.append('{}{} Most Common Venue'.format(ind+1, indicators[ind]))
    except:
        columns.append('{}th Most Common Venue'.format(ind+1))

# create a new dataframe
neighborhoods_venues_sorted = pd.DataFrame(columns=columns)
neighborhoods_venues_sorted['Neighborhood'] = montreal_grouped['Neighborhood']

for ind in np.arange(montreal_grouped.shape[0]):
    neighborhoods_venues_sorted.iloc[ind, 1:] = return_most_common_venues(montreal_grouped.iloc[ind, :], num_top_venues)

neighborhoods_venues_sorted.head()
```
```python
# set number of clusters
kclusters = 3

montreal_grouped_clustering = montreal_grouped.drop('Neighborhood', 1)

# run k-means clustering
kmeans = KMeans(init = "k-means++",n_clusters=kclusters,n_init = 12, random_state=0).fit(montreal_grouped_clustering)


montreal_final['Cluster Labels'] = kmeans.labels_

montreal_final2 = montreal_final[['Postcode', 'Neighborhood', 'Lat', 'Long', 'Cluster Labels']]

# montreal_merged = montreal_final.join(neighborhoods_venues_sorted.set_index('Neighborhood'), on='Neighborhood')
montreal_merged_f = pd.merge(montreal_final2, neighborhoods_venues_sorted, left_on='Neighborhood', right_on='Neighborhood')
```

Let's plot our clusters with Folium

```python
# create map
map_clusters = folium.Map(location=[latitude, longitude], zoom_start=11)

# set color scheme for the clusters
x = np.arange(kclusters)
ys = [i+x+(i*x)**2 for i in range(kclusters)]
colors_array = cm.rainbow(np.linspace(0, 1, len(ys)))
rainbow = [colors.rgb2hex(i) for i in colors_array]

# add markers to the map
markers_colors = []
for lat, lon, poi, cluster in zip(montreal_final['Lat'], montreal_final['Long'], montreal_final['Neighborhood'], montreal_final['Cluster Labels']):
    label = folium.Popup(str(poi) + ' Cluster ' + str(cluster), parse_html=True)
    folium.CircleMarker(
        [lat, lon],
        radius=5,
        popup=label,
        color=rainbow[cluster-1],
        fill=True,
        fill_color=rainbow[cluster-1],
        fill_opacity=0.7).add_to(map_clusters)
       
map_clusters
```

#### 6. Venues for all Neighborhoods in Montréal with the Google Maps Places API
Next, we are going to start utilizing the Google Maps Place API to get venues for all neighborhoods in Montréal.

```python
montreal_merge = pd.merge(df_final, geo, how='left', left_on='Postcode', right_on='Postcode')

def getGoogleMapTypelocation(neigh,lat,lng):

    api_key = '<<HERE YOUR KEY>>'
    key = '&key={}'.format(api_key)

    venues_list=[]
    for neigh, lat, lng in zip(neigh, lat, lng):
     #print(postcode)

        results = requests.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=500&location={},{}'.format(lat,lng)+key).json()
        final = results['results']
        venues_list.append([(
            neigh,
            lat,
            lng,
            v['types'][0]) for v in final])

    nearby_venues = pd.DataFrame([item for venue_list in venues_list for item in venue_list])
    nearby_venues.columns = ['Neighborhood','Lat', 'Long', 'Types']

    return nearby_venues
    
montreal_GAPI = getGoogleMapTypelocation(neigh=montreal_merge['Neighborhood'],
                                   lat=montreal_merge['Lat'],
                                   lng=montreal_merge['Long']
                                  )
```






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
