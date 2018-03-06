# GDAL Utility Functions for R

The [GDAL project](http://www.gdal.org/) provides a number of
command-line utility functions for inspecting and operating on both
raster and vector data. These functions are documented on the [GDAL
Utilities](http://www.gdal.org/gdal_utilities.html) and [OGR Utility
Programs](http://www.gdal.org/ogr_utilities.html).

## Installling

To install the development version from GitHub, run:
```r
library(devtools)
install_github("JoshOBrien/gdalUtilities")
```


## Included functionality 

```r
## 'GDAL Utility Programs'
gdal_grid
gdal_rasterize
gdal_translate
gdalbuildvrt
gdaldem
gdalinfo
gdalwarp
nearblack
## 'OGR Utility Programs'
ogr2ogr
```


```r
## 'GDAL Utility Programs'
gdal_contour
gdaladdo
gdallocationinfo
gdalmanage
gdaltindex
gdaltransform

## 'OGR Utility Programs' 
ogrinfo
ogrlineref
ogrtindex
```
