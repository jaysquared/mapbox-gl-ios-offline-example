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
6) Install mb-util
7) Convert MBTiles to PBF Files
```
./mb-util --image_format=pbf countries.mbtiles countries
gzip -d -r -S .pbf *
find . -type f -exec mv '{}' '{}'.pbf \;
```
8) Zip the folder
