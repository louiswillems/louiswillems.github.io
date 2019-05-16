---
layout: page
title: Foursquare API vs. Google API - Comparing Information of Nearby venues from Neighborhoods in Montreal
---

<br>
<br>

## Table of Contents

In this post, we will explore and cluster the neighborhoods in Montréal.
We will compare the data from Foursquare API with data of nearby venues from Google Maps API. For that, we will analyse both datasets.

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
<br>
### 1. Download and Clean Montreal postal codes data (Wikipedia)

We will build a code to scrape the following Wikipedia page, [List of Postal codes of Canada](https://en.wikipedia.org/wiki/List_of_postal_codes_of_Canada:_H), in order to obtain the data that is in the table of postal codes in Montréal and to transform the data into a pandas dataframe.

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

<img height="230" width="330" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/FvsG_API_photo_1.JPG" src="/public/FvsG_API_photo_1.JPG">

<br>
### 2. Coordinates from Google Maps Geocoding API
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
<img height="230" width="530" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/FvsG_API_photo_1.JPG" src="/public/FvsG_API_photo_2.JPG">

<br>
### 3. Merging Wikipedia data & Coordinates of Montréal
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
<br>
### 4. Venues for all Neighborhoods in Montréal with the Foursquare API
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



<br>
### 5. Analyze, Cluster and Mapping Neighborhoods with Foursquare API
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

<img height="430" width="950" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/FvsG_API_photo_1.JPG" src="/public/FvsG_API_photo_3.JPG">

<br>
### 6. Venues for all Neighborhoods in Montréal with the Google Maps Places API
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

### 7. Analyze, Cluster and Mapping Neighborhoods with Google Places API
Run k-means to cluster the neighborhood into 5 clusters.


```python
# one hot encoding
montreal_onehot = pd.get_dummies(montreal_GAPI[['Types']], prefix="", prefix_sep="")

# add neighborhood column back to dataframe
montreal_onehot['Neighborhood'] = montreal_GAPI['Neighborhood'] 

# move neighborhood column to the first column
fixed_columns = [montreal_onehot.columns[-1]] + list(montreal_onehot.columns[:-1])
montreal_onehot = montreal_onehot[fixed_columns]

montreal_grouped = montreal_onehot.groupby('Neighborhood').mean().reset_index()
montreal_final3 = pd.merge(montreal_merge, montreal_grouped, how='left', left_on='Neighborhood', right_on='Neighborhood')
montreal_final3.dropna(axis=0, inplace=True)


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
neighborhoods_venues_sorted1 = pd.DataFrame(columns=columns)
neighborhoods_venues_sorted1['Neighborhood'] = montreal_grouped['Neighborhood']

for ind in np.arange(montreal_grouped.shape[0]):
    neighborhoods_venues_sorted1.iloc[ind, 1:] = return_most_common_venues(montreal_grouped.iloc[ind, :], num_top_venues)
```


```python
# set number of clusters
kclusters = 3

montreal_grouped_clustering1 = montreal_grouped.drop('Neighborhood', 1)

# run k-means clustering
kmeans = KMeans(init = "k-means++",n_clusters=kclusters,n_init = 12, random_state=0).fit(montreal_grouped_clustering1)

montreal_final3['Cluster Labels'] = kmeans.labels_

montreal_final4 = montreal_final3[['Postcode', 'Neighborhood', 'Lat', 'Long', 'Cluster Labels']]

# montreal_merged = montreal_final.join(neighborhoods_venues_sorted.set_index('Neighborhood'), on='Neighborhood')
montreal_merge_g = pd.merge(montreal_final4, neighborhoods_venues_sorted1, left_on='Neighborhood', right_on='Neighborhood')
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
for lat, lon, poi, cluster in zip(montreal_final['Lat'], montreal_final3['Long'], montreal_final3['Neighborhood'], montreal_final3['Cluster Labels']):
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

<img height="430" width="950" class="progressiveMedia-image js-progressiveMedia-image" data-src="/public/FvsG_API_photo_1.JPG" src="/public/FvsG_API_photo_5.JPG">

<br>
### 8. Conclusion
Now, you can examine each cluster and determine the discriminating venue categories that distinguish each cluster from each API.

#### Google Maps Places API - Cluster 0

```python
montreal_merge_g.loc[montreal_merge_g['Cluster Labels'] == 0, montreal_merge_g.columns[[1] + list(range(5, montreal_merge_g.shape[1]))]].head()
```

#### Foursquare API - Cluster 0

```python
montreal_merged_f.loc[montreal_merged_f['Cluster Labels'] == 0, montreal_merged_f.columns[[1] + list(range(5, montreal_merged_f.shape[1]))]].head()
```

#### Comparing Information from ANJOU EAST: Foursquare vs. Google Places API
Foursquare API

```python
montreal_merged_f.loc[montreal_merged_f['Neighborhood'] == 'AnjouEast', montreal_merged_f.columns[[1] + list(range(5, montreal_merged_f.shape[1]))]].head()
```

Google Places API:

```python
montreal_merge_g.loc[montreal_merge_g['Neighborhood'] == 'AnjouEast', montreal_merge_g.columns[[1] + list(range(5, montreal_merge_g.shape[1]))]].head()
```

<br>
### Conclusion:
The answer of what API to use is difficult. Both apps have pros and cons. <br>
Google places it is an automatic pop up from Google and Google Maps. It is informational, but not precise. For example, if we are looking for the most relevant pharmacy we can take advantage of Google Places. The branch of Google will list the surrounding offices along with ratings, comments, and contact information but the categories for the API are not really accurate.

In the other hand, Foursquare has not the reach of Google. It is a tailored app for a more demanding audience. But, the categories for all venues are really clear and can be easelly understood. 


<br>
<br>
<br>
<br>

***

<br>
<br>
<br>
<br>
