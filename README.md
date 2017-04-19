## How to use this repository
1) Clone or download as a ZIP
2) Open Terminal, navigate to project folder and run
```
pod install
```
3) Open OfflineMaps.xcworkspace
4) Optional: Select team, if you want to run on device
5) Run project

## How to build a map source.
1) Download Mapbox Studio Classic (https://www.mapbox.com/mapbox-studio-classic/#darwin)
2) Create a new source
3) Add some vector data (e.g. http://www.naturalearthdata.com)
4) Save the project
5) Go to settings -> Export to MBTiles
6) Install mb-util (https://github.com/mapbox/mbutil)
7) Convert MBTiles to PBF Files (More info https://github.com/klokantech/vector-tiles-sample)
```
mb-util --image_format=pbf countries.mbtiles countries
gzip -d -r -S .pbf *
find . -type f -exec mv '{}' '{}'.pbf \;
```
8) Zip the folder

## Structure of the style.json file
The Tiles-URL corresponds to your local server running on port 8080. The example zip file contains a top level folder countries. If you choose another zip structure or port, adjust the style.json.
```
"sources": {
        "composite": {
            "type": "vector",
            "tiles": ["http://localhost:8080/countries/{z}/{x}/{y}.pbf"]
        }
    }
```

The layers object is responsible for the styling of the map. The id is unique for every element. Source corresponds to the name in your sources object and the layer corresponds to the name of the layer in your source mbtiles file. For possible styles, use the MapBox Online Editor (http://www.mapbox.com) and download the style file.
```
"layers": [{
        "id": "background",
        "type": "background",
        "paint": {
            "background-color": "hsl(190, 67%, 47%)"
        }
    }, {
        "id": "countries",
        "type": "fill",
        "source": "composite",
        "source-layer": "countries",
        "layout": {
            "visibility": "visible"
        },
        "paint": {
            "fill-color": "hsl(0, 0%, 85%)",
            "fill-outline-color": "#F8E81C"
        }
    }, {
        "id": "countries-border",
        "type": "line",
        "source": "composite",
        "source-layer": "countries",
        "layout": {
            "visibility": "visible"
        },
        "paint": {
            "line-color": "#000000",
            "line-width": 1.2
        }
    }, {
        "id": "countries-deu",
        "type": "fill",
        "source": "composite",
        "source-layer": "countries",
        "filter": ["in", "ADM0_A3", "DEU"],
        "layout": {
            "visibility": "visible"
        },
        "paint": {
            "fill-color": "#BD0FE1"
        }
    }]
```
