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


Before we get the data and start exploring it, let's download all the dependencies that we will need.

To use a theme, add any one of the available theme classes to the `<body>` element in the `default.html` layout, like so:

```python
pip install beautifulsoup4
pip install lxml
pip install requests
pip install folium==0.5.0
pip install geopy
```

1. Download and Clean Montreal postal codes data (Wikipedia)
We will build a code to scrape the following Wikipedia page, https://en.wikipedia.org/wiki/List_of_postal_codes_of_Canada:_H, in order to obtain the data that is in the table of postal codes in Montréal and to transform the data into a pandas dataframe.

```html
<body class="layout-reverse">
  ...
</body>
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
